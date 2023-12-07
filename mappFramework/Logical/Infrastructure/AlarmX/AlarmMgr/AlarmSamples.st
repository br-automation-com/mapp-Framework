ACTION AlarmSampleInit:

	// Call all variables that are needed for the alarm examples and explain all examples in comments

	// If AlarmExamples.LevelMonitoring gets less than 20 or more than 80, the LevelMonitoringExample alarm will trigger
	// The Low limit is 20. The LowLow limit is 10. The High limit is 80. The HighHigh limit is 90.
	AlarmExamples.LevelMonitoring := 50;

	// If AlarmExamples.DeviationMonitoring deviates from the setpoint (AlarmExamples.DeviationMonitoringSetpoint) by more than 5
	// units in either direction, the DeviationMonitoringExample alarm will trigger
	AlarmExamples.DeviationMonitoring := 15;
	AlarmExamples.DeviationMonitoringSetpoint := 15;

	// If AlarmExamples.RateOfChange increases at a rate of more than 5 units per second, the RateOfChangeExample alarm will trigger
	AlarmExamples.RateOfChange := 0;

	// If AlarmExamples.SnippetValue gets between 50 and 100, an alarm will trigger and the current value will be shown in the alarm text
	AlarmExamples.SnippetValue := 10;

END_ACTION

ACTION AlarmSampleFub:

	// Example of using the MpAlarmXControl() function block.
	// Typically this function is called from other tasks within the application (decentralized).
	// For example, if you have an error in the recipe system, you can trigger it directly in the recipe task.
	// Therefore, copy/paste this example to other places in the application as needed.
	MpAlarmXControlExample.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXControlExample.Enable := TRUE;
	MpAlarmXControlExample.Name := ADR('MpAlarmXControlExample');
	MpAlarmXControlExample.Set := AlarmExamples.SetControlExample;
	MpAlarmXControlExample();

END_ACTION