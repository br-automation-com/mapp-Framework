
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysGetSystemLanguage	(*determine preferred user-language*)
	VAR_INPUT
		Execute 		: BOOL; 			(*start on rising edge*)
	END_VAR
	VAR_OUTPUT
		Done			: BOOL; 			(*execution successful. FB finished*)
		Busy			: BOOL; 			(*FB is still active; needs call*)
		Error			: BOOL;
		StatusID		: DINT;
		LanguageCode	: ArTextSysLanguageCodeType;
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysExec1InternalType;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysSetSystemLanguage	(*update preferred user-language*)
	VAR_INPUT
		Execute 		: BOOL;
		LanguageCode	: ArTextSysLanguageCodeType;
	END_VAR
	VAR_OUTPUT
		Done			: BOOL;
		Busy			: BOOL;
		Error			: BOOL; 			(*error occurred during operation*)
		StatusID		: DINT;
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysExec1InternalType;
	END_VAR
END_FUNCTION_BLOCK


{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysGetNamespaceLanguages
	VAR_INPUT
		Execute 		: BOOL; 			(*start on rising edge*)
		Namespace		: UDINT;			(*string-pointer to namespace*)
		First			: BOOL; 			(*get first entry; or next*)
	END_VAR
	VAR_OUTPUT
		Done			: BOOL; 			(*execution successful. FB finished*)
		Busy			: BOOL; 			(*FB is still active; needs call*)
		Error			: BOOL; 			(*error occurred during operation*)
		StatusID		: DINT;
		LanguageCode	: ArTextSysLanguageCodeType;
		EndOfList		: BOOL; 			(*indicator for last found entry*)
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysIter1InternalType;
	END_VAR
END_FUNCTION_BLOCK


{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysGetText
	VAR_INPUT
		Execute 		: BOOL;
		Namespace		: UDINT;			(*string-pointer to namespace*)
		TextID			: UDINT;			(*string-pointer to text-key*)
		LanguageCode	: ArTextSysLanguageCodeType;
		TextBufferSize	: UDINT;			(*size of result-buffer to get text*)
		TextBuffer		: UDINT;			(*pointer to text result-buffer*)
		SearchMode		: ArTextSysSearchModeEnum;
	END_VAR
	VAR_OUTPUT
		Done			: BOOL; 			(*execution successful. FB finished*)
		Busy			: BOOL; 			(*FB is still active; needs call*)
		Error			: BOOL; 			(*error occurred during operation*)
		StatusID		: DINT;
		TextSize		: UDINT;			(*Length of text in result-buffer*)
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysExec1InternalType;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysFormatString
	VAR_INPUT
		Execute 		: BOOL;
		FormatString	: UDINT;			(*string-pointer to format-template*)
		ArgumentCount	: UINT; 			(*count of arguments in list*)
		ArgumentList	: ARRAY[0..9] OF ArTextSysFormatArgumentType;
		LanguageCode	: ArTextSysLanguageCodeType;
		MeasurementCode : UDINT;
		TextBufferSize	: UDINT;			(*size of result-buffer to get text*)
		TextBuffer		: UDINT;			(*pointer to result-buffer*)
	END_VAR
	VAR_OUTPUT
		Done			: BOOL; 			(*execution successful. FB finished*)
		Busy			: BOOL; 			(*FB is still active; needs call*)
		Error			: BOOL; 			(*error occurred during operation*)
		StatusID		: DINT;
		TextSize		: UDINT;			(*Length of text in result-buffer*)
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysExec1InternalType;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArTextSysGetFormattedText
	VAR_INPUT
		Execute 		: BOOL;
		Namespace		: UDINT;			(*string-pointer to namespace*)
		TextID			: UDINT;			(*string-pointer to text-key*)
		ArgumentCount	: UINT; 			(*count of arguments in list*)
		ArgumentList	: ARRAY[0..9] OF ArTextSysFormatArgumentType;
		LanguageCode	: ArTextSysLanguageCodeType;
		MeasurementCode : UDINT;
		TextBufferSize	: UDINT;			(*size of result-buffer to get text*)
		TextBuffer		: UDINT;			(*pointer to result-buffer*)
		SearchMode		: ArTextSysSearchModeEnum;
	END_VAR
	VAR_OUTPUT
		Done			: BOOL; 			(*execution successful. FB finished*)
		Busy			: BOOL; 			(*FB is still active; needs call*)
		Error			: BOOL; 			(*error occurred during operation*)
		StatusID		: DINT;
		TextSize		: UDINT;			(*Length of text in result-buffer*)
	END_VAR
	VAR (*internals*)
		Internal : ArTextSysExec1InternalType;
	END_VAR
END_FUNCTION_BLOCK
