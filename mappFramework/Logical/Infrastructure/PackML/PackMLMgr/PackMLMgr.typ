(*Structure types*)

TYPE
	PackMLHmiInterfaceType : 	STRUCT  (*Structure to hold commands, parameters and status from the HMI*)
		Commands : PackMLCommandsType;
		Parameters : PackMLParametersType;
		Status : PackMLStatusType;
		Activate : BOOL;
	END_STRUCT;
	PackMLCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
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
	PackMLParametersType : 	STRUCT  (*Structure to hold the parameters for the HMI*)
		Par : USINT;
		StateEnabled : PackMLStateEnabledType;
	END_STRUCT;
	PackMLStatusType : 	STRUCT  (*Structure to hold status information from the mapp View HMI*)
		StateCurrent : STRING[20];
		ModeCurrent : STRING[50];
		DownTimeReason : STRING[255];
		PackMLStateModel : STRING[100000];
		PackMLState : MpPackMLStateEnum;
	END_STRUCT;
	PackMLStateEnabledType : 	STRUCT  (*Structure to hold state availability definition*)
		Clearing : BOOL; (*Statistic information for Clearing state*)
		Stopped : BOOL; (*Statistic information for Stopped state*)
		Starting : BOOL; (*Statistic information for Starting state*)
		Idle : BOOL; (*Statistic information for Idle state*)
		Suspended : BOOL; (*Statistic information for Suspended state*)
		Execute : BOOL; (*Statistic information for Execute state*)
		Stopping : BOOL; (*Statistic information for Stopping state*)
		Aborting : BOOL; (*Statistic information for Aborting state*)
		Aborted : BOOL; (*Statistic information for Aborted state*)
		Holding : BOOL; (*Statistic information for Holding state*)
		Held : BOOL; (*Statistic information for Held state*)
		Unholding : BOOL; (*Statistic information for Unholding state*)
		Suspending : BOOL; (*Statistic information for Suspending state*)
		Unsuspending : BOOL; (*Statistic information for Unsuspending state*)
		Resetting : BOOL; (*Statistic information for Resetting state*)
		Completing : BOOL; (*Statistic information for Completing state*)
		Complete : BOOL; (*Statistic information for Complete state*)
	END_STRUCT;
END_TYPE

(*Enumerations*)
