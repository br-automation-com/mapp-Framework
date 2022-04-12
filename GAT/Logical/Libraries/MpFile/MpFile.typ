
TYPE
	MpFileManagerUIItemType : 	STRUCT 
		Name : STRING[255]; (*Filename / Folder name*)
		Size : UDINT; (*File size [bytes]*)
		LastModified : DATE_AND_TIME; (*Date when this file/folder was last modified*)
		ItemType : MpFileManagerUIItemTypeEnum; (*File type (.csv, .jpg, etc.)*)
		IsSelected : BOOL; (*Indicates that a file/folder is selected*)
		IsFolder : BOOL; (*Indicates that the element is a folder*)
	END_STRUCT;
	MpFileManagerUIItemTypeEnum : 
		(
		mpFILE_ITEM_TYPE_NONE := 0, (*No type defined*)
		mpFILE_ITEM_TYPE_FOLDER := 1, (*Indicates that the element is a folder*)
		mpFILE_ITEM_TYPE_FILE := 2, (*Indicates that the element is a file*)
		mpFILE_ITEM_TYPE_TXT := 3, (*Indicates that the element is a text file*)
		mpFILE_ITEM_TYPE_HTML := 4, (*Indicates that the element is an HTML file*)
		mpFILE_ITEM_TYPE_DOC := 5, (*Indicates that the element is a Word file (.doc) *)
		mpFILE_ITEM_TYPE_XLS := 6, (*Indicates that the element is an Excel file (.xls)*)
		mpFILE_ITEM_TYPE_XML := 7, (*Indicates that the element is an XML file (.xml)*)
		mpFILE_ITEM_TYPE_CSV := 8, (*Indicates that the element is an CSV file (.csv)*)
		mpFILE_ITEM_TYPE_JPG := 9, (*Indicates that the element is an image file (.jpg)*)
		mpFILE_ITEM_TYPE_BMP := 10, (*Indicates that the element is an image file (.bmp)*)
		mpFILE_ITEM_TYPE_USER1 := 89, (*Indicates that the element is an user predefined type 1*)
		mpFILE_ITEM_TYPE_USER2 := 90, (*Indicates that the element is an user predefined type 2*)
		mpFILE_ITEM_TYPE_USER3 := 91, (*Indicates that the element is an user predefined type 3*)
		mpFILE_ITEM_TYPE_USER4 := 92, (*Indicates that the element is an user predefined type 4*)
		mpFILE_ITEM_TYPE_USER5 := 93, (*Indicates that the element is an user predefined type 5*)
		mpFILE_ITEM_TYPE_USER6 := 94, (*Indicates that the element is an user predefined type 6*)
		mpFILE_ITEM_TYPE_USER7 := 95, (*Indicates that the element is an user predefined type 7*)
		mpFILE_ITEM_TYPE_USER8 := 96, (*Indicates that the element is an user predefined type 8*)
		mpFILE_ITEM_TYPE_USER9 := 97, (*Indicates that the element is an user predefined type 9*)
		mpFILE_ITEM_TYPE_USER10 := 98, (*Indicates that the element is an user predefined type 10*)
		mpFILE_ITEM_TYPE_UNKNOWN := 99 (*Indicates that the file type is unknown*)
		);
	MpFileManagerUISortOrderEnum : 
		(
		mpFILE_SORT_BY_NAME_ASC := 0, (*Sorts in ascending (alphabetic) order*)
		mpFILE_SORT_BY_NAME_DESC := 1, (*Sorts in descending (alphabetic) order*)
		mpFILE_SORT_BY_SIZE_ASC := 2, (*Sorts in ascending order by file size*)
		mpFILE_SORT_BY_SIZE_DES := 3, (*Sorts in descending order by file size*)
		mpFILE_SORT_BY_MOD_TIME_ASC := 4, (*Sorts in ascending order by date last modified*)
		mpFILE_SORT_BY_MOD_TIME_DESC := 5 (*Sorts in descending order by date last modified*)
		);
	MpFileManagerUIMessageEnum : 
		(
		mpFILE_MSG_OK := 0, (*Dialog box for requesting confirmation of input*)
		mpFILE_MSG_CONFIRM_DELETE := 1, (*Dialog box for requesting confirmation of deletion*)
		mpFILE_MSG_CONFIRM_OVERWRITE := 2, (*Dialog box for requesting confirmation of overwriting*)
		mpFILE_MSG_BUSY := 3 (*Dialog box for requesting confirmation of busy UI*)
		);
	MpFileDiagType : 	STRUCT 
		StatusID : MpFileStatusIDType; (*StatusID diagnostic structure*)
	END_STRUCT;
	MpFileStatusIDType : 	STRUCT 
		ID : MpFileErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system.*)
	END_STRUCT;
	MpFileInfoType : 	STRUCT 
		Diag : MpFileDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpFileManagerUIStatusEnum : 
		(
		mpFILE_UI_STATUS_IDLE := 0, (*Indicates that no process is currently active*)
		mpFILE_UI_STATUS_REFRESH := 1, (*Updating elements*)
		mpFILE_UI_STATUS_CHANGE_PAGE := 2, (*Page change active*)
		mpFILE_UI_STATUS_CHANGE_DIR := 3, (*Folder change active*)
		mpFILE_UI_STATUS_CHANGE_DEVICE := 4, (*File Device Change active*)
		mpFILE_UI_STATUS_CREATE := 5, (*Creating a file/folder active*)
		mpFILE_UI_STATUS_RENAME := 6, (*Renaming a file/folder active*)
		mpFILE_UI_STATUS_DELETE := 7, (*Deleting a file/folder active*)
		mpFILE_UI_STATUS_COPY := 8, (*Copying a file/folder active*)
		mpFILE_UI_STATUS_CUT := 9, (*Cutting a file/folder active*)
		mpFILE_UI_STATUS_PASTE := 10, (*Pasting a file/folder active*)
		mpFILE_UI_STATUS_SORT := 11, (*Sorting files/folders in specified sort order*)
		mpFILE_UI_STATUS_ERROR := 99 (*The last operation generated an error*)
		);
	MpFileManagerUISetupType : 	STRUCT 
		FileListSize : UINT := 10; (*Number of files to be displayed on one page of the list in the HMI application*)
		FileListScrollWindow : USINT := 1; (*Determines how many entries from the list are displayed in advance when scrolling up and down*)
	END_STRUCT;
	MpFileManagerUIConnectType : 	STRUCT 
		Status : MpFileManagerUIStatusEnum; (*Current operation*)
		DeviceList : MpFileManagerUIDeviceListType; (*List of data storage media (file devices) accessible by the file manager*)
		File : MpFileManagerUIFileType; (*Contains the file list as well as additional information about files,folders and possible commands*)
		MessageBox : MpFileManagerUIMessageBoxType; (*Controls dialog boxes*)
		DefaultLayerStatus : UINT; (*Status DP for the default layer of the visu page where the file manager is being displayed*)
	END_STRUCT;
	MpFileManagerUIMessageBoxType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		Type : MpFileManagerUIMessageEnum; (*Type of dialog box*)
		ErrorNumber : UINT; (*Current error number to be displayed*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpFileManagerUIPathInfoType : 	STRUCT 
		CurrentDir : STRING[255]; (*Current folder name*)
		FileCount : UDINT; (*Number of files in the current folder*)
		FolderCount : UDINT; (*Number of subfolders in the current folder*)
	END_STRUCT;
	MpFileManagerUIFileType : 	STRUCT 
		List : MpFileManagerUIFileListType; (*List of all folders and files under the current path, as well as the navigation of the list*)
		Filter : STRING[255]; (*Filter used to sort the files*) (* *) (*#CMD#OPT#;*)
		SortOrder : MpFileManagerUISortOrderEnum; (*Responsible for the order of files in the list*)
		Refresh : BOOL; (*Updates the file list in the current folder*)
		PathInfo : MpFileManagerUIPathInfoType; (*Information about the current path*)
		EnterFolder : BOOL; (*Navigates one folder down*)
		FolderUp : BOOL; (*Navigates one folder up*)
		MultiSelect : BOOL; (*Allows the selection of multiple elements at the same time*)
		Delete : BOOL; (*Deletes a file or folder*)
		Copy : BOOL; (*Copying a file/folder*)
		Cut : BOOL; (*Cuts a file or folder*)
		Paste : BOOL; (*Pastes a file or folder*)
		NewName : STRING[255]; (*The new name of a file or folder when using the "Rename" or "CreateFolder" command*)
		Rename : BOOL; (*Renames a file or folder*)
		CreateFolder : BOOL; (*Creates a folder*)
	END_STRUCT;
	MpFileManagerUIFileListType : 	STRUCT 
		Items : ARRAY[0..49]OF MpFileManagerUIItemType; (*List of all files and folders under the current path*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time*)
		StepUp : BOOL; (*Selects the previous entry in the list*)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed-Start [%]*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed-End [%]*)
	END_STRUCT;
	MpFileManagerUIDeviceListType : 	STRUCT 
		DeviceNames : ARRAY[0..9]OF STRING[50]; (*List of all available data storage media*)
		SelectedIndex : UINT; (*Index of the entry currently selected in the list*)
	END_STRUCT;
	MpFileManagerConfigType : 	STRUCT 
		CustomizedFileType : ARRAY[0..9]OF STRING[5]; (*Customized file type names*)
	END_STRUCT;
END_TYPE
