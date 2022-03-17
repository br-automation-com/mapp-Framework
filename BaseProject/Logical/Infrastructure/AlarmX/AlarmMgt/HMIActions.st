
ACTION GetBacktraceInformation: 

    MaxIndex := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID)/SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0])) - 1;
    // Find selected alarm in order to show backtrace information 
    FOR Index := 0 TO MaxIndex DO
        IF (MpAlarmXCore_0.PendingAlarms = 0) THEN
            // No pending alarms, reset instance id 
            InstanceID := 0;
            EXIT;
        END_IF
		
        IF (MpAlarmXListUIConnect.AlarmList.InstanceID[Index] = InstanceID) THEN
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


ACTION QueryTableConfig: 
    
	// Configure visible list 
    brsstrcpy(ADR(HmiAlarmX.Status.TableConfig[0]), ADR('{ "specRows": [{"from":'));
	FOR i := 0 TO 9 DO 
		IF AlarmQueryHMI.Message[i] <> "" THEN
			EntryCount := i+1;
		END_IF
	END_FOR	
	brsitoa((EntryCount), ADR(HmiAlarmX.Status.TableConfig[0]) + brsstrlen(ADR(HmiAlarmX.Status.TableConfig[0])));	
    brsstrcat(ADR(HmiAlarmX.Status.TableConfig[0]),  ADR(',"to":19, "visible":false}]}'));
	
    
END_ACTION