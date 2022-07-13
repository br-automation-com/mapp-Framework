
TYPE
	AuditQueryHMIType : 	STRUCT  (*Datatype for the structure which rearranges the query data from AuditQuery into a structure of arrays for easy connection to the Table widget in mapp View*)
		EvTime : ARRAY[0..MAX_QUERY_RESULTS]OF DATE_AND_TIME; (*ActiveAudits query, Event-Time column*)
		Text : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[100]; (*ActiveAudits query, Text column*)
		DText : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[100]; (*ActiveAudits query, Display Text column*)
		Op : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[100]; (*ActiveAudits query, Operator-Name column*)
		QueryCount : USINT; (*Count of query results for building the query table configuration string*)
		Name : STRING[80]; (*Name of the query to be executed*)
		Option : USINT;
	END_STRUCT;
	ActiveAuditStateEnum : 
		( (*Enumeration for the state for the query state machine*)
		ACTIVE_AUDIT_WAIT, (*Wait state*)
		ACTIVE_AUDIT_QUERY, (*State to query the Audit data*)
		ACTIVE_AUDIT_NEXT (*State to check if more Audits meet the query criteria and need to be queried*)
		);
	AuditCustomEventType : 	STRUCT  (*Structure for custom events handling*)
		Set : BOOL; (*Trigger the assigned function*)
		Type : WSTRING[100]; (*Entered when creating the entry under %typ*)
		Msg : WSTRING[100]; (*Entered when creating the entry under %msg *)
		Comment : WSTRING[100]; (*Entered when creating the entry under %cmt *)
	END_STRUCT;
	AuditQueryType : 	STRUCT  (*Structure for query results and status*)
		State : ActiveAuditStateEnum; (*State variable for the query state machine*)
		LastUpdateCount : UDINT; (*Previous count of query results. Used to check for new query data. *)
		UpdateCountRecipe : UDINT; (*Count of query results. Increases each time new results are availble. *)
		UpdateCount : UDINT; (*Count of query results. Increases each time new results are availble. *)
		Audits : ARRAY[0..MAX_QUERY_RESULTS]OF AuditType; (*Query data*)
		Next : BOOL; (*Trigger to query the next data, if there are more results than MAX_QUERY_RESULTS*)
	END_STRUCT;
	AuditHmiInterfaceType : 	STRUCT  (*Structure to hold commands and status from the HMI*)
		Commands : AuditCommandsType; (*HMI commands*)
		Status : {REDUND_UNREPLICABLE} AuditStatusType; (*HMI status*)
	END_STRUCT;
	AuditStatusType : 	STRUCT  (*Structure to hold status information from the mapp View HMI. (This structure is not compatible/relevant if you are using a VC4 visualization)*)
		AuditSortCfg : STRING[1000]; (*Sort configuration for the AuditList widget*)
		AuditFilterCfg : STRING[1000]; (*Filter configuration for the AuditList widget*)
		TableConfig : ARRAY[0..1]OF STRING[255]; (*Table configuration for the Audit query Table*)
		Query : AuditQueryHMIType; (*Structure which rearranges the query data from AuditQuery into a structure of arrays for easy connection to the Table widget*)
		CustomEventSortCfg : STRING[1000]; (*Sort configuration for the AuditList Custom Events widget*)
		CustomEventsFilterCfg : STRING[1000]; (*Filter configuration for the AuditList Custom Events widget*)
		ArchiveAvailable : BOOL; (*At least 1 archive is available for export*)
		NumberOfArchives : UINT; (*How many archives are available for export*)
	END_STRUCT;
	AuditType : 	STRUCT  (*Structure to hold the Audit data for the query results*)
		EvTime : DATE_AND_TIME; (*ActiveAudits query, Event-Time column*)
		Text : WSTRING[100]; (*ActiveAudits query, Text column*)
		DText : WSTRING[100]; (*ActiveAudits query, Display Text column*)
		Op : WSTRING[100]; (*ActiveAudits query, Operator-Name column*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	AuditCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		ExportAudits : BOOL; (*Triggers an Audit export of the Audit history. Connected to a button on the HMI. *)
		RunQuery : BOOL; (*Triggers the query to run. Connected to a button on the HMI. *)
	END_STRUCT;
END_TYPE
