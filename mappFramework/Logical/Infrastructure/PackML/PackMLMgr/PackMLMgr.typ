(*Structure types*)

TYPE
	PackMLHmiInterfaceType : 	STRUCT 
		Commands : PackMLCommandsType;
		Parameters : PackMLParametersType;
		Status : PackMLStatusType;
		Activate : BOOL;
	END_STRUCT;
	PackMLCommandsType : 	STRUCT 
		Reset : BOOL;
		Start : BOOL;
		Stop : BOOL;
		Hold : BOOL;
		Unhold : BOOL;
		Suspend : BOOL;
		Unsuspend : BOOL;
		Abort : BOOL;
		Clear : BOOL;
		Complete : BOOL;
	END_STRUCT;
	PackMLParametersType : 	STRUCT 
		Par : USINT;
	END_STRUCT;
	PackMLStatusType : 	STRUCT 
		CurrentPackMLState : USINT;
		CurrentMode : DINT;
		DownTimeReason : STRING[255];
	END_STRUCT;
END_TYPE

(*Enumerations*)
