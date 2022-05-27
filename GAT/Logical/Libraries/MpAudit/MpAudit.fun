
FUNCTION MpAuditWStringChange : DINT (*Detects the change of a unicode string and creates an event for audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Old : WSTRING[100]; (*Entered when creating the entry under %old*) (* *) (*#CMD#;*)
		New : WSTRING[100]; (*Entered when creating the entry under %new*) (* *) (*#CMD#;*)
		Identifier : STRING[100]; (*Entered when creating the entry under %dpid *) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAuditStringChange : DINT (*Detects the change of a string and creates an event for audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Old : STRING[100]; (*Entered when creating the entry under %old *) (* *) (*#CMD#;*)
		New : STRING[100]; (*Entered when creating the entry under %new*) (* *) (*#CMD#;*)
		Identifier : STRING[100]; (*Entered when creating the entry under %dpid *) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MpAuditTrailConfig (*Configuration for audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpAuditTrailConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpAuditTrailInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpAuditCustomEvent : DINT (*Sets a user-defined event*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Type : WSTRING[100]; (*Entered when creating the entry under %typ*) (* *) (*#CMD#;*)
		Message : WSTRING[100]; (*Entered when creating the entry under %msg*) (* *) (*#CMD#;*)
		Comment : WSTRING[100]; (*Entered when creating the entry under %cmt *) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MpAuditTrailUI (*UI connection to a VC4 audit trail page*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : MpAuditTrailUISetupType; (*Used to configure the elements connected to the HMI application*) (* *) (*#PAR#;*)
		Refresh : BOOL; (*A rising edge on this command updates the event list (e.g. after the language has been changed)*) (* *) (*#CMD#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID (and optionally measurement-system) that should be used when exporting data (e,g, "en|metric")*) (* *) (*#CMD#;*)
		UIConnect : REFERENCE TO MpAuditTrailUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpAuditInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAuditTrail (*Centralized event audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID (and optionally measurement-system) that should be used when exporting data (e,g, "en|metric")*) (* *) (*#CMD#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		Export : BOOL; (*Saves the currently logged from memory to a file on the specified data storage medium ("DeviceName")*) (* *) (*#CMD#;*)
		ExportArchive : BOOL; (*Exports the oldest archive to the specified data storage medium ("DeviceName")*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		CurrentRecord : UDINT; (*Counts all events*) (* *) (*#CMD#;*)
		ArchiveAvailable : BOOL; (*Indicates that an archive is currently available and can be exported*) (* *) (*#CMD#;*)
		Info : MpAuditTrailInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpAuditValueChange : DINT (*Detects the change of a value and creates an event for audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Old : LREAL; (*Entered when creating the entry under %old*) (* *) (*#CMD#;*)
		New : LREAL; (*Entered when creating the entry under %new*) (* *) (*#CMD#;*)
		Identifier : STRING[100]; (*Entered when creating the entry under %dpid*) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MpAuditVC4Event (*Collects events from VC4 for the audit trail*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Localize : BOOL; (*Defines whether the user ID or description of the user ID is used to create an entry*) (* *) (*#CMD#;*)
		MinUserID : UINT; (*First ID from VC4 for which events are logged*) (* *) (*#CMD#;*)
		MaxUserID : UINT; (*Last ID from VC4 for which events are logged*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpAuditVC4EventInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAuditRegPar (*Register and monitor a PV*)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*The parameter is registered on a positive edge on this input and unregistered on a negative edge*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		PVName : REFERENCE TO STRING[100]; (*Name of PV that should be monitored*) (* *) (*#CMD#;*)
		Identiffier : REFERENCE TO STRING[100]; (*Identifier for given PV used in MpAudit (optional). If no separate identifier is given than the PV-name will be used*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpAuditTrailInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpAuditClearBuffer : DINT (*Clears the audit buffer (archives are not effected)*)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpAuditStartBatch : DINT (*Creates a event marking the start of a new batch*)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Name : WSTRING[50]; (*Name (unique identifier) of batch*) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MpAuditExport (*Advanced export function*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Filter : REFERENCE TO MpAuditExportFilterType; (*Filter-settings to be applied for data to export*) (* *) (*#CMD#;*)
		ToRecord : UDINT; (*Record-number up to which (and excluding) data is exported*) (* *) (*#CMD#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID (and optionally measurement-system) that should be used when exporting data (e,g, "en|metric")*) (* *) (*#CMD#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		Export : BOOL; (*Execute export*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Record : UDINT; (*Record-number of last exported record (set after export)*) (* *) (*#CMD#;*)
		Info : MpAuditInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpAuditQuery (*Query Data function*) (* $GROUP=mapp Services,$CAT=Audit Trail,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpAudit.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Mode : MpAuditQueryModeEnum; (*Kind of query*) (* *) (*#CMD#;*)
		Name : REFERENCE TO STRING[50]; (*Name of query to execute*) (* *) (*#CMD#;*)
		Language : REFERENCE TO STRING[20]; (*Language ID (and optionally measurement-system) that should be used when exporting data (e,g, "en|metric")*) (* *) (*#CMD#;*)
		Execute : BOOL; (*Execute query*) (* *) (*#CMD#;*)
		Next : BOOL; (*Execute query - get next entries*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpAuditQueryInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK
