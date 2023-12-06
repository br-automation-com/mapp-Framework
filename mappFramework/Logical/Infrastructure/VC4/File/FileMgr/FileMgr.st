//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Task for file management with VC4 front-end.
//***********************************************************************

PROGRAM _INIT

	// Inititialize mapp function block
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'USER';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := 'mappRecipeFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := 'mappAuditFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := 'mappReportFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := 'mappBackupFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := 'mappAlarmXFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := 'mappUserXFiles';
	MpFileManagerUISys.Enable := TRUE;
	MpFileManagerUISys.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUISys.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUISys.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUISys();

	HmiFile.Status.DeleteStep := FILE_DISABLED;

	// Restored the retained values to the FIFO settings
	HmiFile.Parameters.Fifo := FifoSettingsRetain;
	// If the FIFO is disabled and parameters are 0, set default values
	IF NOT HmiFile.Parameters.Fifo.Enable THEN 
		IF HmiFile.Parameters.Fifo.MaxFolderSize = 0 THEN
			HmiFile.Parameters.Fifo.MaxFolderSize := 1000;
		END_IF
		IF HmiFile.Parameters.Fifo.MaxNumberOfFiles = 0 THEN
			HmiFile.Parameters.Fifo.MaxNumberOfFiles := 20;
		END_IF
		IF HmiFile.Parameters.Fifo.ScanInterval = 0 THEN
			HmiFile.Parameters.Fifo.ScanInterval := 60;
		END_IF
		IF HmiFile.Parameters.Fifo.DeviceName = '' THEN
			HmiFile.Parameters.Fifo.DeviceName := 'USER';
		END_IF
	END_IF

	// Initialize which folders should exist
	PathCheck.DeviceList := MpFileManagerUIConnect.DeviceList;
			
	PathCheck.PrgName[0] := 'RecipeMgr';
	PathCheck.PrgName[1] := 'AuditMgr';
	PathCheck.PrgName[2] := 'ReportMgr';
	PathCheck.PrgName[3] := 'BackupMgr';
	PathCheck.PrgName[4] := 'AlarmMgr';
	PathCheck.PrgName[5] := 'UserXMgr';
	PathCheck.PrgName[6] := 'UsbMgr';
	PathCheck.PrgName[7] := 'UsbMgr';

	PathCheck.Folder[0] := 'Recipe';
	PathCheck.Folder[1] := 'Audit';
	PathCheck.Folder[2] := 'Report';
	PathCheck.Folder[3] := 'Backup';
	PathCheck.Folder[4] := 'AlarmX';
	PathCheck.Folder[5] := 'UserX';

	HmiFile.Status.DeviceDataProvider[0] := 'UserPath';
	HmiFile.Status.DeviceDataProvider[1] := 'mappRecipeFiles';
	HmiFile.Status.DeviceDataProvider[2] := 'mappAuditFiles';
	HmiFile.Status.DeviceDataProvider[3] := 'mappReportFiles';
	HmiFile.Status.DeviceDataProvider[4] := 'mappBackupFiles';
	HmiFile.Status.DeviceDataProvider[5] := 'mappAlarmXFiles';
	HmiFile.Status.DeviceDataProvider[6] := 'mappUserXFiles';

	// Calculate offset for potential additional USB devices
	FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			USBOffset := USBOffset + 1;
		END_IF
	END_FOR
	
	// Handle retained FIFO settings
	VC4_Init;
	
END_PROGRAM

PROGRAM _CYCLIC

	// Call all actions
	FormatDeviceDataProvider;
	VC4_Cyclic;
	FIFOOperation;

	// Error reset
	IF NOT MpFileManagerUISys.Error THEN
		MpFileManagerUISys.ErrorReset := FALSE;
	END_IF

	// Assign MpLinks and address references
	MpFileManagerUISys.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUISys.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_FIFO.MpLink := ADR(gMpLinkFileManagerUIFile_FIFO);

	// Call function blocks
	MpFileManagerUISys();
	MpFileManagerUI_FIFO();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocks to unlink the MpLink
	MpFileManagerUISys.Enable := FALSE;
	MpFileManagerUI_FIFO.Enable := FALSE;

	// Call function blocks
	MpFileManagerUISys();
	MpFileManagerUI_FIFO();

END_PROGRAM

