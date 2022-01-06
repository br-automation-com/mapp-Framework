(*********************************************************************************************************************
* Copyright: B&R Industrial Automation GmbH 
* Author:    B&R Industrial Automation GmbH 
* Description: Tasks for backup control.
*********************************************************************************************************************)

PROGRAM _INIT
    
    MpBackupCoreFB.MpLink := ADR(gBackupCore);
    MpBackupCoreFB.Enable := TRUE;
    
    MpFileManagerUIFB.MpLink := ADR(gBackupFileManagerUIMpLink);
    MpFileManagerUIFB.UIConnect := ADR(MpFileManagerUIConnect);
    MpFileManagerUIFB.Enable := TRUE;
    
    MpBackupCoreConfigFB.Enable := TRUE;
    MpBackupCoreConfigFB.MpLink := ADR(gBackupCore);
    MpBackupCoreConfigFB.Configuration := ADR(hmiBackup.Parameters.AutomaticBackup);
    MpBackupCoreConfigFB.Load := TRUE;
    
    brsstrcpy(ADR(hmiBackup.Status.DeviceDataProvider[0]), ADR('{"value":"mappBackup","text":"CF/PLC"}'));
    
END_PROGRAM

PROGRAM _CYCLIC
	
    CASE BackupState OF
        BACKUP_IDLE:
            hmiBackup.Status.CreateAllowed := NOT(MpBackupCoreFB.Info.Automatic.Backup.InProgress);
            hmiBackup.Status.Busy := FALSE;
            IF (hmiBackup.Commands.Create = TRUE) THEN
                hmiBackup.Commands.Create := FALSE;
                MpBackupCoreFB.Create := TRUE;
                hmiBackup.Status.Busy := TRUE;
                hmiBackup.Status.CreateAllowed := FALSE;
                hmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCoreFB.Name := ADR(hmiBackup.Parameters.Name);
                BackupState := BACKUP_CREATING;
            ELSIF (hmiBackup.Commands.Restore = TRUE) THEN
                hmiBackup.Commands.Restore := FALSE;
                MpBackupCoreFB.Install := TRUE;
                hmiBackup.Status.Busy := TRUE;
                hmiBackup.Status.CreateAllowed := FALSE;
                hmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCoreFB.Name := ADR(MpFileManagerUIConnect.File.List.Items[hmiBackup.Parameters.SelectedIndex].Name);
                BackupState := BACKUP_RESTORING;
            ELSIF (hmiBackup.Commands.RestoreAuto = TRUE) THEN
                hmiBackup.Commands.RestoreAuto := FALSE;
                MpBackupCoreFB.Install := TRUE;
                hmiBackup.Status.Busy := TRUE;
                hmiBackup.Status.CreateAllowed := FALSE;
                hmiBackup.Status.RestoreAllowed := FALSE;
                MpBackupCoreFB.Name := ADR(MpBackupCoreFB.Info.Automatic.Update.Name);
                BackupState := BACKUP_RESTORING;
            ELSIF (hmiBackup.Commands.Delete = TRUE) THEN
                MpFileManagerUIConnect.File.List.Items[hmiBackup.Parameters.SelectedIndex].IsSelected := TRUE;
                hmiBackup.Commands.Delete := FALSE;
                MpFileManagerUIConnect.File.Delete := TRUE;
                BackupState := BACKUP_DELETING;
            ELSIF (hmiBackup.Commands.SaveConfig = TRUE) THEN
                hmiBackup.Commands.SaveConfig := FALSE;
                SaveBackupConfiguration;
                MpBackupCoreConfigFB.Save := TRUE;
            ELSIF ((hmiBackup.Parameters.SelectedIndex <> LastSelectedIndex) AND (MpBackupCoreFB.CommandBusy <> TRUE)) THEN
                LastSelectedIndex := hmiBackup.Parameters.SelectedIndex;
                MpBackupCoreFB.Name := ADR(MpFileManagerUIConnect.File.List.Items[hmiBackup.Parameters.SelectedIndex].Name);
                MpBackupCoreFB.RequestInfo := TRUE;
            END_IF
    
        BACKUP_CREATING:
            IF (MpBackupCoreFB.CommandDone = TRUE) THEN
                // force the information refresh
                LastSelectedIndex := LastSelectedIndex + 1;
                MpBackupCoreFB.Create := FALSE;
                MpBackupCoreFB.Install := FALSE;
                MpBackupCoreFB.RequestInfo := FALSE;
                MpFileManagerUIConnect.File.Refresh := TRUE;
                BackupState := BACKUP_IDLE;
            ELSIF (MpBackupCoreFB.Error = TRUE) THEN
                BackupState := BACKUP_ERROR;
                MpBackupCoreFB.Create := FALSE;
                MpBackupCoreFB.Install := FALSE;
                MpBackupCoreFB.RequestInfo := FALSE;                
            END_IF
               
        BACKUP_RESTORING:
            IF (MpBackupCoreFB.CommandDone = TRUE) THEN
                MpBackupCoreFB.Create := FALSE;
                MpBackupCoreFB.Install := FALSE;
                MpBackupCoreFB.RequestInfo := FALSE;
                MpFileManagerUIConnect.File.Refresh := TRUE;
                BackupState := BACKUP_IDLE;
            ELSIF (MpBackupCoreFB.Error = TRUE) THEN
                BackupState := BACKUP_ERROR;
                MpBackupCoreFB.Create := FALSE;
                MpBackupCoreFB.Install := FALSE;
                MpBackupCoreFB.RequestInfo := FALSE;                
            END_IF
            
        BACKUP_DELETING:
            CASE (MpFileManagerUIConnect.MessageBox.Type) OF
                mpFILE_MSG_CONFIRM_DELETE:
                    MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
                mpFILE_MSG_OK:
                    IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                        // force the information refresh
                        LastSelectedIndex := LastSelectedIndex + 1;
                        FOR i:=0 TO ((SIZEOF(MpFileManagerUIConnect.File.List.Items[i])/SIZEOF(MpFileManagerUIConnect.File.List.Items[0]))-1) DO
                            MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
                        END_FOR
                        
                        MpFileManagerUIConnect.MessageBox.Confirm := FALSE;
                        BackupState := BACKUP_IDLE;
                    END_IF
                
            END_CASE
        
        BACKUP_ERROR:
        
    END_CASE

    // reset any errors caused by requesting information
    IF ((MpBackupCoreFB.Error = TRUE) AND (MpBackupCoreFB.RequestInfo = TRUE)) THEN
        MpBackupCoreFB.ErrorReset := TRUE;
        MpBackupCoreFB.RequestInfo := FALSE;
        brsmemset(ADR(hmiBackup.Status.Info), 0, SIZEOF(hmiBackup.Status.Info));
    END_IF
    MpBackupCoreFB.MpLink := ADR(gBackupCore);
    MpBackupCoreFB.DeviceName := ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]);
    MpBackupCoreFB();
    IF (MpBackupCoreFB.CommandDone = TRUE) AND (MpBackupCoreFB.RequestInfo = TRUE) THEN
        MpBackupCoreFB.RequestInfo := FALSE;
        hmiBackup.Status.Info := MpBackupCoreFB.Info.Project.Requested;
    END_IF
    IF (MpBackupCoreFB.Error = FALSE) THEN
        MpBackupCoreFB.ErrorReset := FALSE;
    END_IF
    
    hmiBackup.Status.RestoreAllowed := (hmiBackup.Status.Info.ConfigurationID <> '') AND NOT(MpBackupCoreFB.Info.Automatic.Backup.InProgress); 
    
    FileManager;
    
    Configuration;
    
    FormatDeviceDataProvider;
END_PROGRAM

PROGRAM _EXIT
    
    MpBackupCoreFB.Enable := FALSE;
    MpBackupCoreFB();

    MpFileManagerUIFB.Enable := FALSE;
    MpFileManagerUIFB();

    MpBackupCoreConfigFB.Enable := FALSE;
    MpBackupCoreConfigFB();

END_PROGRAM

