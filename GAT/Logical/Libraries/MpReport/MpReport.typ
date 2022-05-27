
TYPE
	MpReportCoreInfoType : 	STRUCT 
		NumberOfReports : UDINT; (*Number of created reports*)
		GeneratedFileName : STRING[50]; (*File name of created report*)
		Diag : MpReportDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpReportDiagType : 	STRUCT 
		StatusID : MpReportStatusIDType; (*StatusID diagnostic structure *)
	END_STRUCT;
	MpReportStatusIDType : 	STRUCT 
		ID : MpReportErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
END_TYPE
