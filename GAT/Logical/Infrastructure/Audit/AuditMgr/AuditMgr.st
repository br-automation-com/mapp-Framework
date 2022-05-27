//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Author:    B&R Industrial Automation GmbH
//* Created:   30. Dec 2020/08:00
//* Description: Tasks FOR Audit Management.  The Audit Management is done in this task.
//********************************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF

	// Init function blocks 
	MpAuditTrail_0.MpLink := ADR(gAuditTrailMpLink);
	MpAuditTrail_0.Enable := TRUE;
	MpAuditTrail_0.DeviceName := ADR('mappAuditFiles');

	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIAudit);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := 50;

	// Filter files for pdf type 
	MpFileManagerUIConnect.File.Filter := '*.pdf';
END_PROGRAM

PROGRAM _CYCLIC
	// Reset export command 
	IF MpAuditTrail_0.CommandDone THEN
		MpAuditTrail_0.Export := FALSE;
		MpFileManagerUIConnect.File.Refresh := TRUE;
	END_IF

	// Reset error reset 
	IF NOT MpAuditTrail_0.Error THEN
	  MpAuditTrail_0.ErrorReset := FALSE;
	END_IF

    // Save Filenames to a seperate array for display in Table
	FOR i := 0 TO 49 DO
        DisplayFileName[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
        // If selected set a index for display selected file in table
		IF DisplayFileNameIndex = INT_TO_USINT(i) THEN
			MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
		END_IF
    END_FOR
    
    // String for pdfViewer to display right report
	StrSelectedFile := CONCAT(STR_FILE_DEVICE, MpFileManagerUIConnect.File.List.Items[DisplayFileNameIndex].Name);

	// Configure visible file list 
	brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpFileManagerUIConnect.File.PathInfo.FileCount, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
	brsstrcat(ADR(TableConfig),  ADR(',"to":49, "visible":false}]}'));
   
	// Call function blocks 
	MpAuditTrail_0();
	MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	// Insert code here 
	
END_PROGRAM

