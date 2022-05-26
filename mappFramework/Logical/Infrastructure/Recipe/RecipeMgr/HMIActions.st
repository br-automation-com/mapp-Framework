ACTION FormatDeviceDataProvider:
    
	// Select CF device if USB device is not available
    FOR i := 0 TO ((SIZEOF(gUSBAvailable) / SIZEOF(gUSBAvailable[0])) - 1) DO
        IF gUSBAvailable[i] THEN
			HmiRecipe.Parameters.DeviceDataProvider[i + 1] := '{"value":"USB';
			brsitoa(i + 1, ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1]) + brsstrlen(ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1])));
			brsstrcat(ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1]), ADR('","text":"USB'));
			brsitoa(i + 1, ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1]) + brsstrlen(ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1])));
			brsstrcat(ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1]), ADR('"}'));
			MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1] := 'USB';
			brsitoa(i + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1])));
		ELSE
			brsmemset(ADR(HmiRecipe.Parameters.DeviceDataProvider[i + 1]), 0, SIZEOF(HmiRecipe.Parameters.DeviceDataProvider[i + 1]));
			brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]));
		END_IF
	END_FOR
	
	// Configure visible recipe list
	IF MpRecipeUIConnect.Recipe.List.Names[0] = '' THEN
		HmiRecipe.Parameters.TableConfig := '{ "specRows": [{"from":0,"to":19, "visible":false}]}';
	ELSE
		HmiRecipe.Parameters.TableConfig := '{ "specRows": [{"from":';
		brsitoa(MpRecipeUIConnect.Recipe.List.MaxSelection + 1, ADR(HmiRecipe.Parameters.TableConfig) + brsstrlen(ADR(HmiRecipe.Parameters.TableConfig)));
		brsstrcat(ADR(HmiRecipe.Parameters.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    END_IF
	
	HmiRecipe.Status.FilesAvailable := (MpRecipeUIConnect.Recipe.List.Names[0] <> '');
	
END_ACTION

ACTION LoadPreview:

	// Load preview when a recipe is selected
	IF (MpRecipeUIConnect.Recipe.List.SelectedIndex <> HmiRecipe.Status.LastSelectedIndex) OR (HmiRecipe.Status.LastMaxSelection <> MpRecipeUIConnect.Recipe.List.MaxSelection) THEN
		// Check selected recipe name is not empty
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipe_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipe_0.Category := ADR(HmiRecipe.Status.CategoryDropdown);
			MpRecipe_0.Load := TRUE;
			HmiRecipe.Status.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
			HmiRecipe.Status.LastMaxSelection := MpRecipeUIConnect.Recipe.List.MaxSelection;
			HmiRecipe.Status.InvalidRecipe := FALSE;
		END_IF
	END_IF
	
	// Reset load command on MpRecipe_0 FUB
	IF MpRecipe_0.StatusID <> 0 THEN
		HmiRecipe.Status.InvalidRecipe := TRUE;
		HmiRecipe.Commands.ResetPreview := TRUE;
	END_IF;
	
	IF ((MpRecipe_0.CommandDone = TRUE) OR (MpRecipe_0.Error = TRUE)) THEN
		MpRecipe_0.Load := FALSE;
	END_IF

END_ACTION

ACTION RecipeHMIcommands:
    
	CASE HmiRecipe.Status.HMIcommand OF
		REC_HMI_WAIT:
			// The following commands are triggered directly from the HMI. If you imported the mapp View front end of
			// the Framework, then this is already taken care of. If you did not, then your visualization must 
			// trigger each one of these command variables (CreateRecipe, SaveSelectedRecipe, LoadRecipe). 
			IF HmiRecipe.Commands.CreateRecipe THEN
				HmiRecipe.Status.HMIcommand := REC_HMI_CREATE;
				HmiRecipe.Commands.CreateRecipe := FALSE;
			ELSIF HmiRecipe.Commands.SaveSelectedRecipe THEN
				HmiRecipe.Status.HMIcommand := REC_HMI_SAVE;
				HmiRecipe.Commands.SaveSelectedRecipe := FALSE;
			ELSIF HmiRecipe.Commands.LoadRecipe THEN
				HmiRecipe.Status.HMIcommand := REC_HMI_LOAD;
				HmiRecipe.Commands.LoadRecipe := FALSE;
			ELSIF HmiRecipe.Commands.ResetPreview THEN
				HmiRecipe.Status.HMIcommand := REC_HMI_RESET_PREVIEW;
				HmiRecipe.Commands.ResetPreview := FALSE;
			END_IF
	
		REC_HMI_CREATE:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
				ParametersPreview := ParametersEdit;
				brsstrcat(ADR(MpRecipeUIConnect.New.FileName),ADR('.par'));
				HmiRecipe.Parameters.Category := PARAMETERS_CATEGORY;
				// If the default recipe was initially missing and just now created, immediately load it
				IF HmiRecipe.Status.ParameterRecipeMissing THEN
					HmiRecipe.Commands.LoadRecipe := TRUE;
//					HmiRecipe.Status.ParameterRecipeMissing := FALSE;
				END_IF
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
				brsstrcat(ADR(MpRecipeUIConnect.New.FileName),ADR('.mcfg'));
				HmiRecipe.Parameters.Category := MACHINE_CONFIGURATION_CATEGORY;
				// If the default recipe was initially missing and just now created, immediately load it
				IF HmiRecipe.Status.MachineSettingsRecipeMissing THEN
					HmiRecipe.Commands.LoadRecipe := TRUE;
//					HmiRecipe.Status.MachineSettingsRecipeMissing := FALSE;
				END_IF
			END_IF
			
			Header.Name := MpRecipeUIConnect.New.FileName;
			DTGetTime_0.enable := TRUE;
			REPEAT
				DTGetTime_0();
				UNTIL  (DTGetTime_0.status = 0)
			END_REPEAT;
			Header.DateTime := DTGetTime_0.DT1;
			DTGetTime_0.enable := FALSE;
			DTGetTime_0();
			MpRecipeUIConnect.New.Create := TRUE;
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
		REC_HMI_LOAD:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
				Parameters := ParametersPreview;
				// If the default recipe was initially missing and just now created, then it is the last loaded recipe
				IF HmiRecipe.Status.ParameterRecipeMissing THEN
					HmiRecipe.Status.LastLoadedProductRecipe := DEFAULT_PARAMETERS;
					brsstrcat(ADR(HmiRecipe.Status.LastLoadedProductRecipe),ADR(PARAMETERS_FILE_EXTENSION));
					HmiRecipe.Status.ParameterRecipeMissing := FALSE;
				// Otherwise, the last loaded recipe is the selected recipe
				ELSE
					HmiRecipe.Status.LastLoadedProductRecipe := HmiRecipe.Status.SelectedRecipe;
				END_IF
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
				MachineSettings := MachineSettingsPreview;
				// If the default recipe was initially missing and just now created, then it is the last loaded recipe
				IF HmiRecipe.Status.MachineSettingsRecipeMissing THEN
					HmiRecipe.Status.LastLoadedConfigRecipe := DEFAULT_MACHINE_CONFIGURATION;
					brsstrcat(ADR(HmiRecipe.Status.LastLoadedConfigRecipe),ADR(MACHINE_CONFIG_FILE_EXTENSION));
					HmiRecipe.Status.MachineSettingsRecipeMissing := FALSE;
				// Otherwise, the last loaded recipe is the selected recipe
				ELSE
					HmiRecipe.Status.LastLoadedConfigRecipe := HmiRecipe.Status.SelectedRecipe;
				END_IF
			END_IF
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
		REC_HMI_SAVE:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
				ParametersPreview := ParametersEdit;
	        ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
                MachineSettingsPreview := MachineSettingsEdit;
            END_IF
	
			IF (brsstrlen(ADR(HmiRecipe.Status.SelectedRecipe)) > 0) THEN
				MpRecipe_0.FileName := ADR(HmiRecipe.Status.SelectedRecipe);
				MpRecipe_0.Save := TRUE;
			END_IF
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
		
		REC_HMI_RESET_PREVIEW:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
				brsmemset(ADR(ParametersPreview),0,SIZEOF(ParametersPreview));
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
				brsmemset(ADR(MachineSettingsPreview),0,SIZEOF(MachineSettingsPreview));
			END_IF
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
	END_CASE
	
	IF NOT MpRecipe_0.CommandBusy AND brsstrcmp(ADR(HmiRecipe.Status.PreviousRecipe), ADR(HmiRecipe.Parameters.FileName)) <> 0 THEN
		HmiRecipe.Parameters.FileName := HmiRecipe.Status.PreviousRecipe;
	END_IF
	
	// If the Edit or Create dialog boxes open, copy the Preview structure into the Edit structure. 
	IF HmiRecipe.Status.EditDialogOpened OR HmiRecipe.Status.CreateDialogOpened THEN
		IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
			ParametersEdit := ParametersPreview;
			IF HmiRecipe.Status.ParameterRecipeMissing THEN
				MpRecipeUIConnect.New.FileName := DEFAULT_PARAMETERS;
				//HmiRecipe.Status.ParameterRecipeMissing := FALSE;////////////////////////////////////////////////////////////
			ELSE
				MpRecipeUIConnect.New.FileName := 'newParameters';
			END_IF
		ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
			MachineSettingsEdit := MachineSettingsPreview;
			IF HmiRecipe.Status.MachineSettingsRecipeMissing THEN
				MpRecipeUIConnect.New.FileName := DEFAULT_MACHINE_CONFIGURATION;
				//HmiRecipe.Status.MachineSettingsRecipeMissing := FALSE;;////////////////////////////////////////////////////////////
			ELSE
				MpRecipeUIConnect.New.FileName := 'newMachineConfig';
			END_IF
		END_IF
	
		HmiRecipe.Status.EditDialogOpened := FALSE;
		HmiRecipe.Status.CreateDialogOpened := FALSE;
	END_IF
		
	// Check if the file name has already been used
	HmiRecipe.Status.FileDuplicate := FALSE;
	FOR i:= 0 TO ((SIZEOF(MpRecipeUIConnect.Recipe.List.Names) / SIZEOF(MpRecipeUIConnect.Recipe.List.Names[0])) - 1) DO
		temp := MpRecipeUIConnect.New.FileName;
		IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(PARAMETERS_RECIPE)) = 0) THEN
			brsstrcat(ADR(temp),ADR('.par'));
		ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown), ADR(MACHINE_CONFIGURATION_RECIPE)) = 0) THEN
			brsstrcat(ADR(temp),ADR('.mcfg'));
		END_IF
		IF temp = MpRecipeUIConnect.Recipe.List.Names[i] THEN
			HmiRecipe.Status.FileDuplicate := TRUE;
		END_IF
	END_FOR	
	
	// Set whether the loading .gif should be shown on the HMI
	IF MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_REFRESH THEN
		HmiRecipe.Status.LoadingRecipeList := TRUE;
	ELSE
		HmiRecipe.Status.LoadingRecipeList := FALSE;
	END_IF
	
	// Update status information
	HmiRecipe.Status.LastStatus := MpRecipeUIConnect.Status;
	HmiRecipe.Status.SelectedRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];

END_ACTION
