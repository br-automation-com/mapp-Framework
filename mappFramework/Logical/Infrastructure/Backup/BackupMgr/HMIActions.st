ACTION FormatDeviceDataProvider:
    
	// Select CF device if USB device is not available
    FOR i := 0 TO ((SIZEOF(gUSBAvailable) / SIZEOF(gUSBAvailable[0])) - 1) DO
        IF gUSBAvailable[i] THEN
			HmiBackup.Status.DeviceDataProvider[i + 1] := '{"value":"USB';
            brsitoa(i + 1, ADR(HmiBackup.Status.DeviceDataProvider[i + 1]) + brsstrlen(ADR(HmiBackup.Status.DeviceDataProvider[i + 1])));
            brsstrcat(ADR(HmiBackup.Status.DeviceDataProvider[i + 1]), ADR('","text":"USB'));
            brsitoa(i + 1, ADR(HmiBackup.Status.DeviceDataProvider[i + 1]) + brsstrlen(ADR(HmiBackup.Status.DeviceDataProvider[i + 1])));
            brsstrcat(ADR(HmiBackup.Status.DeviceDataProvider[i + 1]), ADR('"}'));
			MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1] := 'USB';
            brsitoa(i + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1])));
        ELSE
            brsmemset(ADR(HmiBackup.Status.DeviceDataProvider[i + 1]), 0, SIZEOF(HmiBackup.Status.DeviceDataProvider[i + 1]));
            brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[i + 1]));
        END_IF
    END_FOR
	
	// Configure visible device list
	HmiBackup.Status.TableConfig[0] := '{ "specRows": [{"from":';
	FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			DeviceCount := i + 1;
		END_IF
	END_FOR
	brsitoa((DeviceCount), ADR(HmiBackup.Status.TableConfig[0]) + brsstrlen(ADR(HmiBackup.Status.TableConfig[0])));
    brsstrcat(ADR(HmiBackup.Status.TableConfig[0]),  ADR(',"to":9, "visible":false}]}'));
	
	// Configure visible file list
	ItemCount := MpFileManagerUIConnect.File.PathInfo.FileCount + MpFileManagerUIConnect.File.PathInfo.FolderCount;
	HmiBackup.Status.TableConfig[1] := '{ "specRows": [{"from":';
    brsitoa((ItemCount), ADR(HmiBackup.Status.TableConfig[1]) + brsstrlen(ADR(HmiBackup.Status.TableConfig[1])));
    brsstrcat(ADR(HmiBackup.Status.TableConfig[1]),  ADR(',"to":50, "visible":false}]}'));
	
	HmiBackup.Status.FileOverMax := ItemCount > (SIZEOF(MpFileManagerUIConnect.File.List.Items)/SIZEOF(MpFileManagerUIConnect.File.List.Items[0]));

END_ACTION

ACTION SaveBackupConfiguration:
    
	AutomaticBackupRetain := HmiBackup.Parameters.AutomaticBackup;
    MpBackupConfiguration.AutomaticBackup.Enabled := HmiBackup.Parameters.AutomaticBackup.Enable;
    MpBackupConfiguration.AutomaticBackup.NamePrefix := HmiBackup.Parameters.AutomaticBackup.Prefix;
    MpBackupConfiguration.AutomaticBackup.DeviceName := HmiBackup.Parameters.AutomaticBackup.Device;
    MpBackupConfiguration.AutomaticBackup.OverwriteOldest := HmiBackup.Parameters.AutomaticBackup.OverwriteOldest;
    MpBackupConfiguration.AutomaticBackup.Mode.Time := UDINT_TO_TOD((((USINT_TO_UDINT(HmiBackup.Parameters.AutomaticBackup.Mode.Hour) * 60) + HmiBackup.Parameters.AutomaticBackup.Mode.Minute) * 60) * 1000);
    CASE HmiBackup.Parameters.AutomaticBackup.Mode.Interval OF
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
	
    HmiBackup.Parameters.AutomaticBackup.Enable := MpBackupConfiguration.AutomaticBackup.Enabled;
    HmiBackup.Parameters.AutomaticBackup.Prefix := MpBackupConfiguration.AutomaticBackup.NamePrefix;
    HmiBackup.Parameters.AutomaticBackup.Device := MpBackupConfiguration.AutomaticBackup.DeviceName;
    HmiBackup.Parameters.AutomaticBackup.OverwriteOldest := MpBackupConfiguration.AutomaticBackup.OverwriteOldest;
    HmiBackup.Parameters.AutomaticBackup.Mode.Hour := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60 / 60);
    HmiBackup.Parameters.AutomaticBackup.Mode.Minute := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60) - (HmiBackup.Parameters.AutomaticBackup.Mode.Hour * 60);
    CASE MpBackupConfiguration.AutomaticBackup.Mode.Interval OF
        mpBACKUP_INTERVAL_DAILY:
            HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_EVERYDAY;
        mpBACKUP_INTERVAL_WEEKLY:
            CASE MpBackupConfiguration.AutomaticBackup.Mode.Day OF
                mpBACKUP_DAY_MONDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_MONDAY;
                mpBACKUP_DAY_TUESDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_TUESDAY;
                mpBACKUP_DAY_WEDNESDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_WEDNESDAY;
                mpBACKUP_DAY_THURSDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_THURSDAY;
                mpBACKUP_DAY_FRIDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_FRIDAY;
                mpBACKUP_DAY_SATURDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SATURDAY;
                mpBACKUP_DAY_SUNDAY:
                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SUNDAY;
            END_CASE
    END_CASE
END_ACTION

ACTION FileManager:
	
    MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIBackup);
    MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
    MpFileManagerUI_0();
    FOR i := 0 TO ((SIZEOF(HmiBackup.Status.FileNames)/SIZEOF(HmiBackup.Status.FileNames[0])) - 1) DO
        HmiBackup.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
        HmiBackup.Status.TimeStamps[i] := MpFileManagerUIConnect.File.List.Items[i].LastModified;
        HmiBackup.Status.Size[i] := MpFileManagerUIConnect.File.List.Items[i].Size;
    END_FOR
    
    IF ((MpFileManagerUIConnect.DeviceList.SelectedIndex <> HmiBackup.Status.LastSelectedDeviceIndex) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE)) THEN
        HmiBackup.Status.LastSelectedDeviceIndex := MpFileManagerUIConnect.DeviceList.SelectedIndex;
		IF HmiBackup.Status.LastSelectedIndex > MpFileManagerUIConnect.File.PathInfo.FolderCount THEN
			HmiBackup.Status.SelectedIndex := 0;
		ELSE	
        	HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.LastSelectedIndex + 1;
		END_IF	
    END_IF
    
END_ACTION
