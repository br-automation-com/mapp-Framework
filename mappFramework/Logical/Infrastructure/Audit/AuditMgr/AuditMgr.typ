
TYPE
	AuditHmiInterfaceType : 	STRUCT  (*Structure to hold commands and status from the HMI*)
		Commands : AuditCommandsType; (*HMI commands*)
		Status : {REDUND_UNREPLICABLE} AuditStatusType; (*HMI status*)
	END_STRUCT;
	AuditCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		ExportAudits : BOOL; (*Triggers an Audit export of the Audit history. Connected to a button on the HMI. *)
		RunQuery : BOOL; (*Triggers the query to run. Connected to a button on the HMI. *)
	END_STRUCT;
	AuditStatusType : 	STRUCT  (*Structure to hold status information from the mapp View HMI. (This structure is not compatible/relevant if you are using a VC4 visualization)*)
		AuditSortCfg : STRING[1000]; (*Sort configuration for the AuditList widget*)
		AuditFilterCfg : STRING[1000]; (*Filter configuration for the AuditList widget*)
		TableConfig : ARRAY[0..1]OF STRING[120]; (*Table configuration for the Audit query Table*)
		Query : AuditQueryHMIType; (*Structure which rearranges the query data from AuditQuery into a structure of arrays for easy connection to the Table widget*)
	END_STRUCT;
	AuditQueryType : 	STRUCT  (*Structure for query results and status*)
		State : ActiveAuditStateEnum; (*State variable for the query state machine*)
		LastUpdateCount : UDINT; (*Previous count of query results. Used to check for new query data. *)
		UpdateCount : UDINT; (*Count of query results. Increases each time new results are availble. *)
		Audits : ARRAY[0..MAX_QUERY_RESULTS]OF AuditType; (*Query data*)
		Next : BOOL; (*Trigger to query the next data, if there are more results than MAX_QUERY_RESULTS*)
	END_STRUCT;
	AuditQueryHMIType : 	STRUCT  (*Datatype for the structure which rearranges the query data from AuditQuery into a structure of arrays for easy connection to the Table widget in mapp View*)
		Active : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL; (*StateActive array*)
		Acknowledged : ARRAY[0..MAX_QUERY_RESULTS]OF BOOL; (*StateAcknowledged array*)
		Scope : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[80]; (*Scope array*)
		Name : ARRAY[0..MAX_QUERY_RESULTS]OF STRING[80]; (*Name array*)
		Message : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255]; (*Message array*)
		AdditionalInfo : ARRAY[0..MAX_QUERY_RESULTS]OF WSTRING[255]; (*AdditionalInformation1 array*)
		TimeStamp : ARRAY[0..MAX_QUERY_RESULTS]OF DATE_AND_TIME; (*TimeStamp array*)
		Code : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT; (*Code array*)
		Severity : ARRAY[0..MAX_QUERY_RESULTS]OF UDINT; (*Severity array*)
		QueryCount : USINT; (*Count of query results for building the query table configuration string*)
	END_STRUCT;
	AuditType : 	STRUCT  (*Structure to hold the Audit data for the query results*)
		Active : BOOL; (*ActiveAudits query, StateActive column*)
		Acknowledged : BOOL; (*ActiveAudits query, StateAcknowledged column*)
		Scope : WSTRING[80]; (*ActiveAudits query, Scope column*)
		Name : STRING[80]; (*ActiveAudits query, Name column*)
		Message : WSTRING[255]; (*ActiveAudits query, Message column*)
		AdditionalInfo : WSTRING[255]; (*ActiveAudits query, AdditionalInformation1*)
		TimeStamp : DATE_AND_TIME; (*ActiveAudits query, TimeStamp column*)
		Code : UDINT; (*ActiveAudits query, Code column*)
		Severity : UDINT; (*ActiveAudits query, Severity column*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	ActiveAuditStateEnum : 
		( (*Enumeration for the state for the query state machine*)
		ACTIVE_AUDIT_WAIT, (*Wait state*)
		ACTIVE_AUDIT_QUERY, (*State to query the Audit data*)
		ACTIVE_AUDIT_NEXT (*State to check if more Audits meet the query criteria and need to be queried*)
		);
END_TYPE
