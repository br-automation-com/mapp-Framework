
FUNCTION_BLOCK MpBackupCore (*This function block can create or restore backups of the machine software. Also newer versions of the machine software can be installed.*) (* $GROUP=mapp Services,$CAT=Backup & Restore,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpBackup.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets  function block errors*) (* *) (*#PAR#;*)
		DeviceName : REFERENCE TO STRING[50]; (*Name of  the file device on which a manual backup should be created or wherefrom  a backup or update should be installed*) (* *) (*#CMD#; *)
		Name : REFERENCE TO STRING[255]; (*Name and path of the backup to create or restore. (e.g. "FolderName/Name"). Together with the file device name an absolute path including name is being built*) (* *) (*#CMD#; *)
		Create : BOOL; (*Creates a new software image of the running target and stores it on the defined DeviceName/Name*) (* *) (*#CMD#; *)
		Install : BOOL; (*Restores a backup or updates new software version given by DeviceName/Name*) (* *) (*#CMD#; *)
		RequestInfo : BOOL; (*Determines project infomation of the specified update/backup*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly *) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block *) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Optional: Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#; *)
		Info : MpBackupCoreInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpBackupCoreConfig (*This function block provides the functionality for changing the mapp configuration of MpBackupCore during runtime*) (* $GROUP=mapp Services,$CAT=Backup & Restore,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpBackup.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpBackupCoreConfigType; (*Configuration parameters (mapp standard interface)*) (* *) (*#PAR#; *)
		Load : BOOL; (*Read configuration*) (* *) (*#CMD#*)
		Save : BOOL; (*Write configuration*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#*)
		Info : MpBackupInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK
