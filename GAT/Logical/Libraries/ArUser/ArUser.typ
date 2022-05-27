                                                                      
 TYPE
	ArUserIdentType : STRUCT
		Handle			: UDINT;
		MagicNumber		: UDINT;
	END_STRUCT;
	
	ArUserAsyncInternalType : STRUCT
		FBStateCtx		: ArFBStateInternalType;
		AsyFuMaCtx		: ArFBAsyFuMaInternalType;
	END_STRUCT;

	ArUserInternalType : STRUCT
		FBStateCtx		: ArFBStateInternalType;
	END_STRUCT;
	
	
END_TYPE
