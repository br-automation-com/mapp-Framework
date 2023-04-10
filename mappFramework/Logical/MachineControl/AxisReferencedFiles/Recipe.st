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

	// HMI support handling
	IF (AxisRecipe.EditDialogOpened OR AxisRecipe.CreateDialogOpened) THEN
		IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Product')) = 0) THEN
			ParametersEdit := ParametersPreview;
		ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Machine')) = 0) THEN
			MachineSettingsEdit := MachineSettingsPreview;
		END_IF
		AxisRecipe.EditDialogOpened := FALSE;
		AxisRecipe.CreateDialogOpened := FALSE;
	END_IF

	CASE AxisRecipe.State OF
		// Wait state
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
		// Create recipe state
		REC_AXIS_CREATE:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Product')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Machine')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;
		// Load recipe state
		REC_AXIS_LOAD:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Product')) = 0) THEN
				AxisControl.Parameters := ParametersPreview;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Machine')) = 0) THEN
				MachineSettings := MachineSettingsPreview;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;
		// Save recipe state
		REC_AXIS_SAVE:
			IF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Product')) = 0) THEN
				ParametersPreview := ParametersEdit;
			ELSIF (brsstrcmp(ADR(AxisRecipe.CategoryDropdown), ADR('Machine')) = 0) THEN
				MachineSettingsPreview := MachineSettingsEdit;
			END_IF
			AxisRecipe.State := REC_AXIS_WAIT;

	END_CASE;

	// Cyclic function block calls
	MpRecipeRegPar_Par.MpLink := ADR(gMpLinkRecipeXml);
	IF (AxisControl.Status.ProductSettingsName = '') THEN
		AxisControl.Status.ProductSettingsName := AxisControl.Status.TaskName;
		brsstrcat(ADR(AxisControl.Status.ProductSettingsName), ADR(':ParametersPreview'));
	END_IF
	MpRecipeRegPar_Par.PVName := ADR(AxisControl.Status.ProductSettingsName);
	MpRecipeRegPar_Par.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegPar_Par();

	MpRecipeRegPar_Cfg.MpLink := ADR(gMpLinkRecipeXml);
	IF (AxisControl.Status.MachineSettingsName = '') THEN
		AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
		brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettingsPreview'));
	END_IF
    
	MpRecipeRegPar_Cfg.PVName := ADR(AxisControl.Status.MachineSettingsName);
	MpRecipeRegPar_Cfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpRecipeRegPar_Cfg();

END_ACTION