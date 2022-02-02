import argparse
import json
import os
from os import makedirs, path, listdir
from queue import Empty
import re
from zipfile import ZipFile
import tempfile
import shutil
from pathlib import Path
import glob
from DirUtils import removeDir

def updateLink(dir, file, version):
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            object = line[line.find('>') + 1 : line.find('</Objects>') - 9]
            if (object == ''):
                if (line.find(rf'C:\BrAutomation\AS410\AS\TechnologySolutions\mapp Framework\V')):
                    line = rf'<Object Type="File" Reference="true">C:\BrAutomation\AS410\AS\TechnologySolutions\mapp Framework\V{version}\Importer\FrameworkImporter.exe</Object>'
                f.write(line)
        f.truncate()


def CreateTechnolo(technologySolutionDir, version):
    # technology solution
    CleanDirectory(rf'{technologySolutionDir}\TechnologySolution')
    CreateDirectory(rf'{technologySolutionDir}\TechnologySolution\V{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.000')
    ZipDirectory(tempDir.name, rf'{technologySolutionDir}\TechnologySolution\V{repo.majorVersion}.{repo.minorVersion}.{repo.buildVersion}.000\CYV_Starter_TS.zip')

    ZipDirectory(tempDir.name, sample)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-n', '--name', help='Project Name', dest='name', required=True)
    parser.add_argument('-v', '--version', help='Project Version', dest='version', required=False, default="V0.0.9.000")
    
    args = parser.parse_args()

    updateLink(rf'{args.project}\Logical\mappFrameworkImporter\\', 'Package.pkg', version)
    tempDir = tempfile.TemporaryDirectory()
    shutil.copytree(rf'{args.project}\Logical', rf'{tempDir.name}\Logical')
    shutil.copy(rf'{args.project}\AdvancedExport.xml', rf'{tempDir.name}\AdvancedExport.xml')
    shutil.copy(rf'{args.project}\Image.png', rf'{tempDir.name}\Image.png')


if __name__ == '__main__':
    main()