
TYPE
	MpDataRecorderHeaderType : 	STRUCT  (*Data record header type*)
		Name : STRING[100]; (*The name of the data recording*)
		Description : STRING[255]; (*Optional user comment describing the data recording*)
	END_STRUCT;
	MpDataInfoType : 	STRUCT  (*MpDataRecorder current file information*)
		Diag : MpDataDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpDataRecorderInfoType : 	STRUCT  (*MpDataRecorder current file information*)
		FileCount : UINT; (*Number of created files*)
		CurrentFileName : STRING[50]; (*Name of the current file*)
		CurrentFileSize : UDINT; (*Size of the current file [kB]*)
		CurrentBufferSize : UINT; (*Amount of internal memory currently being used [kB]*)
		RegisteredPVCount : UINT; (*Number of currently registered PVs*)
		TotalSamples : UDINT; (*Number of entries of each registered PV since the start of recording*)
		ValueOutsideLimits : BOOL; (*One of the registered PVs violated limits in the current cycle. Only applicable if limits are configured and recording is active*)
		Diag : MpDataDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpDataDiagType : 	STRUCT  (*Component diagnostics type*)
		StatusID : MpDataStatusIDType; (*StatusID diagnostics structure*)
	END_STRUCT;
	MpDataStatusIDType : 	STRUCT  (*Component diagnostics status ID type*)
		ID : MpDataErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpDataRecordModeEnum : 
		( (*Recording modes enumeration*)
		mpDATA_RECORD_MODE_TIME := 0, (*New data is recorded on a time basis*)
		mpDATA_RECORD_MODE_TRIGGER := 1, (*New data is recorded after a trigger*)
		mpDATA_RECORD_MODE_VALUE := 2, (*New data from all PVs is recorded after the value of any registered PV is changed*)
		mpDATA_RECORD_MODE_TIME_TRIGGER := 3, (*New data is recorded on a time basis and after a trigger (whichever comes first)*)
		mpDATA_RECORD_MODE_TIME_VALUE := 4, (*New data is recorded on a time basis and in case PV value changed (whichever comes first)*)
		mpDATA_RECORD_MODE_TRIGGER_VALUE := 5, (*New data is recorded after a trigger or in case PV value changed (whichever comes first)*)
		mpDATA_RECORD_MODE_TIME_TRIG_VAL := 6 (*New data is recorded on time basis, after a trigger or in case PV value changed (whichever comes first)*)
		);
	MpDataTableUISetupType : 	STRUCT 
		ValueListSize : UINT := 20; (*Ammount of values shown at once*)
		ValueListScrollWindow : USINT := 1; (*Scroll window for values*)
		PVListSize : UINT := 10; (*Ammount of variables shown at once*)
		PVListScrollWindow : USINT := 1; (*Scroll window for variables*)
	END_STRUCT;
	MpDataTableUIConnectType : 	STRUCT 
		Table : MpDataTableType; (*Table view*)
		Status : MpDataUIStatusEnum; (*Current status of MpDataTableUI*)
		AutoRefresh : BOOL := TRUE; (*Setting: If TRUE, values in Items array will automatically be refreshed when there are newer values in MpDataRecorder internal buffer*)
		Refresh : BOOL := FALSE; (*Command: Trigger refresh now*)
		Language : STRING[20] := ''; (*Language and unit system setting*)
	END_STRUCT;
	MpDataTableUIPVItemType : 	STRUCT 
		Name : STRING[100]; (*Name of the variable*)
		Description : STRING[50]; (*Description of the variable*)
		DescriptionIndex : UINT; (*Index for a description within a text group*)
		Unit : STRING[20]; (*Unit of the variable*)
		Value : ARRAY[0..19]OF LREAL; (*Value of the variable*)
		LimitMonitor : ARRAY[0..19]OF MpDataPVItemLimitEnum; (*Shows whether value is within limits. Only applicable if limits are configured*)
	END_STRUCT;
	MpDataPVItemLimitEnum : 
		( (*Current state of value limit violation*)
		mpDATA_NO_LIMITS_CONFIGURED := 0, (*PV was registered without information about limits or limits for this datatype are not applicable*)
		mpDATA_WITHIN_LIMITS := 1, (*Value is within limits*)
		mpDATA_UPPER_LIMIT_VIOLATED := 2, (*Upper limit is violated*)
		mpDATA_LOWER_LIMIT_VIOLATED := 3 (*Lower limit is violated*)
		);
	MpDataUIStatusEnum : 
		( (*MpDataUI current status enumeration*)
		mpDATA_UI_STATUS_IDLE := 0, (*Status: Idle*)
		mpDATA_UI_STATUS_REFRESH := 1, (*Status: Refreshing*)
		mpDATA_UI_STATUS_ERROR := 99 (*Status: In Error*)
		);
	MpDataTableType : 	STRUCT 
		PV : ARRAY[0..9]OF MpDataTableUIPVItemType;
		Index : ARRAY[0..19]OF UDINT; (*Sample index of variable*)
		TimeStamp : ARRAY[0..19]OF STRING[50]; (*Timestamp of recording*)
		StepUp : BOOL; (*Command: Line up (scroll up)*)
		PageUp : BOOL; (*Command: Page up (scroll up)*)
		StepDown : BOOL; (*Command: Line down (scroll down)*)
		PageDown : BOOL; (*Command: Page down (scroll down)*)
		StepLeft : BOOL; (*Command: Column left (scroll left)*)
		PageLeft : BOOL; (*Command: Page left (scroll left)*)
		StepRight : BOOL; (*Command: Column right (scroll right)*)
		PageRight : BOOL; (*Command: Page right (scroll right)*)
		RangeStartRows : REAL; (*Displayed range for rows: Start %*)
		RangeEndRows : REAL; (*Displayed range for rows: End %*)
		RangeStartColumns : REAL; (*Displayed range for columns: Start %*)
		RangeEndColumns : REAL; (*Displayed range for columns: End %*)
	END_STRUCT;
END_TYPE

(* MpDataStatisticsUI datatypes *)

TYPE
	MpDataStatisticsUISetupType : 	STRUCT 
		PVListSize : UINT := 10; (*Ammount of variables shown at once*)
		PVListScrollWindow : USINT := 1; (*Scroll window for variables*)
	END_STRUCT;
	MpDataStatisticsUIConnectType : 	STRUCT 
		Table : MpDataStatisticsUITableType; (*Statistical data of registered PVs*)
		Status : MpDataUIStatusEnum; (*Current status of MpDataTableUI*)
		Language : STRING[20] := ''; (*Language and unit system setting*)
	END_STRUCT;
	MpDataStatisticsUITableType : 	STRUCT 
		Data : ARRAY[0..19]OF MpDataStatisticsUIPVItemType; (*Statistics table view*)
		StepLeft : BOOL; (*Command: Column left (scroll left)*)
		PageLeft : BOOL; (*Command: Page left (scroll left)*)
		StepRight : BOOL; (*Command: Column right (scroll right)*)
		PageRight : BOOL; (*Command: Page right (scroll right)*)
		RangeStart : REAL; (*Displayed range for columns: Start %*)
		RangeEnd : REAL; (*Displayed range for columns: End %*)
	END_STRUCT;
	MpDataStatisticsUIPVItemType : 	STRUCT 
		Name : STRING[100]; (*Name of the variable*)
		Description : STRING[50]; (*Description of the variable*)
		Unit : STRING[20]; (*Unit of the variable*)
		Minimum : LREAL; (*Minimum logged value of variable since start of recording*)
		Maximum : LREAL; (*Maximum logged value of variable since start of recording*)
		Mean : LREAL; (*Mean value of variable since start of recording*)
		Range : LREAL; (*Range of values since start of recording*)
		StandardDeviation : LREAL; (*Standard deviation of variable since start of recording*)
		DescriptionIndex : UINT; (*Index for a description within a text group*)
	END_STRUCT;
END_TYPE

(* MpDataConfiguration datatypes *)

TYPE
	MpDataFontTypeEnum : 
		(
		mpDATA_FONT_COURIER := 0,
		mpDATA_FONT_HELVETICA := 1,
		mpDATA_FONT_TIMESROMAN := 2,
		mpDATA_FONT_SIMSUN := 3, (*Simplified Chinese*)
		mpDATA_FONT_SIMHEI := 4, (*Simplified Chinese*)
		mpDATA_FONT_MINGLIU := 5, (*Traditional Chinese*)
		mpDATA_FONT_MINCYO := 6, (*Japanese*)
		mpDATA_FONT_GOTHIC := 7, (*Japanese*)
		mpDATA_FONT_PMINCYO := 8, (*Japanese*)
		mpDATA_FONT_PGOTHIC := 9, (*Japanese*)
		mpDATA_FONT_DOTUMCHE := 10, (*Korean*)
		mpDATA_FONT_DOTUM := 11, (*Korean*)
		mpDATA_FONT_BATANGCHE := 11, (*Korean*)
		mpDATA_FONT_BATANG := 12 (*Korean*)
		);
	MpDataPageFormatEnum : 
		(
		mpDATA_PAGE_FORMAT_UNDEFINED := 0,
		mpDATA_PAGE_FORMAT_LETTER := 1,
		mpDATA_PAGE_FORMAT_LEGAL := 2,
		mpDATA_PAGE_FORMAT_A3 := 3,
		mpDATA_PAGE_FORMAT_A4 := 4,
		mpDATA_PAGE_FORMAT_A5 := 5,
		mpDATA_PAGE_FORMAT_B4 := 6,
		mpDATA_PAGE_FORMAT_B5 := 7
		);
	MpDataPageDirectionEnum : 
		(
		mpDATA_PAGE_DIRECTION_UNDEFINED := 0,
		mpDATA_PAGE_DIRECTION_PORTRAIT := 1,
		mpDATA_PAGE_DIRECTION_LANDSCAPE := 2
		);
	MpDataPageMarginEnum : 
		(
		mpDATA_PAGE_MARGIN_NORMAL := 0,
		mpDATA_PAGE_MARGIN_NARROW := 1,
		mpDATA_PAGE_MARGIN_MODERATE := 2,
		mpDATA_PAGE_MARGIN_WIDE := 3
		);
	MpDataConfigHeaderTypeEnum : 
		(
		mpDATA_HEADER_STANDARD := 0,
		mpDATA_HEADER_USER_DEFINED := 1
		);
	MpDataConfigHeaderRowType : 	STRUCT 
		Text : STRING[100];
		HorizontalRule : BOOL;
	END_STRUCT;
	MpDataConfigHeaderType : 	STRUCT 
		Type : MpDataConfigHeaderTypeEnum := mpDATA_HEADER_STANDARD;
		Title : STRING[100];
		Icon : STRING[100];
		Row : ARRAY[0..19]OF MpDataConfigHeaderRowType;
	END_STRUCT;
	MpDataFileTypeEnum : 
		(
		mpDATA_FILE_TYPE_CSV,
		mpDATA_FILE_TYPE_PDF
		);
	MpDataFormatType : 	STRUCT 
		FileType : MpDataFileTypeEnum := mpDATA_FILE_TYPE_CSV;
		Font : MpDataFontTypeEnum := mpDATA_FONT_COURIER;
		Language : STRING[20];
		PageFormat : MpDataPageFormatEnum := mpDATA_PAGE_FORMAT_A4;
		PageDirection : MpDataPageDirectionEnum := mpDATA_PAGE_DIRECTION_PORTRAIT;
		PageMargin : MpDataPageMarginEnum := mpDATA_PAGE_MARGIN_NORMAL;
		OwnerPassword : STRING[50];
		UserPassword : STRING[50];
		AllowPrint : BOOL;
		AllowCopy : BOOL;
		AllowEdit : BOOL;
		Header : MpDataConfigHeaderType;
	END_STRUCT;
	MpDataUnitDefinitionTypeEnum : 
		(
		mpDATA_UNIT_DEF_TYPE_REGISTR := 0, (*Units are based on the parameters of registration function blocks*)
		mpDATA_UNIT_DEF_TYPE_MEASSYS := 1 (*Units are based on the Automation Studio unit system*)
		);
	MpDataUnitDisplayTypeEnum : 
		(
		mpDATA_UNIT_DISPLAY_NONE := 0, (*No units will be displayed*)
		mpDATA_UNIT_DISPLAY_ABBREV := 1, (*Abbreviated unit text will be displayed as defined in unit system*)
		mpDATA_UNIT_DISPLAY_FULL := 2 (*Full unit text will be displayed as defined in unit system*)
		);
	MpDataUnitDefinitionType : 	STRUCT  (*Unit definition configuration*)
		Type : MpDataUnitDefinitionTypeEnum := mpDATA_UNIT_DEF_TYPE_REGISTR; (*Unit definition type*)
		UnitDisplay : MpDataUnitDisplayTypeEnum := mpDATA_UNIT_DISPLAY_ABBREV; (*Unit display definition*)
		MeasurementSystem : STRING[20]; (*Measurement system, e.g. Metric, Imperial, Custom1, ...*)
	END_STRUCT;
	MpDataRecorderConfigType : 	STRUCT  (*MpDataRecorder configuration*)
		MaxNumberOfFiles : UINT := 1; (*This value defines the number of .csv files that are generated after a "Record" command. The "RecordDone" output is set to TRUE when the files have been created*)
		MaxFileSize : UDINT := 1000; (*Defines the size of a file [kB]*)
		DecimalDigits : UINT := 2; (*Specifies how many decimal positions are saved*)
		SaveInterval : TIME := T#10s; (*Specifies the time interval used to transfer data from internal memory to the file (min. 2 s)[s]*)
		BufferSize : UINT := 100; (*Defines the size of internal memory [kB]*)
		PowerFailSafe : BOOL := TRUE; (*Specifies whether the data should survive a power failure (internal memory in DRAM or SRAM (UserRAM))*)
		FileNamePattern : STRING[50] := 'Datalog_%Y_%m_%d_%H_%M_%S.csv'; (*Filename including timestamp. This format can be changed*)
		TimeStampPattern : STRING[50] := '%Y %m %d %H:%M:%S:%L'; (*Timestamp for the file. This format can be changed*)
		ColumnSeparator : STRING[1] := ';'; (*Delimiter used to split up PVs in the .csv file*)
		DecimalMark : STRING[1] := ','; (*Character to be used for the decimal separator*)
		AutoSave : BOOL := TRUE; (*Switches the automatic saving function on/off. When switched off, data is continuously logged to an internal buffer and it can be exported with the SnapShot pin*)
		OverwriteOldestFile : BOOL := FALSE; (*When MaxNumberOfFiles is reached, oldest files will be overwritten without stopping the recording*)
		SaveInitialValues : BOOL := FALSE; (*Parameter allows to log a sample of registered PVs immediately upon the Recorrd pin. Afterwards values are logged based on RecordMode*)
		Format : MpDataFormatType;
		UnitDefinition : MpDataUnitDefinitionType;
	END_STRUCT;
END_TYPE
