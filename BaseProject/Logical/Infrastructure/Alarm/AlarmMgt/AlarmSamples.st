
ACTION AlarmSamples:

    // Variables needed for examples
    AlarmExamples.LevelMonitoring; // If this value gets less than 20 or more than 80, the LevelMonitoringExample alarm will trigger
    AlarmExamples.DeviationMonitoring; // If this value deviates from the setpoint (below) by more than 5 units in either direction, the DeviationMonitoringExample alarm will trigger
    AlarmExamples.DeviationMonitoringSetpoint;
    AlarmExamples.RateOfChange; // If this value increases at a rate of more than 5 units per second, the RateOfChangeExample alarm will trigger 
    AlarmExamples.SnippetValue; //If this value gets between 50 and 100, an alarm will trigger and the current value will be shown in the alarm text
    
    MpAlarmXControlExampleFB.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXControlExampleFB.Enable := TRUE;
    MpAlarmXControlExampleFB.Name := ADR('MpAlarmXControlExample');
    MpAlarmXControlExampleFB.Set := AlarmExamples.ControlExample;
    MpAlarmXControlExampleFB();

END_ACTION
