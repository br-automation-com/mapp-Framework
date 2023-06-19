(*Structure types*)

TYPE
	AlarmHmiInterfaceType : 	STRUCT  (*Structure to hold commands and status from the HMI*)
		Commands : AlarmCommandsType; (*HMI commands*)
		Status : {REDUND_UNREPLICABLE} AlarmStatusType; (*HMI status*)
		Parameters : AlarmParametersType; (*HMI parameters*)
	END_STRUCT;
	AlarmCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		ExportAlarms : BOOL; (*Triggers an alarm export of the alarm history. Connected to a button on the HMI.*)
		RunQuery : BOOL; (*Triggers the query to run. Connected to a button on the HMI. *)
	END_STRUCT;
	AlarmParametersType : 	STRUCT  (*Structure to hold the parameters from the HMI*)
		InstanceID : UINT; (*The instanceID of the alarm that was most recently clicked in the AlarmList. Set by an eventbinding in mapp View*)
	END_STRUCT;
	AlarmStatusType : 	STRUCT  (*Structure to hold status information to the mapp View HMI. (This structure is not compatible/relevant if you are using a VC4 visualization)*)
		AlarmHistSortCfg : STRING[1000]; (*Sort configuration property for the AlarmHistory widget *)
		AlarmHistFilterCfg : STRING[1000]; (*Filter configuration property for the AlarmHistory widget*)
		AlarmSortCfg : STRING[1000]; (*Sort configuration for the AlarmList widget*)
		AlarmFilterCfg : STRING[1000]; (*Filter configuration for the AlarmList widget*)
		TableConfig : ARRAY[0..1]OF STRING[120]; (*Table configuration for the alarm query Table*)
		AlarmExportDone : BOOL; (*Alarm export of alarm history is completed. Connected to a button on the HMI. *)
		AlarmExportDisplayed : BOOL; (*Alarm export of alarm history is displayed. Connected to a button on the HMI. *)
		Query : AlarmQueryHMIType; (*Structure which rearranges the query data from AlarmQuery into a structure of arrays for easy connection to the Table widget*)
	END_STRUCT;
	AlarmQueryType : 	STRUCT  (*Structure for query results and status*)
		State : ActiveAlarmStateEnum; (*State variable for the query state machine*)
		LastUpdateCount : UDINT; (*Previous count of query results. Used to check for new query data. *)
		UpdateCount : UDINT; (*Count of query results. Increases each time new results are availble. *)
		Alarms : ARRAY[0..MAX_QUERY_RESULTS]OF AlarmType; (*Query data*)
		Next : BOOL; (*Trigger to query the next data, if there are more results than MAX_QUERY_RESULTS*)
	END_STRUCT;
	AlarmQueryHMIType : 	STRUCT  (*Datatype for the structure which rearranges the query data from AlarmQuery into a structure of arrays for easy connection to the Table widget in mapp View*)
		Active : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL; (*StateActive array*)
		Acknowledged : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL; (*StateAcknowledged array*)
		Scope : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[80]; (*Scope array*)
		Name : ARRAY[0..MAX_QUERY_RESULTS]OF STRING[80]; (*Name array*)
		Message : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255]; (*Message array*)
		AdditionalInfo : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255]; (*AdditionalInformation1 array*)
		TimeStamp : ARRAY[0..MAX_QUERY_RESULTS]OF DATE_AND_TIME; (*TimeStamp array*)
		Code : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT; (*Code array*)
		Severity : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT; (*Severity array*)
		State : ARRAY[0..MAX_QUERY_RESULTS]OF CurrentAlarmStateEnum; (*State message array*)
		QueryCount : USINT; (*Count of query results for building the query table configuration string*)
	END_STRUCT;
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
		State : CurrentAlarmStateEnum; (*ActiveAlarms query, State column*)
	END_STRUCT;
	MachineDigitalInputsType : 	STRUCT  (*Safety related digital inputs *)
		EmergencyStop : ARRAY[0..MAX_ESTOP]OF BOOL; (*Emergency stop input signals*)
		SafetyDoor : ARRAY[0..MAX_SAFETY_DOOR]OF BOOL; (*Safety door input signals*)
		AcknowledgeAlarms : BOOL; (*Reset button input signal*)
	END_STRUCT;
	AlarmExamplesType : 	STRUCT  (*Structure for alarm samples*)
		LevelMonitoring : INT := 50; (*Triggers LevelMonitoringExample alarm depending on the value set (<20 or >80)*)
		DeviationMonitoring : INT := 15; (*Triggers the DeviationMonitoringExample alarm if this differs from DevationMonitoringSetpoint (below) by more than 5 units*)
		DeviationMonitoringSetpoint : INT := 15; (*Setpoint for the DeviationMonitoringExample alarm. If DeviationMonitoring (above) differs from this value by more than 5 units, the alarm triggers*)
		RateOfChange : INT := 0; (*Triggers the RateOfChangeExample alarm if this value changes at a rate of more than 5 units per second*)
		SnippetValue : INT := 10; (*Process variable used in the SnippetExample alarm for the snippet*)
		SetControlExample : BOOL; (*Boolean to trigger the example alarm which is triggerd by MpAlarmXControlExample_0*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	ActiveAlarmStateEnum : 
		( (*Enumeration for the state for the query state machine*)
		ACTIVE_ALARM_WAIT, (*Wait state*)
		ACTIVE_ALARM_QUERY, (*State to query the alarm data*)
		ACTIVE_ALARM_NEXT (*State to check if more alarms meet the query criteria and need to be queried*)
		);
	CurrentAlarmStateEnum : 
		( (*Enumeration for the state of a particular alarm*)
		INACTIVE_NOT_ACKNOWLEDGED := 0, (*Alarm inactive and not acknowledged*)
		ACTIVE_NOT_ACKNOWLEDGED := 1, (*Alarm active and not acknowledged*)
		ACTIVE_ACKNOWLEDGED := 2, (*Alarm active and acknowledged*)
		INACTIVE_ACKNOWLEDGED := 3 (*Alarm inactive and acknowledged*)
		);
END_TYPE
