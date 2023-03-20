//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Jan 1, 2022
// Description: Tasks for recipe control.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappRecipeFiles'), pName := ADR('/'));

	// Wait for DirCreate_0 to complete.
	WHILE (DirCreate_0.status = ERR_FUB_BUSY) DO
		DirCreate_0();
	END_WHILE
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST OR (DirCreate_0.status = ERR_OK) THEN
		DirCreate_0(enable := FALSE);
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
	MpRecipeUI_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);
	MpRecipeUI_0.UISetup := MpRecipeUISetup;
	MpRecipeUI_0();

	HmiRecipe.Parameters.Category := PARAMETERS_CATEGORY;
	HmiRecipe.Status.DeviceDataProvider[0] := '{"value":"mappRecipeFiles","text":"CF/PLC"}';
	HmiRecipe.Parameters.DeviceName := 'mappRecipeFiles';
	MpRecipe_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipe_0.Enable := TRUE;
	MpRecipe_0.Category := ADR(HmiRecipe.Parameters.Category);
	MpRecipe_0.DeviceName := ADR(HmiRecipe.Parameters.DeviceName);
	MpRecipe_0.FileName := ADR(HmiRecipe.Parameters.FileName);
	MpRecipe_0.Header := ADR(Header);

	// Wait for MpRecipe_0 to activate. This must be active before you can call the RegPar function blocks, which is below.
	WHILE NOT(MpRecipe_0.Active OR MpRecipe_0.Error) DO
		MpRecipe_0();
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
	MpRecipe_0.Load := TRUE;
	WHILE NOT(MpRecipe_0.CommandDone OR MpRecipe_0.Error) DO
		MpRecipe_0();
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
	IF MpRecipe_0.Info.Diag.StatusID.ID = mpRECIPE_ERR_LOAD_DATA THEN
		HmiRecipe.Status.MachineSettingsRecipeMissing := TRUE;
		HmiRecipe.Status.LastLoadedConfigRecipe := '';
		HmiRecipe.Status.ConfigRecipeLoaded := FALSE;
	END_IF

	MpRecipe_0.ErrorReset := MpRecipe_0.Error;
	MpRecipe_0.Load := FALSE;
	MpRecipe_0();

	// Load default Parameter recipe
	HmiRecipe.Parameters.Category := PARAMETERS_CATEGORY;
	IF (brsstrcmp(ADR(HmiRecipeRetain.LastLoadedProductRecipe), ADR('')) <> 0) THEN
		HmiRecipe.Parameters.FileName := HmiRecipeRetain.LastLoadedProductRecipe;
	ELSE
		HmiRecipe.Parameters.FileName := DEFAULT_PARAMETERS;
		brsstrcat(ADR(HmiRecipe.Parameters.FileName),ADR(PARAMETERS_FILE_EXTENSION));
	END_IF	   
	HmiRecipe.Status.PreviousRecipe := DEFAULT_PARAMETERS;
	MpRecipe_0.Load := TRUE;
	WHILE NOT(MpRecipe_0.CommandDone OR MpRecipe_0.Error) DO
		MpRecipe_0();
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
	IF MpRecipe_0.Info.Diag.StatusID.ID = mpRECIPE_ERR_LOAD_DATA THEN
		HmiRecipe.Status.ParameterRecipeMissing := TRUE;
		HmiRecipe.Status.LastLoadedProductRecipe := '';
		HmiRecipe.Status.ProductRecipeLoaded := FALSE;
	END_IF



	MpRecipe_0.ErrorReset := MpRecipe_0.Error;
	MpRecipe_0.Load := FALSE;
	MpRecipe_0();

	// Trigger update notification so that the initial parameters are copied to the process
	MpRecipe_0.UpdateNotification := TRUE;

	// Init Filemanager for exporting/importing files
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIRecipe);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipeFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := '';
	MpFileManagerUI_0();

	HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;

END_PROGRAM

PROGRAM _CYCLIC

	// Call all cyclic actions
	FormatDeviceDataProvider;
	LoadPreview;
	RecipeHMIcommands;
	LoadStatus;

	// Reset commands on MpRecipe FUB
	IF MpRecipe_0.CommandDone THEN
		MpRecipe_0.Load := FALSE;
		MpRecipe_0.Save := FALSE;
		// Set update notification for machine category
		IF ((brsstrcmp(ADR(HmiRecipe.Parameters.Category), ADR(MACHINE_CONFIGURATION_CATEGORY)) = 0) AND (MpRecipe_0.Save = TRUE)) THEN
			MpRecipe_0.UpdateNotification := TRUE;
		ELSE
			MpRecipe_0.UpdateNotification := FALSE;
		END_IF
	END_IF


	// Error reset
	IF NOT MpRecipe_0.Error THEN
		MpRecipe_0.ErrorReset := FALSE;
	END_IF

	IF NOT MpRecipeUI_0.Error THEN
		MpRecipeUI_0.ErrorReset := FALSE;
	END_IF

	// Assign MpLinks & address references
	MpRecipe_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipe_0.Category := ADR(HmiRecipe.Parameters.Category);
	MpRecipe_0.DeviceName := ADR(HmiRecipe.Parameters.DeviceName);
	MpRecipe_0.FileName := ADR(HmiRecipe.Parameters.FileName);
	MpRecipe_0.Header := ADR(Header);
	MpRecipeUI_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIRecipe);
	MpRecipeRegPar_PreviewPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewPar.PVName := ADR('RecipeMgr:ParametersPreview');
	MpRecipeRegPar_PreviewPar.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewCfg.PVName := ADR('RecipeMgr:MachineSettingsPreview');
	MpRecipeRegPar_PreviewCfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);	

	// Call function blocks
	MpRecipe_0();
	MpRecipeUI_0();
	MpFileManagerUI_0();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
	MpRecipe_0.Enable := FALSE;
	MpRecipeUI_0.Enable := FALSE;
	MpRecipeRegPar_PreviewPar.Enable := FALSE;
	MpRecipeRegPar_PreviewCfg.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;

	// Call function blocks
	MpRecipe_0();
	MpRecipeUI_0();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();
	MpFileManagerUI_0();

END_PROGRAM

