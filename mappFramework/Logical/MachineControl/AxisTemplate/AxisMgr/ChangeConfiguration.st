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

	MC_BR_ProcessConfig_AX.DataAddress := ADR(AxisSettings.BaseConfiguration);
	MC_BR_ProcessConfig_AX.DataType := mcCFG_AX;

	MC_BR_ProcessConfig_ACP.DataAddress := ADR(AxisSettings.DriveConfiguration);
	MC_BR_ProcessConfig_ACP.DataType := mcCFG_PURE_V_AX;

	ConfigurationState := CONFIG_STATE_INIT;

END_ACTION

ACTION ChangeConfiguration:

	CASE ConfigurationState OF
		CONFIG_STATE_INIT:

			// Assign string for the name
			MC_BR_ProcessConfig_ACP.Name := MpAxisBasic_0.Info.HardwareInfo.Axis.ConfigElementLocation;
			MC_BR_ProcessConfig_AX.Name := MpAxisBasic_0.Info.HardwareInfo.Axis.AxisName;

			IF (MpAxisBasic_0.Active = TRUE) THEN
				ConfigurationState := CONFIG_STATE_READ;
			END_IF

		CONFIG_STATE_READ:
			// Read the current configuration
			MC_BR_ProcessConfig_ACP.Mode := mcPCM_LOAD;
			MC_BR_ProcessConfig_ACP.Execute := TRUE;

			MC_BR_ProcessConfig_AX.Mode := mcPCM_LOAD;
			MC_BR_ProcessConfig_AX.Execute := TRUE;
			IF (MC_BR_ProcessConfig_ACP.Done = TRUE) AND (MC_BR_ProcessConfig_AX.Done = TRUE) THEN
				MC_BR_ProcessConfig_ACP.Execute := FALSE;
				MC_BR_ProcessConfig_AX.Execute := FALSE;
				ConfigurationState := CONFIG_STATE_READY;
			END_IF

		CONFIG_STATE_WRITE:
			// Write the configuration after changes
			MC_BR_ProcessConfig_ACP.Mode := mcPCM_SAVE;
			MC_BR_ProcessConfig_ACP.Execute := TRUE;

			MC_BR_ProcessConfig_AX.Mode := mcPCM_SAVE;
			MC_BR_ProcessConfig_AX.Execute := TRUE;
			IF (MC_BR_ProcessConfig_ACP.Done = TRUE) AND (MC_BR_ProcessConfig_AX.Done = TRUE) THEN
				MC_BR_ProcessConfig_ACP.Execute := FALSE;
				MC_BR_ProcessConfig_AX.Execute := FALSE;
				ConfigurationState := CONFIG_STATE_READY;
			END_IF

		CONFIG_STATE_READY:

	END_CASE
	
	// Cyclic function block calls
	AxisSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.DataAddress := ADR(AxisSettings.AxisFeatures);
	MC_BR_ProcessConfig_AX.DataAddress := ADR(AxisSettings.BaseConfiguration);
	MC_BR_ProcessConfig_ACP.DataAddress := ADR(AxisSettings.DriveConfiguration);
	MC_BR_ProcessConfig_ACP();
	MC_BR_ProcessConfig_AX();

END_ACTION

ACTION ParameterInit:
	// Initalize drive parameter
	MC_BR_ProcessParam_AX.DataAddress := ADR(AxisSettings.BaseParam);
	MC_BR_ProcessParam_AX.DataType := mcCFG_AX_MOVE_LIM;

	ParameterState := PAR_STATE_INIT;

END_ACTION

ACTION ChangeParameter:

	CASE ParameterState OF
		PAR_STATE_INIT:
			// Wait state
			MC_BR_ProcessParam_AX.Component := MpAxisBasic_0.MpLink;

			IF (MpAxisBasic_0.Active = TRUE) THEN
				ParameterState := PAR_STATE_READ;
			END_IF

		PAR_STATE_READ:
			// Read current parameter values
			MC_BR_ProcessParam_AX.Mode := mcPPM_READ;
			MC_BR_ProcessParam_AX.Execute := TRUE;

			IF (MC_BR_ProcessParam_AX.Done = TRUE) THEN
				MC_BR_ProcessParam_AX.Execute := FALSE;
				ParameterState := PAR_STATE_READY;
			END_IF

		PAR_STATE_WRITE:
			// Write new parameter values
			MC_BR_ProcessParam_AX.Mode := mcPPM_WRITE;
			MC_BR_ProcessParam_AX.Execute := TRUE;

			IF (MC_BR_ProcessParam_AX.Done = TRUE) THEN
				MC_BR_ProcessParam_AX.Execute := FALSE;
				ParameterState := PAR_STATE_READY;
			END_IF

		PAR_STATE_READY:

	END_CASE

	MC_BR_ProcessParam_AX.DataAddress := ADR(AxisSettings.BaseParam);
	MC_BR_ProcessParam_AX();

END_ACTION