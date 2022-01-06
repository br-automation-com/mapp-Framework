                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartCreate			(*creates a memory partition with lenght "len"*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		len	:UDINT;						(*size of the memory partition*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		ident	:UDINT;					(*identifier of the memory partition*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartDestroy			(*deletes a memory partition*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartAlloc			(*allocates a memory block from the specified memory partition*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
		len	:UDINT;						(*size of the memory block to be allocated*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		mem	:UDINT;						(*pointer to the allocated memory block*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartAllocClear		(*allocates a memory block from the specified memory partition*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
		len	:UDINT;						(*size of the memory block to be allocated*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		mem	:UDINT;						(*pointer to the allocated memory block*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartRealloc			(*changes an allocated memory block or allocate a new memory block with the modified size*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
		memOld	:UDINT;					(*pointer to an already allocated memory block*)
		len	:UDINT;						(*size of the memory block to be allocated*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		mem	:UDINT;						(*pointer to the allocated memory block*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartFree			(*frees up an allocated memory block*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
		mem	:UDINT;						(*pointer to the memory block to be freed up*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AsMemPartInfo			(*gives information about free momory of the selected memory partition*)
	VAR_INPUT
		enable	:BOOL;					(*enables execution*)
		ident	:UDINT;					(*identifier of the memory partition*)
	END_VAR
	VAR_OUTPUT
		status	:UINT;					(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		numBytesFree	:UDINT;			(*free memory*)
		maxBlockSizeFree	:UDINT;		(*largest free memory block*)
	END_VAR
END_FUNCTION_BLOCK
