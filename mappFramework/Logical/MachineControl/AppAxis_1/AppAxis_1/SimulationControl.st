ACTION SimulationControl:
	// Automatic settings when project is in simulation
	IF NOT (DiagCpuIsARsim() OR DiagCpuIsSimulated()) THEN
		RETURN;
	END_IF

	IF ((NOT MpAxisBasicAppAxis.IsHomed) AND (NOT MpAxisBasicAppAxis.Home)) THEN
		AxisControl.Command.Reference := TRUE;
	END_IF

END_ACTION
