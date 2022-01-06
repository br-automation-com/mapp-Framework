
TYPE
	MachineDigitalInputs_type : 	STRUCT  (*Safety related digital inputs of the machine*)
		EmergencyStop : ARRAY[0..MAX_IDX_ESTOP]OF BOOL; (*Emergency stop signal*)
		SafetyDoor : ARRAY[0..MAX_IDX_SAFETY_DOOR]OF BOOL; (*Safety door signal*)
		SafetyPLC : BOOL; (*SafetyPLC signal*)
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
		Alarms : ARRAY[0..19]OF AlarmType;
	END_STRUCT;
END_TYPE
