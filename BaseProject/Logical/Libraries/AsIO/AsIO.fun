                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIODPStatus				(*determines the state and current value of an I/O data point; asynchronous execution*)
	VAR_INPUT
		enable       : BOOL; 			(*enables execution*)
		pDatapoint   : UDINT; 			(*I/O data point name given as a pointer*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status       : UINT; 			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
        flags        : USINT;			(*information about the state of the data point*)
        datatype     : USINT;			(*data type of the data point according to the profibus standard*)
        value        : UDINT;			(*value of the data point*)
        forceValue   : UDINT;			(*force value of the data point*)
        defaultValue : UDINT;			(*default value of the data point*)
	END_VAR

END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOSetForceValue		(*sets the value of an I/O data point's "force" status; asynchronous execution*)
	VAR_INPUT
		enable       : BOOL; 			(*enables execution*)
		pDatapoint   : UDINT; 			(*I/O data point name given as a pointer*)
        value        : UDINT;			(*force value*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status  : UINT; 				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOEnableForcing		(*enables the "force" status of an I/O data point; asynchronous execution*)
	VAR_INPUT	
		enable       : BOOL; 			(*enables execution*)
		pDatapoint   : UDINT; 			(*I/O data point name given as a pointer*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status  : UINT; 				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

END_FUNCTION_BLOCK


{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIODisableForcing		(*disables the "force" status of an I/O data point; asynchronous execution*)
	VAR_INPUT
		enable       : BOOL; 			(*enables execution*)
		pDatapoint   : UDINT; 			(*I/O data point name given as a pointer*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status  : UINT; 				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOGlobalDisableForcing	(*disables the "force" status of all I/O data points; asynchronous execution*)
	VAR_INPUT
		enable           : BOOL; 		(*enables execution*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status  : UINT; 				(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

END_FUNCTION_BLOCK


{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOFListDP			(*determines filtered I/O data points; asynchronous execution*)
	VAR_INPUT
		enable           : BOOL; 		(*enables execution*)
		flagsValue		 : UDINT;       (*value of flags filter*)
		flagsMask 		 : UDINT;       (*mask of flags filter*)
		pFilterString    : UDINT;       (*filterstring given as a pointer*)
		pLastDatapoint   : UDINT; 		(*old data point name given as a pointer*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
        buffer       : ARRAY[0..255] OF USINT;	(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status       : UINT; 			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		pDatapoint   : UDINT; 			(*data point name given as a pointer*)
	END_VAR

END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOListDP				(*determines the existing I/O data points; asynchronous execution*)
	VAR_INPUT
		enable       : BOOL; 			(*enables execution*)
		pLastDatapoint   : UDINT; 		(*old data point name given as a pointer*)
	END_VAR

	VAR
        i_state      : UINT;			(*internal variable*)
        i_result     : UINT;			(*internal variable*)
        unused       : UDINT;			(*internal variable*)
        buffer       : ARRAY[0..127] OF USINT;	(*internal variable*)
	END_VAR

	VAR_OUTPUT
		status       : UINT; 			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		pDatapoint   : UDINT; 			(*data point name given as a pointer*)
	END_VAR

END_FUNCTION_BLOCK
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsIOPVInfo				(*collects data about PV's that are linked with a data point; asynchronous execution*)
   VAR_INPUT
       enable     : BOOL;				(*enables execution*)
       pDatapoint : UDINT;				(*I/O data point name given as a pointer*)
       index      : UDINT;				(*index of the searched PV*)
   END_VAR

   VAR
       i_state      : UINT;				(*internal variable*)
       i_result     : UINT;				(*internal variable*)
       bufferA       : ARRAY[0..127] OF USINT;	(*internal variable*)
       bufferB       : ARRAY[0..127] OF USINT;	(*internal variable*)
   END_VAR

	VAR_OUTPUT
		status       : UINT; 			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		pPvName      : UDINT; 			(*PV names given as pointer, 0 if there is no PV linked with the specified index*)
		pPvContext   : UDINT; 			(*context names (given as a pointer) that are used to map this PV*)
        flags        : USINT;			(*additional information*)
	END_VAR

END_FUNCTION_BLOCK


