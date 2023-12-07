ACTION ChangeConfiguration:

	MpAuditTrailConfigSys.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrailConfigSys.Configuration := ADR(AuditTrailConfig);

	IF (MpAuditTrailConfigSys.Error) THEN
		IF (MpAuditTrailConfigSys.StatusID = mpAUDIT_ERR_CONFIG_LOAD) THEN
			LoadAuditConfiguration;
		END_IF
		MpAuditTrailConfigSys.Load := FALSE;
		MpAuditTrailConfigSys.Save := FALSE;
		MpAuditTrailConfigSys.ErrorReset := TRUE;
	END_IF

	MpAuditTrailConfigSys();
	MpAuditTrailConfigSys.ErrorReset := FALSE;

	IF (MpAuditTrailConfigSys.CommandDone) THEN
		IF (MpAuditTrailConfigSys.Load) THEN
			LoadAuditConfiguration;
		END_IF
		// after save the AuditTrail needs to restart
		IF (MpAuditTrailConfigSys.Save) THEN
			MpAuditTrailSys.Enable := FALSE;
		END_IF
		MpAuditTrailConfigSys.Load := FALSE;
		MpAuditTrailConfigSys.Save := FALSE;
	END_IF

END_ACTION
