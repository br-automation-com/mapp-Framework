
ACTION RecipeInit:

    // register the variables with the recipe system
//    AxisControl.Status.ProductSettingsName := AxisControl.Status.TaskName;
//    brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':ParametersPreview'));
//    MpRecipeRegPar_Par.MpLink := ADR(gRecipeXmlMpLink);
//    MpRecipeRegPar_Par.Enable := TRUE;
//    MpRecipeRegPar_Par.PVName := ADR(AxisControl.Status.ProductSettingsName);
//    MpRecipeRegPar_Par.Category := ADR(PRODUCT_CATEGORY); 
//    MpRecipeRegPar_Par();
//	
//    AxisControl.Status.MachineSettingsName := AxisControl.Status.TaskName;
//    brsstrcat(ADR(AxisControl.Status.MachineSettingsName), ADR(':MachineSettingsPreview'));
//    MpRecipeRegPar_Cfg.MpLink := ADR(gRecipeXmlMpLink);
//    MpRecipeRegPar_Cfg.Enable := TRUE;
//    MpRecipeRegPar_Cfg.PVName := ADR(AxisControl.Status.MachineSettingsName);
//    MpRecipeRegPar_Cfg.Category := ADR(MACHINE_CATEGORY); 
//    MpRecipeRegPar_Cfg();
//
//    // Activate RegPar FUBs 
//    WHILE NOT(MpRecipeRegPar_Par.Active OR MpRecipeRegPar_Par.Error) DO
//        MpRecipeRegPar_Par();
//    END_WHILE
//    WHILE NOT(MpRecipeRegPar_Cfg.Active OR MpRecipeRegPar_Cfg.Error) DO
//        MpRecipeRegPar_Cfg();
//    END_WHILE
    
END_ACTION

ACTION RecipeCyclic:
	
    // Copy preview parameters before creating or saving a recipe 
//    IF AxisControl.Command.UpdatePreviewParameters THEN
//        ParametersPreview := AxisControl.Parameters;
//        AxisControl.Command.UpdatePreviewParameters := FALSE;
//    END_IF
//    
//    IF AxisControl.Command.ResetEditParameters THEN
//        AxisControl.Parameters := ParametersPreview;
//        AxisControl.Command.ResetEditParameters := FALSE;
//    END_IF
//
//    MpRecipeRegPar_Par.MpLink := ADR(gRecipeXmlMpLink);
//    MpRecipeRegPar_Par();
//
//    MpRecipeRegPar_Cfg.MpLink := ADR(gRecipeXmlMpLink);
//    MpRecipeRegPar_Cfg();
    
END_ACTION