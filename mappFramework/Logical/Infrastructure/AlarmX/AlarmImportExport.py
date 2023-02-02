import csv
import argparse
import os
from lxml import etree as et
from dataclasses import dataclass

@dataclass
class EdgeAlarm:
	retain: bool
	asynchronous: bool

@dataclass
class PersistentAlarm:
	retain: bool
	asynchronous: bool

@dataclass
class DiscreteValueMonitoring:
	monitoredPV: str
	triggerValues: list
	delay: str

@dataclass
class Level:
	limit: any
	text: str

@dataclass
class LevelMonitoring:
	monitoredPV: str
	delay: str
	lowLimit: Level
	highLimit: Level
	lowLowLimit: Level = None
	highHighLimit: Level = None

@dataclass
class DeviationMonitoring:
	monitoredPV: str
	setpointPV: str
	delay: str
	lowLimit: Level
	highLimit: Level
	lowLowLimit: Level = None
	highHighLimit: Level = None

@dataclass
class RateOfChangeMonitoring:
	monitoredPV: str
	delay: str
	lowLimit: Level
	highLimit: Level
	lowLowLimit: Level = None
	highHighLimit: Level = None
	
class Alarm:
	def __init__(self):
		self._name = ''
		self._message = None
		self._severity = None
		self._behavior = None
		self._code = None  
	
	def parseDict(self, alarmDict: dict):
		self._name = alarmDict['Name']
		self._message = alarmDict['Message']
		self._severity = alarmDict['Severity']
		self._code = alarmDict['Code']
		self._behavior = None
		if (alarmDict['Behavior'] == 'EdgeAlarm'):
			self._behavior = EdgeAlarm(alarmDict['Retain'], alarmDict['Async'])
		elif (alarmDict['Behavior'] == 'PersistentAlarm'):
			self._behavior = PersistentAlarm(alarmDict['Retain'], alarmDict['Async'])
		elif (alarmDict['Behavior'] == 'DiscreteValueMonitoring'):
			self._behavior = DiscreteValueMonitoring(alarmDict['Monitored PV'], alarmDict['Trigger Values'].strip('][').replace("'", '').split(', '), alarmDict['Delay'])
		elif (alarmDict['Behavior'] == 'LevelMonitoring'):
			self._behavior = LevelMonitoring(alarmDict['Monitored PV'], alarmDict['Delay'], Level(alarmDict['Low Limit'], alarmDict['Low Limit Text']), Level(alarmDict['High Limit'], alarmDict['High Limit Text']), Level(alarmDict['Low Low Limit'], alarmDict['Low Low Limit Text']), Level(alarmDict['High High Limit'], alarmDict['High High Limit Text']))
		elif (alarmDict['Behavior'] == 'DeviationMonitoring'):
			self._behavior = DeviationMonitoring(alarmDict['Monitored PV'], alarmDict['Delay'], alarmDict['Set Point PV'], Level(alarmDict['Low Limit'], alarmDict['Low Limit Text']), Level(alarmDict['High Limit'], alarmDict['High Limit Text']), Level(alarmDict['Low Low Limit'], alarmDict['Low Low Limit Text']), Level(alarmDict['High High Limit'], alarmDict['High High Limit Text']))
		elif (alarmDict['Behavior'] == 'RateOfChangeMonitoring'):
			self._behavior = RateOfChangeMonitoring(alarmDict['Monitored PV'], alarmDict['Delay'], Level(alarmDict['Low Limit'], alarmDict['Low Limit Text']), Level(alarmDict['High Limit'], alarmDict['High Limit Text']), Level(alarmDict['Low Low Limit'], alarmDict['Low Low Limit Text']), Level(alarmDict['High High Limit'], alarmDict['High High Limit Text']))
		return self
	
	def _parseLevel(self, element: et.Element) -> Level:
		if (element is None): return None
		if (element.find('Property[@ID="Limit"]') is not None):
			value = element.find('Property[@ID="Limit"]').attrib['Value']
		elif (element.find('Property[@ID="LimitPV"]') is not None):
			value = element.find('Property[@ID="LimitPV"]').attrib['Value']
		text = element.find('Property[@ID="LimitText"]').attrib['Value']
		level = Level(value, text)
		return level

	def _parseLevels(self, selector: et.Element):
		low = None
		lowLow = None
		high = None
		highHigh = None
		levelElement = selector.find('Group/Selector[@ID="LowLimitEnable"]')
		if (levelElement is not None):
			low = self._parseLevel(levelElement)
			lowLow = self._parseLevel(levelElement.find('Selector[@ID="LowLowLimitEnable"]'))
		
		levelElement = selector.find('Group/Selector[@ID="HighLimitEnable"]')
		if (levelElement is not None):
			high = self._parseLevel(levelElement)
			highHigh = self._parseLevel(levelElement.find('Selector[@ID="HighHighLimitEnable"]'))
		return low, lowLow, high, highHigh

	def _parseDelay(self, settings):
		delay = None
		if settings is not None:
			print('has settings')
			delay = settings.find('Property[@ID="Delay"]').attrib['Value'] if (settings.find('Property[@ID="Delay"]') is not None) else None
			if delay is None:
				delay = settings.find('Property[@ID="DelayPV"]').attrib['Value'] if (settings.find('Property[@ID="DelayPV"]') is not None) else None
		return delay

	def parseAlarmElement(self, element: et.Element):
		self._name = element.find('Property[@ID="Name"]').attrib['Value']
		self._message = element.find('Property[@ID="Message"]').attrib['Value'] if (element.find('Property[@ID="Message"]') is not None) else None
		self._code = element.find('Property[@ID="Code"]').attrib['Value'] if (element.find('Property[@ID="Code"]') is not None) else None
		self._severity = element.find('Property[@ID="Severity"]').attrib['Value'] if (element.find('Property[@ID="Severity"]') is not None) else None
		selector = element.find('Selector')
		if (selector is None):
			self._behavior = EdgeAlarm(False, False)
		elif ('Value' in selector.attrib):
			if (selector.attrib['Value'] == 'PersistentAlarm'):
				retain = selector.find('Property[@ID="Retain"]').attrib['Value'] if (selector.find('Property[@ID="Retain"]') is not None) else False
				asynchronous = selector.find('Property[@ID="Async"]').attrib['Value'] if (selector.find('Property[@ID="Async"]') is not None) else False
				self._behavior = PersistentAlarm(retain, asynchronous)
			if (selector.attrib['Value'] == 'DiscreteValueMonitoring'):
				variable = selector.find('Group/Property[@ID="MonitoredPV"]').attrib['Value']
				triggers = []
				for trigger in selector.findall('Group/Group/Property'):
					triggers.append(trigger.attrib['Value'])
				delay = self._parseDelay(selector.find('Group/Selector[@ID="Settings"]'))
				self._behavior = DiscreteValueMonitoring(variable, triggers, delay)
			elif (selector.attrib['Value'] == 'LevelMonitoring'):
				variable = selector.find('Group/Property[@ID="MonitoredPV"]').attrib['Value']
				low, lowLow, high, highHigh = self._parseLevels(selector)
				delay = self._parseDelay(selector.find('Group/Selector[@ID="Settings"]'))
				self._behavior = LevelMonitoring(variable, delay, low, high, lowLow, highHigh)
			elif (selector.attrib['Value'] == 'DeviationMonitoring'):
				variable = selector.find('Group/Property[@ID="MonitoredPV"]').attrib['Value']
				setPointPV = selector.find('Group/Property[@ID="SetpointPV"]').attrib['Value']
				low, lowLow, high, highHigh = self._parseLevels(selector)
				delay = self._parseDelay(selector.find('Group/Selector[@ID="Settings"]'))
				self._behavior = DeviationMonitoring(variable, delay, setPointPV, low, high, lowLow, highHigh)
			elif (selector.attrib['Value'] == 'RateOfChangeMonitoring'):
				variable = selector.find('Group/Property[@ID="MonitoredPV"]').attrib['Value']
				low, lowLow, high, highHigh = self._parseLevels(selector)
				delay = self._parseDelay(selector.find('Group/Selector[@ID="Settings"]'))
				self._behavior = RateOfChangeMonitoring(variable, delay, low, high, lowLow, highHigh)
		else:
			retain = selector.find('Property[@ID="Retain"]').attrib['Value'] if (selector.find('Property[@ID="Retain"]') is not None) else False
			asynchronous = selector.find('Property[@ID="Async"]').attrib['Value'] if (selector.find('Property[@ID="Async"]') is not None) else False    
			self._behavior = EdgeAlarm(retain, asynchronous)
		return self

def readAlarmXCore(alarmXCore) -> list:
	if (not os.path.isfile(alarmXCore)):
		return
	alarmXTree = et.parse(alarmXCore)
	alarmXRoot = alarmXTree.getroot()
	configuration = alarmXRoot.find('.//Element[@Type="mpalarmxcore"]').find('.//Group[@ID="mapp.AlarmX.Core.Configuration"]')
	alarmList = []
	for element in configuration.findall('Group'):
		alarmList.append(Alarm().parseAlarmElement(element))
	return alarmList

def prettyPrintLevel(level: Level) -> list:
	if (level is None): return ['', '']
	return [level.limit, level.text]

def levelToElement(parent: et.Element, name: str, level: Level) -> et.Element:
	if (level.limit.startswith(':')):
		limitEnable = et.SubElement(parent, 'Selector', {'ID': f'{name}LimitEnable', 'Value': 'Dynamic'})
		et.SubElement(limitEnable, 'Property', {'ID': 'LimitPV', 'Value': level.limit})
	else:
		limitEnable = et.SubElement(parent, 'Selector', {'ID': f'{name}LimitEnable', 'Value': 'Static'})
		et.SubElement(limitEnable, 'Property', {'ID': 'Limit', 'Value': level.limit})
	et.SubElement(limitEnable, 'Property', {'ID': 'LimitText', 'Value': level.text})
	return limitEnable

def levelsToElement(parent: et.Element, behavior):
	if (behavior.lowLimit is not None):
		low = levelToElement(parent, 'Low', behavior.lowLimit)
		if (behavior.lowLowLimit is not None):
			levelToElement(low, 'LowLow', behavior.lowLowLimit)
	if (behavior.highLimit is not None):
		high = levelToElement(parent, 'High', behavior.highLimit)
		if (behavior.highHighLimit is not None):
			levelToElement(high, 'HighHigh', behavior.highHighLimit)

def exportAlarmXCore(csvFile, alarmXCore) -> None:
	alarmList = readAlarmXCore(alarmXCore)
	csvData = csv.writer(open(csvFile, 'w', newline=''), dialect='excel')
	csvData.writerow(['Name', 'Message', 'Code', 'Severity', 'Behavior', 'Retain', 'Async', 'Monitored PV', 'Trigger Values', 'Set Point PV', 'Low Low Limit', 'Low Low Limit Text', 'Low Limit', 'Low Limit Text', 'High Limit', 'High Limit Text', 'High High Limit', 'High High Limit Text', 'Delay']) 
	for alarm in alarmList:
		row = [alarm._name, alarm._message, alarm._code, alarm._severity, alarm._behavior.__class__.__name__]
		if (alarm._behavior is None):
			row.remove('NoneType')
			row.append('EdgeAlarm')
			row.append('') # no retain
			row.append('') # no async
			row.append('') # no monitoredPV
			row.append('') # no triggerValues
			row.append('') # no set point PV
			row.append('') # no lowLowLimit
			row.append('') # no lowLowText
			row.append('') # no lowLimit
			row.append('') # no lowLimitText
			row.append('') # no highLimit
			row.append('') # no highLimitText
			row.append('') # no highHighLimit
			row.append('') # no highHighLimitText
			row.append('') # no delay
		if (type(alarm._behavior) is EdgeAlarm):
			row.append(alarm._behavior.retain)
			row.append(alarm._behavior.asynchronous)
			row.append('') # no monitoredPV
			row.append('') # no triggerValues
			row.append('') # no set point PV
			row.append('') # no lowLowLimit
			row.append('') # no lowLowText
			row.append('') # no lowLimit
			row.append('') # no lowLimitText
			row.append('') # no highLimit
			row.append('') # no highLimitText
			row.append('') # no highHighLimit
			row.append('') # no highHighLimitText
			row.append('') # no delay
		elif (type(alarm._behavior) is PersistentAlarm):
			row.append(alarm._behavior.retain)
			row.append(alarm._behavior.asynchronous)
			row.append('') # no monitoredPV
			row.append('') # no triggerValues
			row.append('') # no set point PV
			row.append('') # no lowLowLimit
			row.append('') # no lowLowText
			row.append('') # no lowLimit
			row.append('') # no lowLimitText
			row.append('') # no highLimit
			row.append('') # no highLimitText
			row.append('') # no highHighLimit
			row.append('') # no highHighLimitText
		elif (type(alarm._behavior) is DiscreteValueMonitoring):
			row.append('') # no retain
			row.append('') # no async
			row.append(alarm._behavior.monitoredPV)
			row.append(alarm._behavior.triggerValues)
			row.append('') # no set point PV
			row.append('') # no lowLowLimit
			row.append('') # no lowLowText
			row.append('') # no lowLimit
			row.append('') # no lowLimitText
			row.append('') # no highLimit
			row.append('') # no highLimitText
			row.append('') # no highHighLimit
			row.append('') # no highHighLimitText
			row.append(alarm._behavior.delay)
		elif (type(alarm._behavior) is LevelMonitoring):    
			row.append('') # no retain
			row.append('') # no async
			row.append(alarm._behavior.monitoredPV)
			row.append('') # no trigger values
			row.append('') # no set point PV
			row += prettyPrintLevel(alarm._behavior.lowLowLimit)
			row += prettyPrintLevel(alarm._behavior.lowLimit)
			row += prettyPrintLevel(alarm._behavior.highLimit)
			row += prettyPrintLevel(alarm._behavior.highHighLimit)
			row.append(alarm._behavior.delay)
		elif (type(alarm._behavior) is DeviationMonitoring):
			row.append('') # no retain
			row.append('') # no async
			row.append(alarm._behavior.monitoredPV)
			row.append('') # no trigger values
			row.append(alarm._behavior.setpointPV)
			row += prettyPrintLevel(alarm._behavior.lowLowLimit)
			row += prettyPrintLevel(alarm._behavior.lowLimit)
			row += prettyPrintLevel(alarm._behavior.highLimit)
			row += prettyPrintLevel(alarm._behavior.highHighLimit)
			row.append(alarm._behavior.delay)
		elif (type(alarm._behavior) is RateOfChangeMonitoring):
			row.append('') # no retain
			row.append('') # no async
			row.append(alarm._behavior.monitoredPV)
			row.append('') # no trigger values
			row.append('') # no set point PV
			row += prettyPrintLevel(alarm._behavior.lowLowLimit)
			row += prettyPrintLevel(alarm._behavior.lowLimit)
			row += prettyPrintLevel(alarm._behavior.highLimit)
			row += prettyPrintLevel(alarm._behavior.highHighLimit)
			row.append(alarm._behavior.delay)
		csvData.writerow(row)

def readCsvFile(csvFile) -> list:
	if (not os.path.isfile(csvFile)):
		print('CSV file not found')
		return
	csvData = csv.DictReader(open(csvFile, 'r', newline=''), dialect='excel')
	alarmList = []   
	for row in csvData:
		alarm = Alarm().parseDict(row)
		alarmList.append(alarm)
	return alarmList

def createAlarm(alarm: Alarm, index: int) -> et.Element:
	element = et.Element('Group', {'ID': f'[{str(index)}]'})
	element.tail = '\n'
	et.SubElement(element, 'Property', {'ID': 'Name', 'Value': alarm._name})
	if (alarm._message is not None) and (alarm._message != ''):
		et.SubElement(element, 'Property', {'ID': 'Message', 'Value': alarm._message})
	if (alarm._code is not None) and (alarm._code != ''):
		et.SubElement(element, 'Property', {'ID': 'Code', 'Value': str(alarm._code)})
	if (alarm._severity is not None) and (alarm._severity != ''):
		et.SubElement(element, 'Property', {'ID': 'Severity', 'Value': str(alarm._severity)})
	if (type(alarm._behavior) is EdgeAlarm):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior'})
		et.SubElement(behavior, 'Property', {'ID': 'Retain', 'Value': str(alarm._behavior.retain).upper()})
		et.SubElement(behavior, 'Property', {'ID': 'Async', 'Value': str(alarm._behavior.asynchronous).upper()})
	elif (type(alarm._behavior) is PersistentAlarm):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior'})
		et.SubElement(behavior, 'Property', {'ID': 'Retain', 'Value': str(alarm._behavior.retain).upper()})
		et.SubElement(behavior, 'Property', {'ID': 'Async', 'Value': str(alarm._behavior.asynchronous).upper()})
	elif (type(alarm._behavior) is DiscreteValueMonitoring):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior', 'Value': 'DiscreteValueMonitoring'})
		monitoring = et.SubElement(behavior, 'Group', {'ID': 'Monitoring'})
		et.SubElement(monitoring, 'Property', {'ID': 'MonitoredPV', 'Value': alarm._behavior.monitoredPV})
		triggerValues = et.SubElement(monitoring, 'Group', {'ID': 'TriggerValues'})
		triggerIndex = 0
		for trigger in alarm._behavior.triggerValues:
			et.SubElement(triggerValues, 'Property', {'ID': f'[{triggerIndex}]', 'Value': trigger})
			triggerIndex += 1
		if (alarm._behavior.delay is not None) and (alarm._behavior.delay != ''):
			settings = et.SubElement(monitoring, 'Selector', {'ID': 'Settings'})
			if (alarm._behavior.delay.startswith(':')):
				et.SubElement(settings, 'Property', {'ID': 'DelayPV', 'Value': alarm._behavior.delay})
			else:
				et.SubElement(settings, 'Property', {'ID': 'Delay', 'Value': alarm._behavior.delay})
	elif (type(alarm._behavior) is LevelMonitoring):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior', 'Value': 'DiscreteValueMonitoring'})
		monitoring = et.SubElement(behavior, 'Group', {'ID': 'Monitoring'})
		et.SubElement(monitoring, 'Property', {'ID': 'MonitoredPV', 'Value': alarm._behavior.monitoredPV})
		levelsToElement(behavior, alarm._behavior)
	elif (type(alarm._behavior) is DeviationMonitoring):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior', 'Value': 'DiscreteValueMonitoring'})
		monitoring = et.SubElement(behavior, 'Group', {'ID': 'Monitoring'})
		et.SubElement(monitoring, 'Property', {'ID': 'MonitoredPV', 'Value': alarm._behavior.monitoredPV})
		et.SubElement(monitoring, 'Property', {'ID': 'SetpointPV', 'Value': alarm._behavior.setpointPV})
		levelsToElement(behavior, alarm._behavior)
	elif (type(alarm._behavior) is RateOfChangeMonitoring):
		behavior = et.SubElement(element, 'Selector', {'ID': 'Behavior', 'Value': 'DiscreteValueMonitoring'})
		monitoring = et.SubElement(behavior, 'Group', {'ID': 'Monitoring'})
		et.SubElement(monitoring, 'Property', {'ID': 'MonitoredPV', 'Value': alarm._behavior.monitoredPV})
		levelsToElement(behavior, alarm._behavior)
	return element
	
def updateAlarmXCore(alarmXCore, alarmList):
	if (not os.path.isfile(alarmXCore)):
		print('mpAlarmXCore file not found')
		return
	if (alarmList is None):
		print('no alarms in list')
		return
	alarmXTree = et.parse(alarmXCore)
	alarmXRoot = alarmXTree.getroot()
	print(alarmXRoot.text)
	parent = alarmXRoot.find('.//Element[@Type="mpalarmxcore"]')
	config = parent.find('.//Group[@ID="mapp.AlarmX.Core.Configuration"]')
	for element in config.findall('Group'):
		config.remove(element)
	index = 0
	for alarm in alarmList:
		element = createAlarm(alarm, index)
		index += 1
		config.append(element)
	alarmXTree.write(alarmXCore, encoding="utf-8", xml_declaration=True, pretty_print=True)

def main() -> None:
	parser = argparse.ArgumentParser()
	parser.add_argument('-e', '--export', help='Exports the AlarmXCore configuration to a CSV file', dest='export', required=False, default=False)
	parser.add_argument('-c', '--csv-file', help='The CSV file that you want to import from', dest='csvFile', required=False, default='AlarmTriggers.csv')
	parser.add_argument('-m', '--mpalarmxcore', help='The CSV file that you want to import from', dest='alarmXCore', required=False, default='AlarmXCfg.mpalarmxcore')
	parser.add_argument('-t', '--tmx-file', help='The CSV file that you want to import from', dest='tmxFile', required=False, default='Infrastructure\AlarmX\Alarms.tmx')
	args = parser.parse_args()
	if (args.export):
		exportAlarmXCore(args.csvFile, args.alarmXCore)
	else:
		alarmList = readCsvFile(args.csvFile)
		updateAlarmXCore(args.alarmXCore, alarmList)

if __name__ == '__main__':
	main()