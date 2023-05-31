ACTION HMIAction_Init:
	
	HmiAlarmX.Status.HistoryExportLayer := HIDE;
	
END_ACTION



ACTION HMIActions:
	
	// AlarmHistory Export process has been completed
	IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
		HmiAlarmX.Status.HistoryExportLayer := DISPLAY;	  
	END_IF	
	
	//language assignments
	
	CASE HmiAlarmX.Parameters.Language OF
	
		0://English
			MpAlarmXListUIConnect.Language := 'en';
			MpAlarmXHistory_0.Language := ADR('en');
			MpAlarmXHistoryUIConnect.Language := 'en';
		1://German
			MpAlarmXListUIConnect.Language := 'de';
			MpAlarmXHistory_0.Language := ADR('de');
			MpAlarmXHistoryUIConnect.Language := 'de';
		2://Chinese
			MpAlarmXListUIConnect.Language := 'ch';
			MpAlarmXHistory_0.Language := ADR('ch');
			MpAlarmXHistoryUIConnect.Language := 'ch';
	
	END_CASE
	
END_ACTION
