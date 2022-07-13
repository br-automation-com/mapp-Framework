ACTION CustomEvents:

	// sample code how custom event function can be triggered
	IF EDGEPOS(CustomEvent[0].Set) THEN
		MpAuditCustomEvent(gMpLinkCustomEvents,CustomEvent[0].Type,CustomEvent[0].Msg,CustomEvent[0].Comment);
	END_IF
	
	IF EDGENEG(CustomEvent[1].Set) THEN
		MpAuditCustomEvent(gMpLinkCustomEvents,CustomEvent[1].Type,CustomEvent[1].Msg,CustomEvent[1].Comment);
	END_IF


END_ACTION

ACTION ArchiveExport:

	// assigning variable to exchange with the HMI
	MpAuditTrail_0.ExportArchive := HmiAudit.Commands.ExportAudits;
	HmiAudit.Status.ArchiveAvailable := MpAuditTrail_0.ArchiveAvailable;
	HmiAudit.Status.NumberOfArchives := MpAuditTrail_0.Info.NumberArchives;	

	IF (HmiAudit.Commands.ExportAudits AND MpAuditTrail_0.CommandDone) THEN
		HmiAudit.Commands.ExportAudits := FALSE;
	END_IF	

END_ACTION

ACTION ArchiveSettings:

	// Audit Trail Config implementation
	IF (HmiAudit.Commands.SaveConfig = TRUE) THEN
		HmiAudit.Commands.SaveConfig := FALSE;
		SaveBackupConfiguration;
		MpAuditTrailConfig_0.Save := TRUE;
	END_IF

	IF MpAuditTrail_0.Active = FALSE THEN
		MpAuditTrail_0.Enable := TRUE;
	END_IF	

END_ACTION

ACTION SaveBackupConfiguration:

    AuditTrailConfig.Archive.Time := UDINT_TO_TOD((((USINT_TO_UDINT(HmiAudit.Parameters.ArchiveSettings.Hour) * 60) + HmiAudit.Parameters.ArchiveSettings.Minute) * 60) * 1000);
	AuditTrailConfig.Archive.Enable := HmiAudit.Parameters.ArchiveSettings.Enable;
	AuditTrailConfig.Archive.MaxSize := HmiAudit.Parameters.ArchiveSettings.MaxSize;
	AuditTrailConfig.Archive.Mode := HmiAudit.Parameters.ArchiveSettings.Mode;
	
//    MpBackupConfiguration.AutomaticBackup.Enabled := HmiBackup.Parameters.AutomaticBackup.Enable;
//    MpBackupConfiguration.AutomaticBackup.NamePrefix := HmiBackup.Parameters.AutomaticBackup.Prefix;
//    MpBackupConfiguration.AutomaticBackup.DeviceName := HmiBackup.Parameters.AutomaticBackup.Device;
//    MpBackupConfiguration.AutomaticBackup.OverwriteOldest := HmiBackup.Parameters.AutomaticBackup.OverwriteOldest;
//    MpBackupConfiguration.AutomaticBackup.Mode.Time := UDINT_TO_TOD((((USINT_TO_UDINT(HmiBackup.Parameters.AutomaticBackup.Mode.Hour) * 60) + HmiBackup.Parameters.AutomaticBackup.Mode.Minute) * 60) * 1000);
//    CASE HmiAudit.Status.ArchiveSettings.Mode OF
//        ARCHIVE_EVERYDAY:
//            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_DAILY;
//        ARCHIVE_MONDAY_FRIDAY:
//            MpBackupConfiguration.AutomaticBackup.Mode.Interval := mpBACKUP_INTERVAL_WEEKLY;
//            MpBackupConfiguration.AutomaticBackup.Mode.Day := mpBACKUP_DAY_MONDAY;
//    END_CASE
    
    
 END_ACTION

ACTION LoadBackupConfiguration:

	HmiAudit.Parameters.ArchiveSettings.Hour := UDINT_TO_USINT(TOD_TO_UDINT(AuditTrailConfig.Archive.Time) / 1000 / 60 / 60);
    HmiAudit.Parameters.ArchiveSettings.Minute := UDINT_TO_USINT(TOD_TO_UDINT(AuditTrailConfig.Archive.Time) / 1000 / 60) - (HmiAudit.Parameters.ArchiveSettings.Hour * 60);
	HmiAudit.Parameters.ArchiveSettings.Enable := AuditTrailConfig.Archive.Enable;
	HmiAudit.Parameters.ArchiveSettings.MaxSize := AuditTrailConfig.Archive.MaxSize;
	HmiAudit.Parameters.ArchiveSettings.Mode := AuditTrailConfig.Archive.Mode;

//    HmiBackup.Parameters.AutomaticBackup.Enable := MpBackupConfiguration.AutomaticBackup.Enabled;
//    HmiBackup.Parameters.AutomaticBackup.Prefix := MpBackupConfiguration.AutomaticBackup.NamePrefix;
//    HmiBackup.Parameters.AutomaticBackup.Device := MpBackupConfiguration.AutomaticBackup.DeviceName;
//    HmiBackup.Parameters.AutomaticBackup.OverwriteOldest := MpBackupConfiguration.AutomaticBackup.OverwriteOldest;
//    HmiBackup.Parameters.AutomaticBackup.Mode.Hour := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60 / 60);
//    HmiBackup.Parameters.AutomaticBackup.Mode.Minute := UDINT_TO_USINT(TOD_TO_UDINT(MpBackupConfiguration.AutomaticBackup.Mode.Time) / 1000 / 60) - (HmiBackup.Parameters.AutomaticBackup.Mode.Hour * 60);
//    CASE MpBackupConfiguration.AutomaticBackup.Mode.Interval OF
//        mpBACKUP_INTERVAL_DAILY:
//            HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_EVERYDAY;
//        mpBACKUP_INTERVAL_WEEKLY:
//            CASE MpBackupConfiguration.AutomaticBackup.Mode.Day OF
//                mpBACKUP_DAY_MONDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_MONDAY;
//                mpBACKUP_DAY_TUESDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_TUESDAY;
//                mpBACKUP_DAY_WEDNESDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_WEDNESDAY;
//                mpBACKUP_DAY_THURSDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_THURSDAY;
//                mpBACKUP_DAY_FRIDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_FRIDAY;
//                mpBACKUP_DAY_SATURDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SATURDAY;
//                mpBACKUP_DAY_SUNDAY:
//                    HmiBackup.Parameters.AutomaticBackup.Mode.Interval := BACKUP_SUNDAY;
//            END_CASE
//    END_CASE
END_ACTION

ACTION QueryTableConfig:
    
	// Configure visible list
	HmiAudit.Status.TableConfig[0] := '{ "specRows": [{"from":';
	HmiAudit.Status.Query.QueryCount := 0;
    FOR i := 0 TO 9 DO
        IF HmiAudit.Status.Query.Text[i] <> "" THEN
			HmiAudit.Status.Query.QueryCount := i + 1;
		END_IF
    END_FOR
    brsitoa((HmiAudit.Status.Query.QueryCount), ADR(HmiAudit.Status.TableConfig[0]) + brsstrlen(ADR(HmiAudit.Status.TableConfig[0])));
	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(',"to":19, "visible":false}]'));
	// hide operator column for the recipe query
	IF (HmiAudit.Status.Query.Option = 0) THEN 
    	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(', "specColumns": [ {"from":1, "to":1, "visible":true}]'));
	ELSIF (HmiAudit.Status.Query.Option = 1) THEN 
		brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(', "specColumns": [ {"from":1, "to":1, "visible":false}]'));
	END_IF	

	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR('}'));
END_ACTION
