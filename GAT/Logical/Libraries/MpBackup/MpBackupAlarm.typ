
TYPE
    MpBackupAlarmEnum : 
        ( (* Alarms of MpBackup Library *)
        mpBACKUP_ALM_CREATE_FAILED := 0, (* A backup could not have been created *)
        mpBACKUP_ALM_INSTALL_FAILED := 1, (* A backup/update could not have been installed *)
        mpBACKUP_ALM_UPDATE_CHECK_FAILED := 2 (* Update check could not have been performed *)
    );
END_TYPE
