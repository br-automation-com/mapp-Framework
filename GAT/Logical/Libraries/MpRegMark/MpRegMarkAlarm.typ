
TYPE
    MpRegMarkAlarmEnum : 
        ( (* Alarms of MpRegMark Library *)
        mpREGMARK_ALM_PAR_INVALID := 0, (* The selected parameters are invalid. *)
        mpREGMARK_ALM_CONFIG_NOT_SAVED := 1, (* Some configuration parameters were not saved. *)
        mpREGMARK_ALM_COMMAND_INVALID := 2, (* The command is invalid. *)
        mpREGMARK_ALM_MISSED_MARK := 3 (* No valid registration mark was found. *)
    );
END_TYPE
