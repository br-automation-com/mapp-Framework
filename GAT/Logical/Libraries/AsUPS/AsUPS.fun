                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ups_comm					(*transfers additional parameters and commands to the UPS*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		user_command	:STRING[128];	(*string which should be transferred to the UPS*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		ups_answer	:STRING[128];		(*response from the UPS*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ups_init					(*initializes the connection and transfer of UPS parameters*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		device	:UDINT;					(*device name given as a pointer, which clearly describes the interface used*)
		mode	:UDINT;					(*string which configures the interface to be used, given as a pointer*)
		ShutDownTime	:DINT;			(*time from the detection of the UPS shutdown message to the time it takes automation runtime to shut down*)
		ShutDownMode	:USINT;			(*parameter for shutdown mode: 0 no shutdown, 17 shutdown with warm restart mode, ..*)
		ShutDownDCD	:USINT;				(*shutdown condition for the DCD signal*)
		TWL	:STRING[10];				(*parameter for TWL example*)
		LCS	:STRING[10];				(*parameter for LCS*)
		SDT	:STRING[10];				(*parameter for SDT*)
		POT	:STRING[10];				(*parameter for POT*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		UPS_OS	:STRING[128];			(*UPS operating system version*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ups_getcomstate			(*monitors handshake transmissions and shutdowns for automation runtime*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		DCD	:BOOL;						(*DCD signal state*)
		CTS	:BOOL;						(*CTS signal state*)
		ShutDownTime	:REAL;			(*delay time until automation runtime shutdown*)
	END_VAR
	VAR
		DCD_old	:BOOL;					(*internal variable*)
		CTS_old	:BOOL;					(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ups_ar_shutdown : UINT			(*restarts or shuts down automation runtime*)
	VAR_INPUT	
		enable	:BOOL;					(*enables execution*)
		ShutDownMode	:USINT;			(*shutdown mode: 0 no shutdown, 01 restart with warm restart mode, ..*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ups_deinit : UINT				(*closes all internal connections and releases the interface*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
	END_VAR
END_FUNCTION
