ACTION ChangeConfiguration:

	MpBackupCoreConfigSys.MpLink := ADR(gMpLinkBackupCore);
	MpBackupCoreConfigSys.Configuration := ADR(MpBackupConfiguration);
	IF (MpBackupCoreConfigSys.Error) THEN
		// Loading currently always throws an error about failed to write Auditing.Type
		IF (MpBackupCoreConfigSys.StatusID = mpBACKUP_ERR_CONFIG_LOAD) THEN
			LoadBackupConfiguration;
		END_IF

		MpBackupCoreConfigSys.Load := FALSE;
		MpBackupCoreConfigSys.Save := FALSE;
		MpBackupCoreConfigSys.ErrorReset := TRUE;
	END_IF
	MpBackupCoreConfigSys();
	MpBackupCoreConfigSys.ErrorReset := FALSE;
	IF (MpBackupCoreConfigSys.CommandDone) THEN
		IF (MpBackupCoreConfigSys.Load) THEN
			LoadBackupConfiguration;
		END_IF
		MpBackupCoreConfigSys.Load := FALSE;
		MpBackupCoreConfigSys.Save := FALSE;
	END_IF

END_ACTION
