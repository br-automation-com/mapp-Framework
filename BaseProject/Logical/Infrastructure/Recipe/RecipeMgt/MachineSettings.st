
ACTION MachineSettings:
    
	(* Handle recipe commands *)
    IF ((hmiRecipe.Commands.StoreFixData = TRUE) AND (MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE)) THEN
        (* Store fix data *)
        hmiRecipe.Commands.StoreFixData := FALSE;
        brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(MACHINE_CATEGORY));
        brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR(MACHINE_FILENAME));
        DTGetTime_0(enable := TRUE);
        Header.DateTime := DTGetTime_0.DT1;
        Header.Name := MACHINE_FILENAME;
        Header.Description := 'Machine Settings';
        MpRecipeXml_0.Save := TRUE;
    ELSIF ((hmiRecipe.Commands.FactoryResetFixData = TRUE) AND (MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE)) THEN
        (* Factory reset fixdata *)
        brsstrcpy(ADR(hmiRecipe.Intern.Category), ADR(MACHINE_CATEGORY));
        brsstrcpy(ADR(hmiRecipe.Intern.FileName), ADR(MACHINE_FILENAME));
        MpRecipeXml_0.Load := TRUE;
		
        IF MpRecipeXml_0.CommandDone THEN
            (* Copy factory data into Machine.fix file *)
            hmiRecipe.Commands.FactoryResetFixData := FALSE;
            hmiRecipe.Commands.StoreFixData := TRUE;
        END_IF
    END_IF
    
END_ACTION
