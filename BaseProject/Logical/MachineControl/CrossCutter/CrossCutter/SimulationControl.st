ACTION SimulationControl:

	IF NOT (DiagCpuIsARsim() OR DiagCpuIsSimulated()) THEN
		RETURN;
	END_IF
    
    IF ((MpAxisBasicFB.IsHomed = FALSE) AND (MpAxisBasicFB.Home = FALSE)) THEN
        AxisControl.Command.Reference := TRUE;
    END_IF
    
END_ACTION
