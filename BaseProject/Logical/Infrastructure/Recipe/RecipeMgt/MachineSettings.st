ACTION MachineSettings:
    
	// Handle recipe commands 
    IF ((hmiRecipe.Commands.StoreMachineSettings = TRUE) AND (MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE)) THEN
        // Store factory settings 
        hmiRecipe.Commands.StoreMachineSettings := FALSE;
        brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(MACHINE_CATEGORY));
        brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR(MACHINE_FILENAME));
        DTGetTime_0(enable := TRUE);
        Header.DateTime := DTGetTime_0.DT1;
        Header.Name := MACHINE_FILENAME;
        Header.Description := 'Machine Settings';
        MpRecipe_0.Save := TRUE;
    ELSIF ((hmiRecipe.Commands.FactoryResetMachineSettings = TRUE) AND (MpRecipeUIConnect.Status = mpRECIPE_UI_STATUS_IDLE)) THEN
        // Factory reset the machine settings 
        brsstrcpy(ADR(hmiRecipe.Status.Category), ADR(MACHINE_CATEGORY));
        brsstrcpy(ADR(hmiRecipe.Status.FileName), ADR(MACHINE_FILENAME));
        MpRecipe_0.Load := TRUE;
		
        IF MpRecipe_0.CommandDone THEN
            // Copy factory settings into Machine.fix file 
            hmiRecipe.Commands.FactoryResetMachineSettings := FALSE;
            hmiRecipe.Commands.StoreMachineSettings := TRUE;
        END_IF
    END_IF
    
END_ACTION
