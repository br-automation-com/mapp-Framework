
TYPE
	FileHmiInterface_type : 	STRUCT 
		Commands : FileHmiCommands_type;
		Parameters : FileHmiParameters_type;
		Status : FileHmiStatus_type;
	END_STRUCT;
	FileDeleteStep_enum : 
		(
		FILE_DELETE_WAIT := 0,
		FILE_CHECK_FOR_FILTER,
		FILE_SORT_BY_DATE,
		FILE_SELECT_OLDEST_FILES_0,
		FILE_CALC_FOLDER_SIZE,
		FILE_SELECT_OLDEST_FILES_1,
		FILE_DELETE_FILES,
		FILE_CONFIRM_DELETE
		);
	FileFifoType_enum : 
		(
		FILE_FIFO_NUM_OF_FILES := 0,
		FILE_FIFO_SIZE_OF_FOLDER,
		FILE_FIFO_OLDER_THAN
		);
	FileHmiCommands_type : 	STRUCT 
		Delete : BOOL;
		FolderUp : BOOL;
		EnterFolder : BOOL;
		MultiSelect : BOOL;
		CheckFolder : BOOL;
	END_STRUCT;
	FileHmiParaFifo_type : 	STRUCT 
		Enable : BOOL;
		DeviceName : STRING[50];
		FifoType : FileFifoType_enum;
		MaxFileAge : UINT := 365; (*Files older than 1 year will be deleted*)
		MaxFolderSize : REAL := 1.0; (*Max size of files inside the active folder*)
		MaxNumberOfFiles : UINT := 20; (*Max number of files inside active folder*)
	END_STRUCT;
	FileHmiParameters_type : 	STRUCT 
		SelectedIndex : USINT;
		Fifo : FileHmiParaFifo_type;
	END_STRUCT;
	FileType_enum : 
		(
		FOLDER := 0,
		FILE := 1,
		FILE_SELECTED := 2
		);
	FileHmiStatus_type : 	STRUCT 
		FileNames : ARRAY[0..49]OF STRING[80];
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME;
		Type : ARRAY[0..49]OF DINT;
		Size : ARRAY[0..49]OF UDINT;
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		TableConfig : STRING[120];
		IsFolder : BOOL;
		BackButton : USINT;
		DeleteStep : FileDeleteStep_enum;
		AutoDeleteSelected : USINT;
		FolderSize : REAL;
	END_STRUCT;
END_TYPE
