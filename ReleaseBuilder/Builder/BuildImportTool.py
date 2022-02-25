import tempfile
import os
import shutil
import subprocess, shlex
import argparse
from DirUtils import removeDir

msbuild = r'C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe'
solution = rf'FrameworkImporter.sln'
buildOutput = rf'FrameworkImporter\bin\Release'

def BuildImportTool(dir, outputDir) -> bool:
    global msbuild, solution, buildOutput
    
    if (os.path.exists(msbuild) == False):
        msbuild = r'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\msbuild.exe'

    args = '-p:Configuration=Release;optimize=true;DebugSymbols=false;DebugType=None;PreBuildEvent='
    result = subprocess.run(shlex.split(f'"{msbuild}" "{dir}\\{solution}" "{args}"'))

    removeDir(rf'{outputDir}')
    test = rf'{outputDir}'
    shutil.copytree(rf'{dir}\{buildOutput}', rf'{outputDir}')
    for f in os.listdir(rf'{outputDir}'):
        if (f.startswith('CYV.log')):
            os.remove(rf'{outputDir}' + f)
    return (result.returncode == 0)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-o', '--output', help='Output Directory', dest='output', required=True)

    args = parser.parse_args()
    BuildImportTool(args.project, rf'{args.output}')