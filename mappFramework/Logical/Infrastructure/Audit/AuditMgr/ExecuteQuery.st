ACTION ExecuteQuery:

	// Initialize mapp function block
	QueryUserEvents.MpLink := ADR(gMpLinkAuditTrail);
	QueryUserEvents.Enable := TRUE;
	QueryUserEvents.Name := ADR(HmiAudit.Status.Query.Name);
	QueryUserEvents.Language := ADR('en');
	QueryUserEvents();

	CASE (AuditQuery.State) OF
		ACTIVE_AUDIT_WAIT:
			// Wait until the RunQuery command is triggered from the HMI.
			// If you prefer that the query runs anytime new data is available, then uncomment line 15 and comment out line 16 and delete
			// the "Run query" button from the HMI.
			//IF (AuditQuery.LastUpdateCount <> AuditQuery.UpdateCount) THEN
			IF (HmiAudit.Commands.RunQuery = TRUE) THEN
				// Call the custom event function when the query execution is triggered
				MpAuditCustomEvent(gMpLinkCustomEvents,CustomEvent[2].Type,CustomEvent[2].Msg,CustomEvent[2].Comment);
				brsmemset(ADR(AuditQuery.Audits[0]), 0, SIZEOF(AuditQuery.Audits));
				AuditQuery.LastUpdateCount := AuditQuery.UpdateCount;
				QueryUserEvents.Execute := TRUE;
				HmiAudit.Commands.RunQuery := FALSE;
				IF (HmiAudit.Status.Query.Name = 'UserEvents') THEN
					HmiAudit.Status.Query.Option := 0;
				ELSIF (HmiAudit.Status.Query.Name = 'RecipeEvents') THEN
					HmiAudit.Status.Query.Option := 1;
				END_IF

				AuditQuery.State := ACTIVE_AUDIT_QUERY;
			END_IF

		ACTIVE_AUDIT_QUERY:
			// If the number of query results is less than MAX_QUERY_RESULTS, return to the wait state
			IF ((QueryUserEvents.CommandDone = TRUE) AND (QueryUserEvents.Info.HasMoreRows = FALSE)) THEN
				// Call the custom event function when the query execution is done
				MpAuditCustomEvent(gMpLinkCustomEvents,"Cmd Done","Executing the query command has finished","For additional information check the logger.");
				QueryUserEvents.Execute := FALSE;
				QueryUserEvents.Next := FALSE;
				AuditQuery.State := ACTIVE_AUDIT_WAIT;
				// If the number of query results is more than MAX_QUERY_RESULTS, then query the next set of results
			ELSIF ((QueryUserEvents.CommandDone = TRUE) AND (QueryUserEvents.Info.HasMoreRows = TRUE)) THEN
				QueryUserEvents.Next := FALSE;
				AuditQuery.State := ACTIVE_AUDIT_NEXT;
			END_IF

		ACTIVE_AUDIT_NEXT:
			IF (AuditQuery.Next = TRUE) THEN
				// By default, AuditQuery.Alarms has 20 elements, so it can hold 20 query results at a time (MAX_QUERY_RESULTS = 19).
				// If AuditQuery.Next is true, this means the query result is more than 20 alarms.
				// If you want to save the data for the first 20 alarms, add code here to copy AuditQuery.Alarms to another location.
				// Otherwise, the older alarms in the query will get overwritten with the newest entries here.
				brsmemset(ADR(AuditQuery.Audits[0]), 0, SIZEOF(AuditQuery.Audits));
				AuditQuery.Next := FALSE;
				QueryUserEvents.Next := TRUE;
				AuditQuery.State := ACTIVE_AUDIT_QUERY;
			END_IF
	END_CASE

	// Convert the query results into arrays that can easily be bound to the Table widget in mapp View
	FOR i := 0 TO MAX_QUERY_RESULTS DO
		HmiAudit.Status.Query.EvTime[i] := AuditQuery.Audits[i].EvTime;
		HmiAudit.Status.Query.Op[i] := AuditQuery.Audits[i].Op;
		HmiAudit.Status.Query.Text[i] := AuditQuery.Audits[i].Text;
		HmiAudit.Status.Query.DText[i] := AuditQuery.Audits[i].DText;
	END_FOR

END_ACTION
