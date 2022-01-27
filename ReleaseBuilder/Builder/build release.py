
import argparse
import gitInfo
import re
import AsProjectCompile
import ASProject
import os
import shutil
import tempfile
from zipfile import ZipFile
from os.path import basename
import subprocess, shlex
from pathlib import Path
import winreg

repoDir = ''
repo = None
homeDir = ''
project = None


def removeDir(directory):
    try:
        if (os.path.exists(directory)):
            tempDirName = tempfile.TemporaryDirectory().name
            os.rename(directory, tempDirName)
            shutil.rmtree(tempDirName)
    except:
        return

def CleanUpOldLibraries(directory):
    cyv = directory + '\\CYV'
    removeDir(cyv)
    os.mkdir(cyv)

def CreateDirectory(directory):
    if (os.path.exists(directory) == False):
        os.mkdir(directory)

def CleanProject(project):
    removeDir(project._projectDir + r'\Binaries')
    removeDir(project._projectDir + r'\Temp')
    removeDir(project._projectDir + r'\Diagnosis')

def UpdateVersion(project) -> bool:
    cmd = r'powershell'
    options = rf'-ExecutionPolicy ByPass -File "{project._projectDir}\Logical\Version.ps1" "{project._projectDir}"'
    result = subprocess.run(shlex.split(f'"{cmd}" {options}'))
    return True

def BuildAndExportLibrary(project, exportLocation) -> bool:
    buildResult = AsProjectCompile.Compile(project, 'Config1')
    if (buildResult[0][1] < 3):
        CreateDirectory(exportLocation)
        CleanUpOldLibraries(exportLocation)
        project.exportLibrary('CYV', exportLocation)
        return True
    return False

def UpdateStarterProject(project, libraryDir) -> bool:
    starterLibDir = project._projectDir + r'\Logical\Libraries\CYV'
    removeDir(starterLibDir)
    shutil.copytree(libraryDir + '\\CYV\\' + os.listdir(libraryDir + r'\CYV')[0], starterLibDir)
    return True

def CleanDirectory(directory):
    CreateDirectory(directory)
    contents = [os.path.join(directory, i) for i in os.listdir(directory)]
    [os.remove(i) if os.path.isfile(i) or os.path.islink(i) else shutil.rmtree(i) for i in contents]

def ZipDirectory(directory, zipfile):
    with ZipFile(zipfile, 'w') as zip:
        for folderName, subfolders, filenames in os.walk(directory):
            for filename in filenames:
                filePath = os.path.join(folderName, filename)
                zip.write(filePath, filePath.replace(directory,''))

def BuildAndExportStarterProject(starterProject, technologySolutionDir) -> bool:
    buildResult = AsProjectCompile.Compile(starterProject, 'CYV_ARsim')
    # technology solution
    tempDir = tempfile.TemporaryDirectory()
    shutil.copytree(rf'{starterProject._projectDir}\Logical', rf'{tempDir.name}\Logical')
    shutil.copytree(rf'{starterProject._projectDir}\Physical', rf'{tempDir.name}\Physical')
    shutil.copy(rf'{technologySolutionDir}\AdvancedExport.xml', rf'{tempDir.name}\AdvancedExport.xml')
    shutil.copy(rf'{technologySolutionDir}\Image.png', rf'{tempDir.name}\Image.png')
    CleanDirectory(rf'{technologySolutionDir}\TechnologySolution')
    CreateDirectory(rf'{technologySolutionDir}\TechnologySolution\V{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.000')
    ZipDirectory(tempDir.name, rf'{technologySolutionDir}\TechnologySolution\V{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.000\CYV_Starter_TS.zip')

    # sample project
    tempDir = tempfile.TemporaryDirectory()
    shutil.copytree(rf'{starterProject._projectDir}\Logical', rf'{tempDir.name}\Logical')
    shutil.copytree(rf'{starterProject._projectDir}\Physical', rf'{tempDir.name}\Physical')
    shutil.copy(rf'{starterProject._projectDir}\CYV_Starter.apj', tempDir.name)
    sample = rf'{technologySolutionDir}\Sample\CYV_Starter_{repo.majorVersion}_{repo.minorVersion}.zip'
    CleanDirectory(rf'{technologySolutionDir}\Sample')
    ZipDirectory(tempDir.name, sample)

    return (buildResult[0][1] < 3)

def BuildImportTool() -> bool:
    msbuild = r'C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe'
    if (os.path.exists(msbuild) == False):
        msbuild = r'C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe'
    solution = rf'{repoDir}\PLCImporter\PLCImporter\PLCImporter.sln'
    args = '-p:Configuration=Release;optimize=true;DebugSymbols=false;DebugType=None'
    result = subprocess.run(shlex.split(f'"{msbuild}" "{solution}" "{args}"'))
    removeDir(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\ImporterProgram')
    shutil.copytree(rf'{repoDir}\PLCImporter\PLCImporter\CYV2\bin\Release\\', rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\ImporterProgram\\')
    for f in os.listdir(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\ImporterProgram\\'):
        if (f.startswith('CYV.log')):
            os.remove(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\ImporterProgram\\' + f)
    return (result.returncode == 0)

def FixHelpNDocRegistry():
    aKey = winreg.OpenKey(winreg.HKEY_CURRENT_USER, r'SOFTWARE\IBE Software\HelpNDoc\V6', 0, winreg.KEY_ALL_ACCESS)
    userTemplate = winreg.QueryValueEx(aKey, 'UserPathTemplates')[0]
    print(userTemplate)
    if (userTemplate == ''):
        winreg.SetValueEx(aKey, 'UserPathTemplates', 0, winreg.REG_SZ, rf'{homeDir}\OneDrive - ABB\Documents\HelpNDoc\Templates\\')
    winreg.CloseKey(aKey)

def UpdateTemplate(helpTemplate) -> bool:
    FixHelpNDocRegistry()
    documentDir = rf'{homeDir}\OneDrive - ABB\Documents'
    CreateDirectory(rf'{documentDir}\HelpNDoc')
    CreateDirectory(rf'{documentDir}\HelpNDoc\Templates')
    CleanDirectory(rf'{documentDir}\HelpNDoc\Templates\\')
    removeDir(rf'{documentDir}\HelpNDoc\Templates\\')
    shutil.copytree(rf'{helpTemplate}',rf'{documentDir}\HelpNDoc\Templates')
    return True

def BuildHelp() -> bool:
    CreateDirectory(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help')
    CreateDirectory(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help\Help-en')
    CreateDirectory(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help\Help-en\ChangeYourViewHelp')
    CreateDirectory(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help\Help-en\ChangeYourViewHelp\ChangeYourViewHelp')
    CleanDirectory(rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help\Help-en\ChangeYourViewHelp\ChangeYourViewHelp')
    CleanDirectory(rf'{repoDir}\PLCImporter\PLCImporter\CYV2\Help')
    buildCmd = r'C:\Program Files (x86)\IBE Software\HelpNDoc 6\hnd6.exe'
    project = rf'{repoDir}\Documentation\CYV.hnd' + ''
    options = rf'-s build -x="Build HTML documentation" -o="Build HTML documentation:{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupData\Help\Help-en\ChangeYourViewHelp\ChangeYourViewHelp\CYV.html" -x="Build CHM documentation" -o="Build CHM documentation:{repoDir}\PLCImporter\PLCImporter\CYV2\Help\Change Your View.chm"'
    result = subprocess.run(shlex.split(f'"{buildCmd}" "{project}" {options}'))
    print(f'"{buildCmd}" "{project}" {options}')
    return (result.returncode == 0)

def UpdateVersionNumberInstaller() -> bool:
    p = re.compile('!define Version "([\d\.]+)"')
    with open(f'{repoDir}\InstallerSetup\\Installer AS Technology Solution\\SetupCYV_TS.nsh', 'r') as f:
        filedata = p.sub(f'!define Version "{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.{repo.count}"', f.read())
    with open(f'{repoDir}\InstallerSetup\\Installer AS Technology Solution\\SetupCYV_TS.nsh', 'w', newline='\r\n') as f:
        f.write(filedata)
    return True

def CreateInstaller() -> bool:
    installDir = rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\Install'
    CreateDirectory(installDir)
    CleanDirectory(installDir)
    UpdateVersionNumberInstaller()
    buildCmd = r'C:\Program Files (x86)\NSIS\makensis.exe'
    project = rf'{repoDir}\InstallerSetup\Installer AS Technology Solution\SetupTechnologySolutionComplete.nsi'
    options = f'/V1'
    result = subprocess.run(shlex.split(f'"{buildCmd}" "{project}" "{options}"'))
    if (result.returncode == 0):
        version = repo.majorVersion + '.' + repo.minorVersion.strip('0')
        teamDir = rf'{homeDir}\ABB\NA Product Management - CYV\Releases\{version}.x'
        CreateDirectory(teamDir)
        CreateDirectory(rf'{teamDir}\{version}.{repo.buildVersion}')
        shutil.copy(rf'{installDir}\AS4_TS_ChangeYourView_{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.{repo.count}.exe', rf'{teamDir}\{version}.{repo.buildVersion}')
    return (result.returncode == 0)

def CopyNeededExe(installerDir) -> bool:
    tempDir = rf'{installerDir}\temp\\'
    installDir = rf'{homeDir}\ABB\NA Product Management - CYV\Installer Setup'
    if (os.path.exists(installDir) == False):
        return False
    removeDir(tempDir)
    os.mkdir(tempDir)
    shutil.copy(rf'{installDir}\Technology Guarding.exe', tempDir)
    shutil.copy(rf'{installDir}\vcredist_x86_vs2010.exe', tempDir)
    return True

def BuildLaunchers(installerDir) -> bool:
    buildCmd = rf'{homeDir}\ABB\NA Product Management - CYV\Installer Setup\Bat_To_Exe_Converter_x64.exe'
    options = rf'/bat "{installerDir}\Launch Simulation.bat" /exe "{installerDir}\SetupData\Launch Simulation.exe" /icon "{installerDir}\SetupData\CYVLogo.ico" /overwrite /x64'
    result = subprocess.run(shlex.split(f'"{buildCmd}" {options}'))
    options = rf'/bat "{installerDir}\VisuKioskMode.bat" /exe "{installerDir}\SetupData\VisuKioskMode.exe" /icon "{installerDir}\SetupData\CYVLogo.ico" /overwrite /x64'
    result2 = subprocess.run(shlex.split(f'"{buildCmd}" {options}'))
    return ((result.returncode == 0) and (result2.returncode == 0))

def LoadProject() -> bool:
    global project
    project = ASProject.ASProject(projectDir)
    return True

if __name__ == '__main__':
    homeDir = Path.home()
    # if the build is running as the system (Jenkins) then change the home dir so that the installer is copied to the correct directory
    if homeDir.name.endswith('systemprofile'):
        homeDir = r'C:\Users\buchananw'
    print(homeDir)
    repoDir = os.getcwd().replace('Release Builder', '')
    projectDir = repoDir + r'\PLCImporter\CYV2'
    starterProjectDir = repoDir + r'\StarterProject\CYV_Starter'
    technologySolutionDir = repoDir + r'\InstallerSetup\Installer AS Technology Solution'
    libraryDir = technologySolutionDir + r'\Compiled Library'
    starterProjectDir = repoDir + r'\StarterProject\CYV_Starter'
    helpTemplate = repoDir + r'\Documentation\Templates'

    repo = gitInfo.GitRepo(repoDir)
    LoadProject()
    starterProject = ASProject.ASProject(starterProjectDir)
    buildSteps = [
                  lambda: CleanProject(project),
                  lambda: UpdateVersion(project),
                  lambda: LoadProject(),
                  lambda: BuildAndExportLibrary(project, libraryDir),
                  lambda: UpdateStarterProject(starterProject, libraryDir),
                  lambda: BuildAndExportStarterProject(starterProject, technologySolutionDir),
                  lambda: AsProjectCompile.CreateSimulationTarget(starterProject, 'CYV_ARsim', repoDir + r'\InstallerSetup\Installer AS Technology Solution\ArSim'),
                  lambda: UpdateTemplate(helpTemplate),
                  lambda: BuildHelp(),
                  lambda: BuildImportTool(),
                  lambda: CopyNeededExe(technologySolutionDir),
                  lambda: BuildLaunchers(technologySolutionDir),
                  lambda: CreateInstaller(),
                  ]

    for step in buildSteps:
        if (step() == False):
            print("Build failed, exiting")
            exit()

