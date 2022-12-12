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