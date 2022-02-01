
ACTION FormatDeviceDataProvider: 
    
	(* Select CF device if USB device is not available *)
	FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
		IF gbUSBAvail[Index] THEN
			brsstrcpy(ADR(hmiRecipe.Status.DeviceDataProvider[Index + 1]), ADR('{"value":"USB'));
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
    
	(* Configure visible recipe list *)
	brsstrcpy(ADR(hmiRecipe.Status.TableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpRecipeUIConnect.Recipe.List.MaxSelection + 1, ADR(hmiRecipe.Status.TableConfig) + brsstrlen(ADR(hmiRecipe.Status.TableConfig)));
	brsstrcat(ADR(hmiRecipe.Status.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    
END_ACTION

ACTION LoadPreview:

	(* Load preview when a recipe is selected *)
	IF ((MpRecipeUIConnect.Recipe.List.SelectedIndex <> hmiRecipe.Status.LastSelectedIndex) AND (MpRecipeXml_Preview.Active = TRUE)) THEN
		(* Check selected recipe name is not empty *)
		IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
			MpRecipeXml_Preview.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
			MpRecipeXml_Preview.Load := TRUE;
			hmiRecipe.Status.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
		END_IF
	END_IF

	(* Reset load command on MpRecipe_Pre FUB *)
	IF ((MpRecipeXml_Preview.CommandDone = TRUE) OR (MpRecipeXml_Preview.Error = TRUE)) THEN
		MpRecipeXml_Preview.Load := FALSE;
	END_IF;

END_ACTION

ACTION UpdatePreviewValues:
	
	IF hmiRecipe.Commands.UpdatePreviewParameters THEN
		IF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Product')) = 0) THEN
			ParametersPreview := Parameters;
		ELSIF (brsstrcmp(ADR(hmiRecipe.Status.CategoryDropdown),ADR('Machine')) = 0) THEN
			MachSettingsPreview := MachSettings;
		END_IF		
		hmiRecipe.Commands.UpdatePreviewParameters := FALSE;
	END_IF
END_ACTION