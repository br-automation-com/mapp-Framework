ACTION ChangeConfiguration:

    MpAuditTrailConfig_0.MpLink := ADR(gMpLinkAuditTrail);
    MpAuditTrailConfig_0.Configuration := ADR(AuditTrailConfig);
    
	IF (MpAuditTrailConfig_0.Error = TRUE) THEN
        IF (MpAuditTrailConfig_0.StatusID = mpAUDIT_ERR_CONFIG_LOAD) THEN
            LoadAuditConfiguration;
        END_IF    
        MpAuditTrailConfig_0.Load := FALSE;
        MpAuditTrailConfig_0.Save := FALSE;
        MpAuditTrailConfig_0.ErrorReset := TRUE;
    END_IF
	
    MpAuditTrailConfig_0();
    MpAuditTrailConfig_0.ErrorReset := FALSE;
	
    IF (MpAuditTrailConfig_0.CommandDone = TRUE) THEN
        IF (MpAuditTrailConfig_0.Load = TRUE) THEN
            LoadAuditConfiguration;
        END_IF
		// after save the AuditTrail needs to restart
		IF (MpAuditTrailConfig_0.Save = TRUE) THEN
            MpAuditTrail_0.Enable := FALSE;
        END_IF		
        MpAuditTrailConfig_0.Load := FALSE;
        MpAuditTrailConfig_0.Save := FALSE;
    END_IF
    
END_ACTION
