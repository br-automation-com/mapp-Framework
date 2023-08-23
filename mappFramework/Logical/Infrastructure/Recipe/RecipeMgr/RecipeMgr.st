//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Jan 1, 2022
// Description: Tasks for recipe control.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreateRecipe(enable := TRUE, pDevice := ADR('mappRecipeFiles'), pName := ADR('/'));

	// Wait for DirCreate_0 to complete.
	WHILE (DirCreateRecipe.status = ERR_FUB_BUSY) DO
		DirCreateRecipe();
	END_WHILE
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreateRecipe.status = fiERR_DIR_ALREADY_EXIST OR (DirCreateRecipe.status = ERR_OK) THEN
		DirCreateRecipe(enable := FALSE);
	END_IF
	
	// Initialize mapp function blocks
	// By default, the Framework sets up an XML recipe system. To swtich to the CSV format, refer to the "Change Recipe Format"
	// page in the AS Help (GUID 2052b3a5-f59b-45f9-9fcd-3289c93401af)
	MpRecipeUISetup.Confirmation.RecipeDelete := TRUE;
	MpRecipeUISetup.RecipeListSize := 9;
	MpRecipeUISetup.RecipeListScrollWindow := 0;
	MpRecipeUISetup.AutoLoadHeader := TRUE;
	MpRecipeUIConnect.New.FileName := 'newRecipe';
	MpRecipeUIConnect.Recipe.Filter := '*par';
	MpRecipeUISys.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUISys.Enable := TRUE;
	MpRecipeUISys.UIConnect := ADR(MpRecipeUIConnect);
	MpRecipeUISys.UISetup := MpRecipeUISetup;
	MpRecipeUISys();

	HmiRecipe.Parameters.Category := PARAMETERS_CATEGORY;
	HmiRecipe.Status.DeviceDataProvider[0] := '{"value":"mappRecipeFiles","text":"CF/PLC"}';
	HmiRecipe.Parameters.DeviceName := 'mappRecipeFiles';
	MpRecipeSys.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeSys.Enable := TRUE;
	MpRecipeSys.Category := ADR(HmiRecipe.Parameters.Category);
	MpRecipeSys.DeviceName := ADR(HmiRecipe.Parameters.DeviceName);
	MpRecipeSys.FileName := ADR(HmiRecipe.Parameters.FileName);
	MpRecipeSys.Header := ADR(Header);

	// Wait for MpRecipeSys to activate. This must be active before you can call the RegPar function blocks, which is below.
	WHILE NOT(MpRecipeSys.Active OR MpRecipeSys.Error) DO
		MpRecipeSys();
	END_WHILE

	// Register the preview variables to the recipe. These preview variables are a buffer between the recipe system and the
	// variables used at runtime on the machine (Parameters, MachineSettings). By using these preview variables, you can
	// preview and edit a recipe on the HMI without actually loading it to the machine. For more details, refer to the
	// "Recipe System Design" page in the AS Help (GUID 3ccd7409-0b52-4bbc-a93a-4010f6db414c).

	MpRecipeRegPar_PreviewPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewPar.Enable := TRUE;
	MpRecipeRegPar_PreviewPar.PVName := ADR('RecipeMgr:ParametersPreview');
	MpRecipeRegPar_PreviewPar.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegPar_PreviewPar();

	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewCfg.Enable := TRUE;
	MpRecipeRegPar_PreviewCfg.PVName := ADR('RecipeMgr:MachineSettingsPreview');
	MpRecipeRegPar_PreviewCfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpRecipeRegPar_PreviewCfg();

	// Wait for RegPar function blocks to activate. These must be active before you can load a recipe,
	// which is further down in the Initialization program.
	WHILE NOT(MpRecipeRegPar_PreviewPar.Active OR MpRecipeRegPar_PreviewPar.Error) DO
		MpRecipeRegPar_PreviewPar();
	END_WHILE
	WHILE NOT(MpRecipeRegPar_PreviewCfg.Active OR MpRecipeRegPar_PreviewCfg.Error) DO
		MpRecipeRegPar_PreviewCfg();
	END_WHILE

	// Load default Machine Settings recipe
	HmiRecipe.Parameters.Category := MACHINE_CONFIGURATION_CATEGORY;
	IF (brsstrcmp(ADR(HmiRecipeRetain.LastLoadedConfigRecipe), ADR('')) <> 0) THEN
		HmiRecipe.Parameters.FileName := HmiRecipeRetain.LastLoadedConfigRecipe;
	ELSE
		HmiRecipe.Parameters.FileName := DEFAULT_MACHINE_CONFIGURATION;
		brsstrcat(ADR(HmiRecipe.Parameters.FileName),ADR(MACHINE_CONFIG_FILE_EXTENSION));
	END_IF		
	MpRecipeSys.Load := TRUE;
	WHILE NOT(MpRecipeSys.CommandDone OR MpRecipeSys.Error) DO
		MpRecipeSys();
	END_WHILE
	MachineSettings := MachineSettingsPreview;
	IF (brsstrcmp(ADR(HmiRecipeRetain.LastLoadedConfigRecipe), ADR('')) <> 0) THEN
		HmiRecipe.Status.LastLoadedConfigRecipe := HmiRecipeRetain.LastLoadedConfigRecipe;
	ELSE
		HmiRecipe.Status.LastLoadedConfigRecipe := DEFAULT_MACHINE_CONFIGURATION;
		brsstrcat(ADR(HmiRecipe.Status.LastLoadedConfigRecipe),ADR(MACHINE_CONFIG_FILE_EXTENSION));
		HmiRecipeRetain.LastLoadedConfigRecipe := HmiRecipe.Status.LastLoadedConfigRecipe;
	END_IF		
	HmiRecipe.Status.ConfigRecipeLoaded := TRUE;

	// Check if the default machine settings recipe is missing
	IF MpRecipeSys.Info.Diag.StatusID.ID = mpRECIPE_ERR_LOAD_DATA THEN
		HmiRecipe.Status.MachineSettingsRecipeMissing := TRUE;
		HmiRecipe.Status.LastLoadedConfigRecipe := '';
		HmiRecipe.Status.ConfigRecipeLoaded := FALSE;
	END_IF

	MpRecipeSys.ErrorReset := MpRecipeSys.Error;
	MpRecipeSys.Load := FALSE;
	MpRecipeSys();

	// Load default Parameter recipe
	HmiRecipe.Parameters.Category := PARAMETERS_CATEGORY;
	IF (brsstrcmp(ADR(HmiRecipeRetain.LastLoadedProductRecipe), ADR('')) <> 0) THEN
		HmiRecipe.Parameters.FileName := HmiRecipeRetain.LastLoadedProductRecipe;
	ELSE
		HmiRecipe.Parameters.FileName := DEFAULT_PARAMETERS;
		brsstrcat(ADR(HmiRecipe.Parameters.FileName),ADR(PARAMETERS_FILE_EXTENSION));
	END_IF	   
	HmiRecipe.Status.PreviousRecipe := DEFAULT_PARAMETERS;
	MpRecipeSys.Load := TRUE;
	WHILE NOT(MpRecipeSys.CommandDone OR MpRecipeSys.Error) DO
		MpRecipeSys();
	END_WHILE
	Parameters := ParametersPreview;
	IF (brsstrcmp(ADR(HmiRecipeRetain.LastLoadedProductRecipe), ADR('')) <> 0) THEN
		HmiRecipe.Status.LastLoadedProductRecipe := HmiRecipeRetain.LastLoadedProductRecipe;
	ELSE
		HmiRecipe.Status.LastLoadedProductRecipe := DEFAULT_PARAMETERS;
		brsstrcat(ADR(HmiRecipe.Status.LastLoadedProductRecipe),ADR(PARAMETERS_FILE_EXTENSION));
		HmiRecipeRetain.LastLoadedProductRecipe := HmiRecipe.Status.LastLoadedProductRecipe;
	END_IF	 
	HmiRecipe.Status.ProductRecipeLoaded := TRUE;

	// Check if the default parameters recipe is missing
	IF MpRecipeSys.Info.Diag.StatusID.ID = mpRECIPE_ERR_LOAD_DATA THEN
		HmiRecipe.Status.ParameterRecipeMissing := TRUE;
		HmiRecipe.Status.LastLoadedProductRecipe := '';
		HmiRecipe.Status.ProductRecipeLoaded := FALSE;
	END_IF



	MpRecipeSys.ErrorReset := MpRecipeSys.Error;
	MpRecipeSys.Load := FALSE;
	MpRecipeSys();

	// Trigger update notification so that the initial parameters are copied to the process
	MpRecipeSys.UpdateNotification := TRUE;

	// Init Filemanager for exporting/importing files
	MpFileManagerUIRecipe.Enable := TRUE;
	MpFileManagerUIRecipe.MpLink := ADR(gMpLinkFileManagerUIRecipe);
	MpFileManagerUIRecipe.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUIRecipe.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipeFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := '';
	MpFileManagerUIRecipe();

	HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;

END_PROGRAM

PROGRAM _CYCLIC

	// Call all cyclic actions
	FormatDeviceDataProvider;
	LoadPreview;
	RecipeHMIcommands;
	LoadStatus;

	// Reset commands on MpRecipe FUB
	IF MpRecipeSys.CommandDone THEN
		MpRecipeSys.Load := FALSE;
		MpRecipeSys.Save := FALSE;
		// Set update notification for machine category
		IF ((brsstrcmp(ADR(HmiRecipe.Parameters.Category), ADR(MACHINE_CONFIGURATION_CATEGORY)) = 0) AND (MpRecipeSys.Save = TRUE)) THEN
			MpRecipeSys.UpdateNotification := TRUE;
		ELSE
			MpRecipeSys.UpdateNotification := FALSE;
		END_IF
	END_IF


	// Error reset
	IF NOT MpRecipeSys.Error THEN
		MpRecipeSys.ErrorReset := FALSE;
	END_IF

	IF NOT MpRecipeUISys.Error THEN
		MpRecipeUISys.ErrorReset := FALSE;
	END_IF

	// Assign MpLinks & address references
	MpRecipeSys.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeSys.DeviceName := ADR(HmiRecipe.Parameters.DeviceName);
	MpRecipeSys.Header := ADR(Header);
	MpRecipeUISys.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUISys.UIConnect := ADR(MpRecipeUIConnect);
	MpFileManagerUIRecipe.MpLink := ADR(gMpLinkFileManagerUIRecipe);
	MpRecipeRegPar_PreviewPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewPar.PVName := ADR('RecipeMgr:ParametersPreview');
	MpRecipeRegPar_PreviewPar.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewCfg.PVName := ADR('RecipeMgr:MachineSettingsPreview');
	MpRecipeRegPar_PreviewCfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpFileManagerUIRecipe.UIConnect := ADR(MpFileManagerUIConnect);	

	// Call function blocks
	MpRecipeSys();
	MpRecipeUISys();
	MpFileManagerUIRecipe();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
	MpRecipeSys.Enable := FALSE;
	MpRecipeUISys.Enable := FALSE;
	MpRecipeRegPar_PreviewPar.Enable := FALSE;
	MpRecipeRegPar_PreviewCfg.Enable := FALSE;
	MpFileManagerUIRecipe.Enable := FALSE;

	// Call function blocks
	MpRecipeSys();
	MpRecipeUISys();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();
	MpFileManagerUIRecipe();

END_PROGRAM

