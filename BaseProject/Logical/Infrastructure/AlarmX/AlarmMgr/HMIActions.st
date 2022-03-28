ACTION GetBacktraceInformation:

    MaxIndex := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID)/SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0])) - 1;
    // Find selected alarm in order to show backtrace information
    FOR i := 0 TO MaxIndex DO
        IF (MpAlarmXCore_0.PendingAlarms = 0) THEN
            // No pending alarms, reset instance id
			HmiAlarmX.Status.InstanceID := 0;
			EXIT;
        END_IF
	
        IF (MpAlarmXListUIConnect.AlarmList.InstanceID[i] = HmiAlarmX.Status.InstanceID) THEN
            // Found alarm
            MpAlarmXListUIConnect.AlarmList.SelectedIndex := i;
            EXIT;
        END_IF
        
        IF (MpAlarmXListUIConnect.AlarmList.InstanceID[i] = 0) THEN
            IF (MpAlarmXCore_0.PendingAlarms > i) THEN
                // Alarm not found, List can page up
                MpAlarmXListUIConnect.AlarmList.PageUp := TRUE;
            END_IF
			EXIT;
        ELSIF (i = MaxIndex) THEN
            // Alarm not found, List can page down
            MpAlarmXListUIConnect.AlarmList.PageDown := TRUE;
        END_IF
	END_FOR

END_ACTION

ACTION QueryTableConfig:
    
	// Configure visible list
	HmiAlarmX.Status.TableConfig[0] := '{ "specRows": [{"from":';
    FOR i := 0 TO 9 DO
        IF HmiAlarmX.Status.Query.Message[i] <> "" THEN
			HmiAlarmX.Status.Query.QueryCount := i + 1;
		END_IF
    END_FOR
    brsitoa((HmiAlarmX.Status.Query.QueryCount), ADR(HmiAlarmX.Status.TableConfig[0]) + brsstrlen(ADR(HmiAlarmX.Status.TableConfig[0])));
    brsstrcat(ADR(HmiAlarmX.Status.TableConfig[0]),  ADR(',"to":19, "visible":false}]}'));
	
END_ACTION
