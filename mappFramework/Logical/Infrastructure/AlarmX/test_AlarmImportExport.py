import pytest
from .AlarmImportExport import *
from lxml import etree as et

@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Retain': False, 'Async': True},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Retain': True, 'Async': True},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Retain': False, 'Async': False}])
def test_parseDictionaryEdge(test_input):
	# arrange
	test_input['Behavior'] = 'EdgeAlarm'
	alarm = parseDict(test_input)

	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == EdgeAlarm
	assert alarm._behavior.retain == test_input['Retain']
	assert alarm._behavior.asynchronous == test_input['Async']
	
@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Retain': False, 'Async': True},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Retain': True, 'Async': True},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Retain': False, 'Async': False}])
def test_parseDictionaryPersistentAlarm(test_input):
	# arrange
	test_input['Behavior'] = 'PersistentAlarm'
	alarm = parseDict(test_input)

	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == PersistentAlarm
	assert alarm._behavior.retain == test_input['Retain']
	assert alarm._behavior.asynchronous == test_input['Async']
	
@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Monitored PV': '::test', 'Trigger Values': "['0']", 'Delay': '0.1'},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Monitored PV': '::test', 'Trigger Values': "['0', '1']", 'Delay': '0.1'},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Monitored PV': '::test', 'Trigger Values': "['0']",  'Delay': None},
										{'Name': 'alarm name 4', 'Message': 'alarm message 4', 'Severity': '13', 'Code': '23', 'Monitored PV': '::test', 'Trigger Values': "['0']",  'Delay': ':test'}])
def test_parseDictionaryDiscreteValueMonitoring(test_input):
	# arrange
	test_input['Behavior'] = 'DiscreteValueMonitoring'
	alarm = parseDict(test_input)

	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == DiscreteValueMonitoring
	assert alarm._behavior.triggerValues == test_input['Trigger Values'].strip('][').replace("'", '').split(', ')
	assert alarm._behavior.delay == test_input['Delay']

@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': 'l',  'Low Low Limit Text': 'low low','High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 4', 'Message': 'alarm message 4', 'Severity': '13', 'Code': '23', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': None},])
def test_parseDictionaryLevelMonitoring(test_input):
	# arrange
	test_input['Behavior'] = 'LevelMonitoring'
	alarm = parseDict(test_input)

	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == LevelMonitoring
	assert alarm._behavior.lowLimit.limit == test_input['Low Limit']
	assert alarm._behavior.lowLimit.text == test_input['Low Limit Text']
	assert alarm._behavior.lowLowLimit.limit == test_input['Low Low Limit']
	assert alarm._behavior.lowLowLimit.text == test_input['Low Low Limit Text']
	assert alarm._behavior.highLimit.limit == test_input['High Limit']
	assert alarm._behavior.highLimit.text == test_input['High Limit Text']
	assert alarm._behavior.highHighLimit.limit == test_input['High High Limit']
	assert alarm._behavior.highHighLimit.text == test_input['High High Limit Text']
	assert alarm._behavior.delay == test_input['Delay']


@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Monitored PV': '::test', 'Set Point PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Monitored PV': '::test', 'Set Point PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': 'l',  'Low Low Limit Text': 'low low','High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Monitored PV': '::test', 'Set Point PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 4', 'Message': 'alarm message 4', 'Severity': '13', 'Code': '23', 'Monitored PV': '::test', 'Set Point PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': None},])
def test_parseDictionaryDeviationMonitoring(test_input):
	# arrange
	test_input['Behavior'] = 'DeviationMonitoring'
	alarm = parseDict(test_input)

	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == DeviationMonitoring
	assert alarm._behavior.lowLimit.limit == test_input['Low Limit']
	assert alarm._behavior.lowLimit.text == test_input['Low Limit Text']
	assert alarm._behavior.lowLowLimit.limit == test_input['Low Low Limit']
	assert alarm._behavior.lowLowLimit.text == test_input['Low Low Limit Text']
	assert alarm._behavior.highLimit.limit == test_input['High Limit']
	assert alarm._behavior.highLimit.text == test_input['High Limit Text']
	assert alarm._behavior.highHighLimit.limit == test_input['High High Limit']
	assert alarm._behavior.highHighLimit.text == test_input['High High Limit Text']
	assert alarm._behavior.delay == test_input['Delay']

	
@pytest.mark.parametrize("test_input", [{'Name': 'alarm name 1', 'Message': 'alarm message 1', 'Severity': '10', 'Code': '20', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 2', 'Message': 'alarm message 2', 'Severity': '11', 'Code': '21', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': 'l',  'Low Low Limit Text': 'low low','High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 3', 'Message': 'alarm message 3', 'Severity': '12', 'Code': '22', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': '0.1'},
										{'Name': 'alarm name 4', 'Message': 'alarm message 4', 'Severity': '13', 'Code': '23', 'Monitored PV': '::test', 'Low Limit': '5', 'Low Limit Text': 'low text', 'Low Low Limit': None, 'Low Low Limit Text': None,     'High Limit': None, 'High Limit Text': None, 'High High Limit': None, 'High High Limit Text': None, 'Delay': None}])
def test_parseDictionaryRateOfChangeMonitoring(test_input):
	# arrange
	test_input['Behavior'] = 'RateOfChangeMonitoring'
	
	# act
	alarm = parseDict(test_input)

	#assert
	assert alarm._name == test_input['Name']
	assert alarm._message == test_input['Message']
	assert alarm._severity == test_input['Severity']
	assert alarm._code == test_input['Code']
	assert type(alarm._behavior) == RateOfChangeMonitoring
	assert alarm._behavior.lowLimit.limit == test_input['Low Limit']
	assert alarm._behavior.lowLimit.text == test_input['Low Limit Text']
	assert alarm._behavior.lowLowLimit.limit == test_input['Low Low Limit']
	assert alarm._behavior.lowLowLimit.text == test_input['Low Low Limit Text']
	assert alarm._behavior.highLimit.limit == test_input['High Limit']
	assert alarm._behavior.highLimit.text == test_input['High Limit Text']
	assert alarm._behavior.highHighLimit.limit == test_input['High High Limit']
	assert alarm._behavior.highHighLimit.text == test_input['High High Limit Text']
	assert alarm._behavior.delay == test_input['Delay']

@pytest.mark.parametrize("test_data,expected_level", [('<Selector ID="LowLimitEnable" Value="Static"><Property ID="Limit" Value="20" /><Property ID="LimitText" Value="test" /></Selector>', Level('20', 'test')),
													  ('<Selector ID="LowLimitEnable" Value="Dynamic"><Property ID="Limit" Value="::AlarmMgr:AlarmExamples.RateOfChange" /><Property ID="LimitText" Value="test" /></Selector>', Level('::AlarmMgr:AlarmExamples.RateOfChange', 'test'))])
def test_parseLevel(test_data, expected_level):
	# arrange
	element = et.fromstring(test_data)
	# act
	level = parseLevel(element)
	assert expected_level == level


@pytest.mark.parametrize("test_data,expected_levels", [('''<Selector ID="Behavior" Value="LevelMonitoring">
															<Group ID="Monitoring">
															  <Selector ID="LowLimitEnable" Value="Static">
																<Property ID="Limit" Value="20" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
																<Selector ID="LowLowLimitEnable" Value="Static">
																  <Property ID="Limit" Value="10" />
																  <Property ID="LimitText" Value="LevelMonitoringAlarmLowLowTextExample" />
																</Selector>
															  </Selector>
															  <Selector ID="HighLimitEnable" Value="Static">
																<Property ID="Limit" Value="80" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
																<Selector ID="HighHighLimitEnable" Value="Static">
																  <Property ID="Limit" Value="90" />
																  <Property ID="LimitText" Value="LevelMonitoringAlarmHighHighTextExample" />
																</Selector>
															  </Selector>
														   </Group>
														  </Selector>''', 
														[Level('20', 'LevelMonitoringAlarmLowTextExample'), Level('10', 'LevelMonitoringAlarmLowLowTextExample'), Level('80', 'LevelMonitoringAlarmHighTextExample'), Level('90', 'LevelMonitoringAlarmHighHighTextExample') ]),
														('''<Selector ID="Behavior" Value="LevelMonitoring">
															<Group ID="Monitoring">
															  <Selector ID="LowLimitEnable" Value="Static">
																<Property ID="Limit" Value="20" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
															  </Selector>
															  <Selector ID="HighLimitEnable" Value="Static">
																<Property ID="Limit" Value="80" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
																<Selector ID="HighHighLimitEnable" Value="Static">
																  <Property ID="Limit" Value="90" />
																  <Property ID="LimitText" Value="LevelMonitoringAlarmHighHighTextExample" />
																</Selector>
															  </Selector>
														   </Group>
														  </Selector>''', 
														[Level('20', 'LevelMonitoringAlarmLowTextExample'), None, Level('80', 'LevelMonitoringAlarmHighTextExample'), Level('90', 'LevelMonitoringAlarmHighHighTextExample')]),
														('''<Selector ID="Behavior" Value="LevelMonitoring">
															<Group ID="Monitoring">
															  <Selector ID="LowLimitEnable" Value="Static">
																<Property ID="Limit" Value="20" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
															  </Selector>
															  <Selector ID="HighLimitEnable" Value="Static">
																<Property ID="Limit" Value="80" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
															  </Selector>
														   </Group>
														  </Selector>''', 
														[Level('20', 'LevelMonitoringAlarmLowTextExample'), None, Level('80', 'LevelMonitoringAlarmHighTextExample'), None]),
														('''<Selector ID="Behavior" Value="LevelMonitoring">
															<Group ID="Monitoring">
															  <Selector ID="LowLimitEnable" Value="Static">
																<Property ID="Limit" Value="20" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
															  </Selector>
														   </Group>
														  </Selector>''', 
														[Level('20', 'LevelMonitoringAlarmLowTextExample'), None, None, None]),
														('''<Selector ID="Behavior" Value="LevelMonitoring">
															<Group ID="Monitoring">
															  <Selector ID="HighLimitEnable" Value="Static">
																<Property ID="Limit" Value="80" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
															  </Selector>
														   </Group>
														  </Selector>''', 
														[None, None, Level('80', 'LevelMonitoringAlarmHighTextExample'), None])
														])
def test_parseLevels(test_data, expected_levels):
	# arrange
	element = et.fromstring(test_data)

	# act
	levels = parseLevels(element)

	#assert
	i = 0
	for level in levels:
		assert expected_levels[i] == level
		i += 1

@pytest.mark.parametrize("element, expectedAlarm", [(et.fromstring('''<Group ID="[0]">
																	<Property ID="Name" Value="test" />
																	<Property ID="Message" Value="message" />
																	<Selector ID="Behavior">
																	</Selector>
																</Group>'''),
													Alarm('test', 'message', None, EdgeAlarm(False, False), None )),
													(et.fromstring('''<Group ID="[1]">
																		<Property ID="Name" Value="test" />
																		<Property ID="Message" Value="message" />
																		<Selector ID="Behavior">
																			<Property ID="Async" Value="True" />
																			<Property ID="Retain" Value="TRUE" />
																		</Selector>
																	</Group>'''),
													Alarm('test', 'message', None, EdgeAlarm(True, True), None )),
													(et.fromstring('''<Group ID="[2]">
																		<Property ID="Name" Value="test" />
																		<Property ID="Message" Value="message" />
																		<Selector ID="Behavior" Value="PersistentAlarm">
																		   <Property ID="Retain" Value="TRUE" />
																		</Selector>
																	</Group>'''),
													Alarm('test', 'message', None, PersistentAlarm(True, False), None )),
													(et.fromstring('''<Group ID="[3]">
																		<Property ID="Name" Value="test" />
																		<Property ID="Message" Value="message" />
																		<Selector ID="Behavior" Value="PersistentAlarm">
																		   <Property ID="Async" Value="TRUE" /> 
																		</Selector>
																	</Group>'''),
													Alarm('test', 'message', None, PersistentAlarm(False, True), None )),
													(et.fromstring('''<Group ID="[4]">
																		<Property ID="Name" Value="EmergencyStop_0" />
																		<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/EmergencyStop.0}" />
																		<Property ID="Severity" Value="29" />
																		<Selector ID="Behavior" Value="DiscreteValueMonitoring">
																		<Group ID="Monitoring">
																			<Property ID="MonitoredPV" Value="::AlarmMgr:SafetyInputs.EmergencyStop[0]" />
																			<Group ID="TriggerValues">
																				<Property ID="[0]" Value="1" />
																			</Group>
																			<Selector ID="Settings">
																				<Property ID="Delay" Value="0.1" />
																			</Selector>
																		</Group>
																		</Selector>
																	</Group>'''),
													Alarm('EmergencyStop_0', '{$mappFramework/AlarmX/Alarms/EmergencyStop.0}', '29', DiscreteValueMonitoring('::AlarmMgr:SafetyInputs.EmergencyStop[0]', ['1'], "0.1"), None )),
													(et.fromstring('''<Group ID="[5]">
																		<Property ID="Name" Value="EmergencyStop_0" />
																		<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/EmergencyStop.0}" />
																		<Property ID="Severity" Value="29" />
																		<Selector ID="Behavior" Value="DiscreteValueMonitoring">
																		<Group ID="Monitoring">
																			<Property ID="MonitoredPV" Value="::AlarmMgr:SafetyInputs.EmergencyStop[0]" />
																			<Group ID="TriggerValues">
																				<Property ID="[0]" Value="1" />
																				<Property ID="[1]" Value="2" />
																			</Group>
																		</Group>
																		</Selector>
																	</Group>'''),
													Alarm('EmergencyStop_0', '{$mappFramework/AlarmX/Alarms/EmergencyStop.0}', '29', DiscreteValueMonitoring('::AlarmMgr:SafetyInputs.EmergencyStop[0]', ['1', '2'], None), None )),
													(et.fromstring('''<Group ID="[6]">
														<Property ID="Name" Value="LevelMonitoringExample" />
														<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/LevelMonitoringAlarmExample} {=$mappFramework/AlarmX/Alarms/{&amp;LimitText}}" />
														<Selector ID="Behavior" Value="LevelMonitoring">
														<Group ID="Monitoring">
															<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.LevelMonitoring" />
															<Selector ID="LowLimitEnable" Value="Static">
															<Property ID="Limit" Value="20" />
															<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
															<Selector ID="LowLowLimitEnable" Value="Static">
																<Property ID="Limit" Value="10" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmLowLowTextExample" />
															</Selector>
															</Selector>
															<Selector ID="HighLimitEnable" Value="Static">
															<Property ID="Limit" Value="80" />
															<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
															<Selector ID="HighHighLimitEnable" Value="Static">
																<Property ID="Limit" Value="90" />
																<Property ID="LimitText" Value="LevelMonitoringAlarmHighHighTextExample" />
															</Selector>
															</Selector>
														</Group>
														</Selector>
													</Group>'''),
													Alarm('LevelMonitoringExample', '{$mappFramework/AlarmX/Alarms/LevelMonitoringAlarmExample} {=$mappFramework/AlarmX/Alarms/{&LimitText}}', None, LevelMonitoring('::AlarmMgr:AlarmExamples.LevelMonitoring', None, Level('20', 'LevelMonitoringAlarmLowTextExample'), Level('80', 'LevelMonitoringAlarmHighTextExample'), Level('10', 'LevelMonitoringAlarmLowLowTextExample'), Level('90', 'LevelMonitoringAlarmHighHighTextExample')), None )),
													(et.fromstring('''<Group ID="[7]">
														<Property ID="Name" Value="DeviationMonitoringExample" />
														<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/DeviationMonitoringAlarmExample} {&amp;LimitText}" />
														<Selector ID="Behavior" Value="DeviationMonitoring">
														<Group ID="Monitoring">
															<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.DeviationMonitoring" />
															<Property ID="SetpointPV" Value="::AlarmMgr:AlarmExamples.DeviationMonitoringSetpoint" />
															<Selector ID="LowLimitEnable" Value="Static">
															<Property ID="Limit" Value="-5" />
															<Property ID="LimitText" Value="Low limit exceeded" />
															</Selector>
															<Selector ID="HighLimitEnable" Value="Static">
															<Property ID="Limit" Value="5" />
															<Property ID="LimitText" Value="High limit exceeded" />
															</Selector>
														</Group>
														</Selector>
													</Group>'''),
													Alarm('DeviationMonitoringExample', '{$mappFramework/AlarmX/Alarms/DeviationMonitoringAlarmExample} {&LimitText}', None, DeviationMonitoring('::AlarmMgr:AlarmExamples.DeviationMonitoring', None, '::AlarmMgr:AlarmExamples.DeviationMonitoringSetpoint', Level('-5', 'Low limit exceeded'), Level('5', 'High limit exceeded'), None, None), None )),
													(et.fromstring('''<Group ID="[8]">
														<Property ID="Name" Value="RateOfChangeExample" />
														<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/RateOfChangeAlarmExample}" />
														<Selector ID="Behavior" Value="RateOfChangeMonitoring">
														<Group ID="Monitoring">
															<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.RateOfChange" />
															<Selector ID="HighLimitEnable" Value="Dynamic">
															<Property ID="LimitPV" Value="::AlarmMgr:AlarmExamples.RateOfChange" />
															<Property ID="LimitText" Value="High limit exceeded" />
															</Selector>
														</Group>
														</Selector>
													</Group>'''),
													Alarm('RateOfChangeExample', '{$mappFramework/AlarmX/Alarms/RateOfChangeAlarmExample}', None, RateOfChangeMonitoring('::AlarmMgr:AlarmExamples.RateOfChange', None, None, Level('::AlarmMgr:AlarmExamples.RateOfChange', 'High limit exceeded'), None, None), None )),
													])
def test_parseAlarmElement(element, expectedAlarm):
	# arrange

	# act
	alarm = parseAlarmElement(element)

	#assert
	assert expectedAlarm._name == alarm._name
	assert expectedAlarm._message == alarm._message
	assert expectedAlarm._severity == alarm._severity
	assert expectedAlarm._behavior == alarm._behavior
	assert expectedAlarm._code == alarm._code
	assert expectedAlarm == alarm

@pytest.mark.parametrize("alarm, index, expected", [(Alarm('test', 'message', None, EdgeAlarm(False, False), None), 0, 
														et.fromstring('''<Group ID="[0]">
																			<Property ID="Name" Value="test" />
																			<Property ID="Message" Value="message" />
																			<Selector ID="Behavior" />
																		</Group>''')),
													(Alarm('test', 'message', None, EdgeAlarm(True, False), None), 1, 
														et.fromstring('''<Group ID="[1]">
																			<Property ID="Name" Value="test" />
																			<Property ID="Message" Value="message" />
																			<Selector ID="Behavior">
																				<Property ID="Retain" Value="TRUE" />
																			</Selector>
																		</Group>''')),
													(Alarm('test', 'message', None, EdgeAlarm(False, True), None), 2, 
														et.fromstring('''<Group ID="[2]">
																			<Property ID="Name" Value="test" />
																			<Property ID="Message" Value="message" />
																			<Selector ID="Behavior">
																				<Property ID="Async" Value="TRUE" />
																			</Selector>
																		</Group>''')),
													(Alarm('test', 'message', None, PersistentAlarm(True, False), None), 3, 
														et.fromstring('''<Group ID="[3]">
																			<Property ID="Name" Value="test" />
																			<Property ID="Message" Value="message" />
																			<Selector ID="Behavior" Value="PersistentAlarm">
																				<Property ID="Retain" Value="TRUE" />
																			</Selector>
																		</Group>''')),
													(Alarm('test', 'message', None, PersistentAlarm(False, True), None), 4, 
														et.fromstring('''<Group ID="[4]">
																			<Property ID="Name" Value="test" />
																			<Property ID="Message" Value="message" />
																			<Selector ID="Behavior" Value="PersistentAlarm">
																				<Property ID="Async" Value="TRUE" /> 
																			</Selector>
																		</Group>''')),
													(Alarm('EmergencyStop_0', '{$mappFramework/AlarmX/Alarms/EmergencyStop.0}', '29', DiscreteValueMonitoring('::AlarmMgr:SafetyInputs.EmergencyStop[0]', ['1'], "0.1"), None ), 5, 
														et.fromstring('''<Group ID="[5]">
																			<Property ID="Name" Value="EmergencyStop_0" />
																			<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/EmergencyStop.0}" />
																			<Property ID="Severity" Value="29" />
																			<Selector ID="Behavior" Value="DiscreteValueMonitoring">
																			<Group ID="Monitoring">
																				<Property ID="MonitoredPV" Value="::AlarmMgr:SafetyInputs.EmergencyStop[0]" />
																				<Group ID="TriggerValues">
																					<Property ID="[0]" Value="1" />
																				</Group>
																				<Selector ID="Settings">
																					<Property ID="Delay" Value="0.1" />
																				</Selector>
																			</Group>
																			</Selector>
																		</Group>''')),
													(Alarm('EmergencyStop_0', '{$mappFramework/AlarmX/Alarms/EmergencyStop.0}', '29', DiscreteValueMonitoring('::AlarmMgr:SafetyInputs.EmergencyStop[0]', ['1', '2'], None), None ), 6,
														et.fromstring('''<Group ID="[6]">
																			<Property ID="Name" Value="EmergencyStop_0" />
																			<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/EmergencyStop.0}" />
																			<Property ID="Severity" Value="29" />
																			<Selector ID="Behavior" Value="DiscreteValueMonitoring">
																			<Group ID="Monitoring">
																				<Property ID="MonitoredPV" Value="::AlarmMgr:SafetyInputs.EmergencyStop[0]" />
																				<Group ID="TriggerValues">
																					<Property ID="[0]" Value="1" />
																					<Property ID="[1]" Value="2" />
																				</Group>
																			</Group>
																			</Selector>
																		</Group>''')),
													(Alarm('LevelMonitoringExample', '{$mappFramework/AlarmX/Alarms/LevelMonitoringAlarmExample} {=$mappFramework/AlarmX/Alarms/{&LimitText}}', None, LevelMonitoring('::AlarmMgr:AlarmExamples.LevelMonitoring', None, Level('20', 'LevelMonitoringAlarmLowTextExample'), Level('80', 'LevelMonitoringAlarmHighTextExample'), Level('10', 'LevelMonitoringAlarmLowLowTextExample'), Level('90', 'LevelMonitoringAlarmHighHighTextExample')), None ), 7,
														et.fromstring('''<Group ID="[7]">
																			<Property ID="Name" Value="LevelMonitoringExample" />
																			<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/LevelMonitoringAlarmExample} {=$mappFramework/AlarmX/Alarms/{&amp;LimitText}}" />
																			<Selector ID="Behavior" Value="LevelMonitoring">
																			<Group ID="Monitoring">
																				<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.LevelMonitoring" />
																				<Selector ID="LowLimitEnable" Value="Static">
																				<Property ID="Limit" Value="20" />
																				<Property ID="LimitText" Value="LevelMonitoringAlarmLowTextExample" />
																				<Selector ID="LowLowLimitEnable" Value="Static">
																					<Property ID="Limit" Value="10" />
																					<Property ID="LimitText" Value="LevelMonitoringAlarmLowLowTextExample" />
																				</Selector>
																				</Selector>
																				<Selector ID="HighLimitEnable" Value="Static">
																				<Property ID="Limit" Value="80" />
																				<Property ID="LimitText" Value="LevelMonitoringAlarmHighTextExample" />
																				<Selector ID="HighHighLimitEnable" Value="Static">
																					<Property ID="Limit" Value="90" />
																					<Property ID="LimitText" Value="LevelMonitoringAlarmHighHighTextExample" />
																				</Selector>
																				</Selector>
																			</Group>
																			</Selector>
																		</Group>''')),
													(Alarm('DeviationMonitoringExample', '{$mappFramework/AlarmX/Alarms/DeviationMonitoringAlarmExample} {&LimitText}', None, DeviationMonitoring('::AlarmMgr:AlarmExamples.DeviationMonitoring', None, '::AlarmMgr:AlarmExamples.DeviationMonitoringSetpoint', Level('-5', 'Low limit exceeded'), Level('5', 'High limit exceeded'), None, None), None ), 8, 
														et.fromstring('''<Group ID="[8]">
																			<Property ID="Name" Value="DeviationMonitoringExample" />
																			<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/DeviationMonitoringAlarmExample} {&amp;LimitText}" />
																			<Selector ID="Behavior" Value="DeviationMonitoring">
																			<Group ID="Monitoring">
																				<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.DeviationMonitoring" />
																				<Property ID="SetpointPV" Value="::AlarmMgr:AlarmExamples.DeviationMonitoringSetpoint" />
																				<Selector ID="LowLimitEnable" Value="Static">
																				<Property ID="Limit" Value="-5" />
																				<Property ID="LimitText" Value="Low limit exceeded" />
																				</Selector>
																				<Selector ID="HighLimitEnable" Value="Static">
																				<Property ID="Limit" Value="5" />
																				<Property ID="LimitText" Value="High limit exceeded" />
																				</Selector>
																			</Group>
																			</Selector>
																		</Group>''')),
													(Alarm('RateOfChangeExample', '{$mappFramework/AlarmX/Alarms/RateOfChangeAlarmExample}', None, RateOfChangeMonitoring('::AlarmMgr:AlarmExamples.RateOfChange', None, None, Level('::AlarmMgr:AlarmExamples.RateOfChange', 'High limit exceeded'), None, None), None ), 9,
														et.fromstring('''<Group ID="[9]">
																			<Property ID="Name" Value="RateOfChangeExample" />
																			<Property ID="Message" Value="{$mappFramework/AlarmX/Alarms/RateOfChangeAlarmExample}" />
																			<Selector ID="Behavior" Value="RateOfChangeMonitoring">
																			<Group ID="Monitoring">
																				<Property ID="MonitoredPV" Value="::AlarmMgr:AlarmExamples.RateOfChange" />
																				<Selector ID="HighLimitEnable" Value="Dynamic">
																				<Property ID="LimitPV" Value="::AlarmMgr:AlarmExamples.RateOfChange" />
																				<Property ID="LimitText" Value="High limit exceeded" />
																				</Selector>
																			</Group>
																			</Selector>
																		</Group>'''))                                                        
													])
def test_createAlarm(alarm, index, expected):
	# arrange
	# act
	createdElement = createAlarm(alarm, index)
	et.indent(expected, '  ')
	et.indent(createdElement, '  ')
	
	#assert
	assert et.tostring(expected, pretty_print=True) == et.tostring(createdElement, pretty_print=True)
   