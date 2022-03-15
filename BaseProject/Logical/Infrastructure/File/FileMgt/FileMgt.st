//*********************************************************************** 
// Copyright: B&R Industrial Automation GmbH 
// Author: B&R Industrial Automation GmbH 
// Created: Jan 1, 2022 
// Description: Tasks for File management control. The File management 
// handling is done in this task.
//***********************************************************************

PROGRAM _INIT

	// Init Filemanager for exporting/importing files 
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipe';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := 'mappAudit';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := 'mappReport';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := 'mappData';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := 'mappBackup';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := 'mappAlarmX';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := 'mappUserX';
	
	// Init FIFO feature 
	hmiFile.Parameters.Fifo.DeviceName := 'mappData';
	hmiFile.Parameters.Fifo.MaxFolderSize := 20000; //kB
	hmiFile.Parameters.Fifo.MaxNumberOfFiles := 20;
	hmiFile.Parameters.Fifo.ScanInterval := 60; //minutes
	
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[0]), ADR('{"value":"mappRecipe","text":"mappRecipe"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[1]), ADR('{"value":"mappAudit","text":"mappAudit"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[2]), ADR('{"value":"mappReport","text":"mappReport"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[3]), ADR('{"value":"mappData","text":"mappData"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[4]), ADR('{"value":"mappBackup","text":"mappBackup"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[5]), ADR('{"value":"mappAlarmX","text":"mappAlarmX"}'));
	brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[6]), ADR('{"value":"mappUserX","text":"mappUserX"}'));
	
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
	
	MpFileManagerUI_0();
	
END_PROGRAM

PROGRAM _EXIT
	
	// Reset function blocks to unlink mapp links *)
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
	
END_PROGRAM

