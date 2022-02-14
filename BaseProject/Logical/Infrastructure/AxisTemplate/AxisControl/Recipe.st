
ACTION RecipeInit: 

    // Register machine settings to MpRecipe 
    MpRecipeRegPar_MachineFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_MachineFB.Enable := TRUE;
    MpRecipeRegPar_MachineFB.Category := ADR('Machine');
    AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
    brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettings'));
    MpRecipeRegPar_MachineFB.PVName := ADR(AxisControl.Status.MachineSettingsName);
    
    MpRecipeRegPar_UserFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_UserFB.Enable := TRUE;
    MpRecipeRegPar_UserFB.Category := ADR('Product');
    AxisControl.Status.ProductSettingsName:= AxisControl.Status.TaskName;
    brsstrcat(ADR(AxisControl.Status.ProductSettingsName), ADR(':AxisControl.Parameters'));
    MpRecipeRegPar_UserFB.PVName := ADR(AxisControl.Status.ProductSettingsName);
    
    MpRecipeRegPar_PreFB.MpLink := ADR(gRecipeXmlPreviewMpLink);
    MpRecipeRegPar_PreFB.Enable := TRUE;
    MpRecipeRegPar_PreFB.Category := ADR('Preview');
    AxisControl.Status.ProductPreviewSettingsName := AxisControl.Status.TaskName;
    brsstrcat(ADR(AxisControl.Status.ProductPreviewSettingsName), ADR(':PreviewParameters'));
    MpRecipeRegPar_PreFB.PVName := ADR(AxisControl.Status.ProductPreviewSettingsName);

    MpRecipeRegPar_UserPreFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_UserPreFB.Enable := TRUE;
    MpRecipeRegPar_UserPreFB.Category := ADR('Product');
    MpRecipeRegPar_UserPreFB.PVName := ADR(AxisControl.Status.ProductPreviewSettingsName);
    
    // Activate RegPar FUBs 
    WHILE NOT MpRecipeRegPar_MachineFB.Active AND NOT MpRecipeRegPar_MachineFB.Error DO
        MpRecipeRegPar_MachineFB();
    END_WHILE
    
    WHILE NOT MpRecipeRegPar_UserFB.Active AND NOT MpRecipeRegPar_UserFB.Error DO
        MpRecipeRegPar_UserFB();
    END_WHILE
    
    WHILE NOT MpRecipeRegPar_PreFB.Active AND NOT MpRecipeRegPar_PreFB.Error DO
        MpRecipeRegPar_PreFB();
    END_WHILE
    
    WHILE NOT MpRecipeRegPar_UserPreFB.Active AND NOT MpRecipeRegPar_UserPreFB.Error DO
        MpRecipeRegPar_UserPreFB();
    END_WHILE
    
END_ACTION

ACTION RecipeCyclic:
	
    // Copy preview parameters before creating or saving a recipe 
    IF AxisControl.Command.UpdatePreviewParameters THEN
        PreviewParameters := AxisControl.Parameters;
        AxisControl.Command.UpdatePreviewParameters := FALSE;
    END_IF
    
    IF AxisControl.Command.ResetEditParameters THEN
        AxisControl.Parameters := PreviewParameters;
        AxisControl.Command.ResetEditParameters := FALSE;
    END_IF

    MpRecipeRegPar_MachineFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_MachineFB();

    MpRecipeRegPar_UserFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_UserFB();

    MpRecipeRegPar_PreFB.MpLink := ADR(gRecipeXmlPreviewMpLink);
    MpRecipeRegPar_PreFB();

    MpRecipeRegPar_UserPreFB.MpLink := ADR(gRecipeXmlMpLink);
    MpRecipeRegPar_UserPreFB();
    
END_ACTION