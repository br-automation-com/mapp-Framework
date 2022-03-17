//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* This task let's the OEM change the ACOPOS configuration via the HMI
//*********************************************************************************

PROGRAM _INIT
	// FUB configuration: MC_BR_ProcessConfig for persistent configuration changes, MC_BR_ProcessParam for online configuration changes 
    MC_BR_ProcessConfig_ACP.DataType := mcCFG_ACP_AX;

	AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures1);
	AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;
	AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures2);
	AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;
	
	MC_BR_ProcessConfig_AX.DataType := mcCFG_AX;

	MC_BR_ProcessParam_ACP.ExecutionMode := mcEM_IMMEDIATELY;
	MC_BR_ProcessParam_ACP.Mode := mcPPM_WRITE;
	
	// Register "Machine" category PVs 
	MpRecipeRegPar_M[0].MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_M[0].Enable := TRUE;
	MpRecipeRegPar_M[0].Category := ADR('Machine');
	MpRecipeRegPar_M[0].PVName := ADR('ProcessCon:AcpAxConfig');
	MpRecipeRegPar_M[1].MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_M[1].Enable := TRUE;
	MpRecipeRegPar_M[1].Category := ADR('Machine');
	MpRecipeRegPar_M[1].PVName := ADR('ProcessCon:BaseAxConfig');
	MpRecipeRegPar_M[2].MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_M[2].Enable := TRUE;
	MpRecipeRegPar_M[2].Category := ADR('Machine');
	MpRecipeRegPar_M[2].PVName := ADR('ProcessCon:sAxFeatures1');
	MpRecipeRegPar_M[3].MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_M[3].Enable := TRUE;
	MpRecipeRegPar_M[3].Category := ADR('Machine');
	MpRecipeRegPar_M[3].PVName := ADR('ProcessCon:sAxFeatures2');

	// Activate RegPar FUBs 
	WHILE NOT MpRecipeRegPar_M[0].Active DO
		MpRecipeRegPar_M[0]();
	END_WHILE
	WHILE NOT MpRecipeRegPar_M[1].Active DO
		MpRecipeRegPar_M[1]();
	END_WHILE
	WHILE NOT MpRecipeRegPar_M[2].Active DO
		MpRecipeRegPar_M[2]();
	END_WHILE
	WHILE NOT MpRecipeRegPar_M[3].Active DO
		MpRecipeRegPar_M[3]();
	END_WHILE

	// Trigger first read 
	ReadConfig := TRUE;
	State := 0;
END_PROGRAM

PROGRAM _CYCLIC
	// Read/Write state machine 
	CASE State OF
        0:
            // Idle
			IF MpRecipeRegPar_M[0].UpdateNotification THEN
				// Reset the address of sAxFeatures1/2 
				AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures1);
				AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;
				AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures2);
				AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;

				// Write the configuration 
				SelectedAxis := 0;
				WriteConfig := TRUE;
				ReadConfig := FALSE;
			ELSIF ReadConfig THEN
				// Set axis dependend configuration name 
				IF SelectedAxis = 0 THEN
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel1'));
				ELSE
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel2'));
				END_IF
				AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures1);
				AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;
				AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress := ADR(AxFeatures2);
				AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements := 3;

				MC_BR_ProcessConfig_ACP.DataAddress := ADR(AcpAxConfig[SelectedAxis]);
				MC_BR_ProcessConfig_AX.DataAddress := ADR(BaseAxConfig[SelectedAxis]);
				// Start loading 
				MC_BR_ProcessConfig_ACP.Mode := mcPCM_LOAD;
				MC_BR_ProcessConfig_ACP.Execute := TRUE;
				ErrorRead := FALSE;
				SuccessRead := FALSE;
				State := 10;
			ELSIF WriteConfig THEN
				// Set axis dependend configuration name
				IF SelectedAxis = 0 THEN
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel1'));
					MC_BR_ProcessParam_ACP.Component := ADR(gAxisMaster);
				ELSE
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel2'));
					MC_BR_ProcessParam_ACP.Component := ADR(gAxisSlave);
				END_IF
				MC_BR_ProcessConfig_ACP.DataAddress := ADR(AcpAxConfig[SelectedAxis]);
				MC_BR_ProcessConfig_AX.DataAddress := ADR(BaseAxConfig[SelectedAxis]);
                MC_BR_ProcessParam_ACP.DataAddress := ADR(AcpAxConfig[SelectedAxis].MechanicalElements);
                // mcCFG_ACP_AX is not supported yet, therefore, transfer mech elements and homing parameters in two steps
				MC_BR_ProcessParam_ACP.DataType := mcCFG_ACP_MECH_ELM;
				// Copy direct homing position into the used homing mode, HMI is bound to direct homing position
				CASE AcpAxConfig[SelectedAxis].Homing.Mode.Type OF
					mcAHM_ABS:
						AcpAxConfig[SelectedAxis].Homing.Mode.Absolute.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_ABS_CORR:
						AcpAxConfig[SelectedAxis].Homing.Mode.AbsoluteCorrection.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_ABS_SW:
						AcpAxConfig[SelectedAxis].Homing.Mode.AbsoluteSwitch.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_BLK_LAG_ERR:
						AcpAxConfig[SelectedAxis].Homing.Mode.BlockLagError.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
                    mcAHM_BLK_TORQ:
                        AcpAxConfig[SelectedAxis].Homing.Mode.BlockTorque.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_DIST_C_MARKS:
						AcpAxConfig[SelectedAxis].Homing.Mode.DistanceCodedMarks.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_DIST_C_MARKS_CORR:
						AcpAxConfig[SelectedAxis].Homing.Mode.DistanceCodedMarksCorrection.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_LIM_SW:
						AcpAxConfig[SelectedAxis].Homing.Mode.LimitSwitch.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_SW_GATE:
						AcpAxConfig[SelectedAxis].Homing.Mode.SwitchGate.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position;
				END_CASE;
				MC_BR_ProcessConfig_ACP.Mode := mcPCM_SAVE;
				MC_BR_ProcessConfig_ACP.Execute := TRUE;
				MC_BR_ProcessConfig_AX.Mode := mcPCM_SAVE;
				MC_BR_ProcessConfig_AX.Execute := TRUE;
				MC_BR_ProcessParam_ACP.Execute := TRUE;
				ErrorWrite := FALSE;
				SuccessWrite := FALSE;
				State := 20;
			END_IF
	
        10:
            // Read config
			IF MC_BR_ProcessConfig_ACP.Done OR MC_BR_ProcessConfig_ACP.Error THEN
				MC_BR_ProcessConfig_ACP.Execute := FALSE;
				// Copy homing position into the direct homing position, HMI is bound to direct homing position 
				CASE AcpAxConfig[SelectedAxis].Homing.Mode.Type OF
					mcAHM_ABS:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.Absolute.Position;
					mcAHM_ABS_CORR:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.AbsoluteCorrection.Position;
					mcAHM_ABS_SW:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.AbsoluteSwitch.Position;
					mcAHM_BLK_LAG_ERR:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.BlockLagError.Position;
					mcAHM_BLK_TORQ:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.BlockTorque.Position;
					mcAHM_DIST_C_MARKS:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.DistanceCodedMarks.Position;
					mcAHM_DIST_C_MARKS_CORR:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.DistanceCodedMarksCorrection.Position;
					mcAHM_LIM_SW:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.LimitSwitch.Position;
					mcAHM_SW_GATE:
						AcpAxConfig[SelectedAxis].Homing.Mode.Direct.Position := AcpAxConfig[SelectedAxis].Homing.Mode.SwitchGate.Position;
				END_CASE;
				brsstrcpy(ADR(MC_BR_ProcessConfig_AX.Name), ADR(AcpAxConfig[SelectedAxis].AxisReference.Name));
				MC_BR_ProcessConfig_AX.Mode := mcPCM_LOAD;
				MC_BR_ProcessConfig_AX.Execute := TRUE;
				ErrorRead := FALSE;
				SuccessRead := TRUE;
				State := 11;
			ELSIF MC_BR_ProcessConfig_ACP.Error THEN
				MC_BR_ProcessConfig_ACP.Execute := FALSE;
				ErrorRead := TRUE;
				SuccessRead := FALSE;
				ReadConfig := FALSE;
				State := 0;
			END_IF
	
        11:
            // Read axis config
			IF MC_BR_ProcessConfig_AX.Done OR MC_BR_ProcessConfig_AX.Error THEN
				MC_BR_ProcessConfig_AX.Execute := FALSE;
				ErrorRead := MC_BR_ProcessConfig_AX.Error;
				SuccessRead := NOT bErrorRead;
				IF SelectedAxis = 0 THEN
					SelectedAxis := 1;
				ELSE
					ReadConfig := FALSE;
				END_IF
				State := 0;
			END_IF
	
        20:
            // Write config
			IF (MC_BR_ProcessConfig_ACP.Done OR MC_BR_ProcessConfig_ACP.Error)
				AND (MC_BR_ProcessConfig_AX.Done OR MC_BR_ProcessConfig_AX.Error)
				AND (MC_BR_ProcessParam_ACP.Done OR MC_BR_ProcessParam_ACP.Error) THEN
				MC_BR_ProcessConfig_ACP.Execute := FALSE;
				MC_BR_ProcessConfig_AX.Execute := FALSE;
				MC_BR_ProcessParam_ACP.Execute := FALSE;
				ErrorWrite := MC_BR_ProcessConfig_ACP.Error OR MC_BR_ProcessConfig_AX.Error OR MC_BR_ProcessParam_ACP.Error;
				SuccessWrite := NOT ErrorWrite;
				State := 21;
			END_IF
	
        21:
            // Write Homing config
			MC_BR_ProcessParam_ACP.DataAddress := ADR(AcpAxConfig[SelectedAxis].Homing);// mcCFG_ACP_AX is not supported yet, therefore, transfer mech elements and homing parameters in two steps
			MC_BR_ProcessParam_ACP.DataType := mcCFG_ACP_HOME;
			MC_BR_ProcessParam_ACP.Execute := TRUE;
			IF MC_BR_ProcessParam_ACP.Done OR MC_BR_ProcessParam_ACP.Error THEN
				MC_BR_ProcessParam_ACP.Execute := FALSE;
				ErrorWrite := bErrorWrite OR MC_BR_ProcessParam_ACP.Error;
				SuccessWrite := NOT bErrorWrite;
				State := 0;
				// Update the second axis, or finish 
				IF SelectedAxis = 0 THEN
					SelectedAxis := 1;
				ELSE
					WriteConfig := FALSE;
				END_IF
			END_IF
	END_CASE;
	
	// PLC reboot 
	IF SysReboot THEN
		SYSreset(TRUE, 1);
	END_IF
	
	// Function block calls 
	MC_BR_ProcessConfig_ACP();
	MC_BR_ProcessConfig_AX();
	MC_BR_ProcessParam_ACP();
	MpRecipeRegPar_M[0]();
	MpRecipeRegPar_M[1]();
	MpRecipeRegPar_M[2]();
	MpRecipeRegPar_M[3]();
END_PROGRAM

PROGRAM _EXIT
	// Release mplink 
	MpRecipeRegPar_M[0].Enable := FALSE;
	MpRecipeRegPar_M[1].Enable := FALSE;
	MpRecipeRegPar_M[2].Enable := FALSE;
	MpRecipeRegPar_M[3].Enable := FALSE;
	MpRecipeRegPar_M[0]();
	MpRecipeRegPar_M[1]();
	MpRecipeRegPar_M[2]();
	MpRecipeRegPar_M[3]();
END_PROGRAM

