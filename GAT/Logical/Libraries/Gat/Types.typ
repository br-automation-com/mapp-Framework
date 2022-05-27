
TYPE
	GatIoForcHandInternalType : 	STRUCT 
		AsIOSetForceValue_Int : AsIOSetForceValue;
		AsIODisableForcing_Int : AsIODisableForcing;
		AsIOEnableForcing_Int : AsIOEnableForcing;
		AsIODPStatus_Int : AsIODPStatus;
		IO_OpenIoMap_Int : IO_OpenIoMap;
		IO_CloseIoMap_Int : IO_CloseIoMap;
		AR_OpenArCfg_Int : AR_OpenArCfg;
		AR_CloseArCfg_Int : AR_CloseArCfg;
		ForceValue : ARRAY[0..gatMAX_IDX_IO_MODULES,0..gatMAX_IDX_IO_CHANNELS]OF UDINT;
		ForceEnabled : ARRAY[0..gatMAX_IDX_IO_MODULES,0..gatMAX_IDX_IO_CHANNELS]OF BOOL;
		IoMapIdent : UDINT;
		ArCfgIdent : UDINT;
		IdxModuleNames : UDINT;
		IdxModule : UDINT;
		IdxIoChannel : UDINT;
		IdxModuleCmd : UDINT;
		IdxIoChannelCmd : UDINT;
		NrOfModules : UDINT;
		NrOfIoChannels : UDINT;
		TempChannel : GatIoChannelType;
		CommandState : USINT;
		InitState : USINT;
	END_STRUCT;
	GatIoForceType : 	STRUCT  (*Structure for forcing an IO value*)
		ActualValue : UDINT; (*Actual value on the physical channel*)
		ForceValue : UDINT; (*Force value*)
		SetForceActive : BOOL; (*TRUE: force value is used; FALSE: actual value is used*)
		DpName : STRING[100]; (*IO data point name*)
		RefreshActualValue : BOOL;
	END_STRUCT;
	GatIoMapType : 	STRUCT  (*Structure to read the io map channels*)
		NumberOfChannels : UDINT; (*Number of available IO channels*)
		Ident : UDINT; (*IO map ident*)
	END_STRUCT;
	GatIoChannelType : 	STRUCT  (*Io channel information*)
		Type : IO_Type_enum;
		Inverted : BOOL;
		ChannelName : STRING[80];
		PvName : STRING[80];
		ModulePath : STRING[80];
		TaskClass : USINT;
		IoForcing : GatIoForceType;
	END_STRUCT;
	GatIoModulesType : 	STRUCT 
		ModuleName : STRING[80];
		ModulePath : STRING[80];
		IoChannels : ARRAY[0..gatMAX_IDX_IO_CHANNELS]OF GatIoChannelType;
		NrOfIoChannels : USINT;
	END_STRUCT;
END_TYPE
