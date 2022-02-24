
TYPE
	MachineDigitalInputs_type : 	STRUCT  (*Safety related digital inputs of the machine*)
		EmergencyStop : ARRAY[0..MAX_IDX_ESTOP]OF BOOL; (*Emergency stop signal*)
		SafetyDoor : ARRAY[0..MAX_IDX_SAFETY_DOOR]OF BOOL; (*Safety door signal*)
		AcknowledgeAlarms : BOOL;
	END_STRUCT;
	AlarmExamples_typ : 	STRUCT 
		LevelMonitoring : INT := 50;
		DeviationMonitoring : INT := 15;
		DeviationMonitoringSetpoint : INT := 15;
		RateOfChange : INT;
		SnippetValue : INT := 10;
		ControlExample : BOOL;
	END_STRUCT;
	ActiveAlarmState_enum : 
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
		State : ActiveAlarmState_enum;
		LastActiveAlarmUpdateCount : UDINT;
		ActiveAlarmUpdateCount : UDINT;
		Alarms : ARRAY[0..MAX_QUERY_RESULTS]OF AlarmType;
	END_STRUCT;
	AlarmHmiInterface_type : 	STRUCT 
		Commands : AlarmCommands_type;
		Status : AlarmStatus_type;
	END_STRUCT;
	AlarmStatus_type : 	STRUCT 
		AlarmHistSortCfg : STRING[1000];
		AlarmHistFilterCfg : STRING[1000];
		AlarmSortCfg : STRING[1000];
		AlarmFilterCfg : STRING[1000];
		TableConfig : ARRAY[0..1]OF STRING[120];
	END_STRUCT;
	AlarmCommands_type : 	STRUCT 
		ExportAlarms : BOOL;
		RunQuery : BOOL;
	END_STRUCT;
	AlarmQueryHMI_type : 	STRUCT 
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
