ACTION FormatDeviceDataProvider:
    
	// Select CF device if USB device is not available
	FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
		IF gUSBAvailable[Index] THEN
			HmiRecipe.Parameters.DeviceDataProvider[Index + 1] := '{"value":"USB';
			brsitoa(Index + 1, ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]), ADR('","text":"USB'));
			brsitoa(Index + 1, ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1])));
			brsstrcat(ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]), ADR('"}'));
			brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), ADR('USB'));
			brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1])));
		ELSE
			brsmemset(ADR(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]), 0, SIZEOF(HmiRecipe.Parameters.DeviceDataProvider[Index + 1]));
			brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]));
		END_IF
	END_FOR
	
	// Configure visible recipe list
	HmiRecipe.Parameters.TableConfig := '{ "specRows": [{"from":';
	brsitoa(MpRecipeUIConnect.Recipe.List.MaxSelection + 1, ADR(HmiRecipe.Parameters.TableConfig) + brsstrlen(ADR(HmiRecipe.Parameters.TableConfig)));
	brsstrcat(ADR(HmiRecipe.Parameters.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    
END_ACTION

ACTION LoadPreview:

	// Load preview when a recipe is selected
	IF (MpRecipeUIConnect.Recipe.List.SelectedIndex <> HmiRecipe.Status.LastSelectedIndex) THEN
		// Check selected recipe name is not empty
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipe_0.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipe_0.Category := ADR(HmiRecipe.Status.CategoryDropdown);
			MpRecipe_0.Load := TRUE;
			HmiRecipe.Status.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
		END_IF
	END_IF

	// Reset load command on MpRecipe_Pre FUB
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
			END_IF
	
		REC_HMI_CREATE:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Parameters')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
			MpRecipeUIConnect.New.Create := TRUE;
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
		REC_HMI_LOAD:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Parameters')) = 0) THEN
				Parameters := ParametersPreview;
				HmiRecipe.Status.LastLoadedProductRecipe := HmiRecipe.Status.ActiveRecipe;
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettings := MachineSettingsPreview;
				HmiRecipe.Status.LastLoadedConfigRecipe := HmiRecipe.Status.ActiveRecipe;
			END_IF
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
		REC_HMI_SAVE:
			IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Parameters')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
	
			IF (brsstrlen(ADR(HmiRecipe.Status.ActiveRecipe)) > 0) THEN
				MpRecipe_0.FileName := ADR(HmiRecipe.Status.ActiveRecipe);
				MpRecipe_0.Save := TRUE;
			END_IF
			HmiRecipe.Status.HMIcommand := REC_HMI_WAIT;
	
	END_CASE
	
	IF NOT MpRecipe_0.CommandBusy AND brsstrcmp(ADR(PreviousRecipe),ADR(HmiRecipe.Parameters.FileName)) <> 0 THEN
		HmiRecipe.Parameters.FileName := PreviousRecipe;
	END_IF
	
	// If the Edit or Create dialog boxes open, copy the Preview structure into the Edit structure. 
	IF HmiRecipe.Status.EditDialogOpened OR HmiRecipe.Status.CreateDialogOpened THEN
		IF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Parameters')) = 0) THEN
			ParametersEdit := ParametersPreview;
			MpRecipeUIConnect.New.FileName := 'newParameters.par';
		ELSIF (brsstrcmp(ADR(HmiRecipe.Status.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
			MachineSettingsEdit := MachineSettingsPreview;
			MpRecipeUIConnect.New.FileName := 'newMachConfig.mcfg';
		END_IF
		HmiRecipe.Status.EditDialogOpened := FALSE;
		HmiRecipe.Status.CreateDialogOpened := FALSE;
	END_IF
	
	HmiRecipe.Status.LastStatus := MpRecipeUIConnect.Status;
	HmiRecipe.Status.ActiveRecipe := MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex];

END_ACTION