                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjCreate						(*creates a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		grp			:USINT;						(*group ID for the data object (default 0x00), must be set to zero*)
		pName		:UDINT;						(*pointer to name of the data object to be created*)
		len			:UDINT;						(*length of the data area of the data object to be created*)
		MemType		:USINT;						(*type of target memory: doTEMP, doUSRRAM, doUSRROM, doSYSROM, doFIXRAM, doMEMCARD*)
		Option		:UDINT;						(*options: doNO_CS*)
		pCpyData	:UDINT;						(*pointer to data written to the data object during generation*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		ident		:UDINT;						(*ID of the created data object*)
		pDatObjMem	:UDINT;						(*pointer to the data in the data object*)
	END_VAR
	VAR 
		i_state		:UDINT;						(*internal variable*)
		i_result	:UDINT;						(*internal variable*)
		i_spare		:ARRAY[0..104] OF USINT;	(*internal variable*)
		i_spare_1	:UDINT;						(*internal variable*)
		i_spare_2	:UINT;						(*internal variable*)
		i_spare_3	:UDINT;						(*internal variable*)
		i_spare_4	:USINT;						(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjWrite						(*writes to a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
		Offset		:UDINT;						(*offset in the data area of the data object*)
		pSource		:UDINT;						(*pointer to the data copied to the data object*)
		len			:UDINT;						(*length of the data to be copied*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjRead						(*reads from a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
		Offset		:UDINT;						(*offset in the data area of the data object*)
		pDestination:UDINT;						(*memory to which the data to be read is copied*)
		len			:UDINT;						(*length of the data to be copied*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjDelete						(*deletes data objects*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
	VAR
		i_state		:UDINT;						(*internal variable*)
		i_result	:UDINT;						(*internal variable*)
		i_spare		:USINT;						(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjMove						(*moves the storage space of a data object to a new target memory*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
		MemType		:USINT;						(*target memory in which the data object is to be saved,  e.g. doTEMP, doUSRRAM, doUSRROM, ...*)
		Option		:UDINT;						(*options for the object to be saved (doNO_CS = no checksum)*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		identNew	:UDINT;						(*ID of the new data object*)
		pDatObjMem	:UDINT;						(*pointer to the data in the newly created data object*)
	END_VAR
	VAR
		i_state		:UDINT;						(*internal variable*)
		i_result	:UDINT;						(*internal variable*)
		i_spare		:ARRAY[0..40] OF USINT;		(*internal variable*)
		i_spare_1	:UDINT;						(*internal variable*)
		i_spare_2	:USINT;						(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjCopy						(*copies a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object to be copied*)
		pNameTarget	:UDINT;						(*pointer to name of the new data object*)
		MemTypeTarget	:USINT;					(*target memory in which the new object is to be generated,  e.g. doTEMP, doUSRRAM, ...*)
		OptionTarget	:UDINT;					(*options for the copied object (doNO_CS = no checksum)*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;							(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		identNew	:UDINT;						(*ID of the copied data object*)
		pDatObjMemNew	:UDINT;					(*pointer to the data in the newly created data object*)
	END_VAR
	VAR
		i_state		:UDINT;						(*internal variable*)
		i_result	:UDINT;						(*internal variable*)
		i_spare		:ARRAY[0..40] OF USINT;		(*internal variable*)
		i_spare_1	:UDINT;						(*internal variable*)
		i_spare_2	:USINT;						(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjInfo						(*gives information about a data object*)
	VAR_INPUT	
		enable		:BOOL;						(*enables execution*)
		pName		:UDINT;						(*name of data object*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		ident		:UDINT;						(*ID of the data object*)
		pDatObjMem	:UDINT;						(*pointer to the data in the data object*)
		len			:UDINT;						(*length of the data area in the data object*)
		MemType		:USINT;						(*memory type in which the data object is located,  e.g. doTEMP, doUSRRAM, doUSRROM, ...*)
		Option		:UDINT;						(*information about data object options*)
		ChangeDate	:DATE_AND_TIME;				(*modification date of the data object*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjChangeDate					(*changes the modification date of a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		pName		:UDINT;						(*pointer to name of data object*)
		SetDate		:DATE_AND_TIME;				(*date and time; if the value 0 is transferred, the current PLC system time is used*)
	END_VAR	
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjAttach						(*attaches a data object to prevent deletion*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK DatObjDetach						(*detaches a data object*)
	VAR_INPUT
		enable		:BOOL;						(*enables execution*)
		ident		:UDINT;						(*ID of the data object*)
	END_VAR
	VAR_OUTPUT
		status		:UINT;						(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK
