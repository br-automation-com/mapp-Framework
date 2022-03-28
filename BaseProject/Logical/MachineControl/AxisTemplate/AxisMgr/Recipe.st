ACTION RecipeInit:

    // Register the variables with the recipe system
    AxisControl.Status.ProductSettingsName := AxisControl.Status.TaskName;
    brsstrcat(ADR(AxisControl.Status.ProductSettingsName), ADR(':ParametersPreview'));
    MpRecipeRegPar_Par.MpLink := ADR(gMpLinkRecipeXml);
    MpRecipeRegPar_Par.Enable := TRUE;
    MpRecipeRegPar_Par.PVName := ADR(AxisControl.Status.ProductSettingsName);
    MpRecipeRegPar_Par.Category := ADR(PARAMETERS_CATEGORY);
    MpRecipeRegPar_Par();
    ParametersPreview;
    ParametersEdit;
    
    AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
    brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettingsPreview'));
    MpRecipeRegPar_Cfg.MpLink := ADR(gMpLinkRecipeXml);
    MpRecipeRegPar_Cfg.Enable := TRUE;
    MpRecipeRegPar_Cfg.PVName := ADR(AxisControl.Status.MachineSettingsName);
    MpRecipeRegPar_Cfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
    MpRecipeRegPar_Cfg();
    MachineSettingsPreview;
    MachineSettingsEdit;

    // Activate RegPar FUBs
    WHILE NOT(MpRecipeRegPar_Par.Active OR MpRecipeRegPar_Par.Error) DO
        MpRecipeRegPar_Par();
    END_WHILE
    WHILE NOT(MpRecipeRegPar_Cfg.Active OR MpRecipeRegPar_Cfg.Error) DO
        MpRecipeRegPar_Cfg();
    END_WHILE
    
END_ACTION

ACTION RecipeCyclic:

	IF (AxisRecipe.EditDialogOpened OR AxisRecipe.CreateDialogOpened) THEN
		IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Parameters')) = 0) THEN
			ParametersEdit := ParametersPreview;
		ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
			MachineSettingsEdit := MachineSettingsPreview;
		END_IF
		AxisRecipe.EditDialogOpened := FALSE;
		AxisRecipe.CreateDialogOpened := FALSE;
	END_IF
	
	CASE AxisRecipe.State OF
		REC_AXIS_WAIT:
			IF AxisRecipe.CreateRecipe THEN
				AxisRecipe.State := REC_AXIS_CREATE;
				AxisRecipe.CreateRecipe := FALSE;
			ELSIF AxisRecipe.SaveRecipe THEN
				AxisRecipe.State := REC_AXIS_SAVE;
				AxisRecipe.SaveRecipe := FALSE;
			ELSIF AxisRecipe.LoadRecipe THEN
				AxisRecipe.State := REC_AXIS_LOAD;
				AxisRecipe.LoadRecipe := FALSE;
			END_IF
	
		REC_AXIS_CREATE:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Parameters')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;
	
		REC_AXIS_LOAD:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Parameters')) = 0) THEN
				AxisControl.Parameters := ParametersPreview;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettings := MachineSettingsPreview;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;
	
		REC_AXIS_SAVE:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Parameters')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown),ADR('Machine Configuration')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;
	
	END_CASE;

	MpRecipeRegPar_Par.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_Par();

	MpRecipeRegPar_Cfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_Cfg();
    
END_ACTION