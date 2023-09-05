ACTION VC4_Init:
	
	// Initial layer visibility setup
	HmiAlarmX.Status.HistoryExportLayer := HIDE;
	
END_ACTION

ACTION VC4_Cyclic:
	
	// AlarmHistory Export process has been completed
	IF ((MpAlarmXHistoryMain.Export) AND (MpAlarmXHistoryMain.CommandDone)) THEN
		HmiAlarmX.Status.HistoryExportLayer := DISPLAY;	  
	END_IF	
	
	// Language assignments	  
	CASE HmiAlarmX.Parameters.Language OF
	
		// English
		0:
			MpAlarmXListUIConnect.Language := 'en';
			MpAlarmXHistoryMain.Language := ADR('en');
			MpAlarmXHistoryUIConnect.Language := 'en';
			QueryActiveAlarms.Language := ADR('en');
		// German
		1:
			MpAlarmXListUIConnect.Language := 'de';
			MpAlarmXHistoryMain.Language := ADR('de');
			MpAlarmXHistoryUIConnect.Language := 'de';
			QueryActiveAlarms.Language := ADR('de');
		// Chinese
		2:
			MpAlarmXListUIConnect.Language := 'zh';
			MpAlarmXHistoryMain.Language := ADR('zh');
			MpAlarmXHistoryUIConnect.Language := 'zh';
			QueryActiveAlarms.Language := ADR('zh');	  
		
	END_CASE
	
END_ACTION
