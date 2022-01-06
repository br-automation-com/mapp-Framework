
FUNCTION_BLOCK MpToolManager (*FB for managing tools*)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*MpLink reference to establish the connection between the function block and the tool manager component*) (* *) (*#PAR#;*)
		Enable : BOOL; (*The function block is active as long as this input is set*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpToolManagerParType; (*Function block parameters*) (* *) (*#PAR#; *)
		Create : BOOL; (*Command for creating tool data*) (* *) (*#CMD#; *)
		Delete : BOOL; (*Command for deleting tool data*) (* *) (*#CMD#; *)
		Get : BOOL; (*Command for getting tool data*) (* *) (*#CMD#; *)
		Set : BOOL; (*Command for setting tool data*) (* *) (*#CMD#; *)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Error occurred during execution*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Optional: Function block is currently executing a command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Execution successful. Function block is finished.*) (* *) (*#CMD#; *)
		Info : MpToolManagerInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpToolGetData (*FB for getting tool data stored in the system*)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*MpLink reference to establish the connection between the function block and the tool manager component*) (* *) (*#PAR#;*)
		Enable : BOOL; (*The function block is active as long as this input is set.*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpToolGetDataParType; (*Function block parameters*) (* *) (*#PAR#; *)
		Execute : BOOL; (*Gets first data element. The mode defines which data is read*) (* *) (*#CMD#; *)
		Next : BOOL; (*Gets next data element*) (* *) (*#CMD#; *)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Error occurred during execution*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Optional: Function block is currently executing a command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Execution successful. Function block is finished*) (* *) (*#CMD#; *)
		Result : MpToolGetDataResultType; (*Result output structure*) (* *) (*#CMD#; *)
		HasMoreElements : BOOL; (*If true, more elements are available and can be read using "Next" command*) (* *) (*#CMD#;*)
		Info : MpToolGetDataInfoType; (*Additional information about the component*) (* *) (*#CMD#; *)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK
