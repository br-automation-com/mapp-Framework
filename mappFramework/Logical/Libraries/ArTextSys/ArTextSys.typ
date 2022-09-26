
TYPE
	ArTextSysLanguageCodeType : STRING[18]; (*String-type for language ID*)

	(*Enumeration for ArTextSysGetText-FUBs*)
	ArTextSysSearchModeEnum :
	(
		arTEXTSYS_SEARCH_FALLBACK_SUBST, (*with fallback-languages or substitute*)
		arTEXTSYS_SEARCH_LANGUAGE_ONLY, (*search for matching language only*)
		arTEXTSYS_SEARCH_FALLBACK	(*with fallback-searches, no substitute*)
	);

	(*argument-properties for formatter*)
	ArTextSysFormatArgumentType : STRUCT
		Datatype		: UINT;  (*type of argument; eg. IEC_DATATYPE_UDINT*)
		Data			: UDINT; (*pointer to Argument*)
		UnitNamespace	: UDINT; (*namespace of UnitID; default OPC-UA recommended*)
		UnitID			: UDINT;
	END_STRUCT;

	(*Internal type(s) for FUB-processing*)
	ArTextSysExec1InternalType : STRUCT
		i_serno : UINT;
		i_state : UINT;
		Result	: DINT;
	END_STRUCT;

	ArTextSysIter1InternalType : STRUCT
		i_base	: ArTextSysExec1InternalType;
		m_iter	: DINT; (*internal iterator; eg. ArTextSysGetNamespaceLanguages*)
	END_STRUCT;
END_TYPE
