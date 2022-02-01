
import InstalledAS
import ASProject
import subprocess
import shutil
import sys
import argparse
import tempfile
import re

def CreateSimulationTarget(Project, Configuration, ArSimDir) -> bool:
    print('Creating ArSim installation')
    __projectPath = Project._projectDir
    __compileAsPath = InstalledAS.ASInstallPath(Project)
    if (__compileAsPath == ''):
        return False

    buildCommand = (__compileAsPath + r'\Bin-en\BR.AS.Build.exe '
                        + '"' + __projectPath + '\\' + Project.projectName + '"'
                        + ' -all'
                        + ' -c ' + Project._configurations[Configuration]._name
                        + ' -buildRUCPackage'
                        )
    result = subprocess.run(buildCommand, capture_output=True, text=True)

    tempDir = tempfile.TemporaryDirectory()
    __cpuName = Project._configurations[Configuration]._cpuName

    with open(f'{tempDir.name}\\createArSim.pil', 'x') as f:
        f.write(f'CreateARsimStructure "{__projectPath}\\Binaries\\{Configuration}\\{__cpuName}\\RUCPackage\\RUCPackage.zip", "{ArSimDir}", "Start=-"')

    asVersion = re.search('AS\d+', __compileAsPath).group().replace('AS', '')
    pviCmd = r'C:\BrAutomation\PVI\V' + asVersion[0] + '.' + asVersion[1] + r'\PVI\Tools\PVITransfer\PVITransfer.exe'
    pviOptions = rf'-silent "{tempDir.name}\createArSim.pil"'
    subprocess.run(f'{pviCmd} {pviOptions}')
    print('ArSim created')
    return True

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='projectDir', required=True)
    parser.add_argument('-c', '--configuration', help='Configuration to build', dest='config', required=True)
    parser.add_argument('-s', '--simulationDirectory', help='ArSim installation directory', dest='simulationDir', required=True)
    args = parser.parse_args()

    project = ASProject.ASProject(args.projectDir)
    result = CreateSimulationTarget(project, args.config, args.simulationDir)
    sys.exit(0)
    return

if __name__ == '__main__':
    main()