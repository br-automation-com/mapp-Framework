ACTION SimulationControl:

    IF NOT (DiagCpuIsARsim() OR DiagCpuIsSimulated()) THEN
        RETURN;
    END_IF
    
    //    IF ((MpAxisBasicFB.Info.ReadyToPowerOn = TRUE) AND (MpAxisBasicFB.PowerOn = FALSE)) THEN
    //        AxisControl.Command.Power := TRUE;
    //    END_IF
    
    IF ((MpAxisBasicFB.IsHomed = FALSE) AND (MpAxisBasicFB.Home = FALSE)) THEN
        AxisControl.Command.Reference := TRUE;
    END_IF
    
END_ACTION
