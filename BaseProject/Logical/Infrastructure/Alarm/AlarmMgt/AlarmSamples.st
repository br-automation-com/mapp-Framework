
ACTION AlarmSamples:

    // Call all variables that are needed for the alarm examples and explain all examples in comments
	
    // If AlarmExamples.LevelMonitoring gets less than 20 or more than 80, the LevelMonitoringExample alarm will trigger
	// The Low limit is 20. The LowLow limit is 10. The High limit is 80. The HighHigh limit is 90. 
	AlarmExamples.LevelMonitoring; 
	// If AlarmExamples.DeviationMonitoring deviates from the setpoint (AlarmExamples.DeviationMonitoringSetpoint) by more than 5
	// units in either direction, the DeviationMonitoringExample alarm will trigger
    AlarmExamples.DeviationMonitoring; 
	AlarmExamples.DeviationMonitoringSetpoint;
    // If AlarmExamples.RateOfChange increases at a rate of more than 5 units per second, the RateOfChangeExample alarm will trigger
	AlarmExamples.RateOfChange;  
	//If AlarmExamples.SnippetValue gets between 50 and 100, an alarm will trigger and the current value will be shown in the alarm text
    AlarmExamples.SnippetValue; 
    
    MpAlarmXControlExampleFB.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXControlExampleFB.Enable := TRUE;
    MpAlarmXControlExampleFB.Name := ADR('MpAlarmXControlExample');
    MpAlarmXControlExampleFB.Set := AlarmExamples.ControlExample;
    MpAlarmXControlExampleFB();

END_ACTION
