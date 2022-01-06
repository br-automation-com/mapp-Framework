                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK SdmSystemDump			(*SDM - create a system dump; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		configuration	: UDINT;		(*cfgSDM_SYSTEMDUMP_PARAM(0) parameters only or cfgSDM_SYSTEMDUMP_DATA(1) parameters and data-files*)
		pDevice			: UDINT;		(*Devicename given as a pointer*)
		pFile			: UDINT;		(*Filename given as a pointer*)
		pParam			: UDINT;		(*Parameterstring given as a pointer*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK SdmSetAppParam 	(*SDM - set application mode; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		appMode			: UDINT;		(*cfgSDM_APPMODE_OK(1),cfgSDM_APPMODE_WARNING(2),cfgSDM_APPMODE_ERROR(3)*)
		pLink			: UDINT;		(*URL given as a pointer*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK
