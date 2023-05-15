(*Structure types*)

TYPE
	UserXHmiInterfaceType : 	STRUCT  (*Structure to hold commands and status from the HMI*)
		Commands : UserXCommandsType; (*Structure to hold the commands from the HMI*)
		Status : UserXStatusType; (*Structure to hold status information to the HMI*)
	END_STRUCT;
	UserXCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		Export : BOOL; (*Export a user list*)
		ConfirmOverwrite : BOOL; (*Confirm you want to overwrite an existing user export with the same filenmae*)
	END_STRUCT;
	UserXStatusType : 	STRUCT  (*Structure to hold status information to the HMI*)
		FileDuplicate : BOOL; (*Flag that a user export file already exists with the specified name*)
		UserXHmiState : HmiStateEnum; (*State variable for HMI interaction*)
		LastMgrConnectStatus : MpUserXUIStatusEnum;
		ExportComplete : BOOL;
		UserExportDisplayed : BOOL;
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	HmiStateEnum : 
		( (*State enumeration for HMI interaction*)
		USERX_START := 0,
		USERX_WAIT_FOR_DIALOG := 1,
		USERX_SET_RESPONSE := 2,
		USERX_CONFIRM_RESPONSE := 3,
		USERX_NEW_EXPORT := 4,
		USERX_FINISH := 5
		);
END_TYPE
