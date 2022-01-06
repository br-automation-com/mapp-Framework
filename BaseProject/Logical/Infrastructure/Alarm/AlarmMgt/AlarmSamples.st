
ACTION AlarmSamples:

    // Variables needed for examples
    AlarmExamples.LevelMonitoring;
    AlarmExamples.DeviationMonitoring;
    AlarmExamples.DeviationMonitoringSetpoint;
    AlarmExamples.RateOfChange;
    AlarmExamples.SnippetValue;
    
    MpAlarmXControlExampleFB.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXControlExampleFB.Enable := TRUE;
    MpAlarmXControlExampleFB.Name := ADR('MpAlarmXControlExample');
    MpAlarmXControlExampleFB.Set := AlarmExamples.ControlExample;
    MpAlarmXControlExampleFB();

END_ACTION
