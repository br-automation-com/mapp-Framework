
TYPE
	AR_ModuleParameterCfg_struct : 	STRUCT 
		ParameterName : STRING[30];
		ValueList : ARRAY[0..24]OF STRING[60];
	END_STRUCT;
	AR_AvailableModules_Int_struct : 	STRUCT 
		DirInfo_0 : DirInfo;
		DirRead_0 : DirRead;
		State : USINT;
		NumberOfFiles : UDINT;
		FileInfo : fiDIR_READ_DATA;
		FileIndex : UDINT;
		ActModuleIndex : USINT;
	END_STRUCT;
	AR_GetModuleParInfo_Int_struct : 	STRUCT 
		FileRead_0 : FileRead;
		FileClose_0 : FileClose;
		FileOpen_0 : FileOpen;
		State : USINT;
		FileName : STRING[30];
		FileLen : UDINT;
		ModuleParamData : UDINT;
	END_STRUCT;
	AR_AddModule_Internal_struct : 	STRUCT 
		FileRead_0 : FileRead;
		FileClose_0 : FileClose;
		FileOpen_0 : FileOpen;
		State : USINT;
		FileName : STRING[30];
		FileLen : UDINT;
		NewModuleData : UDINT;
	END_STRUCT;
	AR_OpenArCfg_Internal_struct : 	STRUCT 
		DatObjRead_0 : DatObjRead;
		DatObjDelete_0 : DatObjDelete;
		DatObjInfo_0 : DatObjInfo;
		AsIOMMCopy_0 : AsIOMMCopy;
		State : UDINT;
	END_STRUCT;
	AR_CloseArCfg_Internal_struct : 	STRUCT 
		DatObjCreate_0 : DatObjCreate;
		DatObjDelete_0 : DatObjDelete;
		DatObjInfo_0 : DatObjInfo;
		AsIOMMRemove_0 : AsIOMMRemove;
		AsIOMMCreate_0 : AsIOMMCreate;
		State : UDINT;
	END_STRUCT;
END_TYPE
