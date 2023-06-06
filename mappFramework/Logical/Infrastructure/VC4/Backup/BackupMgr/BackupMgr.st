//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Task for backup management with VC4 front-end.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappBackupFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF

	// Initialize mapp function blocks
	MpBackupCore_0.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCore_0.Enable := TRUE;
	MpBackupCore_0();

	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIBackup);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0();

	MpBackupCoreConfig_0.Enable := TRUE;
	MpBackupCoreConfig_0.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreConfig_0.Configuration := ADR(MpBackupConfiguration);

	MpBackupCoreConfig_0.Load := NOT(DiagCpuIsARsim() OR DiagCpuIsSimulated());

	MpBackupCoreConfig_0();

	HmiBackup.Status.DeviceDataProviderVC4[0] := 'CF/PLC';

	// Restored the retained values to the backup settings
	HmiBackup.Parameters.AutomaticBackup := AutomaticBackupRetain;

END_PROGRAM

PROGRAM _CYCLIC
	CASE BackupState OF
		BACKUP_IDLE:
			HmiBackup.Status.CreateAllowed := NOT(MpBackupCore_0.Info.Automatic.Backup.InProgress) AND NOT HmiBackup.Status.SimulationActive;
			HmiBackup.Status.Busy := FALSE;
			IF (MpBackupCore_0.Error = TRUE) THEN
				MpBackupCore_0.ErrorReset := FALSE;
				BackupState := BACKUP_ERROR;
			ELSIF DiagCpuIsARsim() OR DiagCpuIsSimulated() THEN
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				BackupState := BACKUP_SIM;
			ELSIF (HmiBackup.Commands.Create = TRUE) THEN
				HmiBackup.Commands.Create := FALSE;
				MpBackupCore_0.Create := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCore_0.Name := ADR(HmiBackup.Parameters.Name);
				BackupState := BACKUP_CREATING;
			ELSIF MpBackupCore_0.Info.Automatic.Backup.InProgress THEN
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				BackupState := BACKUP_AUTOCREATE;	
			ELSIF (HmiBackup.Commands.Restore = TRUE) THEN
				HmiBackup.Commands.Restore := FALSE;
				MpBackupCore_0.Install := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCore_0.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].Name);
				BackupState := BACKUP_RESTORING;
			ELSIF (HmiBackup.Commands.Update = TRUE) THEN
				HmiBackup.Commands.Update := FALSE;
				MpBackupCore_0.Install := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCore_0.Name := ADR(MpBackupCore_0.Info.Automatic.Update.Name);
				BackupState := BACKUP_UPDATING;
			ELSIF (HmiBackup.Commands.Delete = TRUE) THEN
				MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].IsSelected := TRUE;
				HmiBackup.Commands.Delete := FALSE;
				MpFileManagerUIConnect.File.Delete := TRUE;
				BackupState := BACKUP_DELETING;
			ELSIF (HmiBackup.Commands.SaveConfig = TRUE) THEN
				HmiBackup.Commands.SaveConfig := FALSE;
				SaveBackupConfiguration;
				MpBackupCoreConfig_0.Save := TRUE;
			ELSIF ((HmiBackup.Status.SelectedIndex <> HmiBackup.Status.LastSelectedIndex) AND (MpBackupCore_0.CommandBusy <> TRUE)) THEN
				HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.SelectedIndex;
				MpBackupCore_0.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].Name);
				MpBackupCore_0.RequestInfo := TRUE;
			END_IF

		BACKUP_CREATING:
			IF (MpBackupCore_0.CommandDone = TRUE) THEN
				MpBackupCore_0.Create := FALSE;
				MpBackupCore_0.Install := FALSE;
				MpBackupCore_0.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_REFRESHING_LIST;
			ELSIF (MpBackupCore_0.Error = TRUE) THEN
				BackupState := BACKUP_ERROR;
			END_IF
			
		BACKUP_AUTOCREATE:
			IF ( MpBackupCore_0.Info.Automatic.Backup.InProgress = FALSE) THEN
				MpBackupCore_0.Install := FALSE;
				MpBackupCore_0.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_REFRESHING_LIST;
			ELSIF (MpBackupCore_0.Error = TRUE) THEN
				BackupState := BACKUP_ERROR;
			END_IF	

		BACKUP_REFRESHING_LIST:
			IF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH THEN
			// Wait for the list to be refreshed with the newly created backup file
			ELSIF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE THEN
				HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.LastSelectedIndex + 1;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCore_0.Error = TRUE) THEN
				BackupState := BACKUP_ERROR;
			END_IF

		BACKUP_RESTORING:
			IF (MpBackupCore_0.CommandDone = TRUE) THEN
				MpBackupCore_0.Create := FALSE;
				MpBackupCore_0.Install := FALSE;
				MpBackupCore_0.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCore_0.Error = TRUE) THEN
				BackupState := BACKUP_ERROR;
			END_IF

		BACKUP_UPDATING:
			IF (MpBackupCore_0.CommandDone = TRUE) THEN
				MpBackupCore_0.Create := FALSE;
				MpBackupCore_0.Install := FALSE;
				MpBackupCore_0.RequestInfo := FALSE;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCore_0.Error = TRUE) THEN
				BackupState := BACKUP_ERROR;
			END_IF

		BACKUP_DELETING:
			CASE (MpFileManagerUIConnect.MessageBox.Type) OF
				mpFILE_MSG_CONFIRM_DELETE:
					MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
				mpFILE_MSG_OK:
					IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
						HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.LastSelectedIndex + 1;
						FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.File.List.Items[i])/SIZEOF(MpFileManagerUIConnect.File.List.Items[0])) - 1) DO
							MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
						END_FOR
						HmiBackup.Status.SelectedIndex := 0;
						MpFileManagerUIConnect.MessageBox.Confirm := FALSE;
						BackupState := BACKUP_IDLE;
					END_IF
			END_CASE

		BACKUP_SIM:
			HmiBackup.Status.SimulationActive := TRUE;

		BACKUP_ERROR:
			MpBackupCore_0.Create := FALSE;
			MpBackupCore_0.Install := FALSE;
			IF MpBackupCore_0.Info.Diag.StatusID.ID <> 0 THEN
				HmiBackup.Status.Error := TRUE;
			END_IF
			IF HmiBackup.Commands.Reset OR (MpBackupCore_0.Info.Diag.StatusID.ID = -1064159486) THEN
				HmiBackup.Commands.Reset := FALSE;
				MpBackupCore_0.ErrorReset := TRUE;
				BackupState := BACKUP_IDLE;
			ELSIF ((MpBackupCore_0.Info.Diag.StatusID.ID = 0) AND (MpBackupCore_0.Error = FALSE)) THEN
				BackupState := BACKUP_IDLE;
			END_IF
	END_CASE

	// Reset any errors caused by requesting information
	IF EDGEPOS((MpBackupCore_0.Error = TRUE) AND (MpBackupCore_0.RequestInfo = TRUE)) THEN
		MpBackupCore_0.ErrorReset := TRUE;
		MpBackupCore_0.RequestInfo := FALSE;
		brsmemset(ADR(HmiBackup.Status.Info), 0, SIZEOF(HmiBackup.Status.Info));
	END_IF

	MpBackupCore_0.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCore_0.DeviceName := ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]);
	MpBackupCore_0();

	IF (MpBackupCore_0.CommandDone = TRUE) AND (MpBackupCore_0.RequestInfo = TRUE) THEN
		MpBackupCore_0.RequestInfo := FALSE;
		HmiBackup.Status.Info := MpBackupCore_0.Info.Project.Requested;
	END_IF
	IF EDGEPOS(MpBackupCore_0.Error = FALSE) THEN
		MpBackupCore_0.ErrorReset := FALSE;
		HmiBackup.Status.Error := FALSE;
	END_IF

	HmiBackup.Status.RestoreAllowed := (MpFileManagerUIConnect.File.PathInfo.FolderCount > 0) AND NOT(MpBackupCore_0.Info.Automatic.Backup.InProgress) AND NOT HmiBackup.Status.SimulationActive;
	HmiBackup.Status.Update := MpBackupCore_0.Info.Automatic.Update;
	HmiBackup.Status.BackupCtrlEnabled := (NOT HmiBackup.Status.SimulationActive);

	// Call all actions
	FileManager;
	VC4_Cylic;
	IF NOT DiagCpuIsARsim() THEN
		ChangeConfiguration;
	END_IF

	// Assign MpLinks
	MpBackupCore_0.MpLink := ADR(gMpLinkBackupCore);
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIBackup);
	MpBackupCoreConfig_0.MpLink := ADR(gMpLinkBackupCore);

	// Call function blocks
	MpBackupCore_0();
	MpFileManagerUI_0();
	MpBackupCoreConfig_0();
	
END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocks to unlink the MpLinks
	MpBackupCore_0.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpBackupCoreConfig_0.Enable := FALSE;

	// Call function blocks
	MpBackupCore_0();
	MpFileManagerUI_0();
	MpBackupCoreConfig_0();

END_PROGRAM

