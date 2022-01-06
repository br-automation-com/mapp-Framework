                                                                      
{REDUND_ERROR} FUNCTION_BLOCK AsIOMMCreate				(*creates a mapping- or ArConfigmodule from the pDataobject data object; asynchronous execution*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		pDataObject	:UDINT;				(*data object's module name given as a pointer*)
		pNewModule	:UDINT;				(*new module name of the mapping- or ArConfigmodules given as a pointer*)
		moduleKind	:USINT;				(*ArConfig or mapping module: name value description iommMAPPING, iommCONFIG*)
		memType	:USINT;					(*type of target memory*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		errCode	:UINT;					(*extended error code*)
	END_VAR
	VAR
		StateMan	:UINT;				(*internal variable*)
		ErrMan	:UINT;					(*internal variable*)
		Init	:UDINT;					(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK AsIOMMRemove				(*deinstalls and deletes the pModuleName CM module; asynchronous execution*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		pModuleName	:UDINT;				(*module name of the configuration- or mappingmodule given as a pointer*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		errCode	:UINT;					(*extended error code*)
	END_VAR
	VAR
		StateMan	:UINT;				(*internal variable*)
		ErrMan	:UINT;					(*internal variable*)
		Init	:UDINT;					(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK AsIOMMCopy				(*creates a copy of the pModuleName CM module in the form of a data object; asynchronous execution*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		pModuleName	:UDINT;				(*module name of the configuration- or mappingmodule given as a pointer*)
		pNewModule	:UDINT;				(*new module name of the mapping- or ArConfigmodules given as a pointer*)
		memType	:USINT;					(*type of target memory*)
		option	:UDINT;					(*doNO_CS = 1 no checksum*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		errCode	:UINT;					(*extended error code*)
		ident	:UDINT;					(*ident of the new module*)
	END_VAR
	VAR
		StateMan	:UINT;				(*internal variable*)
		ErrMan	:UINT;					(*internal variable*)
		Init	:UDINT;					(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK AsIOMMCompare				(*compares installed module pModuleName with pDataObject in the form of a data object; asynchronous execution*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		pModuleName	:UDINT;				(*module name of the configuration- or mappingmodule given as a pointer*)
		pDataObject	:UDINT;				(*other mapping- or ArConfigmodule in form of a data object given as a pointer*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		errCode	:UINT;					(*extended error code*)
		isEqual	:BOOL;					(*true if modules are the same, false otherwise*)
	END_VAR
	VAR
		StateMan	:UINT;				(*internal variable*)
		ErrMan	:UINT;					(*internal variable*)
		Init	:UDINT;					(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK
