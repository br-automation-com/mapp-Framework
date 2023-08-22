ACTION ExecuteQuery:

	// Initialize mapp function block
	QueryActiveAlarms.MpLink := ADR(gMpLinkAlarmXCore);
	QueryActiveAlarms.Enable := TRUE;
	QueryActiveAlarms.Name := ADR('ActiveAlarms');
	QueryActiveAlarms.Language := ADR('en');
	QueryActiveAlarms();

	CASE (AlarmQuery.State) OF
		ACTIVE_ALARM_WAIT:
			// Wait until the RunQuery command is triggered from the HMI.
			// If you prefer that the query runs anytime new data is available, then uncomment line 15 and comment out line 16 and delete
			// the "Run query" button from the HMI.
			//IF (AlarmQuery.LastUpdateCount <> AlarmQuery.UpdateCount) THEN
			IF (HmiAlarmX.Commands.RunQuery = TRUE) THEN
				brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
				AlarmQuery.LastUpdateCount := AlarmQuery.UpdateCount;
				QueryActiveAlarms.Execute := TRUE;
				HmiAlarmX.Commands.RunQuery := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_QUERY;
			END_IF

		ACTIVE_ALARM_QUERY:
			// If the number of query results is less than MAX_QUERY_RESULTS, return to the wait state
			IF ((QueryActiveAlarms.CommandDone = TRUE) AND (QueryActiveAlarms.Info.HasMoreRows = FALSE)) THEN
				QueryActiveAlarms.Execute := FALSE;
				QueryActiveAlarms.Next := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_WAIT;			
				// Convert the query results into arrays that can be displayed in VC4
				FOR i := 0 TO MAX_QUERY_RESULTS DO
					HmiAlarmX.Status.Query.Active[i] := AlarmQuery.Alarms[i].Active;
					HmiAlarmX.Status.Query.Acknowledged[i] := AlarmQuery.Alarms[i].Acknowledged;
					HmiAlarmX.Status.Query.Scope[i] := AlarmQuery.Alarms[i].Scope;
					HmiAlarmX.Status.Query.Name[i] := AlarmQuery.Alarms[i].Name;
					HmiAlarmX.Status.Query.Message[i] := AlarmQuery.Alarms[i].Message;
					HmiAlarmX.Status.Query.AdditionalInfo[i] := AlarmQuery.Alarms[i].AdditionalInfo;
					HmiAlarmX.Status.Query.TimeStamp[i] := DT_TO_STRING(AlarmQuery.Alarms[i].TimeStamp);
					HmiAlarmX.Status.Query.TimeStamp[i] := RIGHT(HmiAlarmX.Status.Query.TimeStamp[i], 19);
					HmiAlarmX.Status.Query.Severity[i] := AlarmQuery.Alarms[i].Severity;
				END_FOR
				//Update the count of active alarms
				HmiAlarmX.Status.Query.QueryCount := 0;
				FOR i := 0 TO MAX_QUERY_RESULTS DO
					IF HmiAlarmX.Status.Query.Message[i] <> "" THEN
						HmiAlarmX.Status.Query.QueryCount := i;
					END_IF
				END_FOR
			// If the number of query results is more than MAX_QUERY_RESULTS, then query the next set of results	
			ELSIF ((QueryActiveAlarms.CommandDone = TRUE) AND (QueryActiveAlarms.Info.HasMoreRows = TRUE)) THEN
				QueryActiveAlarms.Next := FALSE;
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
				QueryActiveAlarms.Next := TRUE;
				AlarmQuery.State := ACTIVE_ALARM_QUERY;
			END_IF
	END_CASE 

END_ACTION
