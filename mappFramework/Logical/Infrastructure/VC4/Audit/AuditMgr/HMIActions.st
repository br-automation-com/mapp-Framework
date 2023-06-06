ACTION ArchiveExport:

	// Assign variables to exchange with the HMI
	MpAuditTrail_0.ExportArchive := HmiAudit.Commands.ExportArchives;
	HmiAudit.Status.ArchiveAvailable := MpAuditTrail_0.ArchiveAvailable;
	HmiAudit.Status.NumberOfArchives := MpAuditTrail_0.Info.NumberArchives;

	IF (HmiAudit.Commands.ExportArchives AND MpAuditTrail_0.CommandDone) THEN
		HmiAudit.Commands.ExportArchives := FALSE;
	END_IF

END_ACTION

ACTION ArchiveSettings:

	// Audit Trail Config implementation
	IF (HmiAudit.Commands.SaveConfig = TRUE) THEN
		HmiAudit.Commands.SaveConfig := FALSE;
		SaveAuditConfiguration;
		MpAuditTrailConfig_0.Save := TRUE;
	END_IF

	// After the configuration has been changed the AuditTrail is reset (disabled). This re-enables the component
	IF MpAuditTrail_0.Active = FALSE THEN
		MpAuditTrail_0.Enable := TRUE;
	END_IF

END_ACTION

ACTION SaveAuditConfiguration:

	// Assign current parameters from the HMI structure to AuditTrail configuration before saving it
	AuditTrailConfig.Archive.Time := UDINT_TO_TOD((((USINT_TO_UDINT(HmiAudit.Parameters.ArchiveSettings.Hour) * 60) +
	HmiAudit.Parameters.ArchiveSettings.Minute) * 60) * 1000);
	AuditTrailConfig.Archive.Enable := HmiAudit.Parameters.ArchiveSettings.Enable;
	AuditTrailConfig.Archive.MaxSize := HmiAudit.Parameters.ArchiveSettings.MaxSize;
	AuditTrailConfig.Archive.Mode := HmiAudit.Parameters.ArchiveSettings.Mode;
	AuditTrailConfig.Export.FileType := HmiAudit.Parameters.ArchiveSettings.FileType;

	// Save current archive setings to retain variable
	ArchiveSettingsRetain := HmiAudit.Parameters.ArchiveSettings;

 END_ACTION

ACTION LoadAuditConfiguration:

	// Assign current parameters from the configuration to the HMI structure
	HmiAudit.Parameters.ArchiveSettings.Hour := UDINT_TO_USINT(TOD_TO_UDINT(AuditTrailConfig.Archive.Time) / 1000 / 60 / 60);
	HmiAudit.Parameters.ArchiveSettings.Minute := UDINT_TO_USINT(TOD_TO_UDINT(AuditTrailConfig.Archive.Time) / 1000 / 60) -
													(HmiAudit.Parameters.ArchiveSettings.Hour * 60);
	HmiAudit.Parameters.ArchiveSettings.Enable := AuditTrailConfig.Archive.Enable;
	HmiAudit.Parameters.ArchiveSettings.MaxSize := AuditTrailConfig.Archive.MaxSize;
	HmiAudit.Parameters.ArchiveSettings.Mode := AuditTrailConfig.Archive.Mode;
	HmiAudit.Parameters.ArchiveSettings.FileType := AuditTrailConfig.Export.FileType;

END_ACTION

ACTION VC4_Cyclic:
 
	// Language assignments	 
	CASE HmiAudit.Parameters.Language OF
	
		//English
		0:
			MpAuditTrail_0.Language := ADR('en');
			MpAuditTrailUI_0.Language := ADR('en');
			MpAuditTrail_CEvents.Language := ADR('en');
			MpAuditTrail_CEvents_UI_0.Language := ADR('en');
		// German
		1:
			MpAuditTrail_0.Language := ADR('de');
			MpAuditTrailUI_0.Language := ADR('de');
			MpAuditTrail_CEvents.Language := ADR('de');
			MpAuditTrail_CEvents_UI_0.Language := ADR('de');
		// Chinese
		2:
			MpAuditTrail_0.Language := ADR('zh');
			MpAuditTrailUI_0.Language := ADR('zh');
			MpAuditTrail_CEvents.Language := ADR('zh');
			MpAuditTrail_CEvents_UI_0.Language := ADR('zh');
	
	END_CASE 

END_ACTION
