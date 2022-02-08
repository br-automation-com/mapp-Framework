
ACTION FormatDeviceDataProvider: 
    
	// Select CF device if USB device is not available 
	FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
		IF gbUSBAvail[Index] THEN
//			brsstrcpy(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]), ADR('{"value":"USB'));
			hmiRecipe.Status.DeviceDataProvider[Index + 1] := '{"value":"USB';
			brsitoa(Index + 1, ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]), ADR('","text":"USB'));
			brsitoa(Index + 1, ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]), ADR('"}'));
			brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), ADR('USB'));
			brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1])));
		ELSE
			brsmemset(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]), 0, SIZEOF(hmiRecipe.Status.DeviceDataProvider[Index + 1]));
			brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]));	
		END_IF
	END_FOR
    
	// Configure visible recipe list 
//	brsstrcpy(ADR(hmiRecipe.Status.TableConfig), ADR('{ "specRows": [{"from":'));
	hmiRecipe.Status.TableConfig := '{ "specRows": [{"from":';
	brsitoa(MpRecipeUIConnect.Recipe.List.MaxSelection + 1, ADR(hmiRecipe.Status.TableConfig) + brsstrlen(ADR(hmiRecipe.Status.TableConfig)));
	brsstrcat(ADR(hmiRecipe.Status.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    
END_ACTION

ACTION LoadPreview:

	// Load preview when a recipe is selected 
//	IF ((MpRecipeUIConnect.Recipe.List.SelectedIndex <> hmiRecipe.Status.LastSelectedIndex) AND (MpRecipeXml_Preview.Active = TRUE)) THEN
	IF (MpRecipeUIConnect.Recipe.List.SelectedIndex <> hmiRecipe.Status.LastSelectedIndex) THEN
		(* Check selected recipe name is not empty *)
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
//			MpRecipeXml_Preview.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
//			MpRecipeXml_Preview.Load := TRUE;
			MpRecipeXml_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipeXml_0.Category := ADR(hmiRecipe.Status.CategoryDropdown);
			MpRecipeXml_0.Load := TRUE;
			hmiRecipe.Status.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
		END_IF
	END_IF

	// Reset load command on MpRecipe_Pre FUB 
//	IF ((MpRecipeXml_Preview.CommandDone = TRUE) OR (MpRecipeXml_Preview.Error = TRUE)) THEN
//		MpRecipeXml_Preview.Load := FALSE;
//	END_IF;
	IF ((MpRecipeXml_0.CommandDone = TRUE) OR (MpRecipeXml_0.Error = TRUE)) THEN
		MpRecipeXml_0.Load := FALSE;
	END_IF;

END_ACTION

ACTION RecipeHMIcommands:
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
			MpRecipeUIConnect.New.FileName := 'newParameters.par';
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsEdit := MachSettingsPreview;
			MpRecipeUIConnect.New.FileName := 'newMachConfig.mcfg';
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
				MachSettings := MachSettingsEdit;
			END_IF
		END_IF
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipeXml_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipeXml_0.Save := TRUE;
		END_IF
		hmiRecipe.Commands.SaveSelectedRecipe := FALSE;
	END_IF
	
	IF hmiRecipe.Commands.CreateRecipe THEN
		IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
			ParametersPreview := ParametersEdit;
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsPreview := MachSettingsEdit;
		END_IF
		MpRecipeUIConnect.New.Create := TRUE;
		hmiRecipe.Commands.CreateRecipe := FALSE;
	END_IF
	
	//	IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
	//		
	//	ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
	//		
	//	END_IF
	

END_ACTION