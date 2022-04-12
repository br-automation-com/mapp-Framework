
TYPE
	IO_Type_enum : 
		(
		IO_DIG_OUTPUT := 0,
		IO_DIG_INPUT := 1,
		IO_ANA_OUTPUT := 2,
		IO_ANA_INPUT := 3,
		IO_USINT_OUTPUT := 4,
		IO_USINT_INPUT := 5,
		IO_UDINT_OUTPUT := 6,
		IO_UDINT_INPUT := 7,
		IO_PWM_OUTPUT := 8,
		IO_TEMP_INPUT := 9,
		IO_RESISTOR_INPUT := 10,
		IO_TYPE_OTHER := 11
		);
	IO_AddModuleIoCh_Internal_struct : 	STRUCT 
		FileRead_0 : FileRead;
		FileClose_0 : FileClose;
		FileOpen_0 : FileOpen;
		State : USINT;
		FileName : STRING[30];
		FileLen : UDINT;
		NewIoData : UDINT;
	END_STRUCT;
	IO_CloseIoMap_Internal_struct : 	STRUCT 
		DatObjCreate_0 : DatObjCreate;
		DatObjDelete_0 : DatObjDelete;
		DatObjInfo_0 : DatObjInfo;
		AsIOMMRemove_0 : AsIOMMRemove;
		AsIOMMCreate_0 : AsIOMMCreate;
		State : UDINT;
	END_STRUCT;
	IO_OpenIoMap_Internal_struct : 	STRUCT 
		DatObjRead_0 : DatObjRead;
		DatObjDelete_0 : DatObjDelete;
		DatObjInfo_0 : DatObjInfo;
		AsIOMMCopy_0 : AsIOMMCopy;
		State : UDINT;
	END_STRUCT;
END_TYPE
