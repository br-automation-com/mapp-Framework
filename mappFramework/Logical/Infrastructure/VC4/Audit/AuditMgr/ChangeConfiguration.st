ACTION ChangeConfiguration:

	MpAuditTrailConfigSys.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrailConfigSys.Configuration := ADR(AuditTrailConfig);

	IF (MpAuditTrailConfigSys.Error = TRUE) THEN
		IF (MpAuditTrailConfigSys.StatusID = mpAUDIT_ERR_CONFIG_LOAD) THEN
			LoadAuditConfiguration;
		END_IF
		MpAuditTrailConfigSys.Load := FALSE;
		MpAuditTrailConfigSys.Save := FALSE;
		MpAuditTrailConfigSys.ErrorReset := TRUE;
	END_IF

	MpAuditTrailConfigSys();
	MpAuditTrailConfigSys.ErrorReset := FALSE;

	IF (MpAuditTrailConfigSys.CommandDone = TRUE) THEN
		IF (MpAuditTrailConfigSys.Load = TRUE) THEN
			LoadAuditConfiguration;
		END_IF
		// after save the AuditTrail needs to restart
		IF (MpAuditTrailConfigSys.Save = TRUE) THEN
			MpAuditTrailSys.Enable := FALSE;
		END_IF
		MpAuditTrailConfigSys.Load := FALSE;
		MpAuditTrailConfigSys.Save := FALSE;
	END_IF

END_ACTION
