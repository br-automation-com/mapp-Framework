import argparse
import re
import subprocess, shlex
import shutil
import os
from DirUtils import CreateDirectory, CleanDirectory, removeDir

def UpdateVersionNumberInstaller(dir, headerFile, version) -> bool:
    p = re.compile('!define Version ".+"')
    fileName = fr'{dir}\{headerFile}' 
    with open(fileName, 'r') as f:
        filedata = p.sub(f'!define Version "{version}"', f.read())
    with open(fileName, 'w', newline='\r\n') as f:
        f.write(filedata)
    return True

def CreateInstaller(dir, installerFileName, version) -> bool:
    installDir = rf'{dir}\Install'
    CreateDirectory(installDir)
    CleanDirectory(installDir)
     
    buildCmd = r'C:\Program Files (x86)\NSIS\makensis.exe'
    project = rf'{dir}\SetupTechnologySolutionComplete.nsi'
    options = f'/V1'
    result = subprocess.run(shlex.split(f'"{buildCmd}" "{project}" "{options}"'))
    #if (result.returncode == 0):
    #    version = repo.majorVersion + '.' + repo.minorVersion.strip('0')
    #    teamDir = rf'{homeDir}\ABB\NA Product Management - CYV\Releases\{version}.x'
    #    CreateDirectory(teamDir)
    #    CreateDirectory(rf'{teamDir}\{version}.{repo.buildVersion}')
    #    shutil.copy(rf'{installDir}\{installerFileName}_{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.{repo.count}.exe', rf'{teamDir}\{version}.{repo.buildVersion}')
    return (result.returncode == 0)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-n', '--name', help='Project Name', dest='name', required=True)
    parser.add_argument('-v', '--version', help='Project Version', dest='version', required=False, default="V0.0.9.000")
    args = parser.parse_args()
    version = args.version.replace('V', '')

    directory = rf'{args.project}\InstallerSetup\TechnologySolution\\'
    for f in os.listdir(directory):
        if f != args.version:
            removeDir(os.path.join(directory, f))

    shutil.copy(rf'{args.project}\InstallerSetup\FrameworkImporter_TS.zip', rf'{args.project}\InstallerSetup\TechnologySolution\{args.version}\FrameworkImporter_TS.zip')

    UpdateVersionNumberInstaller(rf'{args.project}\InstallerSetup', f'Setup{args.name}_TS.nsh', f'{version}')
    CreateInstaller(f'{args.project}\InstallerSetup', f'AS4_TS_{args.name}', f'{version}')
