
FUNCTION_BLOCK MpFileManagerUI (*File management system and UI connection to VC4*) (* $GROUP=mapp Services,$CAT=File Explorer,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpFile.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : MpFileManagerUISetupType; (*Used to configure the elements connected to the HMI application*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpFileManagerUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		Info : MpFileInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpComInternalDataType; (*Internal stucture*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpFileManagerConfig (*mapp component for read/write component configuration*) (* $GROUP=mapp Services,$CAT=File Explorer,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpFile.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpFileManagerConfigType; (*The component configuration structure.*) (* *) (*#PAR#; *)
		Load : BOOL; (*Reads the component configuration.*) (* *) (*#CMD#; *)
		Save : BOOL; (*Writes the component configuration.*) (* *) (*#CMD#; *)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*True if a command finshed successfully.*) (* *) (*#CMD#;*)
		Info : MpFileInfoType; (*Provide any further useful information as function block output.(mapp standard interface)*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK
