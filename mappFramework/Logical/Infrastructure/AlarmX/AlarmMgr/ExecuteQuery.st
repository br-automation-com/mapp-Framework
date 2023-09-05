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
			IF (HmiAlarmX.Commands.RunQuery) THEN
				brsmemset(ADR(AlarmQuery.Alarms[0]), 0, SIZEOF(AlarmQuery.Alarms));
				AlarmQuery.LastUpdateCount := AlarmQuery.UpdateCount;
				QueryActiveAlarms.Execute := TRUE;
				HmiAlarmX.Commands.RunQuery := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_QUERY;
			END_IF

		ACTIVE_ALARM_QUERY:
			// If the number of query results is less than MAX_QUERY_RESULTS, return to the wait state
			IF (QueryActiveAlarms.CommandDone AND (NOT QueryActiveAlarms.Info.HasMoreRows)) THEN
				QueryActiveAlarms.Execute := FALSE;
				QueryActiveAlarms.Next := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_WAIT;
				// If the number of query results is more than MAX_QUERY_RESULTS, then query the next set of results
			ELSIF ((QueryActiveAlarms.CommandDone) AND (QueryActiveAlarms.Info.HasMoreRows)) THEN
				QueryActiveAlarms.Next := FALSE;
				AlarmQuery.State := ACTIVE_ALARM_NEXT;
			END_IF

		ACTIVE_ALARM_NEXT:
			IF (AlarmQuery.Next) THEN
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
		
		IF HmiAlarmX.Status.Query.Active[i] AND NOT HmiAlarmX.Status.Query.Acknowledged[i] THEN
			HmiAlarmX.Status.Query.State[i] := ACTIVE_NOT_ACKNOWLEDGED;
		ELSIF HmiAlarmX.Status.Query.Active[i] AND HmiAlarmX.Status.Query.Acknowledged[i] THEN
			HmiAlarmX.Status.Query.State[i] := ACTIVE_ACKNOWLEDGED;
		ELSIF NOT HmiAlarmX.Status.Query.Active[i] AND NOT HmiAlarmX.Status.Query.Acknowledged[i] THEN
				HmiAlarmX.Status.Query.State[i] := INACTIVE_NOT_ACKNOWLEDGED;
		ELSIF NOT HmiAlarmX.Status.Query.Active[i] AND HmiAlarmX.Status.Query.Acknowledged[i] THEN
				HmiAlarmX.Status.Query.State[i] := INACTIVE_ACKNOWLEDGED;
		END_IF
		
	END_FOR



END_ACTION
