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

projectPath = ''
physicalDir= ''

def copy(exportDir, f):
    global projectPath
    fullPath = projectPath + '\\' + f
    if path.isdir(fullPath):
        shutil.copytree(fullPath, exportDir + '\\' + f)
    elif path.isfile(fullPath):
        #print(Path(f).parent)
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

def copySwDeployment(dir, tasks, libraries, mapps):
    global projectPath
    global physicalDir
    cpuDir = os.listdir(os.path.join(dir, physicalDir))[0]
    file = rf'{physicalDir}\{cpuDir}\Cpu.sw'
    shutil.copy(rf'{projectPath}\{file}', rf'{dir}\{file}')
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            task = ''
            if (line.find('<Task Name="') != -1):
                 task = line[line.find('Source="') + 8 : line.find('"', line.find('Source="') + 8)]
            lib = ''
            if (line.find('<LibraryObject Name="') != -1):
                 lib = line[line.find('Name="') + 6 : line.find('"', line.find('Name="') + 6)]
            if ((task == '') and (lib == '')) or (task in tasks) or (lib in libraries) or (lib in mapps):
                f.write(line)
        f.truncate()

def copyFileDevices(dir, fileDevices):
    global projectPath
    global physicalDir
    file = rf'{physicalDir}\Hardware.hw'
    shutil.copy(rf'{projectPath}\{file}', rf'{dir}\{file}')
    fileDeviceIndex = -1
    fileDeviceLines = []
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            if (fileDeviceIndex == -1):
                fileDeviceIndex = line.find('<Group ID="FileDevice')
            elif ((line.find('Group ID="') != -1) or (line.find('ID="FileDevice') == -1)):
                if (fileDevice in fileDevices):
                    for l in fileDeviceLines:
                        f.write(l)
                fileDeviceIndex = line.find('<Group ID="FileDevice')
                fileDeviceLines = []
            if (fileDeviceIndex != -1):
                fileDeviceLines.append(line)
                if ((line.find('FileDeviceName') != -1) and (line.find('Value="') != -1)):
                    fileDevice = line[line.find('Value="') + 7 : line.find('"', line.find('Value="') + 7)]
            if ((fileDeviceIndex == -1) and ((line.find('<?') != -1) or (line.find('Hardware') != -1) or (line.find('Module') != -1))):
                f.write(line)
        f.truncate()

def enableOpcUa(dir):
    global physicalDir
    file = rf'{dir}\{physicalDir}\Hardware.hw'
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            if (line.find('</Module>') != -1):
                f.write('    <Parameter ID="ActivateOpcUa" Value="1" />\n')
            f.write(line)
        f.truncate()

def setUserPartitionSize(dir):
    global projectPath
    global physicalDir
    file = rf'{physicalDir}\Hardware.hw'

    userPartition = ''
    with open(os.path.join(projectPath, file), "r") as f:
        new_f = f.readlines()
        for line in new_f:
            if (line.find('<Parameter ID="UserPartitionSize"') != -1):
                userPartition = line

    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            if (line.find('</Module>') != -1):
                f.write(userPartition)
            f.write(line)
        f.truncate()

def cleanPackage(exportName, exportDir):
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

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-c', '--config', help='Configuration File Name', dest='config', required=True)
    parser.add_argument('-s', '--physical', help='Physical Directory', dest='physical', required=True)
    parser.add_argument('-o', '--output', help='Output Directory', dest='output', required=True)
    parser.add_argument('-z', '--zip', help='zip output directory', dest='zip', required=False, default=True)
    global projectPath
    global physicalDir
    args = parser.parse_args()
    projectPath = args.project
    physicalDir = args.physical

    tempDir = tempfile.TemporaryDirectory()    
    exportDir = tempDir.name + '\\' + Path(args.config).stem
    os.mkdir(exportDir)

    config = args.config
    if (path.exists(config) != True):
        print('config file not found in ' + config)
        return 0
    export = json.load(open(config))
    if ('libraries' in export):
        for l in export['libraries']:
            copy(exportDir, 'Logical\\Libraries\\' + l)
    if ('mapp' in export):
        for m in export['mapp']:
            copy(exportDir, 'Logical\\Libraries\\' + m)
    if ('files' in export):
        for f in export['files']:
            copy(exportDir, f)
    if ('physical' in export):
        copySwDeployment(exportDir, export['physical']["deployTasks"], export["libraries"], export["mapp"])
        copyFileDevices(exportDir, export['physical']["fileDevices"])
        if (('enableOpcUa' in export['physical']) and (export['physical']['enableOpcUa'] == True)):
            enableOpcUa(exportDir)
        if (('UserPartitionSize' in export['physical']) and (export['physical']['UserPartitionSize'] == True)):
            setUserPartitionSize(exportDir)

    cleanPackage(args.output + '\\' + Path(args.config).stem, exportDir)
    if (args.zip == True):
        shutil.make_archive(args.output + '\\' + Path(args.config).stem, 'zip', exportDir)
    else:
        shutil.copytree(exportDir, args.output + '\\' + Path(args.config).stem)

    if ('mappViewfiles' in export) == False:
        return

    removeDir(exportDir)
    os.mkdir(exportDir)
    if ('libraries' in export):
        for l in export['libraries']:
            copy(exportDir, 'Logical\\Libraries\\' + l)
    if ('mapp' in export):
        for m in export['mapp']:
            copy(exportDir, 'Logical\\Libraries\\' + m)
    if ('files' in export):
        for f in export['files']:
            copy(exportDir, f)
    if ('mappViewfiles' in export):
        for f in export['mappViewfiles']:
            copy(exportDir, f)
    if ('physical' in export):
        copySwDeployment(exportDir, export['physical']["deployTasks"], export["libraries"], export["mapp"])
        copyFileDevices(exportDir, export['physical']["fileDevices"])
        enableOpcUa(exportDir)
        if (('UserPartitionSize' in export['physical']) and (export['physical']['UserPartitionSize'] == True)):
            setUserPartitionSize(exportDir)

    cleanPackage(args.output + '\\' + Path(args.config).stem + 'MappView', exportDir)
    if (args.zip == True):
        shutil.make_archive(args.output + '\\' + Path(args.config).stem + 'MappView', 'zip', exportDir)
    else:
        shutil.copytree(exportDir, args.output + '\\' + Path(args.config).stem + 'MappView')

if __name__ == '__main__':
    main()