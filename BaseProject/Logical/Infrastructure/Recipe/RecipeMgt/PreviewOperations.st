
ACTION LoadPreview:

	(* Load preview when a recipe is selected *)
    IF ((MpRecipeUIConnect.Recipe.List.SelectedIndex <> hmiRecipe.Intern.LastSelectedIndex) AND (MpRecipeXml_Pre.Active = TRUE)) THEN
        (* Check selected recipe name is not empty *)
        
        IF (brsstrlen(ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex])) > 0) THEN
            MpRecipeXml_Pre.Load := TRUE;
            MpRecipeXml_Pre.FileName := ADR(MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]);
            hmiRecipe.Intern.LastSelectedIndex := MpRecipeUIConnect.Recipe.List.SelectedIndex;
        END_IF
        
    END_IF

    (* Reset load command on MpRecipe_Pre FUB *)
    IF ((MpRecipeXml_Pre.CommandDone = TRUE) OR (MpRecipeXml_Pre.Error = TRUE)) THEN
        MpRecipeXml_Pre.Load := FALSE;
    END_IF;

END_ACTION