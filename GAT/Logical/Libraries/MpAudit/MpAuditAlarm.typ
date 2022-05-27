
TYPE
    MpAuditTrailAlarmEnum : 
        ( (* Alarms of MpAudit Trail *)
        mpAUDIT_ALM_ARCHIVE_AVAILABLE := 0, (* Archive is available for export *)
        mpAUDIT_ALM_ARCHIVE_OVERFLOW := 1 (* Max. number of archives reached - archiving stopped *)
    );
END_TYPE
