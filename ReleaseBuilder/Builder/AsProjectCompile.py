"""
Description: This scipt accepts project location and compile the project with appropriate version of Automation studio project

Usage: AsProjectCompile.py "ProjectPath" "TempPath" "Outputpath"

Returns : Build result
    0 = No Errors
    1 = Warnings
    3 = Build Error

Example: c:/projects/CICD/ASHelperScripts/AsProjectCompile.py "C:\projects\CICD\MachineWVD" "C:\projects\CICD\MachineWVD\Temp" "C:\projects\CICD\MachineWVD\output"

"""

import InstalledAS
import ASProject
import os
import shutil
import sys
import argparse
import tempfile
import re
import subprocess

def PrintErorrsAndWarnings(output):
    regex = re.compile(r'.*(error|warning) \d+:.*')
    for l in output:
        if (regex.match(l) != None):
            print(l)

def Compile(Project, Configuration):
    __projectPath = Project._projectDir
    __compileAsPath = InstalledAS.ASInstallPath(Project)
    if (__compileAsPath == ''):
        return [['', '', 3]]

    buildResult = []
    regex = re.compile(r'Build: (\d+) error\(s\), (\d+) warning\(s\)')
    for config in Project._configurations:
        if (Configuration == Project._configurations[config]._name) or (Configuration == 'all'):
            cleanCommand = (__compileAsPath + r'\Bin-en\BR.AS.Build.exe'
                                + ' "' + __projectPath + '\\' + Project.projectName + '"'
                                + ' -cleanAll'
                                )
            result = subprocess.run(cleanCommand, cwd=__projectPath, capture_output=True, text=True)

            buildCommand = (__compileAsPath + r'\Bin-en\BR.AS.Build.exe'
                                + ' "' + __projectPath + '\\' + Project.projectName + '"'
                                + ' -buildMode "Build"'
                                + ' -c ' + Project._configurations[config]._name
                                )
            result = subprocess.run(buildCommand, cwd=__projectPath, capture_output=True, text=True)

            #print(result.stdout)
            errors = 0
            warnings = 0
            output = result.stdout.splitlines()
            r = regex.match(output[-2])
            if (r != None):
                errors = int(r.group(1))
                warnings = int(r.group(2))
                if (errors > 0) or (warnings > 0):
                    PrintErorrsAndWarnings(output)
            buildResult.append([Project._configurations[config]._name, result.returncode, errors, warnings])
    return buildResult

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='projectDir', required=True)
    parser.add_argument('-c', '--configuration', help='Configuration to build', dest='config', required=False, default='all')
    parser.add_argument('-w', '--maxwarnings', help='Maximum allowed warnings during build, -1 disables', dest='maxWarnings', required=False, default=-1)
    args = parser.parse_args()

    project = ASProject.ASProject(args.projectDir)
    results = Compile(project, args.config)
    compileResult = 0
    maxWarnings = 0
    for result in results:
        compileResult = int(result[1]) if (compileResult < int(result[1])) else compileResult
        maxWarnings = result[3] if ((result[3] > maxWarnings) and (args.maxWarnings != -1)) else maxWarnings

    if (compileResult == 1):
        compileResult = 1 if ((int(args.maxWarnings) > 0) and (maxWarnings > int(args.maxWarnings))) else 0

    print('Build Result = ' + str(compileResult))
    sys.exit(compileResult)

if __name__ == '__main__':
    main()
