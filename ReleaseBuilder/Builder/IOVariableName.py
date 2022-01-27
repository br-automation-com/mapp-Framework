# -*- coding: utf-8 -*-
"""
Created on Fri Aug  7 2020

@author: buchananw
"""

import sys
import argparse
import ASProject

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=False, default=r'C:\Users\buchananw\Projects\BuR\CICD\CodeMetrics\codeMetricsTest')
    parser.add_argument('-c', '--configuration', help='Configuration Name', dest='config', required=False, default='X20CPU')
    args = parser.parse_args()

    project = ASProject.ASProject(args.project)
    try:
        c = project._configurations[args.config]
        badVariables = []
        for module in c._modules:
            for var in module.mappedVariables:
                if (((var._type == ASProject.ModuleType.DigitalInput) and (var._name.startswith('di') == False) and (var._channel != 'ModuleOk')) or
                    ((var._type == ASProject.ModuleType.DigitalOutput) and (var._name.startswith('do') == False)) or
                    ((var._type == ASProject.ModuleType.AnalogInput) and (var._name.startswith('ai') == False)) or
                    ((var._type == ASProject.ModuleType.AnalogOutput) and (var._name.startswith('ao') == False))):
                    badVariables.append(var)

        if len(badVariables) > 0:
            for var in badVariables:
                print (var._task + ':' + var._name + ' does not meet IO naming guidelines')
            sys.exit(1)

    except IndexError:
        print (args.output + 'configuration not found')
        sys.exit(1)
    sys.exit(0)

if __name__ == '__main__':
    main()
