
ACTION ChangeConfiguration: 

    MpBackupCoreConfigFB.MpLink := ADR(gBackupCore);
    MpBackupCoreConfigFB.Configuration := ADR(MpBackupConfiguration);
    IF (MpBackupCoreConfigFB.Error = TRUE) THEN
        // Loading currently always throws an error about failed to write Auditing.Type
        IF (MpBackupCoreConfigFB.StatusID = mpBACKUP_ERR_CONFIG_LOAD) THEN
            LoadBackupConfiguration;
        END_IF
        
        MpBackupCoreConfigFB.Load := FALSE;
        MpBackupCoreConfigFB.Save := FALSE;
        MpBackupCoreConfigFB.ErrorReset := TRUE;
    END_IF
    MpBackupCoreConfigFB();
    MpBackupCoreConfigFB.ErrorReset := FALSE;
    IF (MpBackupCoreConfigFB.CommandDone = TRUE) THEN
        IF (MpBackupCoreConfigFB.Load = TRUE) THEN        
            LoadBackupConfiguration;
        END_IF
        MpBackupCoreConfigFB.Load := FALSE;
        MpBackupCoreConfigFB.Save := FALSE;
    END_IF
    
END_ACTION
