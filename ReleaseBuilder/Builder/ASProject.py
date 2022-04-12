# -*- coding: utf-8 -*-
"""
Created on Thu Jul  2 14:16:39 2020

@author: buchananw
"""

import xml.etree.ElementTree as ET
import re
import os.path
from os import path, listdir
from enum import Enum
from zipfile import ZipFile
import tempfile
import shutil
from os.path import basename
from DirUtils import removeDir

class ModuleType(Enum):
    Unknown = 0
    DigitalInput = 1
    DigitalOutput = 2
    AnalogInput = 3
    AnalogOutput = 4

class MappedVariable:
    def __init__(self, name, channel, type):
        var = list(filter(lambda a: a != '', name.split(':')))
        if len(var) > 1:
            self._task = var[0]
            self._name = var[1]
        else:
            self._task = 'Global'
            self._name = var[0]
        self._channel = channel
        self._type = type

class IoModule:
    @staticmethod
    def Namespace():
        return '{http://br-automation.co.at/AS/Hardware}'

    @staticmethod
    def isIoModule(type) -> bool:
        # match any X20 or X67 module that isn't a backplane, terminal block, or cpu
        return re.search(r'(^(X20|X67)(?!(BM|TB|CP|BB)).*)|(Modbus|OpcUa).*', type)

    def __init__(self, name, lineNumber = 0):
        self._name = name
        self.moduleOkMonitored = False
        self.mappedVariables = []
        self._lineNumber = lineNumber

    def isModuleOkMonitored(self) -> bool:
        return self.moduleOkMonitored

    def addMappedVariable(self, channel, variableName, type) -> None:
        self.mappedVariables.append(MappedVariable(variableName, channel, type))
        if (channel == 'ModuleOk'):
            self.moduleOkMonitored = True

class ASTask:
    @staticmethod
    def Namespace():
        return '{http://br-automation.co.at/AS/Package}'
    @staticmethod
    def Type():
        return 'Program'
    def __init__(self, name, directory):
        self._name = name
        self._directory = directory
        #print ('adding program ' + name)

class ASLibrary:
    @staticmethod
    def Namespace():
        return '{http://br-automation.co.at/AS/Library}'
    @staticmethod
    def Type():
        return 'Library'
    @staticmethod
    def __isSourceFile(fileName):
        return (fileName.endswith('.c') or fileName.endswith('.h') or fileName.endswith('.st') or fileName.endswith('.ab') or fileName.endswith('.cpp') or fileName.endswith('.hpp'))

    def __init__(self, name, directory, projectDir, configurations, description=''):
        self.name = name
        self._directory = directory
        self._projectDir = projectDir
        self._configurations = configurations
        libraryFile = [f for f in listdir(directory) if f.endswith('.lby')][0]
        root = ET.parse(directory + '\\' + libraryFile).getroot()
        self._type = root.get('SubType')
        self._description = root.get('Description')
        if (self._description is None):
            self._description = description
        self._version = root.get('Version')
        if (self._version is None):
            self._version = 'V1.00.0'
        if (self._version.startswith('V') == False):
            self._version = 'V' + self._version
        startMinor = self._version.find('.') + 1
        if ((self._version.find('.', startMinor) - startMinor) < 2):
            self._version = self._version.replace('.', '.0', 1)
        self._files = []
        for file in root.find(ASLibrary.Namespace() + 'Files').findall(ASLibrary.Namespace() + 'File'):
            self._files.append(file.text)

        self._dependencies = []
        dependencies = root.find(ASLibrary.Namespace() + 'Dependencies')
        if (dependencies != None):
            for d in dependencies.findall(ASLibrary.Namespace() + 'Dependency'):
                self._dependencies.append(d.get('ObjectName'))

    def export(self, directory):
        if (directory.endswith('\\') == False):
            directory = directory + '\\'

        with tempfile.TemporaryDirectory() as tmpdirname:
            exportDir = tmpdirname + '\\' + self._version
            os.mkdir(exportDir)
            [shutil.copyfile(self._directory + '\\' + f, exportDir + '\\' + f) for f in self._files if (ASLibrary.__isSourceFile(f) == False)]
            ET.register_namespace('', 'http://br-automation.co.at/AS/Library')
            libraryFile = [f for f in listdir(self._directory) if f.endswith('.lby')][0]
            shutil.copyfile(self._directory + '\\' + libraryFile, exportDir + '\\Binary.lby')
            tree = ET.parse(exportDir + '\\Binary.lby')
            tree.getroot().set('SubType', 'Binary')
            tree.getroot().set('Description', self._description)
            files = tree.getroot().find(ASLibrary.Namespace() + 'Files')
            [files.remove(f) for f in files.findall(ASLibrary.Namespace() + 'File') if (ASLibrary.__isSourceFile(f.text))]
            tree.write(exportDir + '\\Binary.lby', xml_declaration=True, encoding='utf-8')

            os.mkdir(exportDir + '\\SG3')
            os.mkdir(exportDir + '\\SGC')
            os.mkdir(exportDir + '\\SG4')
            shutil.copyfile(self._projectDir + '\\Temp\\Includes\\' + self.name + '.h', exportDir + '\\SG3\\' + self.name + '.h')
            shutil.copyfile(self._projectDir + '\\Temp\\Includes\\' + self.name + '.h', exportDir + '\\SGC\\' + self.name + '.h')
            shutil.copyfile(self._projectDir + '\\Temp\\Includes\\' + self.name + '.h', exportDir + '\\SG4\\' + self.name + '.h')
            for c in self._configurations:
                config = self._configurations[c]
                if (os.path.isfile(self._projectDir + '\\Temp\\Objects\\' + config._name + '\\ConfigurationOptions.opt') == False):
                    continue
                root = ET.parse(self._projectDir + '\\Temp\\Objects\\' + config._name + '\\ConfigurationOptions.opt').getroot()
                target = root.get('Target')
                shutil.copyfile(self._projectDir + '\\Temp\\Archives\\' + config._name + '\\' + config._cpuName + '\\lib' + self.name + '.a', exportDir + '\\' + target + '\\lib' + self.name + '.a')
                shutil.copyfile(self._projectDir + '\\Binaries\\' + config._name + '\\' + config._cpuName + '\\' + self.name + '.br', exportDir + '\\' + target + '\\' + self.name + '.br')

            if (os.path.exists(directory + self.name + '\\' + self._version)):
                shutil.rmtree(directory + self.name + '\\' + self._version)
            shutil.copytree(exportDir, directory + self.name + '\\' + self._version)

class ASPackage:
    @staticmethod
    def Namespace():
        return '{http://br-automation.co.at/AS/Package}'
    @staticmethod
    def Type():
        return 'Package'

    def __init__(self, name, directory, projectDir, configurations):
        self._name = name
        self._directory = directory
        self.packages = []
        self.tasks = []
        self.files = []
        self.libraries = []
        objects = ET.parse(directory + '\\Package.pkg').getroot().find(ASPackage.Namespace() + 'Objects')
        for o in objects.findall(ASPackage.Namespace() + 'Object'):
            if ((os.path.isdir(self._directory + '\\' + o.text)) and (o.get('Type') == ASPackage.Type())):
                self.packages.append(ASPackage(o.text, self._directory + '\\' + o.text, projectDir, configurations))
            elif ((os.path.isdir(self._directory + '\\' + o.text)) and (o.get('Type') == ASLibrary.Type())):
                try:
                    description = o.attrib['Description']
                    self.libraries.append(ASLibrary(o.text, self._directory + '\\' + o.text, projectDir, configurations, description))
                except:
                    self.libraries.append(ASLibrary(o.text, self._directory + '\\' + o.text, projectDir, configurations))
            elif ((os.path.isdir(self._directory + '\\' + o.text)) and (o.get('Type') == ASTask.Type())):
                self.tasks.append(ASTask(o.text, self._directory + '\\' + o.text))
            elif ((os.path.isfile(self._directory + '\\' + o.text)) and (o.get('Type') == 'File')):
                self.files.append(o.text)

class ASConfiguration:
    @staticmethod
    def Namespace():
        return '{http://br-automation.co.at/AS/Physical}'

    @staticmethod
    def CpuNamespace():
        return '{http://br-automation.co.at/AS/Cpu}'

    @staticmethod
    def ConfigurationNamespace():
        return '{http://br-automation.co.at/AS/Configuration}'

    @staticmethod
    def Type():
        return 'Configuration'

    @staticmethod
    def __ioType(type):
        if '%IX' in type:
            return ModuleType.DigitalInput
        elif '%QX' in type:
            return ModuleType.DigitalOutput
        elif '%IW' in type:
            return ModuleType.AnalogInput
        elif '%QW' in type:
            return ModuleType.AnalogOutput
        return ModuleType.Unknown

    def __init__(self, name, directory):
        self._name = name
        self._modules = []
        self._directory = directory
        self._cpuName = ''
        self.readCpuName()
        self.readARVersion()
        self.readPLCType()
        self.__ioMapFile = directory + '\\' + self._cpuName + '\\IoMap.iom'
        self.findIoModules()
        self.readIoMapp()
        #print ('added ' + name)

    def findIoModules(self):
        modules = [module for module in ET.parse(self._directory + '\\Hardware.hw').getroot().findall(IoModule.Namespace() + 'Module') if IoModule.isIoModule(module.get('Type'))]
        for m in modules:
            self._modules.append(IoModule(m.get('Name')))

    def readCpuName(self):
        file = self._directory + '\\Config.pkg'
        objects = ET.parse(file).getroot().find(ASConfiguration.ConfigurationNamespace() + 'Objects')
        self._cpuName = [o.text for o in objects.findall(ASConfiguration.ConfigurationNamespace() + 'Object') if o.get('Type') == 'Cpu'][0]

    def readARVersion(self):
        cpu = ET.parse(self._directory + rf'\{self._cpuName}\Cpu.pkg').getroot().find(ASConfiguration.CpuNamespace() + 'Configuration')
        self._arVersion = cpu.find(ASConfiguration.CpuNamespace() + 'AutomationRuntime').get('Version')

    def readPLCType(self):
        self._plcType = ET.parse(self._directory + rf'\{self._cpuName}\Cpu.pkg').getroot().find(ASConfiguration.CpuNamespace() + 'Configuration').get('ModuleId')

    def findIOModule(self, modules, name) -> IoModule:
        for m in self._modules:
            if (m._name == name):
                return m
        return None

    #::Auxiliary:oCameraLight AT %IX."SIO_Safety".ModuleOk;
    def readIoMapp(self) -> None:
        if (path.exists(self.__ioMapFile) != True):
            print ('IoMap does not exist')
            return
        f = open(self.__ioMapFile)
        regex = re.compile(r'\s*(.*)\sAT\s(%.*)\."(.*)"\.(.*);')
        for var in [regex.match(line) for line in f if (regex.match(line) is not None)]:
            module = self.findIOModule(self._modules, var.group(3))
            if (module is not None):
                module.addMappedVariable(var.group(4), var.group(1), ASConfiguration.__ioType(var.group(2)))
        f.close()

    def areAllModuleSupervised(self) -> bool:
        for module in self._modules:
            if (module.isModuleOkMonitored() != True):
                return False
        return True

    def modulesNotSupervised(self) -> IoModule:
        return [m for m in self._modules if m.isModuleOkMonitored() != True]

class ASProject:
    @staticmethod
    def __projectName(projectDir):
        for file in os.listdir(projectDir):
            if file.endswith('.apj'):
                return file

    @staticmethod
    def __version(projectDir):
        for file in os.listdir(projectDir):
            if file.endswith('.apj'):
                apj = open(projectDir + '\\' + file).read()
                return str(re.findall('<?AutomationStudio Version="(.*)"', apj)[0])

    version = []
    def __init__(self, projectDir):
        self._projectDir = projectDir
        self.version = ASProject.__version(projectDir)
        self.projectName = ASProject.__projectName(projectDir)
        self._configurations = {}
        objects = ET.parse(projectDir + '\\Physical\\Physical.pkg').getroot().find(ASConfiguration.Namespace() + 'Objects')
        [self.addConfiguration(ASConfiguration(o.text, projectDir + '\\Physical\\' + o.text)) for o in objects.findall(ASConfiguration.Namespace() + 'Object') if ((os.path.isdir(projectDir + '\\Physical\\' + o.text)) and (o.get('Type') == ASConfiguration.Type()))]

        self._packages = []
        objects = ET.parse(projectDir + '\\Logical\\Package.pkg').getroot().find(ASPackage.Namespace() + 'Objects')
        [self.addPackage(ASPackage(o.text, projectDir + '\\Logical\\' + o.text, projectDir, self._configurations)) for o in objects.findall(ASPackage.Namespace() + 'Object') if ((os.path.isdir(projectDir + '\\Logical\\' + o.text)) and (o.get('Type') == ASPackage.Type()))]

    def addConfiguration(self, configuration):
        self._configurations[configuration._name] = configuration

    def addPackage(self, package):
        self._packages.append(package)

    def IsCompatibleVersion(self, version):
        try:
            asVersion = version.split('.')[0] + '.' + version.split('.')[1]
            projectVersion = self.version.split('.')[0] + '.' + self.version.split('.')[1]
            return (projectVersion == asVersion)
        except:
            return False

    def CleanProject(self):
        removeDir(self._projectDir + r'\Binaries')
        removeDir(self._projectDir + r'\Temp')
        removeDir(self._projectDir + r'\Diagnosis')

    def _findLibrary(self, package, libraryName):
        for library in package.libraries:
            if (library.name == libraryName):
                return library
        for p in package.packages:
            return self._findLibrary(p, libraryName)

    def exportLibrary(self, libraryName, directory):
        lib = None
        for package in self._packages:
            lib = self._findLibrary(package, libraryName)
            if (lib is not None):
                break
        if lib is not None:
            lib.export(directory)
            return True
        return False

    def export(self, files, directory, name):
        if (directory.endswith('\\') == False):
            directory = directory + '\\'

        with tempfile.TemporaryDirectory() as tmpdirname:
            exportDir = tmpdirname + '\\' + name
            os.mkdir(exportDir)
            for f in files:
                shutil.copytree(exportDir, f)
                