
FUNCTION_BLOCK MpReportCore (*Component provides the functionality to enerate pdf reports*) (* $GROUP=mapp Services,$CAT=PDF Report,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpReport.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets  function block errors*) (* *) (*#PAR#;*)
		Name : REFERENCE TO STRING[50]; (*Name of Report*) (* *) (*#CMD#;*)
		Language : REFERENCE TO STRING[20]; (*Report language*) (* *) (*#CMD#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		Generate : BOOL; (*Create Report as PDF*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly *) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block *) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Optional: Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Create report as PDF is finished*) (* *) (*#CMD#;*)
		Info : MpReportCoreInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK
