ACTION ArchiveExport:

	// Assign variables to exchange with the HMI
	MpAuditTrailSys.ExportArchive := HmiAudit.Commands.ExportArchives;
	HmiAudit.Status.ArchiveAvailable := MpAuditTrailSys.ArchiveAvailable;
	HmiAudit.Status.NumberOfArchives := MpAuditTrailSys.Info.NumberArchives;

	IF (HmiAudit.Commands.ExportArchives AND MpAuditTrailSys.CommandDone) THEN
		HmiAudit.Commands.ExportArchives := FALSE;
	END_IF

END_ACTION

ACTION ArchiveSettings:

	// Audit Trail Config implementation
	IF (HmiAudit.Commands.SaveConfig) THEN
		HmiAudit.Commands.SaveConfig := FALSE;
		SaveAuditConfiguration;
		MpAuditTrailConfigSys.Save := TRUE;
	END_IF

	// After the configuration has been changed the AuditTrail is reset (disabled). This re-enables the component
	IF NOT MpAuditTrailSys.Active THEN
		MpAuditTrailSys.Enable := TRUE;
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
			MpAuditTrailSys.Language := ADR('en');
			MpAuditTrailUISys.Language := ADR('en');
			MpAuditTrailCEvents.Language := ADR('en');
			MpAuditTrailCEventsUI.Language := ADR('en');
		// German
		1:
			MpAuditTrailSys.Language := ADR('de');
			MpAuditTrailUISys.Language := ADR('de');
			MpAuditTrailCEvents.Language := ADR('de');
			MpAuditTrailCEventsUI.Language := ADR('de');
		// Chinese
		2:
			MpAuditTrailSys.Language := ADR('zh');
			MpAuditTrailUISys.Language := ADR('zh');
			MpAuditTrailCEvents.Language := ADR('zh');
			MpAuditTrailCEventsUI.Language := ADR('zh');
	
	END_CASE 

END_ACTION
