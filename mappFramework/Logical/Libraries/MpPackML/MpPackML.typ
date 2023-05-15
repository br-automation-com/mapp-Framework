
TYPE
	MpPackMLStatusIDType : 	STRUCT 
		ID : MpPackMLErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpPackMLDiagType : 	STRUCT 
		StatusID : MpPackMLStatusIDType; (*StatusID diagnostic structure*)
	END_STRUCT;
	MpPackMLCoreInfoType : 	STRUCT 
		ModeCurrent : STRING[50]; (*Current mode*)
		StateCurrent : STRING[20]; (*Current state*)
		Diag : MpPackMLDiagType; (*Diagnostic structure for the status ID*)
		PackTagsStatus : MpPackMLPackTagsStatusEnum; (*PackTags initialization status*)
	END_STRUCT;
	MpPackMLModeInfoType : 	STRUCT 
		ModeCurrent : STRING[50]; (*Current mode*)
		StateCurrent : STRING[20]; (*Current state*)
		ActivationAborted : BOOL; (*Displayed if this mode could not be enabled after an "Activate" command*)
		Diag : MpPackMLDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpPackMLUIInfoType : 	STRUCT 
		ModeCurrent : STRING[50]; (*Current mode*)
		StateCurrent : STRING[20]; (*Current state*)
		Diag : MpPackMLDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpPackMLBasicUIConnectType : 	STRUCT 
		StateControl : MpPackMLBasicUIStateControlType; (*States control*)
		ModeControl : MpPackMLBasicUIModeControlType; (*Mode switch control*)
		ModeCurrent : DINT; (*Current mode*)
		StateCurrent : MpPackMLStateEnum; (*Current state. This output reports the state indipendently of the mode*)
	END_STRUCT;
	MpPackMLBasicUIStateControlType : 	STRUCT  (*Commands available from hmi*)
		Start : BOOL; (*PackML command START*)
		Stop : BOOL; (*PackML command STOP*)
		Reset : BOOL; (*PackML command RESET*)
		Hold : BOOL; (*PackML command HOLD*)
		Unhold : BOOL; (*PackML command UNHOLD*)
		Suspend : BOOL; (*PackML command SUSPEND*)
		Unsuspend : BOOL; (*PackML command UNSUSPEND*)
		Abort : BOOL; (*PackML command ABORT*)
		Clear : BOOL; (*PackML command CLEAR*)
		StateComplete : BOOL; (*PackML command STATE COMPLETE*)
		ColorIndex : MpPackMLColorIndexStatesType; (*Color index for HMI visualization of state (ready to use as color map or bitmap group). The blinking of active state is automatically handled*)
	END_STRUCT;
	MpPackMLBasicUIModeControlType : 	STRUCT 
		SelectedIndex : UINT; (*Mode selected: the command Change will call an activation command fir this mode*)
		MaxSelection : UDINT; (*Number of available modes in the system*)
		LockActivation : BOOL; (*The selected mode (ModeSelected) is not activable*)
		Activate : BOOL; (*Command to activate the selected mode (SelectedIndex)*)
	END_STRUCT;
	MpPackMLColorIndexStatesType : 	STRUCT 
		Clearing : USINT; (*Color Index for Clearing state*)
		Stopped : USINT; (*Color Index for Stopped state*)
		Starting : USINT; (*Color Index for Starting state*)
		Idle : USINT; (*Color Index for Idle state*)
		Suspended : USINT; (*Color Index for Suspended state*)
		Execute : USINT; (*Color Index for Execute state*)
		Stopping : USINT; (*Color Index for Stopping state*)
		Aborting : USINT; (*Color Index for Aborting state*)
		Aborted : USINT; (*Color Index for Aborted state*)
		Holding : USINT; (*Color Index for Holding state*)
		Held : USINT; (*Color Index for Held state*)
		Unholding : USINT; (*Color Index for Unholding state*)
		Suspending : USINT; (*Color Index for Suspending state*)
		Unsuspending : USINT; (*Color Index for Unsuspending state*)
		Resetting : USINT; (*Color Index for Resetting state*)
		Completing : USINT; (*Color Index for Completing state*)
		Complete : USINT; (*Color Index for Complete state*)
	END_STRUCT;
	MpPackMLStatisticsUIConnectType : 	STRUCT 
		States : MpPackMLStatisticsUIStatesType; (*States statistics*)
		Mode : MpPackMLStatisticsUIModeType; (*Mode statistics*)
		ModeCurrent : DINT; (*Current mode*)
		StateCurrent : MpPackMLStateEnum; (*Current state. This output reports the state indipendently of the mode*)
	END_STRUCT;
	MpPackMLStatisticsUIModeType : 	STRUCT 
		ModeID : DINT; (*Mode reference for statistics information [0: mode current]*)
		CumulativeTime : MpPackMLStatisticsUITimeType; (*Cumulative timer relative to the ModeID selected [sec]*)
		CumulativePercent : REAL; (*Cumulative timer relative to the ModeID selected [%]*)
	END_STRUCT;
	MpPackMLStatisticsUIStatesType : 	STRUCT 
		Clearing : MpPackMLStatisticsUIStateType; (*Statistic information for Clearing state*)
		Stopped : MpPackMLStatisticsUIStateType; (*Statistic information for Stopped state*)
		Starting : MpPackMLStatisticsUIStateType; (*Statistic information for Starting state*)
		Idle : MpPackMLStatisticsUIStateType; (*Statistic information for Idle state*)
		Suspended : MpPackMLStatisticsUIStateType; (*Statistic information for Suspended state*)
		Execute : MpPackMLStatisticsUIStateType; (*Statistic information for Execute state*)
		Stopping : MpPackMLStatisticsUIStateType; (*Statistic information for Stopping state*)
		Aborting : MpPackMLStatisticsUIStateType; (*Statistic information for Aborting state*)
		Aborted : MpPackMLStatisticsUIStateType; (*Statistic information for Aborted state*)
		Holding : MpPackMLStatisticsUIStateType; (*Statistic information for Holding state*)
		Held : MpPackMLStatisticsUIStateType; (*Statistic information for Held state*)
		Unholding : MpPackMLStatisticsUIStateType; (*Statistic information for Unholding state*)
		Suspending : MpPackMLStatisticsUIStateType; (*Statistic information for Suspending state*)
		Unsuspending : MpPackMLStatisticsUIStateType; (*Statistic information for Unsuspending state*)
		Resetting : MpPackMLStatisticsUIStateType; (*Statistic information for Resetting state*)
		Completing : MpPackMLStatisticsUIStateType; (*Statistic information for Completing state*)
		Complete : MpPackMLStatisticsUIStateType; (*Statistic information for Complete state*)
		ResetTimers : BOOL; (*Command to reset all timers (current and cumulative) about modes and states*)
	END_STRUCT;
	MpPackMLStatisticsUIStateType : 	STRUCT 
		CumulativeTime : MpPackMLStatisticsUITimeType; (*Cumulative timers relative to the state that belong to the ModeID selected [sec]*)
		CumulativePercent : REAL; (*Cumulative timers relative to the state that belong to the ModeID selected [%]*)
		CurrentTime : MpPackMLStatisticsUITimeType; (*Current timers relative to the state that belong to the ModeID selected [sec]*)
	END_STRUCT;
	MpPackMLStatisticsUITimeType : 	STRUCT 
		Hours : UDINT; (*Number of hours*)
		Minutes : USINT; (*Number of minutes within an hour*)
		Seconds : USINT; (*Numer of seconds within a minute*)
	END_STRUCT;
	MpPackMLStateEnum : 
		(
		mpPACKML_STATE_UNDEFINED := 0, (*The system is inactive, no state active*)
		mpPACKML_STATE_CLEARING := 1, (*PackML CLEARING state*)
		mpPACKML_STATE_STOPPED := 2, (*PackML STOPPED state*)
		mpPACKML_STATE_STARTING := 3, (*PackML STARTING state*)
		mpPACKML_STATE_IDLE := 4, (*PackML IDLE state*)
		mpPACKML_STATE_SUSPENDED := 5, (*PackML SUSPENDED state*)
		mpPACKML_STATE_EXECUTE := 6, (*PackML EXECUTE state*)
		mpPACKML_STATE_STOPPING := 7, (*PackML STOPPING state*)
		mpPACKML_STATE_ABORTING := 8, (*PackML ABORTING state*)
		mpPACKML_STATE_ABORTED := 9, (*PackML ABORTED state*)
		mpPACKML_STATE_HOLDING := 10, (*PackML HOLDING state*)
		mpPACKML_STATE_HELD := 11, (*PackML HELD state*)
		mpPACKML_STATE_UNHOLDING := 12, (*PackML UNHOLDING state*)
		mpPACKML_STATE_SUSPENDING := 13, (*PackML SUSPENDING state*)
		mpPACKML_STATE_UNSUSPENDING := 14, (*PackML UNSUSPENDING state*)
		mpPACKML_STATE_RESETTING := 15, (*PackML RESETTING state*)
		mpPACKML_STATE_COMPLETING := 16, (*PackML COMPLETING state*)
		mpPACKML_STATE_COMPLETE := 17, (*PackML COMPLETE state*)
		mpPACKML_STATE_DEACTIVATING := 30, (*Deactivating state. Not a standard PackML state*)
		mpPACKML_STATE_DEACTIVATED := 31, (*Deactivated state. Not a standard PackML state*)
		mpPACKML_STATE_ACTIVATING := 32 (*Activating state. Not a standard PackML state*)
		);
	MpPackMLPackTagsStatusEnum : 
		(
		mpPACKML_PACKTAGS_DISABLED := 0, (*PackTags handling disabled*)
		mpPACKML_PACKTAGS_INIT := 1, (*PackTags initialization in progress*)
		mpPACKML_PACKTAGS_OK := 2, (*PackTags handling ok*)
		mpPACKML_PACKTAGS_ERROR_TAG := 6, (*PackTags initialization finshed with error: mandatory tag not found*)
		mpPACKML_PACKTAGS_ERROR_TYPE := 10, (*PackTags initialization finshed with error: tag has wrong datatype*)
		mpPACKML_PACKTAGS_ERROR_STRUCT := 14 (*PackTags initialization finshed with error: structure configured not found*)
		);
	MpPackMLModuleCommandType : 	STRUCT 
		Abort : BOOL; (*Go to state Aborting - Can be set in all states except Aborting and Aborted.*)
		Clear : BOOL; (*Go to state Clearing - Can only be set in state Aborted.*)
		Stop : BOOL; (*Go to state Stopping - Can be set in all states except Aborting, Aborted, Clearing, Stopping and Stopped.*)
		Reset : BOOL; (*Go to state Resetting - Can only be set in state Stopped.*)
		Start : BOOL; (*Go to state Starting - Can only be set in state Idle.*)
		Hold : BOOL; (*Go to state Holding. Can only be set in state Execute.*)
		Unhold : BOOL; (*Go to state Unholding. Can only be set in state Held.*)
		Suspend : BOOL; (*Go to state Suspending. Can only be set in state Execute.*)
		Unsuspend : BOOL; (*Go to state Unsuspending. Can only be set in state Suspended.*)
		StateComplete : BOOL; (*Go to next waiting state. Can be set in all acting states and state Execute.*)
	END_STRUCT;
	MpPackMLModuleParType : 	STRUCT  (*Parameter structure*)
		Overwrite : MpPackMLModuleOverwriteType; (*Inputs that are overwritten by parent module.*)
		Escalate : MpPackMLModuleEscalateType; (*Escalate command to parent module.*)
	END_STRUCT;
	MpPackMLModuleInfoType : 	STRUCT 
		ModeCurrent : STRING[50]; (*Current mode*)
		StateCurrent : STRING[20]; (*Current state*)
		ChildCount : UDINT; (*How many children are registered to this module. Even when desynchronised the child count will still be valid.*)
		Parent : MpPackMLParentType; (*Information about the parent module.*)
		Level : UDINT; (*Level in the hierarchy. Parent is level 0.*)
		ReadyForCommand : BOOL; (*Indicates that command state complete has been set to true and that the module is ready to receive a command.
*)
		Diag : MpPackMLDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpPackMLParentType : 	STRUCT  (*Information about the parent module.*)
		Name : STRING[255] := ''; (*Name of the module from the module configuration.*)
		StateCurrent : MpPackMLStateEnum := mpPACKML_STATE_UNDEFINED; (*Current parent state.*)
		SubStateCurrent : DINT := 0; (*Current parent sub state.*)
	END_STRUCT;
	MpPackMLModuleOverwriteType : 	STRUCT  (*Inputs that are overwritten by parent module.*)
		Abort : BOOL := TRUE; (*Overwite Abort command from parent module.*)
		Stop : BOOL := TRUE; (*Overwite Stop command from parent module.*)
		AllOtherCommands : BOOL := TRUE; (*Overwite all other commands from parent module.*)
	END_STRUCT;
	MpPackMLModuleEscalateType : 	STRUCT  (*Escalate command to parent module.*)
		Abort : BOOL := TRUE; (*Escalate an Abort command to parent module.*)
	END_STRUCT;
	MpPackMLModulePVType : 	STRUCT  (*This structure provides information about a certain module.*)
		Name : STRING[255] := ''; (*Name of the module from the module configuration.*)
		StateCurrent : MpPackMLStateEnum := mpPACKML_STATE_UNDEFINED; (*Module state.*)
		SubStateCurrent : DINT := 0; (*Module sub state*)
		StateInfo : STRING[255] := ''; (*Module state information*)
	END_STRUCT;
END_TYPE
