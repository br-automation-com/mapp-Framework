                                                                                                 
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_mode				(*modifies the values for the baud rate and asynchronous parameters*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		mode	:UDINT;				(*address of the string which configures the interface to be used*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_ctrl				(*operates the DSR/DTR signals for modem capable interfaces*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		ioctrl	:UINT;				(*control selection*)
		inarg	:UDINT;				(*input argument*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		outarg	:UDINT;				(*output argument*)
	END_VAR
	VAR
		internal	:STRING[43];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_robuf			(*releases the send buffer manually*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		buffer	:UDINT;				(*send buffer address*)
		buflng	:UINT;				(*send buffer length*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_gbuf				(*requests an available send buffer*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		buffer	:UDINT;				(*send buffer address*)
		buflng	:UINT;				(*send buffer length*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_rbuf				(*releases the receive buffer*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		buffer	:UDINT;				(*receive buffer address*)
		buflng	:UINT;				(*receive buffer length*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_close			(*closes a previously opened serial interface*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_write			(*enables the frame driver to send data to the send buffer*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		buffer	:UDINT;				(*send buffer address*)
		buflng	:UINT;				(*send buffer length*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_writeAcknowledged (*enables the frame driver to send data to the send buffer*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
		buffer	:UDINT;				(*send buffer address*)
		buflng	:UINT;				(*send buffer length*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_read				(*starts the receive process*)
	VAR_INPUT	
		enable	:BOOL;				(*enables execution*)
		ident	:UDINT;				(*driver ID for the interface (see FRM_xopen())*)
	END_VAR
	VAR_OUTPUT	
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		buffer	:UDINT;				(*receive buffer address*)
		buflng	:UINT;				(*receive buffer length*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK FRM_xopen			(*opens a serial interface for frame transfer*)
	VAR_INPUT
		enable	:BOOL;				(*enables execution*)
		device	:UDINT;				(*pointer to a string which clearly describes the interface used*)
		mode	:UDINT;				(*pointer to the string which configures the interface to be used*)
		config	:UDINT;				(*address for a configuration structure can be entered at this point (optional entry)*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		ident	:UDINT;				(*driver ID for the interface (required for other functions in the DVFrame library)*)
	END_VAR
	VAR
		internal	:STRING[27];	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK
