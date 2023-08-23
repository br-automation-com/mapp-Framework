ACTION ConfigurationInit:
	// Initalize drive configuration
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.DataAddress := ADR(AxisSettings.AxisFeatures);
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfArrayElements := SIZEOF(AxisSettings.AxisFeatures)/SIZEOF(AxisSettings.AxisFeatures[0]);
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfElements := 0;
	i := 0;
	WHILE ((i <= SIZEOF(AxisSettings.AxisFeatures)/SIZEOF(AxisSettings.AxisFeatures[0])) AND (AxisSettings.AxisFeatures[i] <> '')) DO
		i := i + 1;
	END_WHILE
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfElements := i;

	ProcessConfigAX.DataAddress := ADR(AxisSettings.BaseConfiguration);
	ProcessConfigAX.DataType := mcCFG_AX;

	ProcessConfigACP.DataAddress := ADR(AxisSettings.DriveConfiguration);
	ProcessConfigACP.DataType := mcCFG_PURE_V_AX;

	ConfigurationState := CONFIG_STATE_INIT;

END_ACTION

ACTION ChangeConfiguration:

	CASE ConfigurationState OF
		CONFIG_STATE_INIT:

			// Assign string for the name
			ProcessConfigACP.Name := MpAxisBasicAppAxis.Info.HardwareInfo.Axis.ConfigElementLocation;
			ProcessConfigAX.Name := MpAxisBasicAppAxis.Info.HardwareInfo.Axis.AxisName;

			IF (MpAxisBasicAppAxis.Active = TRUE) THEN
				ConfigurationState := CONFIG_STATE_READ;
			END_IF

		CONFIG_STATE_READ:
			// Read the current configuration
			ProcessConfigACP.Mode := mcPCM_LOAD;
			ProcessConfigACP.Execute := TRUE;

			ProcessConfigAX.Mode := mcPCM_LOAD;
			ProcessConfigAX.Execute := TRUE;
			IF (ProcessConfigACP.Done = TRUE) AND (ProcessConfigAX.Done = TRUE) THEN
				ProcessConfigACP.Execute := FALSE;
				ProcessConfigAX.Execute := FALSE;
				ConfigurationState := CONFIG_STATE_READY;
			END_IF

		CONFIG_STATE_WRITE:
			// Write the configuration after changes
			ProcessConfigACP.Mode := mcPCM_SAVE;
			ProcessConfigACP.Execute := TRUE;

			ProcessConfigAX.Mode := mcPCM_SAVE;
			ProcessConfigAX.Execute := TRUE;
			IF (ProcessConfigACP.Done = TRUE) AND (ProcessConfigAX.Done = TRUE) THEN
				ProcessConfigACP.Execute := FALSE;
				ProcessConfigAX.Execute := FALSE;
				ConfigurationState := CONFIG_STATE_READY;
			END_IF

		CONFIG_STATE_READY:

	END_CASE
	
	// Cyclic function block calls
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.DataAddress := ADR(AxisSettings.AxisFeatures);
	ProcessConfigAX.DataAddress := ADR(AxisSettings.BaseConfiguration);
	ProcessConfigACP.DataAddress := ADR(AxisSettings.DriveConfiguration);
	ProcessConfigACP();
	ProcessConfigAX();

END_ACTION

ACTION ParameterInit:
	// Initalize drive parameter
	ProcessParamAX.DataAddress := ADR(AxisSettings.BaseParam);
	ProcessParamAX.DataType := mcCFG_AX_MOVE_LIM;

	ParameterState := PAR_STATE_INIT;

END_ACTION

ACTION ChangeParameter:

	CASE ParameterState OF
		PAR_STATE_INIT:
			// Wait state
			ProcessParamAX.Component := MpAxisBasicAppAxis.MpLink;

			IF (MpAxisBasicAppAxis.Active = TRUE) THEN
				ParameterState := PAR_STATE_READ;
			END_IF

		PAR_STATE_READ:
			// Read current parameter values
			ProcessParamAX.Mode := mcPPM_READ;
			ProcessParamAX.Execute := TRUE;

			IF (ProcessParamAX.Done = TRUE) THEN
				ProcessParamAX.Execute := FALSE;
				ParameterState := PAR_STATE_READY;
			END_IF

		PAR_STATE_WRITE:
			// Write new parameter values
			ProcessParamAX.Mode := mcPPM_WRITE;
			ProcessParamAX.Execute := TRUE;

			IF (ProcessParamAX.Done = TRUE) THEN
				ProcessParamAX.Execute := FALSE;
				ParameterState := PAR_STATE_READY;
			END_IF

		PAR_STATE_READY:

	END_CASE

	ProcessParamAX.DataAddress := ADR(AxisSettings.BaseParam);
	ProcessParamAX();

END_ACTION