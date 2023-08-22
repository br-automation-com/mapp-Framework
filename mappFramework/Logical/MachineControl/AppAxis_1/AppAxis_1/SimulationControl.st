ACTION SimulationControl:
	// Automatic settings when project is in simulation
	IF NOT (DiagCpuIsARsim() OR DiagCpuIsSimulated()) THEN
		RETURN;
	END_IF

	IF ((MpAxisBasicAppAxis.IsHomed = FALSE) AND (MpAxisBasicAppAxis.Home = FALSE)) THEN
		AxisControl.Command.Reference := TRUE;
	END_IF

END_ACTION
