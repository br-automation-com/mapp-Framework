
 TYPE
	ArEventLogIdentType : UDINT;
	ArEventLogRecordIDType : UDINT;
	ArEventLogLanguageCodeType : STRING[18]; (*String-type for language ID*)

	ArEventLogTimeStampType : STRUCT
		sec				: UDINT;			(*seconds*)
		nsec			: UDINT;			(*nano seconds*)
	END_STRUCT;
	
	ArEventLogAsyncInternalType : STRUCT
		FBStateCtx		: ArFBStateInternalType;
		AsyFuMaCtx		: ArFBAsyFuMaInternalType;
	END_STRUCT;
	
	ArEventLogInternalType : STRUCT
		FBStateCtx		: ArFBStateInternalType;
	END_STRUCT;
END_TYPE
