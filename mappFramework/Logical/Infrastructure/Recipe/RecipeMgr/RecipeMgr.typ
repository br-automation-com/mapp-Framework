(*Structure types*)

TYPE
	RecipeHmiInterfaceType : 	STRUCT  (*Structure to hold commands, parameters and status from the HMI*)
		Commands : RecipeCommandsType; (*Structure to hold the commands from the HMI*)
		Parameters : RecipeParametersType; (*Structure to hold the parameters for the HMI*)
		Status : RecipeStatusType; (*Structure to hold status information from the mapp View HMI*)
	END_STRUCT;
	RecipeCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		LoadRecipe : BOOL; (*Load recipe*)
		SaveSelectedRecipe : BOOL; (*Save the selected recipe (which is not necessarily the active recipe)*)
		CreateRecipe : BOOL; (*Create recipe*)
		ImportFromUSB : BOOL; (*Import from USB device*)
		ExportToUSB : BOOL; (*Export to USB device*)
		ResetPreview : BOOL; (*Reset the preview to empty/zeros in the event of an invalid recipe*)
	END_STRUCT;
	RecipeParametersType : 	STRUCT  (*Structure to hold the parameters for the HMI*)
		Category : STRING[30]; (*Current category*)
		DeviceName : STRING[50]; (*Selected file device name*)
		FileName : STRING[255]; (*Recipe file name*)
	END_STRUCT;
	RecipeStatusType : 	STRUCT  (*Structure to hold status information from the mapp View HMI*)
		HMIcommand : RecipeHmiStepEnum; (*State machine step for HMI commands*)
		LastLoadedConfigRecipe : STRING[255]; (*Last loaded configuration recipe*)
		LastLoadedProductRecipe : STRING[255]; (*Last loaded product recipe*)
		ProductRecipeLoaded : BOOL; (*Product recipe was loaded*)
		ConfigRecipeLoaded : BOOL; (*Config recipe was loaded*)
		LastMaxSelection : UINT; (*The previous maximum number of recipes*)
		LastSelectedIndex : UINT; (*The previous selected index*)
		LastStatus : MpRecipeUIStatusEnum; (*The previous UI status*)
		EditDialogOpened : BOOL; (*Flag that the edit dialog box was opened*)
		CreateDialogOpened : BOOL; (*Flag that the create dialog box was opened*)
		PreviousRecipe : STRING[80]; (*Name of the previous recipe*)
		FileDuplicate : BOOL; (*Recipe file already exists, warn the user.*)
		FilesAvailable : BOOL; (*Control access to widget when no files are available*)
		InvalidRecipe : BOOL; (*The selected recipe cannot be previewed*)
		LoadingRecipeList : BOOL; (*The recipe list is loading*)
		MachineSettingsRecipeMissing : BOOL; (*Flag for if the default machine settings recipe is not present*)
		ParameterRecipeMissing : BOOL; (*Flag for if the default parameters recipe is not present*)
		LoadAllowed : BOOL; (*Flag for whether you can load a recipe. Recipe must exist and be valid. *)
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100]; (*File device data provider*)
		TableConfig : STRING[120]; (*Table configuration *)
		SelectedRecipe : STRING[255]; (*The name of the selected recipe*)
		DefaultRecipeSelected : BOOL; (*The default recipe is selected*)
	END_STRUCT;
	ParametersType : 	STRUCT  (*Demo / starter structure for machine parameters*)
		AddParametersHere1 : BOOL; (*Add your parameteres here *)
		AddParametersHere2 : STRING[80]; (*Add your parameteres here *)
		AddParametersHere3 : REAL; (*Add your parameteres here *)
		AddParametersHere4 : REAL; (*Add your parameteres here *)
		AddParametersHere5 : REAL; (*Add your parameteres here *)
	END_STRUCT;
	MachineSettingsType : 	STRUCT  (*Demo / starter structure for machine configuration settings*)
		AddMachineSettingsHere1 : USINT; (*Add your settings here*)
		AddMachineSettingsHere2 : DINT; (*Add your settings here*)
		AddMachineSettingsHere3 : BOOL; (*Add your settings here*)
		AddMachineSettingsHere4 : REAL; (*Add your settings here*)
		AddMachineSettingsHere5 : UINT; (*Add your settings here*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	RecipeHmiStepEnum : 
		( (*State machine step for HMI commands*)
		REC_HMI_WAIT, (*Wait*)
		REC_HMI_LOAD, (*Load recipe*)
		REC_HMI_SAVE, (*Save recipe*)
		REC_HMI_CREATE, (*Create recipe*)
		REC_HMI_RESET_PREVIEW (*Reset the preview values to 0 / empty*)
		);
END_TYPE
