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
	MpRecipeXml_0.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeXml_0.Enable := TRUE;
	MpRecipeXml_0.Category := ADR(hmiRecipe.Intern.Category);
	MpRecipeXml_0.DeviceName := ADR(hmiRecipe.Intern.DeviceName);
    MpRecipeXml_0.FileName := ADR(hmiRecipe.Intern.FileName);
    MpRecipeXml_0.Header := ADR(Header);

	MpRecipeXml_Pre.MpLink := ADR(gRecipeXmlPreviewMpLink);
	MpRecipeXml_Pre.Enable := TRUE;
	MpRecipeXml_Pre.Category := ADR('Preview');
	MpRecipeXml_Pre.DeviceName := ADR('mappRecipe');

	brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Intern.DeviceDataProvider[0]), ADR('{"value":"mappRecipe","text":"CF/PLC"}'));
	brsstrcpy(ADR(hmiRecipe.Intern.DeviceName), ADR('mappRecipe'));

	MpRecipeUI_0.MpLink := ADR(gRecipeXmlMpLink);
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.UIConnect := ADR(MpRecipeUIConnect);

	(* Configure UI Connect *)
	MpRecipeUI_0.UISetup.Confirmation.RecipeDelete := TRUE;
	MpRecipeUI_0.UISetup.RecipeListSize := 10;
	MpRecipeUI_0.UISetup.RecipeListScrollWindow := 0;
	MpRecipeUI_0.UISetup.AutoLoadHeader := TRUE;

	(* Activate component *)
	WHILE NOT (MpRecipeXml_0.Active OR MpRecipeXml_0.Error) DO
		MpRecipeXml_0();
	END_WHILE;
	
	(* Load fix data *)
	brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(MACHINE_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR(MACHINE_FILENAME));
	MpRecipeXml_0.Load := TRUE;
	WHILE ((NOT MpRecipeXml_0.CommandDone) AND (NOT MpRecipeXml_0.Error)) DO
		MpRecipeXml_0();
    END_WHILE
    
	MpRecipeXml_0.ErrorReset := MpRecipeXml_0.Error;
	MpRecipeXml_0.Load := FALSE;
	MpRecipeXml_0();

	(* Load Default file *)
	brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY));
	brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR('Default.xml'));
    MpRecipeXml_0.Load := TRUE;
    WHILE ((NOT MpRecipeXml_0.CommandDone) AND (NOT MpRecipeXml_0.Error)) DO
		MpRecipeXml_0();
    END_WHILE
    
	brsstrcpy(ADR(hmiRecipe.Intern.LastLoadedRecipe), ADR(MpRecipeXml_0.Info.LastLoadedRecipe));
	MpRecipeXml_0.ErrorReset := MpRecipeXml_0.Error;
	MpRecipeXml_0.Load := FALSE;
	MpRecipeXml_0();

	(* Trigger update notification so that the initial parameters are copied to the process *)
	MpRecipeXml_0.UpdateNotification := TRUE;
	
	(* Init Filemanager for exporting/importing files *)
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gRecFileMgrUIMpLink);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[0]), ADR('mappRecipe'));
	brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[1]), ADR(''));
    brsstrcpy(ADR(MpFileManagerUIConnect.File.Filter), ADR('*.xml'));
    
END_PROGRAM

PROGRAM _CYCLIC

    FormatDeviceDataProvider;	
    LoadPreview;
    MachineSettings;
	
    (* Reset category after saving is done, category should be reset so that autosave files contain ALL the parameters *)
    IF EDGEPOS(MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE) AND
        ((NOT MpRecipeUIConnect.Recipe.Load) AND (NOT MpRecipeUIConnect.Recipe.Save)) THEN
        (* Check if 'Product' category has been loaded *)
        IF ((brsstrcmp(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY)) = 0) AND
            (hmiRecipe.Intern.LastStatus = mpRECIPE_UI_STATUS_LOAD)) THEN
            (* Copy loaded recipe name *)
            brsstrcpy(ADR(hmiRecipe.Intern.LastLoadedRecipe), ADR(MpRecipeXml_0.Info.LastLoadedRecipe));
            (* Set update notification *)
            MpRecipeXml_0.UpdateNotification := TRUE;
        END_IF
	
        (* Trigger a reload of the preview parameters *)
        hmiRecipe.Intern.LastSelectedIndex := hmiRecipe.Intern.LastSelectedIndex + 1;
        brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY));
    END_IF
    hmiRecipe.Intern.LastStatus := MpRecipeUIConnect.Status;

    (* Save current recipe *)
    IF (hmiRecipe.Commands.SaveCurrentRecipe = TRUE) AND NOT (MpRecipeXml_0.Load OR MpRecipeXml_0.Save OR MpRecipeXml_0.UpdateNotification) THEN
        brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR(hmiRecipe.Intern.LastLoadedRecipe));
        DTGetTime_0(enable := TRUE);
        Header.DateTime := DTGetTime_0.DT1;
        Header.Name := hmiRecipe.Intern.FileName;
        Header.Description := '';
        MpRecipeXml_0.Save := TRUE;
        //brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY));
        hmiRecipe.Commands.SaveCurrentRecipe := FALSE;
    END_IF
	
	(* Reset commands on MpRecipe FUB *)
	IF MpRecipeXml_0.CommandDone THEN
		(* Set update notification for machine category *)
		IF ((brsstrcmp(ADR(hmiRecipe.Intern.Category), ADR(MACHINE_CATEGORY)) = 0) AND (MpRecipeXml_0.Save = TRUE)) THEN
			MpRecipeXml_0.UpdateNotification := TRUE;
			MpRecipeXml_0.Load := FALSE;
			MpRecipeXml_0.Save := FALSE;
		ELSE
			MpRecipeXml_0.UpdateNotification := FALSE;
			MpRecipeXml_0.Load := FALSE;
			MpRecipeXml_0.Save := FALSE;
			brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(PRODUCT_CATEGORY));
			brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR('Default.xml'));
        END_IF
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
    MpRecipeXml_Pre();
    MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	(* Reset function blocks to unlink mapp links *)
    MpRecipeXml_0.Enable := FALSE;
    MpRecipeUI_0.Enable := FALSE;
    MpRecipeXml_Pre.Enable := FALSE;
    MpFileManagerUI_0.Enable := FALSE;
    MpRecipeXml_0();
    MpRecipeUI_0();
    MpRecipeXml_Pre();
    MpFileManagerUI_0();
END_PROGRAM

