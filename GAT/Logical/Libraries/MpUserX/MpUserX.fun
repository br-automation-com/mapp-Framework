
FUNCTION_BLOCK MpUserXLogin (*Login and logout users (via the application)*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		LifeSign : DINT; (*Used to determine if the logged in user has been inactive for a long time. The inactivity time is reset when this input changes*) (* *) (*#CYC#;*)
		Login : BOOL; (*Command used to log in*) (* *) (*#CMD#;*)
		Logout : BOOL; (*Command used to log out*) (* *) (*#CMD#;*)
		UserName : REFERENCE TO WSTRING[50]; (*Username to be used for logging in*) (* *) (*#CMD#;*)
		Password : REFERENCE TO WSTRING[50]; (*Password to be used for logging in*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		CurrentUser : WSTRING[50]; (*Username of the logged in user*) (* *) (*#CMD#;*)
		CurrentLevel : DINT; (*Level of the logged in user*) (* *) (*#CMD#;*)
		AccessRights : ARRAY[0..19] OF MpUserXAccessRightEnum; (*Access rights of the logged in user*) (* *) (*#CMD#;*)
		Info : MpUserXLoginInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpUserXInternalType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXManagerUI (*UI connection for VC4 user management page*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : MpUserXMgrUISetupType; (*Used to configure the elements connected to the HMI application*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpUserXMgrUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpUserXInternalType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXLoginUI (*UI connection for VC4 login/logout page*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpUserXLoginUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpUserXInternalType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION MpUserXLevel : DINT (*Returns the level of the user who is currently logged in*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION MpUserXAccessRight : MpUserXAccessRightEnum (*Returns the access rights of the user who is currently logged in*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Right : UINT; (*Function for which the access right should be checked*) (* *) (*#CMD#;*)
	END_VAR
END_FUNCTION

FUNCTION MpUserXHasRole : BOOL (*Returns whether the currently logged in user has the given role*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Role : WSTRING[50];
	END_VAR
END_FUNCTION

FUNCTION MpUserXGetData : DINT (*Get additional user-data for a given user*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		UserName : WSTRING[50]; (*Username to be used for logging in*) (* *) (*#PAR#;*)
		Key : WSTRING[20]; (*Key to identify value to query (case-sensitive)*) (* *) (*#PAR#;*)
		Value : WSTRING[255]; (*Buffer to write value to*) (* *) (*#PAR#;*)
		ValueSize : UDINT; (*Max. size of write-buffer*) (* *) (*#PAR#;*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MpUserXConfig (*Configuration for user management*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpUserXConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal information *)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXLoginConfig (*Configuration for the login/logout behavior*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpUserXLoginConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal information *)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXSignatureUI (*UI-Interface for electronic signature*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		SignAction : DINT; (*Triggers for application to start signature-procedure*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpUserXSignatureUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpUserXInternalType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXSignature (*Check electronic signature*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		ActionID : DINT; (*Optional ActionID set by the SignatureUI*) (* *) (*#CMD#;*)
		Released : BOOL; (*Action is released (Active for 1 call only!)*) (* *) (*#CMD#;*)
		Rejected : BOOL; (*Action is rejected (Active for 1 call only!)*) (* *) (*#CMD#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpUserXInternalType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXServerConfig (*Configuration for central user management*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpUserXServerConfigType; (*Structure used to specify the server configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal information *)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpUserXMappingConfig (*Configuration for group to role mapping*) (* $GROUP=mapp Services,$CAT=User Role Manager,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpUserX.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpUserXMappingConfigType; (*Structure used to specify the mapping*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpUserXInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal information *)
	END_VAR
END_FUNCTION_BLOCK
