
TYPE
	FileHmiInterface_type : 	STRUCT 
		Commands : FileHmiCommands_type;
		Parameters : FileHmiParameters_type;
		Status : FileHmiStatus_type;
	END_STRUCT;
	FileCopyStep_enum : 
		(
		FILE_COPY_WAIT := 0,
		FILE_COPY_TO_USB,
		FILE_COPY_FROM_USB,
		FILE_COPY_BUSY
		);
	FileHmiCommands_type : 	STRUCT 
		Delete : BOOL;
		FolderUp : BOOL;
		EnterFolder : BOOL;
	END_STRUCT;
	FileHmiParameters_type : 	STRUCT 
		SelectedIndex : USINT;
	END_STRUCT;
	FileHmiStatus_type : 	STRUCT 
		FileNames : ARRAY[0..49]OF STRING[80];
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME;
		Size : ARRAY[0..49]OF UDINT;
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		TableConfig : STRING[120];
		IsFolder : BOOL;
		BackButton : USINT;
	END_STRUCT;
END_TYPE
