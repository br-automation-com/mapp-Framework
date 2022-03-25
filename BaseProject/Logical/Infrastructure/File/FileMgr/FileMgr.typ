
TYPE
	FileHmiInterfaceType : 	STRUCT 
		Commands : FileHmiCommandsType;
		Parameters : FileHmiParametersType;
		Status : FileHmiStatusType;
	END_STRUCT;
	FileDeleteStepEnum : 
		(
		FILE_DELETE_WAIT := 0,
		FILE_SCAN_FOLDER_WAIT,
		FILE_SELECT_DEVICE,
		FILE_CHECK_FOR_FILTER,
		FILE_SORT_BY_DATE,
		FILE_SORT_BY_DATE_WAIT,
		FILE_SELECT_OLDEST_FILES_0,
		FILE_CALC_FOLDER_SIZE,
		FILE_SELECT_OLDEST_FILES_1,
		FILE_DELETE_FILES,
		FILE_CONFIRM_DELETE,
		FILE_RESET_SORT_BY,
		FILE_RESET_SORT_BY_WAIT
		);
	FileFifoTypeEnum : 
		(
		FILE_FIFO_NUM_OF_FILES := 0,
		FILE_FIFO_SIZE_OF_FOLDER,
		FILE_FIFO_OLDER_THAN
		);
	FileHmiCommandsType : 	STRUCT 
		Delete : BOOL;
		FolderUp : BOOL;
		EnterFolder : BOOL;
		MultiSelect : BOOL;
		CheckFolder : BOOL;
	END_STRUCT;
	FileHmiParaFifoType : 	STRUCT 
		Enable : BOOL;
		DeviceName : STRING[50];
		FifoType : FileFifoTypeEnum;
		ScanInterval : DINT := 60; (*[minutes]*)
		MaxFileAge : UINT := 365; (*[days] Files older than 1 year will be deleted*)
		MaxFolderSize : REAL := 1000; (*[kB] - Max size of files inside the active folder*)
		MaxNumberOfFiles : UINT := 20; (*Max number of files inside active folder*)
	END_STRUCT;
	FileHmiParametersType : 	STRUCT 
		SelectedIndex : USINT;
		OldSortOrder : MpFileManagerUISortOrderEnum;
		Fifo : FileHmiParaFifoType;
	END_STRUCT;
	FileTypeEnum : 
		(
		FOLDER := 0,
		FILE := 1,
		FILE_SELECTED := 2
		);
	FileHmiStatusType : 	STRUCT 
		FileNames : ARRAY[0..49]OF STRING[80];
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME;
		Type : ARRAY[0..49]OF DINT;
		Size : ARRAY[0..49]OF UDINT;
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		TableConfig : ARRAY[0..1]OF STRING[120];
		IsFolder : BOOL;
		BackButton : USINT;
		DeleteStep : FileDeleteStepEnum;
		AutoDeleteSelected : USINT;
		FolderSize : REAL;
		CurrentPage : STRING[80];
	END_STRUCT;
END_TYPE
