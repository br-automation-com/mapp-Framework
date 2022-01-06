
ACTION RefreshReport: 

	IF bStartGenerate = TRUE THEN		//Generate process
		MpReportCore_0.Language := ADR(LanguageSelect_0.LanguageSelection[LanguageSelect_0.SelectedIndex]);;
		MpReportCore_0.Generate := TRUE;
		
		IF MpReportCore_0.CommandDone = TRUE THEN
			
			bStartGenerate := FALSE;
			Refresh := TRUE;
			bEnableGenerate := FALSE;
		END_IF

	ELSE 
		MpReportCore_0.Generate := FALSE;
	END_IF
	
	IF bDeleteReport = TRUE THEN				//Deleting process  
		MpFileManagerUIConnect.File.Delete        := TRUE;
		MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
		bDeleteReport := FALSE;
		Refresh := TRUE;
		bEnableDelete := FALSE;
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
		bEnableDelete := TRUE;
		bEnableGenerate := TRUE;
	END_IF
	
	FOR i := 0 TO 49 DO							// Save Filenames to a seperate array for display in Table
		sDisplayFileName[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
		IF uDisplayFileNameIndex = i THEN		// if selected set a index for display selected file in table
			MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;	
		END_IF
	END_FOR
	
	sStrSelectedFile := CONCAT(STR_FILE_DEVICE, MpFileManagerUIConnect.File.List.Items[uDisplayFileNameIndex].Name);		// String for pdfViewer to display right report
	
	IF LanguageSelect_0.SelectedIndex = 0 THEN
		sSetLanguage := 'en';
	ELSE
		sSetLanguage := 'de';	
	END_IF

END_ACTION
