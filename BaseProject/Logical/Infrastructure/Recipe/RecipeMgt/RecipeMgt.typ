
TYPE
	RecipeCommands_type : 	STRUCT 
		StoreMachineSettings : BOOL;
		FactoryResetMachineSettings : BOOL;
		SaveCurrentRecipe : BOOL;
		ImportFromUSB : BOOL;
		ExportToUSB : BOOL;
	END_STRUCT;
	RecipeStatus_type : 	STRUCT 
		Category : STRING[30];
		LastLoadedRecipe : STRING[255];
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		DeviceName : STRING[50];
		FileName : STRING[255];
		LastSelectedIndex : UINT;
		LastStatus : MpRecipeUIStatusEnum;
		TableConfig : STRING[120];
		CopyStep : RecipeCopyStep_enum;
	END_STRUCT;
	RecipeHmiInterface_type : 	STRUCT 
		Commands : RecipeCommands_type;
		Status : RecipeStatus_type;
	END_STRUCT;
	RecipeCopyStep_enum : 
		(
		REC_COPY_WAIT := 0,
		REC_COPY_TO_USB,
		REC_COPY_FROM_USB,
		REC_COPY_BUSY
		);
END_TYPE
