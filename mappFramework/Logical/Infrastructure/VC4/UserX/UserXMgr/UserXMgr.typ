
TYPE
	enumCheckState : 
		(
		USERX_START := 0,
		USERX_WAIT_FOR_DIALOG := 1,
		USERX_SET_RESPONSE := 2,
		USERX_CONFIRM_RESPONSE := 3,
		USERX_NEW_EXPORT := 4,
		USERX_FINISH := 5
		);
	HMIUser_Typ : 	STRUCT 
		NewFileName : STRING[255];
		Export : BOOL;
		ConfirmOverwrite : BOOL;
		CancelOverwrite : BOOL;
		FileDuplicate : BOOL;
		FileDuplicateLayerStatus : USINT;
		ButtonLockedMessageLayer : USINT;
		ButtonLockingLayer : USINT;
	END_STRUCT;
END_TYPE
