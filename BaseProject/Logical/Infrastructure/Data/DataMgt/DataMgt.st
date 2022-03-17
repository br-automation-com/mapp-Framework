//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Author:    B&R Industrial Automation GmbH
//* Created:   30. Sep 2020/08:00
//* Description: Tasks FOR Data Management control. The Data Management handling is done in this task.
//*********************************************************************************

PROGRAM _INIT

	//Create folder for this component on the user file device
	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));
	
	//Check if folder already exist and if so disabled the function block call
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF

	// Init mapp function blocks 
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIData);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);

	MpDataRecorder_0.MpLink := ADR(gMpLinkDataRecorder);
	MpDataRecorder_0.Enable := TRUE ;
	MpDataRecorder_0.DeviceName := ADR('mappData');
	MpDataRecorder_0.RecordMode := mpDATA_RECORD_MODE_TIME;
	MpDataRecorder_0.SamplingTime := t#5s;

	// Register PVs for data recording 
	MpDataRegPar_x[0].MpLink := ADR(gMpLinkDataRecorder);
	MpDataRegPar_x[0].Enable := TRUE;
	MpDataRegPar_x[0].PVName := ADR('PIDControl:rActValue');
	MpDataRegPar_x[0].Description := ADR('Control Value');

	MpDataRegPar_x[1].MpLink := ADR(gMpLinkDataRecorder);
	MpDataRegPar_x[1].Enable := TRUE;
	MpDataRegPar_x[1].PVName := ADR('MainCtrl:MpAxisBasic_x[0].Velocity');
	MpDataRegPar_x[1].Description := ADR('Feeder Velocity');

	// Filter files for pdf type 
	MpFileManagerUIConnect.File.Filter := '*.pdf';
END_PROGRAM

PROGRAM _CYCLIC
	//***************************************************
	FOR i := 0 TO 49 DO
		// Save Filenames to a seperate array for display in Table
		DisplayFileName[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
		// mark file selection
		MpFileManagerUIConnect.File.List.Items[i].IsSelected := (DisplayFileNameIndex = INT_TO_USINT(i));
    END_FOR
    // String for pdfViewer to display right report
	StrSelectedFile := CONCAT(STR_FILE_DEVICE, MpFileManagerUIConnect.File.List.Items[DisplayFileNameIndex].Name);
	
	// Configure visible file list 
	brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpFileManagerUIConnect.File.PathInfo.FileCount, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
	brsstrcat(ADR(TableConfig),  ADR(',"to":49, "visible":false}]}'));

	// Call function blocks 
	MpDataRecorder_0();
	FOR i := 0 TO MAX_IDX_DATA_REG DO
		MpDataRegPar_x[i]();
	END_FOR
	MpFileManagerUI_0();

	// Reset ErrorReset command 
	IF NOT MpDataRecorder_0.Error THEN
		MpDataRecorder_0.ErrorReset := FALSE;
	END_IF
	FOR i := 0 TO MAX_IDX_DATA_REG DO
		IF NOT MpDataRegPar_x[i].Error THEN
			MpDataRegPar_x[i].ErrorReset := FALSE;
		END_IF
	END_FOR
END_PROGRAM

PROGRAM _EXIT
	// call mapp function blocks with enable = false 
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	MpDataRecorder_0.Enable := FALSE;
	MpDataRecorder_0();
	FOR i := 0 TO MAX_IDX_DATA_REG DO
		MpDataRegPar_x[i].Enable := FALSE;
		MpDataRegPar_x[i]();
	END_FOR
END_PROGRAM

