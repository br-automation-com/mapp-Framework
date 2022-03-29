ACTION ExecuteQuery:

	// Initialize mapp function block
	QueryActiveAlarms_0.MpLink := ADR(gMpLinkAlarmXCore);
	QueryActiveAlarms_0.Enable := TRUE;
	QueryActiveAlarms_0.Name := ADR('ActiveAlarms');
	QueryActiveAlarms_0.Language := ADR('en');
	QueryActiveAlarms_0();
    
	CASE (AlarmQuery.State) OF
		ACTIVE_ALARM_WAIT:
			// Wait until the RunQuery command is triggered from the HMI. 
			// If you prefer that the query runs anytime new data is available, then uncomment line 15 and comment out line 16 and delete 
			// the "Run query" button from the HMI.
//			IF (AlarmQuery.LastUpdateCount <> AlarmQuery.UpdateCount) THEN
			IF (HmiAlarmX.Commands.RunQuery = TRUE) THEN
				brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
				AlarmQuery.LastUpdateCount := AlarmQuery.UpdateCount;
				QueryActiveAlarms_0.Execute := TRUE;
				HmiAlarmX.Commands.RunQuery := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_QUERY;
			END_IF 
            
		ACTIVE_ALARM_QUERY:
			// If the number of query results is less than MAX_QUERY_RESULTS, return to the wait state
			IF ((QueryActiveAlarms_0.CommandDone = TRUE) AND (QueryActiveAlarms_0.Info.HasMoreRows = FALSE)) THEN
				QueryActiveAlarms_0.Execute := FALSE;
				QueryActiveAlarms_0.Next := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_WAIT;
				// If the number of query results is more than MAX_QUERY_RESULTS, then query the next set of results 
			ELSIF ((QueryActiveAlarms_0.CommandDone = TRUE) AND (QueryActiveAlarms_0.Info.HasMoreRows = TRUE)) THEN
				QueryActiveAlarms_0.Next := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_NEXT;
			END_IF
            
		ACTIVE_ALARM_NEXT:
			IF (AlarmQuery.Next = TRUE) THEN
				// By default, AlarmQuery.Alarms has 20 elements, so it can hold 20 query results at a time (MAX_QUERY_RESULTS = 19).
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
		HmiAlarmX.Status.Query.Active[i] := AlarmQuery.Alarms[i].Active;
		HmiAlarmX.Status.Query.Acknowledged[i] := AlarmQuery.Alarms[i].Acknowledged;
		HmiAlarmX.Status.Query.Scope[i] := AlarmQuery.Alarms[i].Scope;
		HmiAlarmX.Status.Query.Name[i] := AlarmQuery.Alarms[i].Name;
		HmiAlarmX.Status.Query.Message[i] := AlarmQuery.Alarms[i].Message;
		HmiAlarmX.Status.Query.AdditionalInfo[i] := AlarmQuery.Alarms[i].AdditionalInfo;
		HmiAlarmX.Status.Query.TimeStamp[i] := AlarmQuery.Alarms[i].TimeStamp;
		HmiAlarmX.Status.Query.Severity[i] := AlarmQuery.Alarms[i].Severity;
	END_FOR
	
	

END_ACTION
