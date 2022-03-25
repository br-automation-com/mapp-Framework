ACTION ExecuteQuery:

    QueryActiveAlarms_0.MpLink := ADR(gMpLinkAlarmXCore);
    QueryActiveAlarms_0.Enable := TRUE;
    QueryActiveAlarms_0.Name := ADR('ActiveAlarms');
    QueryActiveAlarms_0.Language := ADR('en');
    QueryActiveAlarms_0();
    
    CASE (AlarmQuery.State) OF
        ACTIVE_ALARM_WAIT:
            IF (HmiAlarmX.Commands.RunQuery = TRUE) THEN
                brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.LastActiveAlarmUpdateCount := AlarmQuery.ActiveAlarmUpdateCount;
				QueryActiveAlarms_0.Execute := TRUE;
				HmiAlarmX.Commands.RunQuery := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
            
        ACTIVE_ALARM_QUERY:
            IF ((QueryActiveAlarms_0.CommandDone = TRUE) AND (QueryActiveAlarms_0.Info.HasMoreRows = FALSE)) THEN
                QueryActiveAlarms_0.Execute := FALSE;
                QueryActiveAlarms_0.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_WAIT;
            ELSIF ((QueryActiveAlarms_0.CommandDone = TRUE) AND (QueryActiveAlarms_0.Info.HasMoreRows = TRUE)) THEN
                QueryActiveAlarms_0.Next := FALSE;
                AlarmQuery.State := ACTIVE_ALARM_NEXT;
            END_IF
            
        ACTIVE_ALARM_NEXT:
            IF (AlarmQuery.Next = TRUE) THEN
				// AlarmQuery.Alarms has 20 elements, so it can hold 20 query results at a time.
				// If AlarmQuery.Next is true, this means the query result is more than 20 alarms.
				// If you want to save the data for the first 20 alarms, add code here to copy AlarmQuery.Alarms to another location.
				// Otherwise, the older alarms in the query will get overwritten with the newest entries here.
				brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
                AlarmQuery.Next := FALSE;
                QueryActiveAlarms_0.Next := TRUE;
                AlarmQuery.State := ACTIVE_ALARM_QUERY;
            END_IF
	END_CASE
	
	// Convert the query results into arrays that can easily be bound to the Table widget in mapp View
	FOR i := 0 TO MAX_QUERY_RESULTS DO
		AlarmQueryHMI.Active[i] := AlarmQuery.Alarms[i].Active;
		AlarmQueryHMI.Acknowledged[i] := AlarmQuery.Alarms[i].Acknowledged;
		AlarmQueryHMI.Scope[i] := AlarmQuery.Alarms[i].Scope;
		AlarmQueryHMI.Name[i] := AlarmQuery.Alarms[i].Name;
		AlarmQueryHMI.Message[i] := AlarmQuery.Alarms[i].Message;
		AlarmQueryHMI.AdditionalInfo[i] := AlarmQuery.Alarms[i].AdditionalInfo;
		AlarmQueryHMI.TimeStamp[i] := AlarmQuery.Alarms[i].TimeStamp;
		AlarmQueryHMI.Severity[i] := AlarmQuery.Alarms[i].Severity;
	END_FOR
    
END_ACTION
