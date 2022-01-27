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

projectPath = ''

def copy(exportDir, f):
    global projectPath
    fullPath = projectPath + '\\' + f
    if path.isdir(fullPath):
        shutil.copytree(fullPath, exportDir + '\\' + f)
    elif path.isfile(fullPath):
        print(Path(f).parent)
        if (path.exists(exportDir + '\\' + str(Path(f).parent)) == False):
            os.makedirs(exportDir + '\\' + str(Path(f).parent))
        shutil.copy(fullPath, exportDir + '\\' + f)

def cleanPackageFile(dir, file):
    files = os.listdir(dir)
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            object = line[line.find('>') + 1 : line.find('</Objects>') - 9]
            if (object == '') or (object in files):
                f.write(line)
        f.truncate()

def createZip(exportName, exportDir):
    global projectPath
    for root, dirs, files in os.walk(exportDir):
        for name in dirs:
            relativePath = os.path.join(root.replace(exportDir, ''), name)
            if (relativePath.startswith('\\')):
                relativePath = relativePath.replace('\\', '', 1)
            exportPackageFile = glob.glob(os.path.join(root, name) + '\\*.pkg')
            projectPackageFile = glob.glob(os.path.join(projectPath, relativePath) + '\\*.pkg')
            if ((len(exportPackageFile) == 0) and (len(projectPackageFile) != 0)):
                shutil.copy(projectPath + '\\' + relativePath + '\\' + Path(projectPackageFile[0]).name, exportDir + '\\' + relativePath + '\\' + Path(projectPackageFile[0]).name)
                cleanPackageFile(exportDir + '\\' + relativePath, Path(projectPackageFile[0]).name)
    
    shutil.make_archive(exportName, 'zip', exportDir)

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-c', '--config', help='Configuration File Name', dest='config', required=True)
    parser.add_argument('-o', '--output', help='Output Directory', dest='output', required=True)
    global projectPath

    args = parser.parse_args()
    projectPath = args.project

    tempDir = tempfile.TemporaryDirectory()    
    exportDir = tempDir.name + '\\' + Path(args.config).stem
    os.mkdir(exportDir)

    config = args.config
    if (path.exists(config) != True):
        print('config file not found in ' + config)
        return 0
    files = json.load(open(config))
    for l in files[0]['libraries']:
        copy(exportDir, 'Logical\\Libraries\\' + l)
    for m in files[1]['mapp']:
        copy(exportDir, 'Logical\\Libraries\\' + m)
    for f in files[2]['files']:
        copy(exportDir, f)
    createZip(args.output + '\\' + Path(args.config).stem, exportDir)

    shutil.rmtree(exportDir)
    os.mkdir(exportDir)
    for l in files[0]['libraries']:
        copy(exportDir, 'Logical\\Libraries\\' + l)
    for m in files[1]['mapp']:
        copy(exportDir, 'Logical\\Libraries\\' + m)
    for f in files[2]['files']:
        copy(exportDir, f)
    for f in files[3]['mappViewfiles']:
        copy(exportDir, f)
    createZip(args.output + '\\' + Path(args.config).stem + 'MappView', exportDir)

if __name__ == '__main__':
    main()