//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Jan 1, 2022
// Description: Tasks for recipe control.
//***********************************************************************

PROGRAM _INIT
	
	// Create folder for this component on the user file device
	DirCreate_New(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF
	
	// Initialize mapp function blocks
	MpRecipeUISetup.Confirmation.RecipeDelete := TRUE;
	MpRecipeUISetup.RecipeListSize := 10;
	MpRecipeUISetup.RecipeListScrollWindow := 0;
	MpRecipeUISetup.AutoLoadHeader := TRUE;
	MpRecipeUIConnect.New.FileName := 'newRecipe.par';
	MpRecipeUIConnect.Recipe.Filter := '*par';
	MpRecipeUI_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);
	MpRecipeUI_0.UISetup := MpRecipeUISetup;
	MpRecipeUI_0();
	
	HmiRecipe.Parameters.Category := PRODUCT_CATEGORY;
	HmiRecipe.Parameters.DeviceDataProvider[0] := '{"value":"mappRecipeFiles","text":"CF/PLC"}';
	HmiRecipe.Parameters.DeviceName := 'mappRecipeFiles';
	MpRecipe_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipe_0.Enable := TRUE;
	MpRecipe_0.Category := ADR(HmiRecipe.Parameters.Category);
	MpRecipe_0.DeviceName := ADR(HmiRecipe.Parameters.DeviceName);
    MpRecipe_0.FileName := ADR(HmiRecipe.Parameters.FileName);
	MpRecipe_0.Header := ADR(Header);

	// Wait for MpRecipe_0 to activate. This must be active before you can call the RegPar function blocks, 
	// which is further down in the Initialization program.
	WHILE NOT(MpRecipe_0.Active OR MpRecipe_0.Error) DO
		MpRecipe_0();
	END_WHILE
	
    MpRecipeRegPar_PreviewPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewPar.Enable := TRUE;
	MpRecipeRegPar_PreviewPar.PVName := ADR('RecipeMgr:ParametersPreview');
	MpRecipeRegPar_PreviewPar.Category := ADR(PRODUCT_CATEGORY);
	MpRecipeRegPar_PreviewPar();
	
	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewCfg.Enable := TRUE;
	MpRecipeRegPar_PreviewCfg.PVName := ADR('RecipeMgr:MachineSettingsPreview');
	MpRecipeRegPar_PreviewCfg.Category := ADR(MACHINE_CATEGORY);
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
	HmiRecipe.Parameters.Category := MACHINE_CATEGORY;
	HmiRecipe.Parameters.FileName := MACHINE_FILENAME;
	MpRecipe_0.Load := TRUE;
	WHILE NOT(MpRecipe_0.CommandDone OR MpRecipe_0.Error) DO
		MpRecipe_0();
    END_WHILE
	MachineSettings := MachineSettingsPreview;
	
	MpRecipe_0.ErrorReset := MpRecipe_0.Error;
	MpRecipe_0.Load := FALSE;
	MpRecipe_0();

	// Load default Parameter recipe
	HmiRecipe.Parameters.Category := PRODUCT_CATEGORY;
	HmiRecipe.Parameters.FileName := 'Default.par';
	PreviousRecipe := 'Default.par';
	MpRecipe_0.Load := TRUE;
	WHILE NOT(MpRecipe_0.CommandDone OR MpRecipe_0.Error) DO
		MpRecipe_0();
	END_WHILE
	Parameters := ParametersPreview;
    
	HmiRecipe.Parameters.LastLoadedProductRecipe := MpRecipe_0.Info.LastLoadedRecipe;
	HmiRecipe.Parameters.LastLoadedConfigRecipe := MACHINE_FILENAME;
	MpRecipe_0.ErrorReset := MpRecipe_0.Error;
	MpRecipe_0.Load := FALSE;
	MpRecipe_0();

    // Trigger update notification so that the initial parameters are copied to the process
    // might not be necessary.*****
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

	// Call actions
	FormatDeviceDataProvider;
	LoadPreview;
	RecipeHMIcommands;
	FileCopyOperation;
	
    // Reset category after saving is done, category should be reset so that autosave files contain ALL the parameters
    IF EDGEPOS(MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE) AND ((NOT MpRecipeUIConnect.Recipe.Load) AND (NOT MpRecipeUIConnect.Recipe.Save)) THEN
        // Check if 'Product' category has been loaded
        IF ((brsstrcmp(ADR(HmiRecipe.Parameters.Category), ADR(PRODUCT_CATEGORY)) = 0) AND (HmiRecipe.Parameters.LastStatus = mpRECIPE_UI_STATUS_LOAD)) THEN
			HmiRecipe.Parameters.LastLoadedProductRecipe := MpRecipe_0.Info.LastLoadedRecipe;
			MpRecipe_0.UpdateNotification := TRUE;
		ELSIF ((brsstrcmp(ADR(HmiRecipe.Parameters.Category), ADR(MACHINE_CATEGORY)) = 0) AND (HmiRecipe.Parameters.LastStatus = mpRECIPE_UI_STATUS_LOAD)) THEN
			HmiRecipe.Parameters.LastLoadedConfigRecipe := MpRecipe_0.Info.LastLoadedRecipe;
			MpRecipe_0.UpdateNotification := TRUE;
        END_IF
		// Trigger a reload of the preview parameters
        HmiRecipe.Parameters.LastSelectedIndex := HmiRecipe.Parameters.LastSelectedIndex + 1;
        brsstrcpy(ADR(HmiRecipe.Parameters.Category), ADR(PRODUCT_CATEGORY));
    END_IF
    HmiRecipe.Parameters.LastStatus := MpRecipeUIConnect.Status;
	HmiRecipe.Parameters.ActiveRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];

    // Save current recipe
    IF (HmiRecipe.Commands.SaveCurrentRecipe = TRUE) AND NOT (MpRecipe_0.Load OR MpRecipe_0.Save OR MpRecipe_0.UpdateNotification) THEN
		HmiRecipe.Parameters.FileName := HmiRecipe.Parameters.LastLoadedProductRecipe;
        DTGetTime_0(enable := TRUE);
        Header.DateTime := DTGetTime_0.DT1;
        Header.Name := HmiRecipe.Parameters.FileName;
        Header.Description := '';
        MpRecipe_0.Save := TRUE;
        HmiRecipe.Commands.SaveCurrentRecipe := FALSE;
    END_IF
	
	// Reset commands on MpRecipe FUB
	IF MpRecipe_0.CommandDone THEN
		// Set update notification for machine category
		IF ((brsstrcmp(ADR(HmiRecipe.Parameters.Category), ADR(MACHINE_CATEGORY)) = 0) AND (MpRecipe_0.Save = TRUE)) THEN
			MpRecipe_0.UpdateNotification := TRUE;
			MpRecipe_0.Load := FALSE;
			MpRecipe_0.Save := FALSE;
		ELSE
			MpRecipe_0.UpdateNotification := FALSE;
			MpRecipe_0.Load := FALSE;
			MpRecipe_0.Save := FALSE;
			HmiRecipe.Parameters.Category := PRODUCT_CATEGORY;
			HmiRecipe.Parameters.FileName := 'Default.par';
        END_IF
    END_IF
    
	// Error reset
	IF NOT MpRecipe_0.Error THEN
		MpRecipe_0.ErrorReset := FALSE;
	END_IF
    
	IF NOT MpRecipeUI_0.Error THEN
		MpRecipeUI_0.ErrorReset := FALSE;
	END_IF
	
	// Assign MpLinks
	MpRecipe_0.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeUI_0.MpLink := ADR(gMpLinkRecipeXml);
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIRecipe);
	MpRecipeRegPar_PreviewPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gMpLinkRecipeXml);
	
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

