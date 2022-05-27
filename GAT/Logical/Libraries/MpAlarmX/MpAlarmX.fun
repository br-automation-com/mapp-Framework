(*Core Function Blocks*)

FUNCTION_BLOCK MpAlarmXCore (*mapp component for advanced centralized alarm collection and management*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		ActiveAlarms : UDINT; (*Number of alarms which are currently active*) (* *) (*#CMD#;*)
		PendingAlarms : UDINT; (*Number of alarms which are currently pending (either active, or not yet acknowleged)*) (* *) (*#CMD#;*)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK
(*UI Function Blocks*)

FUNCTION_BLOCK MpAlarmXListUI (*add-on function block that provides VC4 connection datapoints to display the currently active alarms in a list*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		UISetup : MpAlarmXListUISetupType; (*Setup UI connection - must be configured before enabling the FB*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpAlarmXListUIConnectType; (*UI connection datapoints*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAlarmXHistoryUI (*add-on function block that provides VC4 connection datapoints to display the alarm history in a list*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		UISetup : MpAlarmXHistoryUISetupType; (*Setup UI connection - must be configured before enabling the FB*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpAlarmXHistoryUIConnectType; (*UI connection datapoints*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK
(*General add-ons*)

FUNCTION MpAlarmXCheckState : BOOL (*Add-on function which checks whether an alarm is currently in a certain state*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : STRING[255]; (*Unique Identifier of the alarm*) (* *) (*#PAR#;*)
		State : MpAlarmXStateEnum; (*Check whether the alarm is currently in this state*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXCheckStateID : BOOL (*Add-on function which checks whether an alarm is currently in a certain state*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		InstanceID : UDINT; (*Instance ID of the alarm that should be checked for its state*) (* *) (*#PAR#;*)
		State : MpAlarmXStateEnum; (*Check whether the alarm is currently in this state*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXCheckReaction : BOOL (*Add-on function which checks whether a certain reaction is currently active, returns TRUE if at least one alarm is currently active that requires this reaction*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : STRING[255]; (*Unique name of the reaction*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXSet : UDINT (*Add-On function to set (raise) a user alarm. By calling this function the alarm system is informed that a specific alarm is active. Returns InstanceID of the alarm that was set.*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : STRING[255]; (*Unique name of the alarm*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXAcknowledge : DINT (*Add-On function to acknowledge an alarm. By calling this function the alarm system is informed that the operator has acknowledged an alarm. Returns result code.*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : STRING[255]; (*Unique name of the alarm*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXAcknowledgeID : DINT (*Add-On function to acknowledge an alarm. By calling this function the alarm system is informed that the operator has acknowledged an alarm. Returns result code.*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		InstanceID : UDINT; (*Instance ID of the alarm that should be acknowledged*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXReset : DINT (*Add-On function to reset a user alarm. By calling this function the alarm system is informed that a specific alarm is inactive. Returns result code.*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : STRING[255]; (*Unique name of the alarm*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAlarmXResetID : DINT (*Add-On function to reset a user alarm. By calling this function the alarm system is informed that a specific alarm is inactive. Returns result code.*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		InstanceID : UDINT; (*Instance ID of the alarm that should be reset*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION
(*History add-ons*)

FUNCTION_BLOCK MpAlarmXHistory (*Historical recording of all alarm related events*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		DeviceName : REFERENCE TO STRING[50]; (*Name of device to export the alarm history to*) (* *) (*#CMD#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID that should be used when exporting data*) (* *) (*#CMD#OPT#;*)
		Export : BOOL; (*Save the current alarm history data (since last archiving) to the given file device (as a human-readable file)*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (* *) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpAlarmXClearHistory : DINT (*Add-On function to clear the complete alarm history*) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION
(*Configuration add-ons*)

FUNCTION_BLOCK MpAlarmXConfigAlarm (*add-on function block that allows to load and save alarm configurations *) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : REFERENCE TO STRING[255]; (*Unique Identifier of the alarm*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpAlarmXAlarmConfigType; (*Configuration parameters (mapp standard interface)*) (* *) (*#PAR#;*)
		Load : BOOL; (*Read configuration from AR into the config structure*) (* *) (*#CMD#*)
		Save : BOOL; (*Write configuration from config structure to AR*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAlarmXConfigMapping (*add-on function block that allows to load and save mapping configurations *) (* $GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Type : MpAlarmXMappingTypeEnum; (*Type of the mapping (Alarm Name, Severity or Default)*) (* *) (*#PAR#;*)
		Name : REFERENCE TO STRING[255]; (*Name (meaning depends on the Type setting)*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpAlarmXMappingConfigType; (*Configuration parameters (mapp standard interface)*) (* *) (*#PAR#;*)
		Load : BOOL; (*Read configuration from AR into the config structure*) (* *) (*#CMD#*)
		Save : BOOL; (*Write configuration from config structure to AR*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		Info : MpAlarmXInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAlarmXQuery (*Add-on function block that can be used to get data from the Alarm system using configured Queries.*) (*$GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID (and optionally measurement-system) that will be used when exporting the data. (e.g. "en|metric").*) (* *) (*#PAR#;*)
		Mode : MpAlarmXQueryModeEnum; (*Specify the kind of query. For the "Pending alarms" Query source, the Mode input is ignored and behaves always like the mpALARMX_QUERY_MODE_ALL*) (* *) (*#CMD#;*)
		Name : REFERENCE TO STRING[50]; (*Name of the Query to execute*) (* *) (*#CMD#;*)
		Execute : BOOL; (*Execute the query*) (* *) (*#CMD#;*)
		Next : BOOL; (*Execute the query - get next entries*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		Info : MpAlarmXQueryInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAlarmXAcknowledgeAll (*Add-on function block that can be used to acknowledge all alarms from the Alarm system.*) (*$GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Execute : BOOL; (*Execute the command acknowledgeAll*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		Info : MpAlarmXAcknowledgeAllInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAlarmXAlarmControl (*Add-on function block that can be used to control a single alarm.*) (*$GROUP=mapp Services,$CAT=Alarm System,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAlarmX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Name : REFERENCE TO STRING[255]; (*Unique name of the alarm - will only be evaluated during Enable of the FB*) (* *) (*#PAR#;*)
		ID : UDINT; (*SessionID. When this is set the Reset/Acknowledge will work on the session with this given ID*) (* *) (*#PAR#;*)
		Set : BOOL; (*Set (raise) the specified alarm (Name). By setting this command the alarm system is informed that the alarm is active. Same behaviour as MpAlarmXSet*) (* *) (*#CMD#;*)
		Reset : BOOL; (*Reset the specfified alarm (Name or ID when ID != 0). By setting this command the alarm system is informed that the alarm is inactive. Same behaviour as MpAlarmXReset(ID)*) (* *) (*#CMD#;*)
		Acknowledge : BOOL; (*Acknowledge the speficief alarm (Name or ID when ID != 0). By setting this command the alarm system is informed that the operator has acknowledged the alarm. Same behaviour as MpAlarmXAcknowledge(ID)*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#;*)
		InstanceID : UDINT; (*SessionID of the last alarm-session that was set by this FB*) (* *) (*#PAR#;*)
		Info : MpAlarmXControlInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK
