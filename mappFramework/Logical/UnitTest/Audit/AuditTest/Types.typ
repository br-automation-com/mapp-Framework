
TYPE
	TestStateEnum : 
		(
		TEST_ARRANGE := 10,
		TEST_ACT := 20,
		TEST_ASSERT := 30,
		temp := 40
		);
END_TYPE

(*UserX control*)

TYPE
	UserXLogin_type : 	STRUCT 
		Commands : UserXLoginCommands_type;
		Status : UserXLoginStatus_type;
		Parameters : UserXLoginParameters_type;
	END_STRUCT;
	UserXLoginCommands_type : 	STRUCT 
		Enable : BOOL;
		Login : BOOL;
		Logout : BOOL;
	END_STRUCT;
	UserXLoginStatus_type : 	STRUCT 
		CommandDone : BOOL;
		CurrentUser : WSTRING[50];
		Error : BOOL;
	END_STRUCT;
	UserXLoginParameters_type : 	STRUCT 
		UserName : STRING[50];
		Password : UDINT;
	END_STRUCT;
END_TYPE

(*HMIAudit control*)

TYPE
	HMIAuditInterface_type : 	STRUCT 
		Commands : HMIAuditInterfaceCommands_type;
		Status : HMIAuditInterfaceStatus_type;
		Parameters : HMIAuditInterfaceParameters_type;
	END_STRUCT;
	HMIAuditInterfaceCommands_type : 	STRUCT 
		ExportArchives : BOOL;
	END_STRUCT;
	HMIAuditInterfaceStatus_type : 	STRUCT 
		AuditTrailCmdDone : BOOL;
		AuditTrailArchiveAvailable : BOOL;
		NumberOfArchives : UINT;
	END_STRUCT;
	HMIAuditInterfaceParameters_type : 	STRUCT 
		ArchiveSettings : HMIAuditArchiveParType;
	END_STRUCT;
	HMIAuditArchiveParType : 	STRUCT 
		Enable : BOOL;
		MaxSize : UDINT;
		Mode : MpAuditArchiveModeEnum;
		Hour : USINT;
		Minute : USINT;
		FileType : MpAuditFileTypeEnum;
	END_STRUCT;
END_TYPE

(*MpRecipe control*)

TYPE
	MpRecipeUIConnect_type : 	STRUCT 
		Parameters : MpRecipeUIConnectParameters_type;
		Commands : MpRecipeUIConnectCommands_type;
		Status : MpRecipeUIConnectStatus_type;
	END_STRUCT;
	MpRecipeUIConnectParameters_type : 	STRUCT 
		FileName : USINT;
	END_STRUCT;
	MpRecipeUIConnectCommands_type : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	MpRecipeUIConnectStatus_type : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
END_TYPE
