
ACTION ConfigurationInit: 

    MachineSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.DataAddress := ADR(MachineSettings.AxisFeatures);
    MachineSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfArrayElements := SIZEOF(MachineSettings.AxisFeatures)/SIZEOF(MachineSettings.AxisFeatures[0]);	
    MachineSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfElements := 0;
    i := 0;
    WHILE ((i <= SIZEOF(MachineSettings.AxisFeatures)/SIZEOF(MachineSettings.AxisFeatures[0])) AND (MachineSettings.AxisFeatures[i] <> '')) DO
        i := i + 1;
    END_WHILE
    MachineSettings.DriveConfiguration.PureVirtualAxis.AxisFeatures.FeatureReference.NumberOfElements := i;
    
    MC_BR_ProcessConfig_AX.DataAddress := ADR(MachineSettings.BaseConfiguration);    
    MC_BR_ProcessConfig_AX.DataType := mcCFG_AX;

    MC_BR_ProcessConfig_ACP.DataAddress := ADR(MachineSettings.DriveConfiguration);
    MC_BR_ProcessConfig_ACP.DataType := mcCFG_PURE_V_AX;
    
    configurationState := CONFIG_STATE_INIT;
    
END_ACTION

ACTION ChangeConfiguration:

    CASE configurationState OF
        CONFIG_STATE_INIT:

            (* build up the string for the name *)
            MC_BR_ProcessConfig_ACP.Name := MpAxisBasicFB.Info.HardwareInfo.Axis.ConfigElementLocation;
            MC_BR_ProcessConfig_AX.Name := MpAxisBasicFB.Info.HardwareInfo.Axis.AxisName;
            
            IF (MpAxisBasicFB.Active = TRUE) THEN
                configurationState := CONFIG_STATE_READ;
            END_IF

        CONFIG_STATE_READ:
            MC_BR_ProcessConfig_ACP.Mode := mcPCM_LOAD;
            MC_BR_ProcessConfig_ACP.Execute := TRUE;
            
            MC_BR_ProcessConfig_AX.Mode := mcPCM_LOAD;
            MC_BR_ProcessConfig_AX.Execute := TRUE;
            IF (MC_BR_ProcessConfig_ACP.Done = TRUE) AND (MC_BR_ProcessConfig_AX.Done = TRUE) THEN
                MC_BR_ProcessConfig_ACP.Execute := FALSE;
                MC_BR_ProcessConfig_AX.Execute := FALSE;
                configurationState := CONFIG_STATE_READY;
            END_IF            
    
        CONFIG_STATE_WRITE:
            MC_BR_ProcessConfig_ACP.Mode := mcPCM_SAVE;
            MC_BR_ProcessConfig_ACP.Execute := TRUE;
            
            MC_BR_ProcessConfig_AX.Mode := mcPCM_SAVE;
            MC_BR_ProcessConfig_AX.Execute := TRUE;
            IF (MC_BR_ProcessConfig_ACP.Done = TRUE) AND (MC_BR_ProcessConfig_AX.Done = TRUE) THEN
                MC_BR_ProcessConfig_ACP.Execute := FALSE;
                MC_BR_ProcessConfig_AX.Execute := FALSE;
                configurationState := CONFIG_STATE_READY;
            END_IF
            
        CONFIG_STATE_READY:
    
    END_CASE
    
    MC_BR_ProcessConfig_ACP();
    MC_BR_ProcessConfig_AX();

END_ACTION