
TYPE
	MachineDigitalInputsType : 	STRUCT  (*Safety related digital inputs of the machine*)
		EmergencyStop : ARRAY[0..MAX_IDX_ESTOP]OF BOOL; (*Emergency stop signal*)
		SafetyDoor : ARRAY[0..MAX_IDX_SAFETY_DOOR]OF BOOL; (*Safety door signal*)
		AcknowledgeAlarms : BOOL;
	END_STRUCT;
	AlarmExamplesType : 	STRUCT 
		LevelMonitoring : INT;
		DeviationMonitoring : INT;
		DeviationMonitoringSetpoint : INT;
		RateOfChange : INT;
		SnippetValue : INT;
		SetControlExample : BOOL;
	END_STRUCT;
	ActiveAlarmStateEnum : 
		(
		ACTIVE_ALARM_WAIT,
		ACTIVE_ALARM_QUERY,
		ACTIVE_ALARM_NEXT
		);
	AlarmType : 	STRUCT 
		Active : BOOL;
		Acknowledged : BOOL;
		Scope : WSTRING[80];
		Name : STRING[80];
		Message : WSTRING[255];
		AdditionalInfo : WSTRING[255];
		TimeStamp : DATE_AND_TIME;
		Code : UDINT;
		Severity : UDINT;
	END_STRUCT;
	AlarmQueryType : 	STRUCT 
		Next : BOOL;
		State : ActiveAlarmStateEnum;
		LastActiveAlarmUpdateCount : UDINT;
		ActiveAlarmUpdateCount : UDINT;
		Alarms : ARRAY[0..MAX_QUERY_RESULTS]OF AlarmType;
	END_STRUCT;
	AlarmHmiInterfaceType : 	STRUCT 
		Commands : AlarmCommandsType;
		Status : {REDUND_UNREPLICABLE} AlarmStatusType;
	END_STRUCT;
	AlarmStatusType : 	STRUCT 
		AlarmHistSortCfg : STRING[1000];
		AlarmHistFilterCfg : STRING[1000];
		AlarmSortCfg : STRING[1000];
		AlarmFilterCfg : STRING[1000];
		TableConfig : ARRAY[0..1]OF STRING[120];
	END_STRUCT;
	AlarmCommandsType : 	STRUCT 
		ExportAlarms : BOOL;
		RunQuery : BOOL;
	END_STRUCT;
	AlarmQueryHMIType : 	STRUCT 
		Active : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL;
		Acknowledged : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL;
		Scope : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[80];
		Name : ARRAY[0..MAX_QUERY_RESULTS]OF STRING[80];
		Message : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255];
		AdditionalInfo : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255];
		TimeStamp : ARRAY[0..MAX_QUERY_RESULTS]OF DATE_AND_TIME;
		Code : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT;
		Severity : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT;
	END_STRUCT;
END_TYPE
