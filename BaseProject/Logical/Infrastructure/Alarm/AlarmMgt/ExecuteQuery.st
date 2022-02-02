
ACTION ExecuteQuery:

    QueryActiveAlarms.MpLink := ADR(gAlarmXMpLink);
    QueryActiveAlarms.Enable := TRUE;
    QueryActiveAlarms.Name := ADR('ActiveAlarms');
    QueryActiveAlarms.Language := ADR('en');
    QueryActiveAlarms();
    
    CASE (AlarmQuery.State) OF
        ACTIVE_ALARM_WAIT:
            IF (AlarmQuery.LastActiveAlarmUpdateCount <> AlarmQuery.ActiveAlarmUpdateCount) THEN
                brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.LastActiveAlarmUpdateCount := AlarmQuery.ActiveAlarmUpdateCount;
                QueryActiveAlarms.Execute := TRUE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
            
        ACTIVE_ALARM_QUERY:
            IF ((QueryActiveAlarms.CommandDone = TRUE) AND (QueryActiveAlarms.Info.HasMoreRows = FALSE)) THEN
                QueryActiveAlarms.Execute := FALSE;
                QueryActiveAlarms.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_WAIT;
            ELSIF ((QueryActiveAlarms.CommandDone = TRUE) AND (QueryActiveAlarms.Info.HasMoreRows = TRUE)) THEN
                QueryActiveAlarms.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_NEXT;
            END_IF
            
        ACTIVE_ALARM_NEXT:
            IF (AlarmQuery.Next = TRUE) THEN
                brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.Next := FALSE;
                QueryActiveAlarms.Next := TRUE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
        
    END_CASE
    
END_ACTION
