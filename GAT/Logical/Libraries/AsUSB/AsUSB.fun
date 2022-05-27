                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK UsbNodeListGet			(* get USB node list *)
	VAR_INPUT
		enable			: BOOL;			(* fub enable *)
		pBuffer			: UDINT;		(* pointer to input buffer *)
		bufferSize		: UDINT;		(* max length of input buffer *)
		filterInterfaceClass : UINT;	(* filter for interface class *)
		filterInterfaceSubClass : UINT;	(* filter for interface subclass *)
	END_VAR
	VAR_OUTPUT
		status			: UINT;			(* status *)
		allNodes		: UDINT;		(* all usb nodes on target *)
		listNodes		: UDINT;		(* usb nodes in the list *)
		attachDetachCount:UDINT;		(* attach/deatch actions *)
	END_VAR
	VAR
        i_state			: UINT;			(* internal variable *)
		i_result		: UINT;			(* internal variable *)
        i_tmp			: UDINT;		(* internal variable *)
	END_VAR
END_FUNCTION_BLOCK
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK UsbNodeGet 				(* get USB node description *)
	VAR_INPUT
		enable			: BOOL;			(* fub enable *)
		nodeId			: UDINT;		(* unique node identifier of USBNodeListGet *)
		pBuffer			: UDINT;		(* pointer to input buffer *)
		bufferSize		: UDINT;		(* max length of input buffer *)
	END_VAR
	VAR_OUTPUT
		status			: UINT;			(* status *)
	END_VAR
	VAR
        i_state			: UINT;			(* internal variable *)
		i_result		: UINT;			(* internal variable *)
        i_tmp			: UDINT;		(* internal variable *)
	END_VAR
END_FUNCTION_BLOCK
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK UsbDescriptorGet			(* get USB node descriptor *)
	VAR_INPUT
		enable			: BOOL;			(* fub enable *)
		nodeId			: UDINT;		(* unique node identifier of USBNodeListGet *)
		requestType		: USINT;		(* reqeust type *)
		descriptorType	: USINT;		(* descriptor type *)
		descriptorIndex	: USINT;		(* descriptor index *)
		languageId		: UINT;			(* language unicode *)
		pBuffer			: UDINT;		(* pointer to input buffer *)
		bufferSize		: UINT;			(* max length of input buffer *)
	END_VAR
	VAR_OUTPUT
		status			: UINT;			(* status *)
		actSize			: UINT;			(* length of received data *)
	END_VAR
	VAR
        i_state			: UINT;			(* internal variable *)
		i_result		: UINT;			(* internal variable *)
        i_tmp			: UDINT;		(* internal variable *)
	END_VAR
END_FUNCTION_BLOCK
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK UsbMsDeviceReady			(* get USB mass storage device ready status *)
	VAR_INPUT
		enable			: BOOL;			(* fub enable *)
		pIfName			: UDINT;		(* pointer to string of ifName of input buffer of USBNodeGet *)
	END_VAR
	VAR_OUTPUT
		status			: UINT;			(* status *)
		ready			: BOOL;			(* device ready status true/false *)
	END_VAR
	VAR
        i_state			: UINT;			(* internal variable *)
		i_result		: UINT;			(* internal variable *)
        i_tmp			: UDINT;		(* internal variable *)
	END_VAR
END_FUNCTION_BLOCK


