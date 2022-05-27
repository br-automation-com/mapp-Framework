
TYPE
    MpDataRecorderAlarmEnum : 
        ( (* Alarms of MpData Recorder *)
        mpDATA_ALM_RECORDING_COMPLETED := 0, (* Recording has completed *)
        mpDATA_ALM_RECORDING_ABORTED := 1, (* Recording has been aborted due to error in data recorder *)
        mpDATA_ALM_LIMIT_VIOLATED := 2 (* Value of a registered PV has violated limits *)
    );
END_TYPE
