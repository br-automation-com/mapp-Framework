
TYPE
	MpAuditTrailUIStatusEnum : 
		(
		mpAUDIT_UI_STATUS_IDLE, (*Indicates that no process is currently active*)
		mpAUDIT_UI_STATUS_UPDATE, (*Performs an update*)
		mpAUDIT_UI_STATUS_FILTER, (*Displays a window for filtering the results*)
		mpAUDIT_UI_STATUS_EXPORT, (*Exporting data*)
		mpAUDIT_UI_STATUS_ERROR (*Error pending*)
		);
	MpAuditFileTypeEnum : 
		(
		mpAUDIT_FILE_TYPE_TXT := 0, (*Export as text file*)
		mpAUDIT_FILE_TYPE_XML := 1, (*Export as .xml file*)
		mpAUDIT_FILE_TYPE_PDF := 2 (*Export as .pdf file*)
		);
	MpAuditArchiveModeEnum : 
		(
		mpAUDIT_ARCHIVE_DAILY := 0, (*Creates an archive daily*)
		mpAUDIT_ARCHIVE_MO_TO_FR := 1, (*Creates an archive from Monday to Friday*)
		mpAUDIT_ARCHIVE_BATCH := 2 (*Create archives at start of new batch*)
		);
	MpAuditFontTypeEnum : 
		(
		mpAUDIT_FONT_COURIER := 0,
		mpAUDIT_FONT_HELVETICA := 1,
		mpAUDIT_FONT_TIMESROMAN := 2,
		mpAUDIT_FONT_SIMSUN := 3, (*Simplified Chinese*)
		mpAUDIT_FONT_SIMHEI := 4, (*Simplified Chinese*)
		mpAUDIT_FONT_MINGLIU := 5, (*Traditional Chinese*)
		mpAUDIT_FONT_MINCYO := 6, (*Japanese*)
		mpAUDIT_FONT_GOTHIC := 7, (*Japanese*)
		mpAUDIT_FONT_PMINCYO := 8, (*Japanese*)
		mpAUDIT_FONT_PGOTHIC := 9, (*Japanese*)
		mpAUDIT_FONT_DOTUMCHE := 10, (*Korean*)
		mpAUDIT_FONT_DOTUM := 11, (*Korean*)
		mpAUDIT_FONT_BATANGCHE := 12, (*Korean*)
		mpAUDIT_FONT_BATANG := 13 (*Korean*)
		);
	MpAuditPageFormatEnum : 
		(
		mpAUDIT_PAGE_FORMAT_UNDEFINED := 0,
		mpAUDIT_PAGE_FORMAT_LETTER := 1,
		mpAUDIT_PAGE_FORMAT_LEGAL := 2,
		mpAUDIT_PAGE_FORMAT_A3 := 3,
		mpAUDIT_PAGE_FORMAT_A4 := 4,
		mpAUDIT_PAGE_FORMAT_A5 := 5,
		mpAUDIT_PAGE_FORMAT_B4 := 6,
		mpAUDIT_PAGE_FORMAT_B5 := 7
		);
	MpAuditPageDirectionEnum : 
		(
		mpAUDIT_PAGE_DIRECTION_UNDEFINED := 0,
		mpAUDIT_PAGE_DIRECTION_PORTRAIT := 1,
		mpAUDIT_PAGE_DIRECTION_LANDSCAPE := 2
		);
	MpAuditPageMarginEnum : 
		(
		mpAUDIT_PAGE_MARGIN_NORMAL := 0,
		mpAUDIT_PAGE_MARGIN_NARROW := 1,
		mpAUDIT_PAGE_MARGIN_MODERATE := 2,
		mpAUDIT_PAGE_MARGIN_WIDE := 3
		);
	MpAuditQueryModeEnum : 
		(
		mpAUDIT_QUERY_MODE_ALL, (*Read all elements starting from newest entry*)
		mpAUDIT_QUERY_MODE_NEW (*Read only new elements (added since last successfull call of MpAuditQuery) - For the first call it behaves like mpAUDIT_QUERY_MODE_ALL*)
		);
	MpAuditMemoryEnum : 
		(
		mpAUDIT_MEM_TEMP := 0, (*Memory location: DRAM (temporary)*)
		mpAUDIT_MEM_ROM := 1, (*Memory location: USER ROM (memory card)*)
		mpAUDIT_MEM_SRAM := 2, (*Memory location: SRAM (battery-backed)*)
		mpAUDIT_MEM_BUFFERD_ROM := 3 (*Memory location: DRAM (temporary)*)
		);
	MpAuditDisplayTextSourceType : 	STRUCT 
		FormatSource : STRING[100]; (*only for With mpAUDIT_TEXT_SOURCE_VC4 as text source: Defines the index of the text group of the visualization object from which the text is added*)
		Format : STRING[255]; (*With mpAUDIT_TEXT_SOURCE_NONE as text source: This parameter defines how the entry looks.
With mpAUDIT_TEXT_SOURCE_VC4 as text source: Defines the index in the text group from which the text is added*)
	END_STRUCT;
	MpAuditTextSourceType : 	STRUCT 
		Type : MpAuditTextSourceEnum := mpAUDIT_TEXT_SOURCE_NONE; (*Type of text source*)
		Name : STRING[50]; (*only for mpAUDIT_TEXT_SOURCE_VC4 as text source: Name of the VC4 visualization application*)
		OutputFormat : STRING[255] := '[%[TIME=%c]] [%ev] [%op]'; (*With mpAUDIT_TEXT_SOURCE_NONE as text source: This parameter defines how the entry looks.
With mpAUDIT_TEXT_SOURCE_VC4 as text source: Defines the index in the text group from which the text is added*)
		OutputFormatSource : STRING[100]; (*only for With mpAUDIT_TEXT_SOURCE_VC4 as text source: Defines the index of the text group of the visualization object from which the text is added*)
		Display : MpAuditDisplayTextSourceType;
		ErrorMessage : MpAuditErrorMessageType; (*Replacement text that is added if the specified ID is not found*)
	END_STRUCT;
	MpAuditLanguageFontType : 	STRUCT 
		Language : STRING[20];
		Font : MpAuditFontTypeEnum;
	END_STRUCT;
	MpAuditPdfTitleType : 	STRUCT 
		Enable : BOOL := TRUE; (*Enable PDF Title page*)
		Text : STRING[100];
	END_STRUCT;
	MpAuditExportPdfType : 	STRUCT 
		DefaultFont : MpAuditFontTypeEnum;
		Format : MpAuditPageFormatEnum;
		Direction : MpAuditPageDirectionEnum;
		Margins : MpAuditPageMarginEnum;
		OwnerPassword : STRING[50];
		UserPassword : STRING[50];
		AllowPrint : BOOL;
		AllowCopy : BOOL;
		AllowEdit : BOOL;
		Icon : STRING[100];
		Header : STRING[100];
		Title : MpAuditPdfTitleType;
		Fonts : ARRAY[0..4]OF MpAuditLanguageFontType;
	END_STRUCT;
	MpAuditExportType : 	STRUCT 
		FileNamePattern : STRING[50] := 'Audit_%Y_%m_%d_%H_%M'; (*Filename including timestamp. This format can be changed*)
		ArchiveNamePattern : STRING[50] := 'Archive_%Y_%m_%d_%H_%M'; (*Archive name including timestamp. This format can be changed*)
		PassPhrase : STRING[100] := 'DefaultPassword1'; (*Password (or phrase) for the encrypted files / archive. Special characters are not permitted*)
		Encrypt : BOOL := FALSE; (*Encrypted export files*)
		RawData : BOOL := FALSE; (*Attaches raw data to the export file*)
		FileType : MpAuditFileTypeEnum := mpAUDIT_FILE_TYPE_TXT; (*File type for the export file*)
		PDF : MpAuditExportPdfType; (*Settings for PDF-export*)
	END_STRUCT;
	MpAuditExportFilterType : 	STRUCT 
		From : MpAuditTrailUICurrDTFilterType; (*Time from which events are displayed*)
		Until : MpAuditTrailUICurrDTFilterType; (*Time until which events are displayed*)
		Event : MpAuditTrailUIEventFilterType; (*Defines which events are displayed*)
		Operator : MpAuditTrailUIOpFilterType; (*Determines from which user events are displayed*)
		Pattern : MpAuditTrailUIPatternFilterType; (*Event-message filter (pattern matching)*)
		Batch : MpAuditTrailUIBatchFilterType; (*Batch filter*)
	END_STRUCT;
	MpAuditArchiveType : 	STRUCT 
		Enable : BOOL := FALSE; (*Switches the archive function on/off*)
		Mode : MpAuditArchiveModeEnum := mpAUDIT_ARCHIVE_DAILY; (*Defines which weekdays archiving takes place*)
		Time : TIME_OF_DAY; (*Defines which time archiving takes place*)
		MaxSize : UDINT := 100; (*If the number of events reaches this size, an archive is created immediately regardless of the day/time [kB]*)
	END_STRUCT;
	MpAuditTrailConfigType : 	STRUCT 
		Events : ARRAY[0..9]OF UINT := [16#10,16#12,8(0)]; (*Defines which events will be logged . This value are only read when the component is initialized (Disabled -> Enabled).*)
		RecordingSize : UDINT := 200; (*Reserved memory for events [kB]. This value is only read when the component is initialized (Disabled -> Enabled).*)
		SramBufferSize : UDINT := 20; (*Reserved memory for events in SRAM [kB] (this parameter is only used if "RecordMemory" is set to mpAUDIT_MEM_BUFFERED_ROM). This value is only read when the component is initialized (Disabled -> Enabled).*)
		RecordMemory : MpAuditMemoryEnum := mpAUDIT_MEM_TEMP; (*Memory where logging is stored while active. This value is only read when the component is initialized (Disabled -> Enabled).*)
		TextSource : MpAuditTextSourceType; (*Defines the origin of the description text for the various events*)
		Archive : MpAuditArchiveType; (*Specifies when an archive should be created from the current events*)
		Export : MpAuditExportType; (*Specifies how the export should proceed*)
	END_STRUCT;
	MpAuditErrorMessageType : 	STRUCT 
		TextNotFound : STRING[20] := '{Err:Text}'; (*Text that is displayed if the desired index was not found*)
		SpecifierInvalid : STRING[20] := '{Err:Specifier}'; (*Text that is displayed if the desired icon wasn't found or is not available for this event*)
	END_STRUCT;
	MpAuditTextSourceEnum : 
		(
		mpAUDIT_TEXT_SOURCE_NONE := 0, (*Event text from the configuration*)
		mpAUDIT_TEXT_SOURCE_VC4 := 1, (*Event text taken from VC4*)
		mpAUDIT_TEXT_SOURCE_TEXTSYS := 2 (*AR TextSystem with Audit-specific notation*)
		);
	MpAuditTrailUISetupType : 	STRUCT 
		EventListSize : UINT := 20; (*Number of events to be displayed on one page of the list in the HMI application*)
		ScrollWindow : USINT := 0; (*Determines how many entries from the list are displayed in advance when scrolling up and down*)
	END_STRUCT;
	MpAuditTrailUIConnectType : 	STRUCT 
		Status : MpAuditTrailUIStatusEnum; (*Current operation*)
		Output : MpAuditTrailUIOutputType; (*Indicates the filtered events*)
		Filter : MpAuditUIFilterType; (*Allows events to be filtered*)
		Export : BOOL; (*Export audit-data*)
		MessageBox : MpAuditUIMessageBoxType; (*Controls dialog boxes*)
	END_STRUCT;
	MpAuditUIMessageEnum : 
		(
		mpAUDIT_UI_MSG_NONE := 0, (*No dialog box*)
		mpAUDIT_UI_MSG_ERROR := 1 (*Dialog box: Errors*)
		);
	MpAuditUIMessageBoxType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box *)
		Type : MpAuditUIMessageEnum; (*Type of dialog box*)
		ErrorNumber : UINT; (*Current error number to be displayed *)
		StatusID : DINT;
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpAuditInfoType : 	STRUCT 
		Diag : MpAuditDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpAuditQueryInfoType : 	STRUCT 
		AvailableSpace : UDINT; (*Number of available "rows" in the PV configured for the query*)
		RowsRead : UDINT; (*Actual number of rows read by the query*)
		HasMoreRows : BOOL; (*Query is complete (alll data read and copied to PV)*)
		Diag : MpAuditDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpAuditTrailInfoType : 	STRUCT 
		NumberArchives : UINT; (*Number of available archives*)
		Diag : MpAuditDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpAuditDiagType : 	STRUCT 
		StatusID : MpAuditStatusIDType; (*StatusID diagnostic structure *)
	END_STRUCT;
	MpAuditStatusIDType : 	STRUCT 
		ID : MpAuditErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpAuditTrailUIOutputType : 	STRUCT 
		EventID : ARRAY[0..19]OF UINT; (*List of IDs from all events meeting the current filter criteria*)
		EventText : ARRAY[0..19]OF WSTRING[100]; (*List of all events meeting the current filter criteria*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time The size of the page is defined using the "EventListSize" parameter in the MpAuditTrailUISetupType structure*)
		StepUp : BOOL; (*Selects the previous entry in the list*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time The size of the page is defined using the "EventListSize" parameter in the MpAuditTrailUISetupType structure*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed. Used for the starting value of "Range" for a scaled element in the HMI application*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed. Used for the ending value of "Range" for a scaled element in the HMI application*)
	END_STRUCT;
	MpAuditTrailUICurrDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		DateTime : DATE_AND_TIME; (*Time from/to which filtering should take place*)
	END_STRUCT;
	MpAuditTrailUISetDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		Year : UINT; (*Year from/to which filtering should take place*)
		Month : USINT; (*Month from/to which filtering should take place*)
		Day : USINT; (*Day from/to which filtering should take place*)
		Hour : USINT; (*Hour from/to which filtering should take place*)
		Minute : USINT; (*Minute from/to which filtering should take place*)
	END_STRUCT;
	MpAuditTrailUIEventFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		Exclude : BOOL; (*Either only this event type (FALSE) or all but this event type (TRUE)*)
		Event : ARRAY[0..4]OF UDINT; (*Events that should be filtered*)
	END_STRUCT;
	MpAuditTrailUIOpFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		Exclude : BOOL; (*Only this user (FALSE) / All other users (TRUE)*)
		Name : WSTRING[50]; (*Operator name*)
	END_STRUCT;
	MpAuditTrailUIPatternFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		Exclude : BOOL; (*Select events matching the pattern (FALSE) or all other events (TRUE)*)
		Compare : WSTRING[50]; (*String Pattern containing wildcards (* and ?) that is applied on the event-message*)
	END_STRUCT;
	MpAuditTrailUIBatchFilterType : 	STRUCT 
		Enable : BOOL; (*Enables the filter*)
		Name : WSTRING[50]; (*Name (identifier) of batch to be  included in output*)
	END_STRUCT;
	MpAuditTrailUIFilterDialogType : 	STRUCT 
		LayerStatus : UINT; (*Status data point for the default layer of the visualization page where the filter is configured*)
		From : MpAuditTrailUISetDTFilterType; (*Time from which events are displayed*)
		Until : MpAuditTrailUISetDTFilterType; (*Time until which events are displayed*)
		Event : MpAuditTrailUIEventFilterType; (*Defines which events are displayed*)
		Operator : MpAuditTrailUIOpFilterType; (*Determines from which user events are displayed*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
		Pattern : MpAuditTrailUIPatternFilterType; (*Event-message filter (pattern matching)*)
		Batch : MpAuditTrailUIBatchFilterType; (*Batch filter*)
	END_STRUCT;
	MpAuditTrailUICurrentFilterType : 	STRUCT 
		From : MpAuditTrailUICurrDTFilterType; (*Time from which events are displayed*)
		Until : MpAuditTrailUICurrDTFilterType; (*Time until which events are displayed*)
		Event : MpAuditTrailUIEventFilterType; (*Defines which events are displayed*)
		Operator : MpAuditTrailUIOpFilterType; (*Determines from which user events are displayed*)
		Pattern : MpAuditTrailUIPatternFilterType; (*Event-message filter (pattern matching)*)
		Batch : MpAuditTrailUIBatchFilterType; (*Batch filter*)
	END_STRUCT;
	MpAuditUIFilterType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Dialog : MpAuditTrailUIFilterDialogType; (*Window for selecting an event filter*)
		Current : MpAuditTrailUICurrentFilterType; (*Displays the current filter*)
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page on which the filter options are available*)
	END_STRUCT;
	MpAuditVC4EventInternalType : 	STRUCT 
		hEventSys : UDINT;
	END_STRUCT;
	MpAuditMonitorInternalType : 	STRUCT 
		Handle : UDINT;
	END_STRUCT;
END_TYPE
