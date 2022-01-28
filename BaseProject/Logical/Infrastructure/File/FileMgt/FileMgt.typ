
TYPE
	FileIntern_type : 	STRUCT 
		LastLoadedFile : STRING[255];
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		TableConfig : STRING[120];
		CopyStep : FileCopyStep_enum;
	END_STRUCT;
	FileHmiInterface_type : 	STRUCT 
		Commands : FileCommands_type;
		Intern : FileIntern_type;
	END_STRUCT;
	FileCopyStep_enum : 
		(
		FILE_COPY_WAIT := 0,
		FILE_COPY_TO_USB,
		FILE_COPY_FROM_USB,
		FILE_COPY_BUSY
		);
	FileCommands_type : 	STRUCT 
		StoreFixData : BOOL;
		FactoryResetFixData : BOOL;
		SaveCurrentFile : BOOL;
		ImportFromUSB : BOOL;
		ExportToUSB : BOOL;
	END_STRUCT;
END_TYPE
