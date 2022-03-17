ACTION RefreshReport:

	IF StartGenerate = TRUE THEN		//Generate process
		MpReportCore_0.Language := ADR(LanguageSelect_0.LanguageSelection[LanguageSelect_0.SelectedIndex]);
		MpReportCore_0.Generate := TRUE;
	
		IF MpReportCore_0.CommandDone = TRUE THEN
	
			StartGenerate := FALSE;
			Refresh := TRUE;
			EnableGenerate := FALSE;
		END_IF

	ELSE
		MpReportCore_0.Generate := FALSE;
	END_IF
	
	IF DeleteReport = TRUE THEN				//Deleting process
		MpFileManagerUIConnect.File.Delete := TRUE;
		MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
		DeleteReport := FALSE;
		Refresh := TRUE;
		EnableDelete := FALSE;
	END_IF
	
	IF Refresh = TRUE THEN				//Refresh process
		TON_0(IN := TRUE, PT := T#2s);
		IF TON_0.Q = TRUE THEN
			Refresh := FALSE;
			TON_0(IN := FALSE, PT := T#2s);
			MpFileManagerUIConnect.File.Refresh := TRUE;
		END_IF
	END_IF
	
	IF Refresh = FALSE THEN		//reset enable attribute for buttons
		EnableDelete := TRUE;
		EnableGenerate := TRUE;
	END_IF
	
	FOR i := 0 TO 49 DO							// Save Filenames to a seperate array for display in Table
		DisplayFileName[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
		IF DisplayFileNameIndex = i THEN		// if selected set a index for display selected file in table
			MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
		END_IF
	END_FOR
	
	StrSelectedFile := CONCAT(STR_FILE_DEVICE, MpFileManagerUIConnect.File.List.Items[DisplayFileNameIndex].Name);// String for pdfViewer to display right report
	
	IF LanguageSelect_0.SelectedIndex = 0 THEN
		SetLanguage := 'en';
	ELSE
		SetLanguage := 'de';
	END_IF

END_ACTION
