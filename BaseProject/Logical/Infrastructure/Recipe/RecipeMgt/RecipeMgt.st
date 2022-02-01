(*********************************************************************************
* Copyright: B&R Industrial Automation GmbH 
* Author:    B&R Industrial Automation GmbH 
* Created:   30. Sep 2020/08:00 
* Description: Tasks for Recipe control. The Recipe Control handling is done in this task.
*********************************************************************************)

PROGRAM _INIT
	(*Create folder for this component on the user file device*)
	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));		
	
	(*Check if folder already exist and if so disabled the function block call*)
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF	
	
	(* Init MpRecipe function blocks *)
	brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Status.DeviceDataProvider[0]), ADR('{"value":"mappRecipe","text":"CF/PLC"}'));
	brsstrcpy(ADR(hmiRecipe.Status.DeviceName), ADR('mappRecipe'));
	MpRecipeXml_0.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeXml_0.Enable := TRUE;
	MpRecipeXml_0.Category := ADR(hmiRecipe.Status.Category);
	MpRecipeXml_0.DeviceName := ADR(hmiRecipe.Status.DeviceName);
    MpRecipeXml_0.FileName := ADR(hmiRecipe.Status.FileName);
	MpRecipeXml_0.Header := ADR(Header);
	
	MpRecipeUISetup.Confirmation.RecipeDelete := TRUE;
	MpRecipeUISetup.RecipeListSize := 10;
	MpRecipeUISetup.RecipeListScrollWindow := 0;
	MpRecipeUISetup.AutoLoadHeader := TRUE;
	MpRecipeUIConnect.New.FileName := 'newRecipe.par';
	MpRecipeUIConnect.Recipe.Filter := '*par';
	MpRecipeUI_0.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);
	MpRecipeUI_0.UISetup := MpRecipeUISetup;

	(* Activate component *)
	WHILE NOT (MpRecipeXml_0.Active OR MpRecipeXml_0.Error) DO
		MpRecipeXml_0();
	END_WHILE;
	
	
	MpRecipeRegPar_PreviewPar.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_PreviewPar.Enable := TRUE;
	MpRecipeRegPar_PreviewPar.PVName := ADR('RecipeMgt:ParametersPreview');
	MpRecipeRegPar_PreviewPar.Category := ADR(PRODUCT_CATEGORY); 
	MpRecipeRegPar_PreviewPar();
	
	MpRecipeRegPar_PreviewCfg.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_PreviewCfg.Enable := TRUE;
	MpRecipeRegPar_PreviewCfg.PVName := ADR('RecipeMgt:MachSettingsPreview');
	MpRecipeRegPar_PreviewCfg.Category := ADR(MACHINE_CATEGORY); 
	MpRecipeRegPar_PreviewCfg();

	(* Activate RegPar FUBs *)
	WHILE NOT MpRecipeRegPar_PreviewPar.Active AND NOT MpRecipeRegPar_PreviewPar.Error DO
		MpRecipeRegPar_PreviewPar();
	END_WHILE
	WHILE NOT MpRecipeRegPar_PreviewCfg.Active AND NOT MpRecipeRegPar_PreviewCfg.Error DO
		MpRecipeRegPar_PreviewCfg();
	END_WHILE

	Parameters;
	MachSettings;
	ParametersPreview;
	MachSettingsPreview;
	
	(* Load Machine Settings *)
	brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(MACHINE_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR(MACHINE_FILENAME));
	MpRecipeXml_0.Load := TRUE;
	WHILE ((NOT MpRecipeXml_0.CommandDone) AND (NOT MpRecipeXml_0.Error)) DO
		MpRecipeXml_0();
    END_WHILE
	MachSettings := MachSettingsPreview;
	
	MpRecipeXml_0.ErrorReset := MpRecipeXml_0.Error;
	MpRecipeXml_0.Load := FALSE;
	MpRecipeXml_0();

	(* Load Default parameter file *)
	brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR('Default.par'));
	previousRecipe := 'Default.par';
    MpRecipeXml_0.Load := TRUE;
    WHILE ((NOT MpRecipeXml_0.CommandDone) AND (NOT MpRecipeXml_0.Error)) DO
		MpRecipeXml_0();
	END_WHILE
	Parameters := ParametersPreview;//////
	
    
	brsstrcpy(ADR(hmiRecipe.Status.LastLoadedProductRecipe), ADR(MpRecipeXml_0.Info.LastLoadedRecipe));
	brsstrcpy(ADR(hmiRecipe.Status.LastLoadedConfigRecipe), ADR(MACHINE_FILENAME));
	MpRecipeXml_0.ErrorReset := MpRecipeXml_0.Error;
	MpRecipeXml_0.Load := FALSE;
	MpRecipeXml_0();

	(* Trigger update notification so that the initial parameters are copied to the process *)
	MpRecipeXml_0.UpdateNotification := TRUE; //might not be necessary.
	
	(* Init Filemanager for exporting/importing files *)
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gRecFileMgrUIMpLink);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[0]), ADR('mappRecipe'));
	brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[1]), ADR(''));
  //  brsstrcpy(ADR(MpFileManagerUIConnect.File.Filter), ADR('*'));
    
END_PROGRAM

PROGRAM _CYCLIC

	FormatDeviceDataProvider;	
	UpdatePreviewValues;
	LoadPreview;
	MachineSettings;
	
	
	
    (* Reset category after saving is done, category should be reset so that autosave files contain ALL the parameters *)
    IF EDGEPOS(MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE) AND ((NOT MpRecipeUIConnect.Recipe.Load) AND (NOT MpRecipeUIConnect.Recipe.Save)) THEN
        (* Check if 'Product' category has been loaded *)
        IF ((brsstrcmp(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY)) = 0) AND (hmiRecipe.Status.LastStatus = mpRECIPE_UI_STATUS_LOAD)) THEN
			brsstrcpy(ADR(hmiRecipe.Status.LastLoadedProductRecipe), ADR(MpRecipeXml_0.Info.LastLoadedRecipe));
			MpRecipeXml_0.UpdateNotification := TRUE;
		ELSIF ((brsstrcmp(ADR(hmiRecipe.Status.Category), ADR(MACHINE_CATEGORY)) = 0) AND (hmiRecipe.Status.LastStatus = mpRECIPE_UI_STATUS_LOAD)) THEN
			brsstrcpy(ADR(hmiRecipe.Status.LastLoadedConfigRecipe), ADR(MpRecipeXml_0.Info.LastLoadedRecipe));
			MpRecipeXml_0.UpdateNotification := TRUE;
        END_IF
		(* Trigger a reload of the preview parameters *)
        hmiRecipe.Status.LastSelectedIndex := hmiRecipe.Status.LastSelectedIndex + 1;
        brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY));
    END_IF
    hmiRecipe.Status.LastStatus := MpRecipeUIConnect.Status;

    (* Save current recipe *)
    IF (hmiRecipe.Commands.SaveCurrentRecipe = TRUE) AND NOT (MpRecipeXml_0.Load OR MpRecipeXml_0.Save OR MpRecipeXml_0.UpdateNotification) THEN
        brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR(hmiRecipe.Status.LastLoadedProductRecipe));
        DTGetTime_0(enable := TRUE);
        Header.DateTime := DTGetTime_0.DT1;
        Header.Name := hmiRecipe.Status.FileName;
        Header.Description := '';
        MpRecipeXml_0.Save := TRUE;
        //brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY));
        hmiRecipe.Commands.SaveCurrentRecipe := FALSE;
    END_IF
	
	(* Reset commands on MpRecipe FUB *)
	IF MpRecipeXml_0.CommandDone THEN
		(* Set update notification for machine category *)
		IF ((brsstrcmp(ADR(hmiRecipe.Status.Category), ADR(MACHINE_CATEGORY)) = 0) AND (MpRecipeXml_0.Save = TRUE)) THEN
			MpRecipeXml_0.UpdateNotification := TRUE;
			MpRecipeXml_0.Load := FALSE;
			MpRecipeXml_0.Save := FALSE;
		ELSE
			MpRecipeXml_0.UpdateNotification := FALSE;
			MpRecipeXml_0.Load := FALSE;
			MpRecipeXml_0.Save := FALSE;
			brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(PRODUCT_CATEGORY));
			brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR('Default.par'));
        END_IF
    END_IF
	
	IF NOT MpRecipeXml_0.CommandBusy AND brsstrcmp(ADR(previousRecipe),ADR(hmiRecipe.Status.FileName)) <> 0 THEN
		hmiRecipe.Status.FileName := previousRecipe;
	END_IF
	
	IF hmiRecipe.Commands.LoadRecipe THEN
		IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
			Parameters := ParametersPreview;
			hmiRecipe.Status.LastLoadedProductRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettings := MachSettingsPreview;
			hmiRecipe.Status.LastLoadedConfigRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
		END_IF
		hmiRecipe.Commands.LoadRecipe := FALSE;
	END_IF
	IF hmiRecipe.Status.EditDialogOpened OR hmiRecipe.Status.CreateDialogOpened THEN
		IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
			ParametersEdit := ParametersPreview;
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsEdit := MachSettingsPreview;
		END_IF
		hmiRecipe.Status.EditDialogOpened := FALSE;
		hmiRecipe.Status.CreateDialogOpened := FALSE;
	END_IF
	IF hmiRecipe.Commands.SaveSelectedRecipe THEN
		IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
			ParametersPreview := ParametersEdit;
			IF (brsstrcmp(ADR(hmiRecipe.Status.LastLoadedProductRecipe),ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]))=0) THEN
				Parameters := ParametersEdit;
			END_IF
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsPreview := MachSettingsEdit;
			IF (brsstrcmp(ADR(hmiRecipe.Status.LastLoadedConfigRecipe),ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]))=0) THEN
				Parameters := ParametersEdit;
			END_IF
		END_IF
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipeXml_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipeXml_0.Save := TRUE;
		END_IF
		hmiRecipe.Commands.SaveSelectedRecipe := FALSE;
	END_IF
	
//	IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
//		
//	ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
//		
//	END_IF

	IF hmiRecipe.Commands.CreateRecipe THEN
		ParametersPreview := ParametersEdit;
		MpRecipeUIConnect.New.Create := TRUE;
		hmiRecipe.Commands.CreateRecipe := FALSE;
	END_IF
	
	
//	IF beginEdit THEN
//		ParametersEdit := ParametersPreview;
//		beginEdit := FALSE;
//	END_IF
	
	
//	IF hmiRecipe.Commands.SaveSelectedRecipe THEN
//		
//		previousRecipe := hmiRecipe.Status.FileName;
//		hmiRecipe.Status.FileName := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
//		hmiRecipe.Commands.SaveCurrentRecipe := TRUE;
//		hmiRecipe.Commands.SaveSelectedRecipe := FALSE;
//	END_IF
	
		
	
	
	
    FileCopyOperation;
    
    (* Error reset *)
    IF NOT MpRecipeXml_0.Error THEN
        MpRecipeXml_0.ErrorReset := FALSE;
    END_IF
    
    IF NOT MpRecipeUI_0.Error THEN
        MpRecipeUI_0.ErrorReset := FALSE;
    END_IF
	
    MpRecipeXml_0();
    MpRecipeUI_0();
//    MpRecipeXml_Preview();
	MpFileManagerUI_0();
//	MpRecipeRegPar_mcfg();
//	MpRecipeRegPar_par();
//	MpRecipeRegPar_mcfgPreview1();
//	MpRecipeRegPar_parPreview1();
//	MpRecipeRegPar_mcfgPreview2();
//	MpRecipeRegPar_parPreview2();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();
END_PROGRAM

PROGRAM _EXIT
	(* Reset function blocks to unlink mapp links *)
	MpRecipeXml_0.Enable := FALSE;
	MpRecipeUI_0.Enable := FALSE;
	//	MpRecipeXml_Preview.Enable := FALSE;
	MpRecipeRegPar_PreviewPar.Enable := FALSE;
	MpRecipeRegPar_PreviewCfg.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpRecipeXml_0();
	MpRecipeUI_0();
	//	MpRecipeXml_Preview();
	MpRecipeRegPar_PreviewPar();
	MpRecipeRegPar_PreviewCfg();
	MpFileManagerUI_0();
END_PROGRAM

