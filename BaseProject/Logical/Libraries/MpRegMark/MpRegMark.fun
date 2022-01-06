
FUNCTION_BLOCK MpRegMarkDetection (*mapp component to detect registration marks.*) (* $GROUP=mapp Control,$CAT=WebHandling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpWebHandling.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Detect : BOOL; (*Starts/stops the automatic detection of a registration mark.*) (* *) (*#CMD#;*)
		Search : BOOL; (*Starts/stops the manual search of a registration mark.*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		DetectionBusy : BOOL; (*The detection of the registration mark is busy.*) (* *) (*#CMD#;*)
		DetectionActive : BOOL; (*The detection of the registration mark is active.*) (* *) (*#CMD#;*)
		DetectionTrigger : BOOL; (*A valid registratin mark was detected.*) (* *) (*#CMD#;*)
		SearchBusy : BOOL; (*The manual search of a registration mark is busy.*) (* *) (*#CMD#;*)
		SearchActive : BOOL; (*The manual search of a registration mark is active.*) (* *) (*#CMD#;*)
		SearchDone : BOOL; (*The manual search of a registration mark is completed.*) (* *) (*#CMD#;*)
		Info : MpRegMarkDetectionInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpRegMarkDetectionConfig (*mapp component to configure a registration mark detection.*) (* $GROUP=mapp Control,$CAT=WebHandling,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpWebHandling.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Incoming communication handle (mapp standard interface)*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block (mapp standard interface)*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets all function block errors (mapp standard interface)*) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpRegMarkDetectionConfigType; (*Configuration parameters (mapp standard interface)*) (* *) (*#PAR#; *)
		Load : BOOL; (*Read configuration*) (* *) (*#CMD#*)
		Save : BOOL; (*Write configuration*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active (mapp standard interface)*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates an error (mapp standard interface)*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Error/Status information (mapp standard interface)*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block is busy processing a command.*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command has finished and was successful.*) (* *) (*#CMD#*)
		Info : MpRegMarkInfoType; (*Additional information*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK
