# -*- coding: utf-8 -*-
"""
Created on Thu Jul  2 14:16:39 2020

@author: buchananw
"""

import sys
import argparse
import ASProject
import xml.etree.ElementTree as ET

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=False, default=r'C:\Users\buchananw\Projects\BuR\CICD\CodeMetrics\codeMetricsTest')
    parser.add_argument('-c', '--configuration', help='Configuration Name', dest='config', required=False, default='X20CPU')
    parser.add_argument('-o', '--output', help='Output Type', dest='output', required=False, default='Warning')
    args = parser.parse_args()

    project = ASProject.ASProject(args.project)
    try:
        c = project._configurations[args.config]
        [print (c._name + ' (Module: ' + m._name + ') ' + args.output + ': ' + m._name + ' module not supervised') for m in c.modulesNotSupervised()]
        if (len(c.modulesNotSupervised()) > 0):
            sys.exit(1)
    except IndexError:
        print (args.output + 'configuration not found')
        sys.exit(1)
    sys.exit(0)

if __name__ == '__main__':
    main()
