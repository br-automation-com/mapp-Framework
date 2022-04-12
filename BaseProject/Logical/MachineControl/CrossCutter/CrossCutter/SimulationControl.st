ACTION SimulationControl:

	IF NOT (DiagCpuIsARsim() OR DiagCpuIsSimulated()) THEN
		RETURN;
	END_IF
    
    IF ((MpAxisBasic_0.IsHomed = FALSE) AND (MpAxisBasic_0.Home = FALSE)) THEN
        AxisControl.Command.Reference := TRUE;
    END_IF
    
END_ACTION
