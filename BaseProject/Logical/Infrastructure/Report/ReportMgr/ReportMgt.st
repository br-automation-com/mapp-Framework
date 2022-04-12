//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Author:    B&R Industrial Automation GmbH
//* Created:   30. Sep 2020/08:00
//* Description: Tasks FOR report control. The Report Control handling is done in this task.
//********************************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF

	// Init mapp function blocks 
	MpReportCore_0.Enable := TRUE;
	MpReportCore_0.MpLink := ADR(gMpLinkReport);
	MpReportCore_0.Name := ADR(REPORT_NAME);
	MpReportCore_0.DeviceName := ADR(REPORT_DEVICE);
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIReport);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.Enable := TRUE;
	// Filter for pdf files 
	MpFileManagerUIConnect.File.Filter := '*.pdf';
END_PROGRAM

PROGRAM _CYCLIC
	// Configure visible file list 
	brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpFileManagerUIConnect.File.PathInfo.FileCount, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
	brsstrcat(ADR(TableConfig),  ADR(',"to":49, "visible":false}]}'));
	
	// Refresh report action
	RefreshReport;

	// Reset ErrorReset command 
	IF NOT MpReportCore_0.Error THEN
		MpReportCore_0.ErrorReset := FALSE;
	END_IF
	
	// Function block calls 
	MpReportCore_0();
	MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	// Disable and call mapp function blocks 
	MpReportCore_0.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpReportCore_0();
	MpFileManagerUI_0();
END_PROGRAM