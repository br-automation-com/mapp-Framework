ACTION RecipeInit:

	// Register the variables with the recipe system
	AxisControl.Status.ProductSettingsName := AxisControl.Status.TaskName;
	brsstrcat(ADR(AxisControl.Status.ProductSettingsName), ADR(':ParametersPreview'));
	MpRecipeRegParPar.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegParPar.Enable := TRUE;
	MpRecipeRegParPar.PVName := ADR(AxisControl.Status.ProductSettingsName);
	MpRecipeRegParPar.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegParPar();
	ParametersPreview;
	ParametersEdit;

	AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
	brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettingsPreview'));
	MpRecipeRegParCfg.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegParCfg.Enable := TRUE;
	MpRecipeRegParCfg.PVName := ADR(AxisControl.Status.MachineSettingsName);
	MpRecipeRegParCfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpRecipeRegParCfg();
	MachineSettingsPreview;
	MachineSettingsEdit;

	// Activate RegPar FUBs
	WHILE NOT(MpRecipeRegParPar.Active OR MpRecipeRegParPar.Error) DO
		MpRecipeRegParPar();
	END_WHILE
	WHILE NOT(MpRecipeRegParCfg.Active OR MpRecipeRegParCfg.Error) DO
		MpRecipeRegParCfg();
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
	MpRecipeRegParPar.MpLink := ADR(gMpLinkRecipeXml);
	IF (AxisControl.Status.ProductSettingsName = '') THEN
		AxisControl.Status.ProductSettingsName := AxisControl.Status.TaskName;
		brsstrcat(ADR(AxisControl.Status.ProductSettingsName), ADR(':ParametersPreview'));
	END_IF
	MpRecipeRegParPar.PVName := ADR(AxisControl.Status.ProductSettingsName);
	MpRecipeRegParPar.Category := ADR(PARAMETERS_CATEGORY);
	MpRecipeRegParPar();

	MpRecipeRegParCfg.MpLink := ADR(gMpLinkRecipeXml);
	IF (AxisControl.Status.MachineSettingsName = '') THEN
		AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
		brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettingsPreview'));
	END_IF
	
	MpRecipeRegParCfg.PVName := ADR(AxisControl.Status.MachineSettingsName);
	MpRecipeRegParCfg.Category := ADR(MACHINE_CONFIGURATION_CATEGORY);
	MpRecipeRegParCfg();

END_ACTION