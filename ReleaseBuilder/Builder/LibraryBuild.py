
import argparse
import json
import os
import sys
import ASProject
import AsProjectCompile

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='projectDir', required=False, default=r'C:\Users\buchananw\Projects\BuR\ChangeYourView2\git3\PLCImporter\CYV2')
    parser.add_argument('-c', '--config', help='Configuration File Name', dest='config', required=False, default='Config1')
    parser.add_argument('-l', '--library', help='Library to export', dest='library', required=False, default='CYV')
    parser.add_argument('-d', '--directory', help='Directory to export library to', dest='exportLocation', required=False, default=r'C:\Users\buchananw\Projects\BuR\ChangeYourView2\git3\InstallerSetup\Installer AS Technology Solution\Compiled Library')
    args = parser.parse_args()
    project = ASProject.ASProject(args.projectDir)
    c = [c for c in project._configurations if (c == args.config)][0]
    #AsProjectCompile.Compile(project, args.config)
    project.exportLibrary(args.library, args.exportLocation)

if __name__ == '__main__':
    main()