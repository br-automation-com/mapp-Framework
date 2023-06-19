ACTION SaveBackupConfiguration:

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

	// Save current backup setings to retain variable
	AutomaticBackupRetain := HmiBackup.Parameters.AutomaticBackup;

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
		
		HmiBackup.Status.TimeStampsString[i] := DT_TO_STRING(HmiBackup.Status.TimeStamps[i]);
		IF HmiBackup.Status.FileNames[i] <> '' THEN
			HmiBackup.Status.TimeStampsString[i] := RIGHT(HmiBackup.Status.TimeStampsString[i], 19);
		ELSE
			HmiBackup.Status.TimeStampsString[i] := '';	
		END_IF;
	END_FOR

	IF ((MpFileManagerUIConnect.DeviceList.SelectedIndex <> HmiBackup.Status.LastSelectedDeviceIndex) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE)) THEN
		HmiBackup.Status.LastSelectedDeviceIndex := MpFileManagerUIConnect.DeviceList.SelectedIndex;
		IF HmiBackup.Status.LastSelectedIndex >= MpFileManagerUIConnect.File.PathInfo.FolderCount THEN
			HmiBackup.Status.SelectedIndex := 0;
		ELSE
			HmiBackup.Status.LastSelectedIndex := HmiBackup.Status.LastSelectedIndex + 1;
		END_IF
	END_IF

END_ACTION


ACTION VC4_Cylic:	  

	IF HmiBackup.Status.DeviceDataProviderSelectedIndex = 0 THEN
		HmiBackup.Parameters.AutomaticBackup.Device := 'mappBackupFiles';
		
	ELSIF HmiBackup.Status.DeviceDataProviderSelectedIndex = 1 THEN
		HmiBackup.Parameters.AutomaticBackup.Device := 'USB';
		
	ELSIF HmiBackup.Status.DeviceDataProviderSelectedIndex = 2 THEN
		HmiBackup.Parameters.AutomaticBackup.Device := '';
		
	ELSIF HmiBackup.Status.DeviceDataProviderSelectedIndex = 3 THEN
		HmiBackup.Parameters.AutomaticBackup.Device := '';
	END_IF;
	
	// Function is not available Layer manager
	IF HmiBackup.Status.CmdButtonsPressed AND HmiBackup.Status.SimulationActive THEN
		HmiBackup.Status.Layer.FuncNotAvailable := DISPLAY;
	ELSE
		HmiBackup.Status.Layer.FuncNotAvailable := HIDE;		
	END_IF;	
	
	// New version available Layer manager
	IF HmiBackup.Status.Update.IsAvailable AND HmiBackup.Status.ButtonOperation.CheckForUpdate = 1 THEN
		HmiBackup.Status.Layer.NewVersion := DISPLAY;
	ELSE
		HmiBackup.Status.Layer.NewVersion := HIDE;		
	END_IF;	

	// Visibility creating layer
	IF BackupState = BACKUP_CREATING THEN
		HmiBackup.Status.Layer.Creating := DISPLAY;
	ELSE
		HmiBackup.Status.Layer.Creating := HIDE;
	END_IF;	
	
	// Visibility UpDown buttons
	IF HmiBackup.Status.FileOverMax THEN
		HmiBackup.Status.ButtonOperation.VisibilityPageUpDown := DISPLAY;
	ELSE
		HmiBackup.Status.ButtonOperation.VisibilityPageUpDown := HIDE;	  
	END_IF;	
	
	// Operation Create Button
	IF HmiBackup.Status.CreateAllowed AND NOT HmiBackup.Status.SimulationActive THEN
		HmiBackup.Status.ButtonOperation.OperationCreate := OPERATION_ACTIVATED;
	ELSE
		HmiBackup.Status.ButtonOperation.OperationCreate := OPERATION_DEACTIVATED;
	END_IF;	
	
	// Operation Restore Button
	IF HmiBackup.Status.RestoreAllowed AND NOT HmiBackup.Status.SimulationActive THEN
		HmiBackup.Status.ButtonOperation.OperationRestore := OPERATION_ACTIVATED;
	ELSE
		HmiBackup.Status.ButtonOperation.OperationRestore := OPERATION_DEACTIVATED;
	END_IF;	
	
	// Operation Delete Button
	IF NOT HmiBackup.Status.SimulationActive THEN
		HmiBackup.Status.ButtonOperation.OperationDelete := OPERATION_ACTIVATED;
	ELSE
		HmiBackup.Status.ButtonOperation.OperationDelete := OPERATION_DEACTIVATED;
	END_IF;	
	
	// Operation Settings Button
	IF NOT HmiBackup.Status.SimulationActive THEN
		HmiBackup.Status.ButtonOperation.OperationSettings := OPERATION_ACTIVATED;
	ELSE
		HmiBackup.Status.ButtonOperation.OperationSettings := OPERATION_DEACTIVATED;
	END_IF;	  
	
	//BackupDetailsStatus Visible/Hide
	IF HmiBackup.Status.BackupCtrlEnabled AND HmiBackup.Status.Info.Name <> '' THEN
		HmiBackup.Status.BackupDetailsStatus := DISPLAY;	
		
	ELSIF NOT HmiBackup.Status.BackupCtrlEnabled OR HmiBackup.Status.Info.Name = '' THEN
		HmiBackup.Status.BackupDetailsStatus := HIDE;		
	END_IF;
	  
	//settings contents
	IF HmiBackup.Parameters.AutomaticBackup.Enable THEN
		HmiBackup.Status.SettingsContentsStatus := USINT_TO_BOOL(DISPLAY);
	ELSE
		HmiBackup.Status.SettingsContentsStatus := USINT_TO_BOOL(HIDE);	  
	END_IF;

END_ACTION

