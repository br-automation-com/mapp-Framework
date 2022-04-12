
TYPE
	MpRecipeStatusIDType : 	STRUCT 
		ID : MpRecipeErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpRecipeDiagType : 	STRUCT 
		StatusID : MpRecipeStatusIDType; (*StatusID diagnostics structure*)
	END_STRUCT;
	MpRecipeInfoType : 	STRUCT 
		Diag : MpRecipeDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpRecipeUISetupConfirmType : 	STRUCT 
		RecipeLoad : BOOL; (*Enables a confirmation window when loading a recipe*)
		RecipeSave : BOOL; (*Enables a confirmation window when saving a recipe*)
		RecipeCreate : BOOL; (*Enables a confirmation window when creating a recipe	*)
		RecipeDelete : BOOL; (*Enables a confirmation window when creating a recipe*)
		RecipeRename : BOOL; (*Enables a confirmation window when renaming a recipe*)
	END_STRUCT;
	MpRecipeUISetupType : 	STRUCT 
		RecipeListSize : UINT := 20; (*Number of recipes to be displayed on one page of the list in the HMI application*)
		RecipeListScrollWindow : USINT := 1; (*Determines how many entries from the list are displayed in advance when scrolling up and down*)
		Confirmation : MpRecipeUISetupConfirmType; (*Displaying the confirmation window*)
		AutoLoadHeader : BOOL; (*Header info of a recipe should be loaded automatically when a recipe is selected (like a preview) *)
	END_STRUCT;
	MpRecipeUIMessageEnum : 
		(
		mpRECIPE_UI_MSG_NONE := 0, (*No dialog is required*)
		mpRECIPE_UI_MSG_CONFIRM_LOAD := 1, (*Dialog box for confirming the loading procedure*)
		mpRECIPE_UI_MSG_CONFIRM_SAVE := 2, (*Dialog box for confirming the saving procedure*)
		mpRECIPE_UI_MSG_CONFIRM_CREATE := 3, (*Dialog box for confirming the creation of a new recipe	*)
		mpRECIPE_UI_MSG_CONFIRM_DELETE := 4, (*Dialog box for confirming the deletion of an existing recipe*)
		mpRECIPE_UI_MSG_CONFIRM_RENAME := 5 (*Dialog box for confirming the renaming of an existing recipe*)
		);
	MpRecipeUIStatusEnum : 
		(
		mpRECIPE_UI_STATUS_IDLE := 0, (*Indicates that no process is currently active*)
		mpRECIPE_UI_STATUS_LOAD := 1, (*A recipe is being loaded*)
		mpRECIPE_UI_STATUS_SAVE := 2, (*A recipe is being saved*)
		mpRECIPE_UI_STATUS_CREATE := 3, (*A recipe is being created*)
		mpRECIPE_UI_STATUS_REFRESH := 4, (*The recipe list is being refreshed*)
		mpRECIPE_UI_STATUS_NOTIFY := 5, (*mapp components are being informed that new parameters are to be used*)
		mpRECIPE_UI_STATUS_DELETE := 6, (*A recipe is being deleted*)
		mpRECIPE_UI_STATUS_RENAME := 7, (*A recipe is being renamed*)
		mpRECIPE_UI_STATUS_ERROR := 99 (*The last operation generated an error*)
		);
	MpRecipeUIMessageBoxType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box *)
		Type : MpRecipeUIMessageEnum; (*Type of dialog box*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpRecipeUINewType : 	STRUCT 
		FileName : STRING[255]; (*Name of the new recipe*)
		Create : BOOL; (*Creates a new recipe*)
	END_STRUCT;
	MpRecipeUIConnectType : 	STRUCT 
		Status : MpRecipeUIStatusEnum; (*Current operation*)
		Recipe : MpRecipeUIRecipeType; (*Access to existing recipes*)
		New : MpRecipeUINewType; (*To create new recipes*)
		MessageBox : MpRecipeUIMessageBoxType; (*Controls dialog boxes*)
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page where the recipe management system is being displayed*)
	END_STRUCT;
	MpRecipeUIRecipeListType : 	STRUCT 
		Names : ARRAY[0..19] OF STRING[255]; (*List of all available recipes (filenames)*)
		SelectedIndex : UINT; (*Index of the entry currently selected in the list*)
		MaxSelection : UINT; (*Index of the last entry in the list*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time *)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time *)
		StepUp : BOOL; (*Selects the previous entry in the list*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed-Start [%]*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed-End [%]*)
		Sizes : ARRAY[0..19]OF UDINT; (*List of all recipe file sizes*)
		LastModified : ARRAY[0..19]OF STRING[50]; (*List of the last modification dates for all recipe files*)
	END_STRUCT;
	MpRecipeUIHeaderType : 	STRUCT 
		Name : STRING[100]; (*Name of the recipe*)
		Description : STRING[255]; (*Comment that describes the recipe*)
		Version : STRING[20]; (*Version of the recipe*)
		DateTime : DATE_AND_TIME; (*Date and time the recipe was created*)
	END_STRUCT;
	MpRecipeUIRecipeType : 	STRUCT 
		List : MpRecipeUIRecipeListType; (*List of all available recipes (filenames)*)
		Load : BOOL; (*Loads the selected recipe*)
		Save : BOOL; (*Saves the selected recipe*)
		Filter : STRING[255]; (*Filter used to sort the recipes*)
		SortOrder : MpRecipeUISortOrderEnum; (*Sorts the recipe list*)
		Refresh : BOOL; (*Updates the recipe list*)
		UpdateNotification : BOOL; (*Request to all mapp components to enter the current values of the recipe parameters*)
		Delete : BOOL; (*Deletes the selected recipe*)
		Rename : BOOL; (*Renames the currently selected recipe*)
		NewFileName : STRING[255]; (*Name of the new recipe*)
		Header : MpRecipeUIHeaderType; (*The header info of the currently selected recipe (is only loaded if the option is enabled in UISetup)*)
	END_STRUCT;
	MpRecipeXmlInfoType : 	STRUCT 
		FileSize : UDINT; (*Size of the recipe stored on the respective data storage medium*)
		PendingSync : UDINT; (*Number of pending save notifications ("SaveNotification") that have not yet been confirmed*)
		Diag : MpRecipeDiagType; (*Diagnostic structure for the status ID *)
		LastLoadedRecipe : STRING[255]; (*The name of the last loaded recipe*)
	END_STRUCT;
	MpRecipeUISortOrderEnum : 
		(
		mpRECIPE_UI_SORT_ASCENDING := 0, (*Sorts in ascending (alphabetic) order*)
		mpRECIPE_UI_SORT_DESCENDING := 1, (*Sorts in descending (alphabetic) order*)
		mpRECIPE_UI_SORT_DATE_ASCENDING := 2, (*Sorts in ascending (date/time) order*)
		mpRECIPE_UI_SORT_DATE_DESCENDING := 3 (*Sorts in descending (date/time) order*)
		);
	MpRecipeXmlHeaderType : 	STRUCT 
		Name : STRING[100]; (*Name of the recipe*)
		Description : STRING[255]; (*Comment that describes the recipe*)
		Version : STRING[20]; (*Version of the recipe*)
		DateTime : DATE_AND_TIME; (*Date and time the recipe was created*)
	END_STRUCT;
	MpRecipeXmlLoadEnum : 
		(
		mpRECIPE_XML_LOAD_ALL := 0, (*Loads the entire content of the recipe*)
		mpRECIPE_XML_LOAD_HEADER := 1 (*Loads only the recipe's header*)
		);
	MpRecipeCsvHeaderType : 	STRUCT 
		Name : STRING[100]; (*Name of the recipe*)
		Description : STRING[255]; (*Comment that describes the recipe*)
		Version : STRING[20]; (*Version of the recipe*)
		DateTime : DATE_AND_TIME; (*Date and time the recipe was created*)
	END_STRUCT;
	MpRecipeCsvInfoType : 	STRUCT 
		FileSize : UDINT; (*Size of the recipe stored on the respective data storage medium*)
		PendingSync : UDINT; (*Number of pending save notifications ("SaveNotification") that have not yet been confirmed*)
		LastLoadedRecipe : STRING[255]; (*The name of the last loaded recipe*)
		Diag : MpRecipeDiagType; (*Diagnostic structure for the status ID *)
	END_STRUCT;
	MpRecipeCsvLoadEnum : 
		(
		mpRECIPE_CSV_LOAD_ALL := 0, (*Loads the entire content of the recipe*)
		mpRECIPE_CSV_LOAD_HEADER := 1 (*Loads only the recipe's header*)
		);
END_TYPE
