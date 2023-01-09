ACTION HMIAction_Init:
	
	HmiAlarmX.Status.HistoryExportLayer := HIDE;
	
END_ACTION



ACTION HMIActions:
	
	// AlarmHistory Export process has been completed
	IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
		HmiAlarmX.Status.HistoryExportLayer := DISPLAY;	  
	END_IF	
	
END_ACTION
