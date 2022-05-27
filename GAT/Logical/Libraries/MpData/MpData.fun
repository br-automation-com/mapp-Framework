
FUNCTION_BLOCK MpDataRecorder (*Logs PVs and stores them in a .csv file*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Header : REFERENCE TO MpDataRecorderHeaderType; (*Header information with additional information for recording or no header information if NULL appended*) (* *) (*#CMD#OPT#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		SamplingTime : TIME; (*Sampling rate used for saving new values (used for time-based recording mode)[ms]*) (* *) (*#CMD#;*)
		RecordMode : MpDataRecordModeEnum; (*Recording mode*) (* *) (*#CMD#;*)
		Record : BOOL; (*Command used to begin recording PV data*) (* *) (*#CMD#;*)
		Trigger : BOOL; (*Trigger (used for the recording mode that works with a trigger)*) (* *) (*#CMD#;*)
		SnapShot : BOOL; (*Exports the current data in the internal buffer to the file without interrupting or affecting recording*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		Recording : BOOL; (*Indicates that a "Record" command is active*) (* *) (*#CMD#; *)
		RecordDone : BOOL; (*Data recording successfully completed*) (* *) (*#CMD#; *)
		SnapShotDone : BOOL; (*Data transferred from internal memory to file successfully*) (* *) (*#CMD#; *)
		Info : MpDataRecorderInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDataRecorderConfig (*Configuration for data recorder*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpDataRecorderConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpDataInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDataRegParLimits (*Registers process variables for logging*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		PVName : REFERENCE TO STRING[100]; (*The name of the PV that should be recorded*) (* *) (*#PAR#;*)
		Unit : REFERENCE TO STRING[20]; (*Unit for the process variable*) (* *) (*#PAR#;*)
		Description : REFERENCE TO STRING[50]; (*Column header in the file*) (* *) (*#PAR#;*)
		ScaleFactor : REAL := 1.0; (*Factor used to multiply the PV by before saving (default value = 1.0)*) (* *) (*#PAR#;*)
		UpperLimit : LREAL; (*Upper limit (considering scale factor)*) (* *) (*#CMD#;*)
		LowerLimit : LREAL; (*Lower limit (considering scale factor)*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		LimitMonitor : MpDataPVItemLimitEnum; (*Shows whether value is within limits, checked when recording is active. Always shows mpDATA_NO_LIMITS_CONFIGURED for non-primitve datatypes (arrays, structures) *)  (* *) (*#CMD#;*)
		Info : MpDataInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDataRegPar (*Registers process variables for logging*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		PVName : REFERENCE TO STRING[100]; (*The name of the PV that should be recorded*) (* *) (*#PAR#;*)
		Unit : REFERENCE TO STRING[20]; (*Unit for the process variable*) (* *) (*#PAR#;*)
		Description : REFERENCE TO STRING[50]; (*Column header in the file*) (* *) (*#PAR#;*)
		ScaleFactor : REAL := 1.0; (*Factor used to multiply the PV by before saving (default value = 1.0)*) (* *) (*#PAR#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpDataInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDataStatisticsUI (*Logs PVs and stores them in a .csv file*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : MpDataStatisticsUISetupType; (*Configuration of elements to be connected to the visualization*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpDataStatisticsUIConnectType; (*Parameters and commands to be connected to the visualization*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpDataInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDataTableUI (*Logs PVs and stores them in a .csv file*) (* $GROUP=mapp Services,$CAT=PV Value Sampling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpData.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : MpDataTableUISetupType; (*Configuration of elements to be connected to the visualization*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpDataTableUIConnectType; (*Parameters and commands to be connected to the visualization*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpDataInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK
