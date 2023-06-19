
FUNCTION_BLOCK MpPackMLCore (*Centralized PackML state machine handling*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		ModeCurrent : DINT; (*Current mode*) (* *) (*#CMD#;*)
		StateCurrent : MpPackMLStateEnum; (*Current state, depends on the active mode*) (* *) (*#CMD#;*)
		Info : MpPackMLCoreInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpPackMLMode (*Controls state transitions*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		ModeID : DINT; (*Unique identification number for each mode*) (* *) (*#PAR#;*)
		Activate : BOOL; (*Enables this mode, if allowed*) (* *) (*#CMD#;*)
		Start : BOOL; (*PackML START command*) (* *) (*#CMD#;*)
		Stop : BOOL; (*PackML STOP command*) (* *) (*#CMD#;*)
		Reset : BOOL; (*PackML RESET command*) (* *) (*#CMD#;*)
		Hold : BOOL; (*PackML HOLD command*) (* *) (*#CMD#;*)
		Unhold : BOOL; (*PackML UNHOLD command*) (* *) (*#CMD#;*)
		Suspend : BOOL; (*PackML SUSPEND command*) (* *) (*#CMD#;*)
		Unsuspend : BOOL; (*PackML UNSUSPEND command*) (* *) (*#CMD#;*)
		Abort : BOOL; (*PackML ABORT command*) (* *) (*#CMD#;*)
		Clear : BOOL; (*PackML CLEAR command*) (* *) (*#CMD#;*)
		StateComplete : BOOL; (*PackML STATE COMPLETE command*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		ChangeModeAllowed : BOOL; (*Indicates whether changing the mode is allowed*) (* *) (*#CMD#;*)
		ModeActive : BOOL; (*Indicates whether this mode is active*) (* *) (*#CMD#;*)
		StateCurrent : MpPackMLStateEnum; (*Current state*) (* *) (*#CMD#;*)
		Info : MpPackMLModeInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpPackMLBasicUI (*mapp component for connecting a VC4 visualization to the MpPackML and display a debug page with PackML states machine in a graphical view*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpPackMLBasicUIConnectType; (*UI connection data points*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#;*)
		Info : MpPackMLUIInfoType; (*Structure with information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpPackMLStatisticsUI (*mapp component for connecting a VC4 visualization to the MpPackML and display a debug page with PackML states machine in a graphical view*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpPackMLStatisticsUIConnectType; (*UI connection data points*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#;*)
		Info : MpPackMLUIInfoType; (*Structure with information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpPackMLModule (*Synchronized PackML state machine handling*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpPackMLModuleParType; (*Parameters*) (* *) (*#PAR#;*)
		Update : BOOL; (*Updates the parameters*) (* *) (*#PAR#;*)
		Blocked : BOOL; (*Indicates that the machine is blocked and signals the top module to send out a Suspend command. When the signal is set to false the top module will send out a Unsuspend command.*) (* *) (*#CYC#OPT#;*)
		Starved : BOOL; (*Indicates that the machine is starved and signals the top module to send out a Suspend command. When the signal is set to false the top module will send out a Unsuspend command.*) (* *) (*#CYC#OPT#;*)
		Command : MpPackMLModuleCommandType; (*Control commands from ISA-TR88.00.02 commands.*) (* *) (*#CMD#;*)
		SubState : DINT; (*The sub state of the module. Can be used for programming the sequence inside a PackML state. Will automatically be reset to 0 by a PackML state change.*) (* *) (*#CYC#;*)
		StateInfo : STRING[255]; (*Status of what the substate is doing or waiting for. Will also be used for logging.*) (* *) (*#CYC#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		UpdateDone : BOOL; (*Update of parameters done*) (* *) (*#PAR#; *)
		StateCurrent : MpPackMLStateEnum; (*Current state*) (* *) (*#CMD#;*)
		SubStateCurrent : DINT; (*Current sub state*) (* *) (*#CMD#;*)
		ModeID : DINT; (*Unique identification number for each mode*) (* *) (*#CMD#;*)
		Info : MpPackMLModuleInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpPackMLModeChangeIsAllowed : DINT (*Indicates whether it is possible to go to the desired Mode from the current State and Mode *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp. Must be of type mppackmlcore configuration*) (* *) (*#PAR#;*)
		ModeID : DINT; (*Desired mode to change to. The mode must be defined in the mppackmlcore configuration*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLChangeMode : DINT (*Function changing the mode of a MpPackMLModule*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp. Must be of type mppackmlcore configuration*) (* *) (*#PAR#;*)
		ModeID : DINT; (*Desired mode to change to. The mode must be defined in the mppackmlcore configuration*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLModeCurrent : DINT (*Returns the current mode as an ID*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLStateCurrent : MpPackMLStateEnum (*Returns the current state*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLStateIsActive : BOOL (*Indicates whether the state being checked is active*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		State : MpPackMLStateEnum; (*State to be checked*) (* *) (*#PAR#;*)
		Mode : DINT; (*Mode in which the command should be executed (0 = the command can be executed in all modes)*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLModeIsActive : BOOL (*Indicates whether the mode being checked is active*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Mode : DINT; (*Mode being checked*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLStateComplete : BOOL (*Function executing STATE COMPLETE command. The return value is TRUE if the command was accepted*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Mode : DINT; (*Mode in which the command should be executed (0 = the command can be executed in all modes)*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpPackMLAbort : BOOL (*Function executing ABORT command. The return value is TRUE if the command was accepted*) (* $GROUP=mapp Services,$CAT=OMAC PackML,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpPackML.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Mode : DINT; (*Mode in which the command should be executed (0 = the command can be executed in all modes)*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION
