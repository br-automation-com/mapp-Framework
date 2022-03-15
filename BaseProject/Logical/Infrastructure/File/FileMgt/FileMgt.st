//*********************************************************************** 
// Copyright: B&R Industrial Automation GmbH 
// Author: B&R Industrial Automation GmbH 
// Created: Jan 1, 2022 
// Description: Tasks for File management control. The File management 
// handling is done in this task.
//***********************************************************************

PROGRAM _INIT

	// Inititialize mapp function block
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipe';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := 'mappAudit';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := 'mappReport';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := 'mappData';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := 'mappBackup';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := 'mappAlarmX';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := 'mappUserX';
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUI_0();

	// Initialize FIFO feature 
	hmiFile.Parameters.Fifo.DeviceName := 'mappData';
	hmiFile.Parameters.Fifo.MaxFolderSize := 20000; // kB
	hmiFile.Parameters.Fifo.MaxNumberOfFiles := 20;
	hmiFile.Parameters.Fifo.ScanInterval := 60; // minutes
	
	hmiFile.Status.DeviceDataProvider[0] := '{"value":"mappRecipe","text":"mappRecipe"}';
	hmiFile.Status.DeviceDataProvider[1] := '{"value":"mappAudit","text":"mappAudit"}';
	hmiFile.Status.DeviceDataProvider[2] := '{"value":"mappReport","text":"mappReport"}';
	hmiFile.Status.DeviceDataProvider[3] := '{"value":"mappData","text":"mappData"}';
	hmiFile.Status.DeviceDataProvider[4] := '{"value":"mappBackup","text":"mappBackup"}';
	hmiFile.Status.DeviceDataProvider[5] := '{"value":"mappAlarmX","text":"mappAlarmX"}';
	hmiFile.Status.DeviceDataProvider[6] := '{"value":"mappUserX","text":"mappUserX"}';
	
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all actions
	FormatDeviceDataProvider;
	FileManager;
	IF hmiFile.Parameters.Fifo.Enable THEN
		FIFOOperation;
	END_IF 
	
	// Error reset 
    IF NOT MpFileManagerUI_0.Error THEN
        MpFileManagerUI_0.ErrorReset := FALSE;
    END_IF
	
	// Assign MpLink
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIFile);
	
	// Call function block
	MpFileManagerUI_0();
	
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocls to unlink the MpLink
	MpFileManagerUI_0.Enable := FALSE;
	
	// Call function block
	MpFileManagerUI_0();	
	
END_PROGRAM

