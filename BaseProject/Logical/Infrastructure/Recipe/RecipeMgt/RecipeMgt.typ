
TYPE
	RecipeCommands_type : 	STRUCT 
		StoreMachineSettings : BOOL;
		FactoryResetMachineSettings : BOOL;
		SaveCurrentRecipe : BOOL;
		ImportFromUSB : BOOL;
		ExportToUSB : BOOL;
		SaveSelectedRecipe : BOOL;
		LoadRecipe : BOOL;
		CreateRecipe : BOOL;
	END_STRUCT;
	RecipeParameters_type : 	STRUCT 
		Category : STRING[30];
		LastLoadedConfigRecipe : STRING[255];
		LastLoadedProductRecipe : STRING[255];
		ActiveRecipe : STRING[255];
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		LastSelectedIndex : UINT;
		LastStatus : MpRecipeUIStatusEnum;
		TableConfig : STRING[120];
		CopyStep : RecipeCopyStep_enum;
		CategoryDropdown : STRING[50];
		EditDialogOpened : BOOL;
		CreateDialogOpened : BOOL;
	END_STRUCT;
	RecipeStatus_type : 	STRUCT 
		HMIcommand : RecipeHmiStep_enum;
	END_STRUCT;
	RecipeHmiInterface_type : 	STRUCT 
		Commands : RecipeCommands_type;
		Parameters : RecipeParameters_type;
		Status : RecipeStatus_type;
	END_STRUCT;
	RecipeCopyStep_enum : 
		(
		REC_COPY_WAIT := 0,
		REC_COPY_TO_USB,
		REC_COPY_FROM_USB,
		REC_COPY_BUSY
		);
	MachineSettings_type : 	STRUCT 
		AddMachineSettingsHere1 : USINT;
		AddMachineSettingsHere2 : DINT;
		AddMachineSettingsHere3 : BOOL;
		AddMachineSettingsHere4 : REAL;
		AddMachineSettingsHere5 : UINT;
	END_STRUCT;
	Parameters_type : 	STRUCT 
		AddParametersHere1 : BOOL;
		AddParametersHere2 : STRING[80];
		AddParametersHere3 : REAL;
		AddParametersHere4 : REAL;
		AddParametersHere5 : REAL;
	END_STRUCT;
	RecipeHmiStep_enum : 
		(
		REC_HMI_WAIT,
		REC_HMI_LOAD,
		REC_HMI_SAVE,
		REC_HMI_CREATE
		);
END_TYPE
