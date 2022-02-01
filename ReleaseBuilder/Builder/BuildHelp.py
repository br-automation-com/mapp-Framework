import argparse
import shutil
import subprocess, shlex
import winreg
from pathlib import Path
from DirUtils import CreateDirectory, removeDir, CleanDirectory

homeDir = ''

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

def BuildHelp(projectDir, outputDir, name) -> bool:
    CreateDirectory(rf'{projectDir}\{outputDir}')
    CreateDirectory(rf'{projectDir}\{outputDir}\Help-en')
    CreateDirectory(rf'{projectDir}\{outputDir}\Help-en\{name}Help')
    CreateDirectory(rf'{projectDir}\{outputDir}\Help-en\{name}Help\{name}Help')
    CleanDirectory(rf'{projectDir}\{outputDir}\Help-en\{name}Help\{name}Help')
    buildCmd = r'C:\Program Files (x86)\IBE Software\HelpNDoc 6\hnd6.exe'
    project = rf'{projectDir}\Documentation\{name}.hnd' + ''
    options = rf'-s build -x="Build HTML documentation" -o="Build HTML documentation:{projectDir}\{outputDir}\\Help-en\{name}Help\{name}Help\{name}.html"'
    result = subprocess.run(shlex.split(f'"{buildCmd}" "{project}" {options}'))
    print(f'"{buildCmd}" "{project}" {options}')
    return (result.returncode == 0)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-n', '--name', help='name', dest='name', required=True)
    args = parser.parse_args()

    homeDir = Path.home()
    # if the build is running as the system (Jenkins) then change the home dir so that the installer is copied to the correct directory
    if homeDir.name.endswith('systemprofile'):
        homeDir = r'C:\Users\buchananw'
    print(homeDir)

    UpdateTemplate(rf'{args.project}\Documentation\Templates')
    BuildHelp(args.project, r'\ReleaseBuilder\InstallerSetup\Help', args.name)
