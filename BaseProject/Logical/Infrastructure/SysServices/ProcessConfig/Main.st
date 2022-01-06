(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Author:    deermannd 
 * Created:   9 July, 2020/13:59 
 * This task let's the OEM change the ACOPOS configuration via the HMI
 *********************************************************************************)

PROGRAM _INIT
	(* FUB configuration: MC_BR_ProcessConfig for persistent configuration changes, MC_BR_ProcessParam for online configuration changes *)
	MC_BR_ProcessConfig_ACP.DataType			:= mcCFG_ACP_AX;

	AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures1);
	AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;
	AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures2);
	AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;
	
	MC_BR_ProcessConfig_AX.DataType				:= mcCFG_AX;

	MC_BR_ProcessParam_ACP.ExecutionMode		:= mcEM_IMMEDIATELY;
	MC_BR_ProcessParam_ACP.Mode					:= mcPPM_WRITE;
	
	(* Register "Machine" category PVs *)
	MpRecipeRegPar_M[0].MpLink					:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_M[0].Enable					:= TRUE;
	MpRecipeRegPar_M[0].Category				:= ADR('Machine');
	MpRecipeRegPar_M[0].PVName					:= ADR('ProcessCon:AcpAxConfig');
	MpRecipeRegPar_M[1].MpLink					:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_M[1].Enable					:= TRUE;
	MpRecipeRegPar_M[1].Category				:= ADR('Machine');
	MpRecipeRegPar_M[1].PVName					:= ADR('ProcessCon:BaseAxConfig');
	MpRecipeRegPar_M[2].MpLink					:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_M[2].Enable					:= TRUE;
	MpRecipeRegPar_M[2].Category				:= ADR('Machine');
	MpRecipeRegPar_M[2].PVName					:= ADR('ProcessCon:sAxFeatures1');
	MpRecipeRegPar_M[3].MpLink					:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_M[3].Enable					:= TRUE;
	MpRecipeRegPar_M[3].Category				:= ADR('Machine');
	MpRecipeRegPar_M[3].PVName					:= ADR('ProcessCon:sAxFeatures2');

	(* Activate RegPar FUBs *)
	WHILE NOT MpRecipeRegPar_M[0].Active DO
		MpRecipeRegPar_M[0]();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_M[1].Active DO
		MpRecipeRegPar_M[1]();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_M[2].Active DO
		MpRecipeRegPar_M[2]();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_M[3].Active DO
		MpRecipeRegPar_M[3]();
	END_WHILE;

	(* Trigger first read *)
	bReadConfig									:= TRUE;
	uState										:= 0;
END_PROGRAM

PROGRAM _CYCLIC
	(* Read/Write state machine *)
	CASE uState OF
		0: // Idle
			IF MpRecipeRegPar_M[0].UpdateNotification THEN
				(* Reset the address of sAxFeatures1/2 *)
				AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures1);
				AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;
				AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures2);
				AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;

				(* Write the configuration *)
				uSelectedAxis					:= 0;
				bWriteConfig					:= TRUE;
				bReadConfig						:= FALSE;
			ELSIF bReadConfig THEN
				(* Set axis dependend configuration name *)
				IF uSelectedAxis = 0 THEN
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel1'));
				ELSE
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel2'));
				END_IF;
				AcpAxConfig[0].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures1);
				AcpAxConfig[0].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;
				AcpAxConfig[1].AxisFeatures.FeatureReference.DataAddress			:= ADR(sAxFeatures2);
				AcpAxConfig[1].AxisFeatures.FeatureReference.NumberOfArrayElements	:= 3;

				MC_BR_ProcessConfig_ACP.DataAddress			:= ADR(AcpAxConfig[uSelectedAxis]);
				MC_BR_ProcessConfig_AX.DataAddress			:= ADR(BaseAxConfig[uSelectedAxis]);
				(* Start loading *)
				MC_BR_ProcessConfig_ACP.Mode				:= mcPCM_LOAD;
				MC_BR_ProcessConfig_ACP.Execute				:= TRUE;
				bErrorRead									:= FALSE;
				bSuccessRead								:= FALSE;
				uState										:= 10;
			ELSIF bWriteConfig THEN
				(* Set axis dependend configuration name *)
				IF uSelectedAxis = 0 THEN
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel1'));
					MC_BR_ProcessParam_ACP.Component		:= ADR(gAxisMaster);
				ELSE
					brsstrcpy(ADR(MC_BR_ProcessConfig_ACP.Name), ADR('IF1.ST1/DriveConfiguration/Channel2'));
					MC_BR_ProcessParam_ACP.Component		:= ADR(gAxisSlave);
				END_IF;
				MC_BR_ProcessConfig_ACP.DataAddress			:= ADR(AcpAxConfig[uSelectedAxis]);
				MC_BR_ProcessConfig_AX.DataAddress			:= ADR(BaseAxConfig[uSelectedAxis]);
				MC_BR_ProcessParam_ACP.DataAddress			:= ADR(AcpAxConfig[uSelectedAxis].MechanicalElements);
				MC_BR_ProcessParam_ACP.DataType				:= mcCFG_ACP_MECH_ELM; // mcCFG_ACP_AX is not supported yet, therefore, transfer mech elements and homing parameters in two steps
				(* Copy direct homing position into the used homing mode, HMI is bound to direct homing position *)
				CASE AcpAxConfig[uSelectedAxis].Homing.Mode.Type OF
					mcAHM_ABS:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Absolute.Position						:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_ABS_CORR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.AbsoluteCorrection.Position				:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_ABS_SW:
						AcpAxConfig[uSelectedAxis].Homing.Mode.AbsoluteSwitch.Position					:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_BLK_LAG_ERR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.BlockLagError.Position					:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_BLK_TORQ:
						AcpAxConfig[uSelectedAxis].Homing.Mode.BlockTorque.Position						:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_DIST_C_MARKS:
						AcpAxConfig[uSelectedAxis].Homing.Mode.DistanceCodedMarks.Position				:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_DIST_C_MARKS_CORR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.DistanceCodedMarksCorrection.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_LIM_SW:
						AcpAxConfig[uSelectedAxis].Homing.Mode.LimitSwitch.Position						:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
					mcAHM_SW_GATE:
						AcpAxConfig[uSelectedAxis].Homing.Mode.SwitchGate.Position						:= AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position;
				END_CASE;
				MC_BR_ProcessConfig_ACP.Mode	:= mcPCM_SAVE;
				MC_BR_ProcessConfig_ACP.Execute	:= TRUE;
				MC_BR_ProcessConfig_AX.Mode		:= mcPCM_SAVE;
				MC_BR_ProcessConfig_AX.Execute	:= TRUE;
				MC_BR_ProcessParam_ACP.Execute	:= TRUE;
				bErrorWrite						:= FALSE;
				bSuccessWrite					:= FALSE;
				uState							:= 20;
			END_IF;
		
		10: // Read config
			IF MC_BR_ProcessConfig_ACP.Done OR MC_BR_ProcessConfig_ACP.Error THEN
				MC_BR_ProcessConfig_ACP.Execute	:= FALSE;
				(* Copy homing position into the direct homing position, HMI is bound to direct homing position *)
				CASE AcpAxConfig[uSelectedAxis].Homing.Mode.Type OF
					mcAHM_ABS:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.Absolute.Position;
					mcAHM_ABS_CORR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.AbsoluteCorrection.Position;
					mcAHM_ABS_SW:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.AbsoluteSwitch.Position;
					mcAHM_BLK_LAG_ERR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.BlockLagError.Position;
					mcAHM_BLK_TORQ:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.BlockTorque.Position;
					mcAHM_DIST_C_MARKS:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.DistanceCodedMarks.Position;
					mcAHM_DIST_C_MARKS_CORR:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.DistanceCodedMarksCorrection.Position;
					mcAHM_LIM_SW:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.LimitSwitch.Position;
					mcAHM_SW_GATE:
						AcpAxConfig[uSelectedAxis].Homing.Mode.Direct.Position	:= AcpAxConfig[uSelectedAxis].Homing.Mode.SwitchGate.Position;
				END_CASE;
				brsstrcpy(ADR(MC_BR_ProcessConfig_AX.Name), ADR(AcpAxConfig[uSelectedAxis].AxisReference.Name));
				MC_BR_ProcessConfig_AX.Mode		:= mcPCM_LOAD;
				MC_BR_ProcessConfig_AX.Execute	:= TRUE;
				bErrorRead						:= FALSE;
				bSuccessRead					:= TRUE;
				uState							:= 11;
			ELSIF MC_BR_ProcessConfig_ACP.Error THEN
				MC_BR_ProcessConfig_ACP.Execute	:= FALSE;
				bErrorRead						:= TRUE;
				bSuccessRead					:= FALSE;
				bReadConfig						:= FALSE;
				uState							:= 0;
			END_IF;
		
		11: // Read axis config
			IF MC_BR_ProcessConfig_AX.Done OR MC_BR_ProcessConfig_AX.Error THEN
				MC_BR_ProcessConfig_AX.Execute	:= FALSE;
				bErrorRead						:= MC_BR_ProcessConfig_AX.Error;
				bSuccessRead					:= NOT bErrorRead;
				IF uSelectedAxis = 0 THEN
					uSelectedAxis				:= 1;
				ELSE
					bReadConfig					:= FALSE;
				END_IF;
				uState							:= 0;
			END_IF;
			
		20: // Write config
			IF (MC_BR_ProcessConfig_ACP.Done OR MC_BR_ProcessConfig_ACP.Error)
				AND (MC_BR_ProcessConfig_AX.Done OR MC_BR_ProcessConfig_AX.Error)
				AND (MC_BR_ProcessParam_ACP.Done OR MC_BR_ProcessParam_ACP.Error) THEN
				MC_BR_ProcessConfig_ACP.Execute	:= FALSE;
				MC_BR_ProcessConfig_AX.Execute	:= FALSE;
				MC_BR_ProcessParam_ACP.Execute	:= FALSE;
				bErrorWrite						:= MC_BR_ProcessConfig_ACP.Error OR MC_BR_ProcessConfig_AX.Error OR MC_BR_ProcessParam_ACP.Error;
				bSuccessWrite					:= NOT bErrorWrite;
				uState							:= 21;
			END_IF;
		
		21: // Write Homing config
			MC_BR_ProcessParam_ACP.DataAddress	:= ADR(AcpAxConfig[uSelectedAxis].Homing); // mcCFG_ACP_AX is not supported yet, therefore, transfer mech elements and homing parameters in two steps
			MC_BR_ProcessParam_ACP.DataType		:= mcCFG_ACP_HOME;
			MC_BR_ProcessParam_ACP.Execute		:= TRUE;
			IF MC_BR_ProcessParam_ACP.Done OR MC_BR_ProcessParam_ACP.Error THEN
				MC_BR_ProcessParam_ACP.Execute	:= FALSE;
				bErrorWrite						:= bErrorWrite OR MC_BR_ProcessParam_ACP.Error;
				bSuccessWrite					:= NOT bErrorWrite;
				uState							:= 0;
				(* Update the second axis, or finish *)
				IF uSelectedAxis = 0 THEN
					uSelectedAxis				:= 1;
				ELSE
					bWriteConfig				:= FALSE;
				END_IF;
			END_IF;
	END_CASE;
	
	(* PLC reboot *)
	IF bSysReboot THEN
		SYSreset(TRUE, 1);	
	END_IF;
	
	(* Function block calls *)
	MC_BR_ProcessConfig_ACP();
	MC_BR_ProcessConfig_AX();
	MC_BR_ProcessParam_ACP();
	MpRecipeRegPar_M[0]();
	MpRecipeRegPar_M[1]();
	MpRecipeRegPar_M[2]();
	MpRecipeRegPar_M[3]();
END_PROGRAM

PROGRAM _EXIT
	(* Release mplink *)
	MpRecipeRegPar_M[0].Enable			:= FALSE;
	MpRecipeRegPar_M[1].Enable			:= FALSE;
	MpRecipeRegPar_M[2].Enable			:= FALSE;
	MpRecipeRegPar_M[3].Enable			:= FALSE;
	MpRecipeRegPar_M[0]();
	MpRecipeRegPar_M[1]();
	MpRecipeRegPar_M[2]();
	MpRecipeRegPar_M[3]();
END_PROGRAM

