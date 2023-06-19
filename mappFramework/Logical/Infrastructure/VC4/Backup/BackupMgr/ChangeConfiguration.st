ACTION ChangeConfiguration:

	MpBackupCoreConfig_0.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreConfig_0.Configuration := ADR(MpBackupConfiguration);
	
	IF (MpBackupCoreConfig_0.Error = TRUE) THEN
		// Loading currently always throws an error about failed to write Auditing.Type
		IF (MpBackupCoreConfig_0.StatusID = mpBACKUP_ERR_CONFIG_LOAD) THEN
			LoadBackupConfiguration;
		END_IF

		MpBackupCoreConfig_0.Load := FALSE;
		MpBackupCoreConfig_0.Save := FALSE;
		MpBackupCoreConfig_0.ErrorReset := TRUE;
	END_IF
	
	MpBackupCoreConfig_0();
	MpBackupCoreConfig_0.ErrorReset := FALSE;
	
	IF (MpBackupCoreConfig_0.CommandDone = TRUE) THEN
		IF (MpBackupCoreConfig_0.Load = TRUE) THEN
			LoadBackupConfiguration;
		END_IF
		MpBackupCoreConfig_0.Load := FALSE;
		MpBackupCoreConfig_0.Save := FALSE;
	END_IF

END_ACTION
