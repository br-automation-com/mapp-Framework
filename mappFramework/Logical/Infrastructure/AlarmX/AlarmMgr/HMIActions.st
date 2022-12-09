ACTION QueryTableConfig:

	// Configure visible list
	HmiAlarmX.Status.TableConfig[0] := '{ "specRows": [{"from":';
	HmiAlarmX.Status.Query.QueryCount := 0;
	FOR i := 0 TO 9 DO
		IF HmiAlarmX.Status.Query.Message[i] <> "" THEN
			HmiAlarmX.Status.Query.QueryCount := i + 1;
		END_IF
	END_FOR
	brsitoa((HmiAlarmX.Status.Query.QueryCount), ADR(HmiAlarmX.Status.TableConfig[0]) + brsstrlen(ADR(HmiAlarmX.Status.TableConfig[0])));
	brsstrcat(ADR(HmiAlarmX.Status.TableConfig[0]), ADR(',"to":19, "visible":false}]}'));

END_ACTION

ACTION HistoryExportLayer:
	
	// AlarmHistory Export process has been completed
	IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
		HmiAlarmX.Status.HistoryExportLayer := DISPLAY;	  
	END_IF	

END_ACTION

ACTION FirstInCycle:
	
	// The system has been opened just now
	IF isFirstInCycle THEN
		isFirstInCycle := FALSE;
		
		HmiAlarmX.Status.HistoryExportLayer := HIDE;	  
	END_IF

END_ACTION