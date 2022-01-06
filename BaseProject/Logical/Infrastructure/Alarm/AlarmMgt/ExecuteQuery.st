
ACTION ExecuteQuery:

    MpAlarmXQueryActiveAlarmsFB.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXQueryActiveAlarmsFB.Enable := TRUE;
    MpAlarmXQueryActiveAlarmsFB.Name := ADR('ActiveAlarms');
    MpAlarmXQueryActiveAlarmsFB.Language := ADR('en');
    MpAlarmXQueryActiveAlarmsFB();
    
    CASE (AlarmQuery.State) OF
        ACTIVE_ALARM_WAIT:
            IF (AlarmQuery.LastActiveAlarmUpdateCount <> AlarmQuery.ActiveAlarmUpdateCount) THEN
                memset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.LastActiveAlarmUpdateCount := AlarmQuery.ActiveAlarmUpdateCount;
                MpAlarmXQueryActiveAlarmsFB.Execute := TRUE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
            
        ACTIVE_ALARM_QUERY:
            IF ((MpAlarmXQueryActiveAlarmsFB.CommandDone = TRUE) AND (MpAlarmXQueryActiveAlarmsFB.Info.HasMoreRows = FALSE)) THEN
                MpAlarmXQueryActiveAlarmsFB.Execute := FALSE;
                MpAlarmXQueryActiveAlarmsFB.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_WAIT;
            ELSIF ((MpAlarmXQueryActiveAlarmsFB.CommandDone = TRUE) AND (MpAlarmXQueryActiveAlarmsFB.Info.HasMoreRows = TRUE)) THEN
                MpAlarmXQueryActiveAlarmsFB.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_NEXT;
            END_IF
            
        ACTIVE_ALARM_NEXT:
            IF (AlarmQuery.Next = TRUE) THEN
                brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.Next := FALSE;
                MpAlarmXQueryActiveAlarmsFB.Next := TRUE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
        
    END_CASE
    
END_ACTION
