//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Task for file management
//***********************************************************************

PROGRAM _INIT

	// Inititialize mapp function block
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipeFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := 'mappAuditFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := 'mappReportFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := 'mappDataFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := 'mappBackupFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := 'mappAlarmXFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := 'mappUserXFiles';
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUI_0();

	HmiFile.Status.DeleteStep := FILE_DISABLED;

	// Initialize FIFO feature
	HmiFile.Status.FifoConfigEnable := TRUE;
	IF HmiFile.Parameters.Fifo.DeviceName = '' THEN
		HmiFile.Parameters.Fifo.DeviceName := 'mappDataFiles';
	END_IF

	// MaxFolderSize is in kB
	IF HmiFile.Parameters.Fifo.MaxFolderSize = 0 THEN
		HmiFile.Parameters.Fifo.MaxFolderSize := 1000;
	END_IF

	IF HmiFile.Parameters.Fifo.MaxNumberOfFiles = 0 THEN
		HmiFile.Parameters.Fifo.MaxNumberOfFiles := 20;
	END_IF

	// ScanInterval is in minutes
	IF HmiFile.Parameters.Fifo.ScanInterval = 0 THEN
		HmiFile.Parameters.Fifo.ScanInterval := 60;
	END_IF


	// Initialize which folders should exist
	PathCheck.DeviceList := MpFileManagerUIConnect.DeviceList;
			
	PathCheck.PrgName[0] := 'RecipeMgr';
	PathCheck.PrgName[1] := 'AuditMgr';
	PathCheck.PrgName[2] := 'ReportMgr';
	PathCheck.PrgName[3] := 'DataMgr';
	PathCheck.PrgName[4] := 'BackupMgr';
	PathCheck.PrgName[5] := 'AlarmMgr';
	PathCheck.PrgName[6] := 'UserXMgr';

	PathCheck.Folder[0] := 'Recipe';
	PathCheck.Folder[1] := 'Audit';
	PathCheck.Folder[2] := 'Report';
	PathCheck.Folder[3] := 'Data';
	PathCheck.Folder[4] := 'Backup';
	PathCheck.Folder[5] := 'AlarmX';
	PathCheck.Folder[6] := 'UserX';

	HmiFile.Status.DeviceDataProvider[0] := '{"value":"mappRecipeFiles","text":"mappRecipeFiles"}';
	HmiFile.Status.DeviceDataProvider[1] := '{"value":"mappAuditFiles","text":"mappAuditFiles"}';
	HmiFile.Status.DeviceDataProvider[2] := '{"value":"mappReportFiles","text":"mappReportFiles"}';
	HmiFile.Status.DeviceDataProvider[3] := '{"value":"mappDataFiles","text":"mappDataFiles"}';
	HmiFile.Status.DeviceDataProvider[4] := '{"value":"mappBackupFiles","text":"mappBackupFiles"}';
	HmiFile.Status.DeviceDataProvider[5] := '{"value":"mappAlarmXFiles","text":"mappAlarmXFiles"}';
	HmiFile.Status.DeviceDataProvider[6] := '{"value":"mappUserXFiles","text":"mappUserXFiles"}';

	// Calculate offset for potential additional USB devices
	FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			USBOffset := USBOffset + 1;
		END_IF
	END_FOR
	
	// Restored the retained values to the FIFO settings
	HmiFile.Parameters.Fifo := FifoSettingsRetain;

END_PROGRAM

PROGRAM _CYCLIC

	// Call all actions
	FormatDeviceDataProvider;
	FileManager;
	FIFOOperation;

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
	MpFileManagerUI_FIFO.Enable := FALSE;

	// Call function block
	MpFileManagerUI_0();
	MpFileManagerUI_FIFO();

END_PROGRAM

