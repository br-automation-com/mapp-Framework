
ACTION FormatDeviceDataProvider: 
    
	// Select CF device if USB device is not available 
    FOR i := 0 TO MAX_IDX_USB_DEV_LIST DO
        IF gbUSBAvail[i] THEN
            brsstrcpy(ADR(hmiBackup.Status.DeviceDataProvider[i + 1]), ADR('{"value":"USB'));
            brsitoa(i + 1, ADR(hmiBackup.Status.DeviceDataProvider[i + 1]) + brsstrlen(ADR(hmiBackup.Status.DeviceDataProvider[i + 1])));
            brsstrcat(ADR(hmiBackup.Status.DeviceDataProvider[i + 1]), ADR('","text":"USB'));
            brsitoa(i + 1, ADR(hmiBackup.Status.DeviceDataProvider[i + 1]) + brsstrlen(ADR(hmiBackup.Status.DeviceDataProvider[i + 1])));
            brsstrcat(ADR(hmiBackup.Status.DeviceDataProvider[i + 1]), ADR('"}'));
            brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]), ADR('USB'));
            brsitoa(i + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1])));
        ELSE
            brsmemset(ADR(hmiBackup.Status.DeviceDataProvider[i + 1]), 0, SIZEOF(hmiBackup.Status.DeviceDataProvider[i + 1]));
            brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]));
        END_IF
    END_FOR
    
END_ACTION

ACTION SaveBackupConfiguration:
    
    MpBackupConfiguration.AutomaticBackup.Enabled := hmiBackup.Parameters.AutomaticBackup.Enable;
    MpBackupConfiguration.AutomaticBackup.NamePrefix := hmiBackup.Parameters.AutomaticBackup.Prefix;
    MpBackupConfiguration.AutomaticBackup.DeviceName := hmiBackup.Parameters.AutomaticBackup.Device;
    MpBackupConfiguration.AutomaticBackup.OverwriteOldest := hmiBackup.Parameters.AutomaticBackup.OverwriteOldest;    
    MpBackupConfiguration.AutomaticBackup.Mode.Time := UDINT_TO_TOD((((USINT_TO_UDINT(hmiBackup.Parameters.AutomaticBackup.Mode.Hour) * 60) + hmiBackup.Parameters.AutomaticBackup.Mode.Minute) * 60) * 1000);
    CASE hmiBackup.Parameters.AutomaticBackup.Mode.Interval OF
        BACKUP_EVERYDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_DAILY;
        BACKUP_MONDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_MONDAY;
        BACKUP_TUESDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_TUESDAY;
        BACKUP_WEDNESDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_WEDNESDAY;
        BACKUP_THURSDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_THURSDAY;
        BACKUP_FRIDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_FRIDAY;
        BACKUP_SATURDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_SATURDAY;
        BACKUP_SUNDAY:
            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_SUNDAY;
    END_CASE
    
    
 END_ACTION

ACTION LoadBackupConfiguration:
    hmiBackup.Parameters.AutomaticBackup.Enable := MpBackupConfiguration.AutomaticBackup.Enabled;
    hmiBackup.Parameters.AutomaticBackup.Prefix := MpBackupConfiguration.AutomaticBackup.NamePrefix;
    hmiBackup.Parameters.AutomaticBackup.Device := MpBackupConfiguration.AutomaticBackup.DeviceName;
    hmiBackup.Parameters.AutomaticBackup.OverwriteOldest := MpBackupConfiguration.AutomaticBackup.OverwriteOldest;
    hmiBackup.Parameters.AutomaticBackup.Mode.Hour := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60 / 60);
    hmiBackup.Parameters.AutomaticBackup.Mode.Minute := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60) - (hmiBackup.Parameters.AutomaticBackup.Mode.Hour * 60);
    CASE MpBackupConfiguration.AutomaticBackup.Mode.Interval OF
        mpBACKUP_INTERVAL_DAILY:
            hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_EVERYDAY;
        mpBACKUP_INTERVAL_WEEKLY:
            CASE MpBackupConfiguration.AutomaticBackup.Mode.Day OF
                mpBACKUP_DAY_MONDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_MONDAY;
                mpBACKUP_DAY_TUESDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_TUESDAY;
                mpBACKUP_DAY_WEDNESDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_WEDNESDAY;
                mpBACKUP_DAY_THURSDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_THURSDAY;
                mpBACKUP_DAY_FRIDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_FRIDAY;
                mpBACKUP_DAY_SATURDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SATURDAY;
                mpBACKUP_DAY_SUNDAY:
                    hmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SUNDAY;
            END_CASE
    END_CASE
END_ACTION

ACTION FileManager:
    MpFileManagerUIFB.MpLink := ADR(gBackupFileManagerUIMpLink);
    MpFileManagerUIFB.UIConnect := ADR(MpFileManagerUIConnect);
    MpFileManagerUIFB();
    FOR i:=0 TO ((SIZEOF(hmiBackup.Status.FileNames)/SIZEOF(hmiBackup.Status.FileNames[0]))-1) DO
        hmiBackup.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
        hmiBackup.Status.TimeStamps[i] := MpFileManagerUIConnect.File.List.Items[i].LastModified;
        hmiBackup.Status.Size[i] := MpFileManagerUIConnect.File.List.Items[i].Size;
    END_FOR
    
    IF ((MpFileManagerUIConnect.DeviceList.SelectedIndex <> LastSelectedDeviceIndex) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE)) THEN
        LastSelectedDeviceIndex := MpFileManagerUIConnect.DeviceList.SelectedIndex;
        LastSelectedIndex := LastSelectedIndex + 1;
    END_IF
    
END_ACTION
