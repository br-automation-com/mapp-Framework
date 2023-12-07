//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Task for backup management with VC4 front-end.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreateBackup(enable := TRUE, pDevice := ADR('mappBackupFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreateBackup.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreateBackup(enable := FALSE);
	END_IF

	// Initialize mapp function blocks
	MpBackupCoreSys.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreSys.Enable := TRUE;
	MpBackupCoreSys();

	MpFileManagerUIBackup.MpLink := ADR(gMpLinkFileManagerUIBackup);
	MpFileManagerUIBackup.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUIBackup.Enable := TRUE;
	MpFileManagerUIBackup();

	MpBackupCoreConfigSys.Enable := TRUE;
	MpBackupCoreConfigSys.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreConfigSys.Configuration := ADR(MpBackupConfiguration);

	MpBackupCoreConfigSys.Load := NOT(DiagCpuIsARsim() OR DiagCpuIsSimulated());

	MpBackupCoreConfigSys();

	HmiBackup.Status.DeviceDataProviderVC4[0] := 'CF/PLC';

	// Restored the retained values to the backup settings
	HmiBackup.Parameters.AutomaticBackup := AutomaticBackupRetain;

END_PROGRAM

PROGRAM _CYCLIC
	CASE BackupState OF
		BACKUP_IDLE:
			HmiBackup.Status.CreateAllowed := NOT(MpBackupCoreSys.Info.Automatic.Backup.InProgress) AND NOT HmiBackup.Status.SimulationActive;
			HmiBackup.Status.Busy := FALSE;
			IF (MpBackupCoreSys.Error) THEN
				MpBackupCoreSys.ErrorReset := FALSE;
				BackupState := BACKUP_ERROR;
			ELSIF DiagCpuIsARsim() OR DiagCpuIsSimulated() THEN
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				BackupState := BACKUP_SIM;
			ELSIF (HmiBackup.Commands.Create) THEN
				HmiBackup.Commands.Create := FALSE;
				MpBackupCoreSys.Create := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCoreSys.Name := ADR(HmiBackup.Parameters.Name);
				BackupState := BACKUP_CREATING;
			ELSIF MpBackupCoreSys.Info.Automatic.Backup.InProgress THEN
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				BackupState := BACKUP_AUTOCREATE;	
			ELSIF (HmiBackup.Commands.Restore) THEN
				HmiBackup.Commands.Restore := FALSE;
				MpBackupCoreSys.Install := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCoreSys.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].Name);
				BackupState := BACKUP_RESTORING;
			ELSIF (HmiBackup.Commands.Update) THEN
				HmiBackup.Commands.Update := FALSE;
				MpBackupCoreSys.Install := TRUE;
				HmiBackup.Status.Busy := TRUE;
				HmiBackup.Status.CreateAllowed := FALSE;
				HmiBackup.Status.RestoreAllowed := FALSE;
				MpBackupCoreSys.Name := ADR(MpBackupCoreSys.Info.Automatic.Update.Name);
				BackupState := BACKUP_UPDATING;
			ELSIF (HmiBackup.Commands.Delete) THEN
				MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].IsSelected := TRUE;
				HmiBackup.Commands.Delete := FALSE;
				MpFileManagerUIConnect.File.Delete := TRUE;
				BackupState := BACKUP_DELETING;
			ELSIF (HmiBackup.Commands.SaveConfig) THEN
				HmiBackup.Commands.SaveConfig := FALSE;
				SaveBackupConfiguration;
				MpBackupCoreConfigSys.Save := TRUE;
			ELSIF ((HmiBackup.Status.SelectedIndex <> HmiBackup.Status.LastSelectedIndex) AND (MpBackupCoreSys.CommandBusy <> TRUE)) THEN
				HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.SelectedIndex;
				MpBackupCoreSys.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].Name);
				IF MpFileManagerUIConnect.File.List.Items[HmiBackup.Status.SelectedIndex].Name <> '' THEN
					MpBackupCoreSys.RequestInfo := TRUE;
				END_IF
			END_IF

		BACKUP_CREATING:
			IF (MpBackupCoreSys.CommandDone) THEN
				MpBackupCoreSys.Create := FALSE;
				MpBackupCoreSys.Install := FALSE;
				MpBackupCoreSys.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_REFRESHING_LIST;
			ELSIF (MpBackupCoreSys.Error) THEN
				BackupState := BACKUP_ERROR;
			END_IF
			
		BACKUP_AUTOCREATE:
			IF (NOT MpBackupCoreSys.Info.Automatic.Backup.InProgress) THEN
				MpBackupCoreSys.Install := FALSE;
				MpBackupCoreSys.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_REFRESHING_LIST;
			ELSIF (MpBackupCoreSys.Error) THEN
				BackupState := BACKUP_ERROR;
			END_IF	

		BACKUP_REFRESHING_LIST:
			IF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH THEN
				// Wait for the list to be refreshed with the newly created backup file
			ELSIF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE THEN
				HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.LastSelectedIndex + 1;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCoreSys.Error) THEN
				BackupState := BACKUP_ERROR;
			END_IF

		BACKUP_RESTORING:
			IF (MpBackupCoreSys.CommandDone) THEN
				MpBackupCoreSys.Create := FALSE;
				MpBackupCoreSys.Install := FALSE;
				MpBackupCoreSys.RequestInfo := FALSE;
				MpFileManagerUIConnect.File.Refresh := TRUE;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCoreSys.Error) THEN
				BackupState := BACKUP_ERROR;
			END_IF

		BACKUP_UPDATING:
			IF (MpBackupCoreSys.CommandDone) THEN
				MpBackupCoreSys.Create := FALSE;
				MpBackupCoreSys.Install := FALSE;
				MpBackupCoreSys.RequestInfo := FALSE;
				BackupState := BACKUP_IDLE;
			ELSIF (MpBackupCoreSys.Error) THEN
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
			MpBackupCoreSys.Create := FALSE;
			MpBackupCoreSys.Install := FALSE;
			IF MpBackupCoreSys.Info.Diag.StatusID.ID <> 0 THEN //-1064159486
				HmiBackup.Status.Error := TRUE;
			END_IF
			IF HmiBackup.Commands.Reset OR (MpBackupCoreSys.Info.Diag.StatusID.ID = -1064159486) THEN
				HmiBackup.Commands.Reset := FALSE;
				MpBackupCoreSys.ErrorReset := TRUE;
				BackupState := BACKUP_IDLE;
			ELSIF ((MpBackupCoreSys.Info.Diag.StatusID.ID = 0) AND (NOT MpBackupCoreSys.Error)) THEN
				BackupState := BACKUP_IDLE;
			END_IF
	END_CASE

	// Reset any errors caused by requesting information
	IF EDGEPOS((MpBackupCoreSys.Error) AND (MpBackupCoreSys.RequestInfo)) THEN
		MpBackupCoreSys.ErrorReset := TRUE;
		MpBackupCoreSys.RequestInfo := FALSE;
		brsmemset(ADR(HmiBackup.Status.Info), 0, SIZEOF(HmiBackup.Status.Info));
	END_IF

	MpBackupCoreSys.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreSys.DeviceName := ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]);
	MpBackupCoreSys();

	IF (MpBackupCoreSys.CommandDone) AND (MpBackupCoreSys.RequestInfo) THEN
		MpBackupCoreSys.RequestInfo := FALSE;
		HmiBackup.Status.Info := MpBackupCoreSys.Info.Project.Requested;
	END_IF
	IF EDGEPOS(NOT MpBackupCoreSys.Error) THEN
		MpBackupCoreSys.ErrorReset := FALSE;
		HmiBackup.Status.Error := FALSE;
	END_IF

	HmiBackup.Status.RestoreAllowed := (MpFileManagerUIConnect.File.PathInfo.FolderCount > 0) AND NOT(MpBackupCoreSys.Info.Automatic.Backup.InProgress) AND NOT HmiBackup.Status.SimulationActive;
	HmiBackup.Status.Update := MpBackupCoreSys.Info.Automatic.Update;
	HmiBackup.Status.BackupCtrlEnabled := (NOT HmiBackup.Status.SimulationActive);

	// Call all actions
	FileManager;
	VC4_Cylic;
	IF NOT DiagCpuIsARsim() THEN
		ChangeConfiguration;
	END_IF

	// Assign MpLinks & address references
	MpBackupCoreSys.MpLink := ADR(gMpLinkBackupCore);
	MpFileManagerUIBackup.MpLink := ADR(gMpLinkFileManagerUIBackup);
	MpFileManagerUIBackup.UIConnect := ADR(MpFileManagerUIConnect);
	MpBackupCoreConfigSys.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreConfigSys.Configuration := ADR(MpBackupConfiguration);

	// Call function blocks
	MpBackupCoreSys();
	MpFileManagerUIBackup();
	MpBackupCoreConfigSys();
	
END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocks to unlink the MpLinks
	MpBackupCoreSys.Enable := FALSE;
	MpFileManagerUIBackup.Enable := FALSE;
	MpBackupCoreConfigSys.Enable := FALSE;

	// Call function blocks
	MpBackupCoreSys();
	MpFileManagerUIBackup();
	MpBackupCoreConfigSys();

END_PROGRAM

