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
	
	MpRecipeXml_Preview.MpLink := ADR(gRecipeXmlPreviewMpLink);
	MpRecipeXml_Preview.Enable := TRUE;
	MpRecipeXml_Preview.Category := ADR('Preview');
	MpRecipeXml_Preview.DeviceName := ADR('mappRecipe');
	
	MpRecipeUISetup.Confirmation.RecipeDelete := TRUE;
	MpRecipeUISetup.RecipeListSize := 10;
	MpRecipeUISetup.RecipeListScrollWindow := 0;
	MpRecipeUISetup.AutoLoadHeader := TRUE;
	MpRecipeUIConnect.New.FileName := 'newRecipe.xml';
	MpRecipeUIConnect.Recipe.Filter := '*par';
	MpRecipeUI_0.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);
	MpRecipeUI_0.UISetup := MpRecipeUISetup;

	(* Activate component *)
	WHILE NOT (MpRecipeXml_0.Active OR MpRecipeXml_0.Error) DO
		MpRecipeXml_0();
	END_WHILE;
	
	MpRecipeRegPar_mcfg.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_mcfg.Enable := TRUE;
	MpRecipeRegPar_mcfg.PVName := ADR('RecipeMgt:MachSettings');
	MpRecipeRegPar_mcfg.Category := ADR(MACHINE_CATEGORY);
	MpRecipeRegPar_mcfg();
	
	MpRecipeRegPar_par.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_par.Enable := TRUE;
	MpRecipeRegPar_par.PVName := ADR('RecipeMgt:Parameters');
	MpRecipeRegPar_par.Category := ADR(PRODUCT_CATEGORY); 
	MpRecipeRegPar_par();
	
	MpRecipeRegPar_mcfgPreview1.MpLink := ADR(gRecipeXmlPreviewMpLink);
	MpRecipeRegPar_mcfgPreview1.Enable := TRUE;
	MpRecipeRegPar_mcfgPreview1.PVName := ADR('RecipeMgt:MachSettingsPreview');
	MpRecipeRegPar_mcfgPreview1.Category := ADR(PREVIEW_CATEGORY); 
	MpRecipeRegPar_mcfgPreview1();
	
	MpRecipeRegPar_parPreview1.MpLink := ADR(gRecipeXmlPreviewMpLink);
	MpRecipeRegPar_parPreview1.Enable := TRUE;
	MpRecipeRegPar_parPreview1.PVName := ADR('RecipeMgt:ParametersPreview');
	MpRecipeRegPar_parPreview1.Category := ADR(PREVIEW_CATEGORY); 
	MpRecipeRegPar_parPreview1();
	
	MpRecipeRegPar_mcfgPreview2.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_mcfgPreview2.Enable := TRUE;
	MpRecipeRegPar_mcfgPreview2.PVName := ADR('RecipeMgt:MachSettingsPreview');
	MpRecipeRegPar_mcfgPreview2.Category := ADR(MACHINE_CATEGORY); 
	MpRecipeRegPar_mcfgPreview2();
	
	MpRecipeRegPar_parPreview2.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_parPreview2.Enable := TRUE;
	MpRecipeRegPar_parPreview2.PVName := ADR('RecipeMgt:ParametersPreview');
	MpRecipeRegPar_parPreview2.Category := ADR(PRODUCT_CATEGORY); 
	MpRecipeRegPar_parPreview2();

	(* Activate RegPar FUBs *)
	WHILE NOT MpRecipeRegPar_mcfg.Active AND NOT MpRecipeRegPar_mcfg.Error DO
		MpRecipeRegPar_mcfg();
	END_WHILE
	WHILE NOT MpRecipeRegPar_par.Active AND NOT MpRecipeRegPar_par.Error DO
		MpRecipeRegPar_par();
	END_WHILE
	WHILE NOT MpRecipeRegPar_mcfgPreview1.Active AND NOT MpRecipeRegPar_mcfgPreview1.Error DO
		MpRecipeRegPar_mcfgPreview1();
	END_WHILE
	WHILE NOT MpRecipeRegPar_parPreview1.Active AND NOT MpRecipeRegPar_parPreview1.Error DO
		MpRecipeRegPar_parPreview1();
	END_WHILE
	WHILE NOT MpRecipeRegPar_mcfgPreview2.Active AND NOT MpRecipeRegPar_mcfgPreview2.Error DO
		MpRecipeRegPar_mcfgPreview2();
	END_WHILE
	WHILE NOT MpRecipeRegPar_parPreview2.Active AND NOT MpRecipeRegPar_parPreview2.Error DO
		MpRecipeRegPar_parPreview2();
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
	
//	IF beginEdit THEN
//		ParametersEdit := ParametersPreview;
//		beginEdit := FALSE;
//	END_IF
	
	
	IF hmiRecipe.Commands.SaveSelectedRecipe THEN
		
		previousRecipe := hmiRecipe.Status.FileName;
		hmiRecipe.Status.FileName := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
		hmiRecipe.Commands.SaveCurrentRecipe := TRUE;
		hmiRecipe.Commands.SaveSelectedRecipe := FALSE;
	END_IF
	
		
	
	
	
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
    MpRecipeXml_Preview();
	MpFileManagerUI_0();
	MpRecipeRegPar_mcfg();
	MpRecipeRegPar_par();
	MpRecipeRegPar_mcfgPreview1();
	MpRecipeRegPar_parPreview1();
	MpRecipeRegPar_mcfgPreview2();
	MpRecipeRegPar_parPreview2();

END_PROGRAM

PROGRAM _EXIT
	(* Reset function blocks to unlink mapp links *)
	MpRecipeXml_0.Enable := FALSE;
	MpRecipeUI_0.Enable := FALSE;
	MpRecipeXml_Preview.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpRecipeXml_0();
	MpRecipeUI_0();
	MpRecipeXml_Preview();
	MpFileManagerUI_0();
END_PROGRAM

