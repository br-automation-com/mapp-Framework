
ACTION GetBacktraceInformation: 

    MaxIndex := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID)/SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0])) - 1;
    // Find selected alarm in order to show backtrace information 
    FOR Index := 0 TO MaxIndex DO
        IF (MpAlarmXCore_0.PendingAlarms = 0) THEN
            // No pending alarms, reset instance id 
            uInstanceID := 0;
            EXIT;
        END_IF
		
        IF (MpAlarmXListUIConnect.AlarmList.InstanceID[Index] = uInstanceID) THEN
            // Found alarm    
            MpAlarmXListUIConnect.AlarmList.SelectedIndex := Index;
            EXIT;
        END_IF
        
        IF (MpAlarmXListUIConnect.AlarmList.InstanceID[Index] = 0) THEN
            IF (MpAlarmXCore_0.PendingAlarms > Index) THEN
                // Alarm not found, List can page up 
                MpAlarmXListUIConnect.AlarmList.PageUp := TRUE;
            END_IF
			EXIT;
        ELSIF (Index = MaxIndex) THEN
            // Alarm not found, List can page down 
            MpAlarmXListUIConnect.AlarmList.PageDown := TRUE;
        END_IF
	END_FOR

END_ACTION
