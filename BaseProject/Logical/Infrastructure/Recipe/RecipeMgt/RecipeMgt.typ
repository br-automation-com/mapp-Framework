
TYPE
	RecipeCommandsType : 	STRUCT 
		StoreMachineSettings : BOOL;
		FactoryResetMachineSettings : BOOL;
		SaveCurrentRecipe : BOOL;
		ImportFromUSB : BOOL;
		ExportToUSB : BOOL;
		SaveSelectedRecipe : BOOL;
		LoadRecipe : BOOL;
		CreateRecipe : BOOL;
	END_STRUCT;
	RecipeParametersType : 	STRUCT 
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
		CopyStep : RecipeCopyStepEnum;
		CategoryDropdown : STRING[50];
		EditDialogOpened : BOOL;
		CreateDialogOpened : BOOL;
	END_STRUCT;
	RecipeStatusType : 	STRUCT 
		HMIcommand : RecipeHmiStepEnum;
	END_STRUCT;
	RecipeHmiInterfaceType : 	STRUCT 
		Commands : RecipeCommandsType;
		Parameters : RecipeParametersType;
		Status : RecipeStatusType;
	END_STRUCT;
	RecipeCopyStepEnum : 
		(
		REC_COPY_WAIT := 0,
		REC_COPY_TO_USB,
		REC_COPY_FROM_USB,
		REC_COPY_BUSY
		);
	MachineSettingsType : 	STRUCT 
		AddMachineSettingsHere1 : USINT;
		AddMachineSettingsHere2 : DINT;
		AddMachineSettingsHere3 : BOOL;
		AddMachineSettingsHere4 : REAL;
		AddMachineSettingsHere5 : UINT;
	END_STRUCT;
	ParametersType : 	STRUCT 
		AddParametersHere1 : BOOL;
		AddParametersHere2 : STRING[80];
		AddParametersHere3 : REAL;
		AddParametersHere4 : REAL;
		AddParametersHere5 : REAL;
	END_STRUCT;
	RecipeHmiStepEnum : 
		(
		REC_HMI_WAIT,
		REC_HMI_LOAD,
		REC_HMI_SAVE,
		REC_HMI_CREATE
		);
END_TYPE
