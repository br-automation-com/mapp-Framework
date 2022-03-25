//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Jan 1, 2022
// Description: Tasks for backup control.
//***********************************************************************

PROGRAM _INIT
    
	// Create folder for this component on the user file device
	DirCreate_New(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF

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
	MpBackupCoreConfig_0.Load := TRUE;
	MpBackupCoreConfig_0();
    
	HmiBackup.Status.DeviceDataProvider[0] := '{"value":"mappBackupFiles","text":"CF/PLC"}';
	    
END_PROGRAM

PROGRAM _CYCLIC

    CASE BackupState OF
        BACKUP_IDLE:
            HmiBackup.Status.CreateAllowed := NOT(MpBackupCore_0.Info.Automatic.Backup.InProgress);
            HmiBackup.Status.Busy := FALSE;
            IF (HmiBackup.Commands.Create = TRUE) THEN
                HmiBackup.Commands.Create := FALSE;
                MpBackupCore_0.Create := TRUE;
                HmiBackup.Status.Busy := TRUE;
                HmiBackup.Status.CreateAllowed := FALSE;
                HmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCore_0.Name := ADR(HmiBackup.Parameters.Name);
                BackupState := BACKUP_CREATING;
            ELSIF (HmiBackup.Commands.Restore = TRUE) THEN
                HmiBackup.Commands.Restore := FALSE;
                MpBackupCore_0.Install := TRUE;
                HmiBackup.Status.Busy := TRUE;
                HmiBackup.Status.CreateAllowed := FALSE;
                HmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCore_0.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Parameters.SelectedIndex].Name);
                BackupState := BACKUP_RESTORING;
            ELSIF (HmiBackup.Commands.RestoreAuto = TRUE) THEN
                HmiBackup.Commands.RestoreAuto := FALSE;
                MpBackupCore_0.Install := TRUE;
                HmiBackup.Status.Busy := TRUE;
                HmiBackup.Status.CreateAllowed := FALSE;
                HmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCore_0.Name := ADR(MpBackupCore_0.Info.Automatic.Update.Name);
                BackupState := BACKUP_RESTORING;
            ELSIF (HmiBackup.Commands.Delete = TRUE) THEN
                MpFileManagerUIConnect.File.List.Items[HmiBackup.Parameters.SelectedIndex].IsSelected := TRUE;
                HmiBackup.Commands.Delete := FALSE;
                MpFileManagerUIConnect.File.Delete := TRUE;
                BackupState := BACKUP_DELETING;
            ELSIF (HmiBackup.Commands.SaveConfig = TRUE) THEN
                HmiBackup.Commands.SaveConfig := FALSE;
                SaveBackupConfiguration;
                MpBackupCoreConfig_0.Save := TRUE;
            ELSIF ((HmiBackup.Parameters.SelectedIndex <> LastSelectedIndex) AND (MpBackupCore_0.CommandBusy <> TRUE)) THEN
                LastSelectedIndex := HmiBackup.Parameters.SelectedIndex;
                MpBackupCore_0.Name := ADR(MpFileManagerUIConnect.File.List.Items[HmiBackup.Parameters.SelectedIndex].Name);
                MpBackupCore_0.RequestInfo := TRUE;
			ELSIF DiagCpuIsARsim() OR DiagCpuIsSimulated() THEN
              	HmiBackup.Status.SimulationActive := TRUE;
                HmiBackup.Status.CreateAllowed := FALSE;
                HmiBackup.Status.RestoreAllowed := FALSE;
            END_IF
    
        BACKUP_CREATING:
            IF (MpBackupCore_0.CommandDone = TRUE) THEN
				LastSelectedIndex := LastSelectedIndex + 1;
                MpBackupCore_0.Create := FALSE;
                MpBackupCore_0.Install := FALSE;
                MpBackupCore_0.RequestInfo := FALSE;
                MpFileManagerUIConnect.File.Refresh := TRUE;
                BackupState := BACKUP_IDLE;
            ELSIF (MpBackupCore_0.Error = TRUE) THEN
                BackupState := BACKUP_ERROR;				
                MpBackupCore_0.Create := FALSE;
                MpBackupCore_0.Install := FALSE;
                MpBackupCore_0.RequestInfo := FALSE;
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
                MpBackupCore_0.Create := FALSE;
                MpBackupCore_0.Install := FALSE;
                MpBackupCore_0.RequestInfo := FALSE;
            END_IF
            
        BACKUP_DELETING:
            CASE (MpFileManagerUIConnect.MessageBox.Type) OF
                mpFILE_MSG_CONFIRM_DELETE:
                    MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
                mpFILE_MSG_OK:
                    IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
						LastSelectedIndex := LastSelectedIndex + 1;
                        FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.File.List.Items[i])/SIZEOF(MpFileManagerUIConnect.File.List.Items[0])) - 1) DO
                            MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
                        END_FOR
						MpFileManagerUIConnect.MessageBox.Confirm := FALSE;
                        BackupState := BACKUP_IDLE;
                    END_IF
			END_CASE
        
        BACKUP_ERROR:
			IF MpBackupCore_0.Info.Diag.StatusID.ID = mpBACKUP_ERR_CREATE_FAILED THEN
				HmiBackup.Status.Error := TRUE;
			END_IF	
			IF HmiBackup.Commands.Reset THEN
				HmiBackup.Commands.Reset := FALSE;
				MpBackupCore_0.ErrorReset := TRUE;
        		BackupState := BACKUP_IDLE;
			END_IF	
    END_CASE

    // Reset any errors caused by requesting information
    IF ((MpBackupCore_0.Error = TRUE) AND (MpBackupCore_0.RequestInfo = TRUE)) THEN
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
    IF (MpBackupCore_0.Error = FALSE) THEN
        MpBackupCore_0.ErrorReset := FALSE;
		HmiBackup.Status.Error := FALSE;
    END_IF
    
    HmiBackup.Status.RestoreAllowed := (HmiBackup.Status.Info.ConfigurationID <> '') AND NOT(MpBackupCore_0.Info.Automatic.Backup.InProgress);
    
	// Call all actions
    FileManager;
	ChangeConfiguration;
	FormatDeviceDataProvider;
	
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
    
	// Disable the function blocls to unlink the MpLinks
    MpBackupCore_0.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpBackupCoreConfig_0.Enable := FALSE;
	
	// Call function blocks
	MpBackupCore_0();
	MpFileManagerUI_0();
	MpBackupCoreConfig_0();

END_PROGRAM

