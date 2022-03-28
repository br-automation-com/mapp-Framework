
TYPE
	MachineDigitalInputsType : 	STRUCT  (*Safety related digital inputs *)
		EmergencyStop : ARRAY[0..MAX_ESTOP]OF BOOL; (*Emergency stop input signals*)
		SafetyDoor : ARRAY[0..MAX_SAFETY_DOOR]OF BOOL; (*Safety door input signals*)
		AcknowledgeAlarms : BOOL; (*Reset button input signal*)
	END_STRUCT;
	AlarmExamplesType : 	STRUCT  (*Structure for alarm samples*)
		LevelMonitoring : INT; (*Triggers LevelMonitoringExample alarm depending on the value set (<20 or >80)*)
		DeviationMonitoring : INT; (*Triggers the DeviationMonitoringExample alarm if this differs from DevationMonitoringSetpoint (below) by more than 5 units*)
		DeviationMonitoringSetpoint : INT; (*Setpoint for the DeviationMonitoringExample alarm. If DeviationMonitoring (above) differs from this value by more than 5 units, the alarm triggers*)
		RateOfChange : INT; (*Triggers the RateOfChangeExample alarm if this value changes at a rate of more than 5 units per second*)
		SnippetValue : INT; (*Process variable used in the SnippetExample alarm for the snippet*)
		SetControlExample : BOOL; (*Boolean to trigger the example alarm which is triggerd by MpAlarmXControlExample_0*)
	END_STRUCT;
	ActiveAlarmStateEnum : 
		( (*Enumeration for the state for the query state machine*)
		ACTIVE_ALARM_WAIT, (*Wait state*)
		ACTIVE_ALARM_QUERY, (*State to query the alarm data*)
		ACTIVE_ALARM_NEXT (*State to check if more alarms meet the query criteria and need to be queried*)
		);
	AlarmType : 	STRUCT  (*Structure to hold the alarm data for the query results*)
		Active : BOOL; (*ActiveAlarms query, StateActive column*)
		Acknowledged : BOOL; (*ActiveAlarms query, StateAcknowledged column*)
		Scope : WSTRING[80]; (*ActiveAlarms query, Scope column*)
		Name : STRING[80]; (*ActiveAlarms query, Name column*)
		Message : WSTRING[255]; (*ActiveAlarms query, Message column*)
		AdditionalInfo : WSTRING[255]; (*ActiveAlarms query, AdditionalInformation1*)
		TimeStamp : DATE_AND_TIME; (*ActiveAlarms query, TimeStamp column*)
		Code : UDINT; (*ActiveAlarms query, Code column*)
		Severity : UDINT; (*ActiveAlarms query, Severity column*)
	END_STRUCT;
	AlarmQueryType : 	STRUCT  (*Structure for query results and status*)
		State : ActiveAlarmStateEnum; (*State variable for the query state machine*)
		LastActiveAlarmUpdateCount : UDINT;
		ActiveAlarmUpdateCount : UDINT;
		Alarms : ARRAY[0..MAX_QUERY_RESULTS]OF AlarmType;
		Next : BOOL;
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
		Query : AlarmQueryHMIType;
		InstanceID : UINT;
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
		QueryCount : USINT; (*Count of query results*)
	END_STRUCT;
END_TYPE
