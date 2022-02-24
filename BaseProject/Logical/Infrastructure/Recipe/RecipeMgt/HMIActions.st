ACTION FormatDeviceDataProvider: 
    
	// Select CF device if USB device is not available 
	FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
		IF gbUSBAvail[Index] THEN
			hmiRecipe.Parameters.DeviceDataProvider[Index + 1] := '{"value":"USB';
			brsitoa(Index + 1, ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]), ADR('","text":"USB'));
			brsitoa(Index + 1, ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]), ADR('"}'));
			brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), ADR('USB'));
			brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1])));
		ELSE
			brsmemset(ADR(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]), 0, SIZEOF(hmiRecipe.Parameters.DeviceDataProvider[Index + 1]));
			brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]));	
		END_IF
	END_FOR
	
	// Configure visible recipe list 
	hmiRecipe.Parameters.TableConfig := '{ "specRows": [{"from":';
	brsitoa(MpRecipeUIConnect.Recipe.List.MaxSelection + 1, ADR(hmiRecipe.Parameters.TableConfig) + brsstrlen(ADR(hmiRecipe.Parameters.TableConfig)));
	brsstrcat(ADR(hmiRecipe.Parameters.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    
END_ACTION

ACTION LoadPreview:

	// Load preview when a recipe is selected 
	IF (MpRecipeUIConnect.Recipe.List.SelectedIndex <> hmiRecipe.Parameters.LastSelectedIndex) THEN
		// Check selected recipe name is not empty 
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipe_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipe_0.Category := ADR(hmiRecipe.Parameters.CategoryDropdown);
			MpRecipe_0.Load := TRUE;
			hmiRecipe.Parameters.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
		END_IF
	END_IF

	// Reset load command on MpRecipe_Pre FUB 
	IF ((MpRecipe_0.CommandDone = TRUE) OR (MpRecipe_0.Error = TRUE)) THEN
		MpRecipe_0.Load := FALSE;
	END_IF;

END_ACTION

ACTION RecipeHMIcommands:
	
	CASE hmiRecipe.Status.HMIcommand OF
		REC_HMI_WAIT:
			IF hmiRecipe.Commands.LoadRecipe THEN 
				hmiRecipe.Status.HMIcommand := REC_HMI_LOAD;
				hmiRecipe.Commands.LoadRecipe := FALSE;
			ELSIF hmiRecipe.Commands.SaveSelectedRecipe THEN
				hmiRecipe.Status.HMIcommand := REC_HMI_SAVE;
				hmiRecipe.Commands.SaveSelectedRecipe := FALSE;
			ELSIF hmiRecipe.Commands.CreateRecipe THEN
				hmiRecipe.Status.HMIcommand := REC_HMI_CREATE;
				hmiRecipe.Commands.CreateRecipe := FALSE;
			ELSIF hmiRecipe.Commands.StoreMachineSettings THEN
				hmiRecipe.Status.HMIcommand := REC_HMI_STORE_MACH_SETTINGS;
				hmiRecipe.Commands.StoreMachineSettings := FALSE;
			ELSIF hmiRecipe.Commands.FactoryResetMachineSettings THEN
				hmiRecipe.Status.HMIcommand := REC_HMI_FACTORY_RESET;
				hmiRecipe.Commands.FactoryResetMachineSettings := FALSE;
			END_IF
		
		REC_HMI_LOAD:
			IF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Product')) = 0) THEN
				Parameters := ParametersPreview;
				hmiRecipe.Parameters.LastLoadedProductRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
			ELSIF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Machine')) = 0) THEN
				MachSettings := MachSettingsPreview;
				hmiRecipe.Parameters.LastLoadedConfigRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];
			END_IF
			hmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
		
		REC_HMI_SAVE:
			IF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Product')) = 0) THEN
				ParametersPreview := ParametersEdit;
				IF (brsstrcmp(ADR(hmiRecipe.Parameters.LastLoadedProductRecipe),ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]))=0) THEN
					Parameters := ParametersEdit;
				END_IF
			ELSIF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Machine')) = 0) THEN
				MachSettingsPreview := MachSettingsEdit;
				IF (brsstrcmp(ADR(hmiRecipe.Parameters.LastLoadedConfigRecipe),ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]))=0) THEN
					MachSettings := MachSettingsEdit;
				END_IF
			END_IF
			IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
				MpRecipe_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
				MpRecipe_0.Save := TRUE;
			END_IF
			hmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
		
		REC_HMI_CREATE:
			IF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Product')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Machine')) = 0) THEN
				MachSettingsPreview := MachSettingsEdit;
			END_IF
			MpRecipeUIConnect.New.Create := TRUE;
			hmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
		
		REC_HMI_STORE_MACH_SETTINGS:
			brsstrcpy(ADR(hmiRecipe.Parameters.Category), ADR(MACHINE_CATEGORY));
			brsstrcpy(ADR(hmiRecipe.Parameters.FileName), ADR(MACHINE_FILENAME));
			DTGetTime_0(enable := TRUE);
			Header.DateTime := DTGetTime_0.DT1;
			Header.Name := MACHINE_FILENAME;
			Header.Description := 'Machine Settings';
			MpRecipe_0.Save := TRUE;
			hmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
		
		REC_HMI_FACTORY_RESET:
			// Factory reset the machine settings 
			brsstrcpy(ADR(hmiRecipe.Parameters.Category), ADR(MACHINE_CATEGORY));
			brsstrcpy(ADR(hmiRecipe.Parameters.FileName), ADR(MACHINE_FILENAME));
			MpRecipe_0.Load := TRUE;
		
			IF MpRecipe_0.CommandDone THEN
				// Copy factory settings into Machine.mcfg file 
				hmiRecipe.Commands.FactoryResetMachineSettings := FALSE;
				hmiRecipe.Commands.StoreMachineSettings := TRUE;
			END_IF
	END_CASE;
	
	IF NOT MpRecipe_0.CommandBusy AND brsstrcmp(ADR(previousRecipe),ADR(hmiRecipe.Parameters.FileName)) <> 0 THEN
		hmiRecipe.Parameters.FileName := previousRecipe;
	END_IF
	
	IF hmiRecipe.Parameters.EditDialogOpened OR hmiRecipe.Parameters.CreateDialogOpened THEN
		IF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Product')) = 0) THEN
			ParametersEdit := ParametersPreview;
			MpRecipeUIConnect.New.FileName := 'newParameters.par';
		ELSIF (brsstrcmp(ADR(hmiRecipe.Parameters.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsEdit := MachSettingsPreview;
			MpRecipeUIConnect.New.FileName := 'newMachConfig.mcfg';
		END_IF
		hmiRecipe.Parameters.EditDialogOpened := FALSE;
		hmiRecipe.Parameters.CreateDialogOpened := FALSE;
	END_IF
	
END_ACTION