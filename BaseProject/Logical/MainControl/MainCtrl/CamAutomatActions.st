(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Author:    B&R Industrial Automation GmbH 
 * Created:   24 June, 2021/15:05 
 * This task reads the cam automat data from the ACOPOS into the PV structure
 *********************************************************************************)

ACTION InitCamAutFunctionBlocks:
	(* Init cam automat related function blocks *)
	McCamAutDefine.DataAddress := ADR(McCamAutPar);
	MC_BR_CamAutomatGetPar_AcpAx_0.Slave := ADR(gAxisSlave);
	MC_BR_CamAutomatGetPar_AcpAx_0.Command := mcGET_PAR_ACTUAL;
	MC_BR_CamAutomatGetPar_AcpAx_0.CamAutomat := McCamAutDefine;
	MC_BR_CamAutomatSetPar_AcpAx_0.Command := mcSET_UPDATE_FROM_ADR;
	MC_BR_CamAutomatSetPar_AcpAx_0.AdvancedParameters.ParLock := mcCAMAUT_UNLOCK_SYNCHRON; // Synchron means the new parameters are valid when an event with synchronous update = TRUE happens
	MC_BR_CamAutomatSetPar_AcpAx_0.CamAutomat := McCamAutDefine;
	MC_BR_CamAutomatSetPar_AcpAx_0.Slave := ADR(gAxisSlave);
	MC_BR_CamAutomatCommand_0.Slave := ADR(gAxisSlave);
	MC_BR_CamAutomatCommand_0.Enable := TRUE;
END_ACTION

ACTION GetCamAutPar: 
	CASE InitCamAut OF
		0: (* Set up function blocks for reading and writing cam automat parameters *)
			MC_BR_CamAutomatGetPar_AcpAx_0.Execute := TRUE;
			InitCamAut := 1;
		
		1: (* Wait for function block done *)
			IF MC_BR_CamAutomatGetPar_AcpAx_0.Done THEN
				MC_BR_CamAutomatGetPar_AcpAx_0.Execute := FALSE;
				InitCamAut := 10;
			END_IF
			(* In case of error abort reading *)
			IF MC_BR_CamAutomatGetPar_AcpAx_0.Error THEN
				MC_BR_CamAutomatGetPar_AcpAx_0.Execute := FALSE;
				InitCamAut := 100;
			END_IF
		
		10: (* Done, do nothing *)
		
		100: (* Error handling *)
	END_CASE;
END_ACTION

ACTION UpdateCamAutomatAction:
	CASE CamUpdateState OF
		0: (* Calculate new cam automat parameters *)
			IF UpdateCamAutomat AND (InitCamAut = 10) THEN
				(* General CAM settings *)
				McCamAutPar.Common.Master.MasterStartInterval := MainCtrl.Intern.ProductLength[MainCtrl.Status.CurrentBatch];
				McCamAutPar.Common.Master.MasterStartPosition := 0;
	
				(* CAM state 0: Base state, wait for master start position *)
				McCamAutPar.State[0].Event[0].NextState := 1;
				McCamAutPar.State[0].Event[0].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[0].Event[0].Transition := mcEVENT_IMMEDIATELY;
				McCamAutPar.State[0].Event[0].Type := mcEVENT_START_POSITION; // Starts cutting process on interval, modify according to machine e.g. change to mcEVENT_SRC_TRIGGER1 for a signal wired to input channel 1 on ACOPOS

				(* CAM state 1: First cut movement *)
				McCamAutPar.State[1].MasterFactor := REAL_TO_DINT(GatDegreeToDistance(MainCtrl.FixParameter.SyncAngle, MainCtrl.FixParameter.CutDiameter / 2) * 100); // * 100 because of measurement units to resolution units conversion
				McCamAutPar.State[1].SlaveFactor := REAL_TO_DINT(MainCtrl.FixParameter.SyncAngle * 100); // * 100 because of measurement units to resolution units conversion
				McCamAutPar.State[1].CompensationParameters.MasterCompDistance := MainCtrl.Intern.ProductLength[MainCtrl.Status.CurrentBatch]; // Assuming print mark signals coincide with cutting positions
				IF MainCtrl.FixParameter.NrOfKnives = 0 THEN
					(* There must be at least one knife! *)
					MainCtrl.FixParameter.NrOfKnives := 1;
				END_IF
				McCamAutPar.State[1].CompensationParameters.SlaveCompDistance := (360 / (2 * MainCtrl.FixParameter.NrOfKnives)) - (MainCtrl.FixParameter.SyncAngle / 2);
				(* Change to next state at end of state *)
				McCamAutPar.State[1].Event[0].NextState := 3;
				McCamAutPar.State[1].Event[0].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[1].Event[0].Transition := mcEVENT_END_OF_STATE;
				McCamAutPar.State[1].Event[0].Type := mcEVENT_SIGNAL2;
				McCamAutPar.State[1].Event[1].NextState := 2;
				McCamAutPar.State[1].Event[1].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[1].Event[1].Transition := mcEVENT_END_OF_STATE;
				McCamAutPar.State[1].Event[1].Type := mcEVENT_STATE_END;

				(* CAM state 2: Repeating cut movements *)
				McCamAutPar.State[2].MasterFactor := REAL_TO_DINT(GatDegreeToDistance(MainCtrl.FixParameter.SyncAngle, MainCtrl.FixParameter.CutDiameter / 2) * 100); // * 100 because of measurement units to resolution units conversion
				McCamAutPar.State[2].SlaveFactor := REAL_TO_DINT(MainCtrl.FixParameter.SyncAngle * 100); // * 100 because of measurement units to resolution units conversion
				McCamAutPar.State[2].CompensationParameters.MasterCompDistance := MainCtrl.Intern.ProductLength[MainCtrl.Status.CurrentBatch];
				McCamAutPar.State[2].CompensationParameters.SlaveCompDistance := (360 / MainCtrl.FixParameter.NrOfKnives);
				(* Repeat state at end of state, or go to next state in case of signal 2 (stop cutting signal) *)
				McCamAutPar.State[2].Event[0].NextState := 3;
				McCamAutPar.State[2].Event[0].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[2].Event[0].Transition := mcEVENT_END_OF_STATE;
				McCamAutPar.State[2].Event[0].Type := mcEVENT_SIGNAL2;
				McCamAutPar.State[2].Event[1].NextState := 2;
				McCamAutPar.State[2].Event[1].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[2].Event[1].Transition := mcEVENT_END_OF_STATE;
				McCamAutPar.State[2].Event[1].Type := mcEVENT_STATE_END;
	
				(* CAM state 3: Decelerate and stop at home position *)
				McCamAutPar.State[3].MasterFactor := 100; // Master with any positive value & slave = 0 means slave is not moving
				McCamAutPar.State[3].SlaveFactor := 0; // Master with any positive value & slave = 0 means slave is not moving
				McCamAutPar.State[3].CompensationParameters.MasterCompDistance := MainCtrl.Intern.ProductLength[MainCtrl.Status.CurrentBatch] / 2; // allow half a product length to stop
				McCamAutPar.State[3].CompensationParameters.SlaveCompDistance := (360 / (2 * MainCtrl.FixParameter.NrOfKnives));
				(* Return to base state after axis has stopped *)
				McCamAutPar.State[3].Event[0].NextState := 0;
				McCamAutPar.State[3].Event[0].SynchronousUpdate := mcSWITCH_ON;
				McCamAutPar.State[3].Event[0].Transition := mcEVENT_END_OF_STATE;
				McCamAutPar.State[3].Event[0].Type := mcEVENT_STATE_END;

				MC_BR_CamAutomatSetPar_AcpAx_0.Execute := TRUE;
				CamUpdateState := 1;
			END_IF
			
		1: (* Wait for SetPar done *)
			IF MC_BR_CamAutomatSetPar_AcpAx_0.Done THEN
				UpdateCamAutomat := FALSE;
				MC_BR_CamAutomatSetPar_AcpAx_0.Execute := FALSE;
				CamUpdateState := 0;
			ELSIF MC_BR_CamAutomatSetPar_AcpAx_0.Error THEN
				(* Error handling *)
				MpAlarmXSet(gMpLinkAlarmXCore, 'SetCamFailed');
				UpdateCamAutomat := FALSE;
				MC_BR_CamAutomatSetPar_AcpAx_0.Execute := FALSE;
				CamUpdateState := 0;
			END_IF
	END_CASE;
END_ACTION
