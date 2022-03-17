(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   29 June, 2021/10:43 
 * Process specific logic to update production information and process parameters
 *********************************************************************************)

ACTION CrossCutter: 
	
	//****************************Starting and stopping the process*********************************
	
	IF MainCtrl.Command.AutoModeOn THEN
		(* Switch on axes *)
		AxisControl[AXIS_IDX_FEEDER].Command.Power := TRUE;
		AxisControl[AXIS_IDX_CUTTER].Command.Power := TRUE;
		(* Home axes if not homed yet *)
		IF NOT MpAxisBasic_x[AXIS_IDX_FEEDER].IsHomed AND (AxisControl[AXIS_IDX_FEEDER].AxisState = AX_STATE_WAIT) THEN
			AxisControl[AXIS_IDX_FEEDER].Command.Home := TRUE;
		END_IF
		IF NOT MpAxisBasic_x[AXIS_IDX_CUTTER].IsHomed AND (AxisControl[AXIS_IDX_CUTTER].AxisState = AX_STATE_WAIT) THEN
			AxisControl[AXIS_IDX_CUTTER].Command.Home := TRUE;
		END_IF
		
		(* Reset run switches when in error state *)
		IF (AxisControl[AXIS_IDX_FEEDER].AxisState = AX_STATE_ERROR) OR (AxisControl[AXIS_IDX_CUTTER].AxisState = AX_STATE_ERROR) THEN
			MainCtrl.Command.RunCutter := FALSE;
			MainCtrl.Command.RunFeeder := FALSE;
		END_IF
		
		(* Start movement of feeder axis *)
		AxisControl[AXIS_IDX_FEEDER].Command.MoveVelocity := MainCtrl.Command.RunFeeder;
		
		(* Start synchronized movement of Cutter with cam automat *)
		IF MainCtrl.Command.RunCutter THEN
			AxisControl[AXIS_IDX_CUTTER].Command.RunCamAutomat := TRUE;
		ELSE
			(* If axis is moving use signal1 to stop slave in home position after the current product is done, otherwise stop now *)
			IF (MpAxisBasic_x[AXIS_IDX_CUTTER].Velocity > 0) AND MC_BR_CamAutomatCommand_0.Running THEN
				MC_BR_CamAutomatCommand_0.SetSignal1 := TRUE;
			ELSE
				(* Back in base state reset signal and end camautomat *)
				MC_BR_CamAutomatCommand_0.SetSignal1 := FALSE;
				MC_BR_CamAutomatCommand_0.EndAutomat := MC_BR_CamAutomatCommand_0.Running;
				IF NOT MC_BR_CamAutomatCommand_0.Running THEN
					(* Automat has stopped *)
					AxisControl[AXIS_IDX_CUTTER].Command.RunCamAutomat := FALSE;
				END_IF
			END_IF
		END_IF
	ELSIF LastAutoModeOn THEN
		(* Auto mode is switched off, reste run commands *)
		MainCtrl.Command.RunCutter := FALSE;
		AxisControl[AXIS_IDX_CUTTER].Command.RunCamAutomat := FALSE;
		MainCtrl.Command.RunFeeder := FALSE;
		AxisControl[AXIS_IDX_FEEDER].Command.MoveVelocity := FALSE;
	END_IF
	LastAutoModeOn := MainCtrl.Command.AutoModeOn;

	//********************************Parameters Limits************

	IF (AxisControl[AXIS_IDX_FEEDER].Parameter.AxPar.Velocity = 0) AND AxisControl[AXIS_IDX_FEEDER].Command.MoveVelocity THEN
		MpAlarmXSet(gMpLinkAlarmXCore, 'FeederSpeedNotSet');
		AxisControl[AXIS_IDX_FEEDER].Command.MoveVelocity := FALSE;
	END_IF
	IF (AxisControl[AXIS_IDX_CUTTER].Parameter.AxPar.Velocity = 0) AND AxisControl[AXIS_IDX_CUTTER].Command.MoveAdditive THEN
		MpAlarmXSet(gMpLinkAlarmXCore, 'CutterSpeedNotSet');
		AxisControl[AXIS_IDX_CUTTER].Command.MoveAdditive := FALSE;
	END_IF
	IF (AxisControl[AXIS_IDX_CUTTER].Parameter.AxPar.Distance = 0) AND (AxisControl[AXIS_IDX_CUTTER].Command.MoveAdditive)  THEN
		MpAlarmXSet(gMpLinkAlarmXCore, 'CutterPositionNotSet');
		AxisControl[AXIS_IDX_CUTTER].Command.MoveAdditive := FALSE;
	END_IF
	

	//****************************Product Cutting numbering*********************************

	(* Update parameters on recipe load *)
	IF MpRecipeRegPar_P.UpdateNotification THEN
		brsmemcpy(ADR(MainCtrl.Intern.ProductLength), ADR(MainCtrl.Parameter.ProductLength), SIZEOF(MainCtrl.Intern.ProductLength));
		brsmemcpy(ADR(MainCtrl.Intern.ProductNumber), ADR(MainCtrl.Parameter.ProductNumber), SIZEOF(MainCtrl.Intern.ProductNumber));
		UpdateCamAutomat := TRUE;
	END_IF
	
	(* InCam -> next cut is starting *)
	IF EDGEPOS(MC_BR_CamAutomatCommand_0.InCam) THEN
		MainCtrl.Status.ProductsCutBatch := MainCtrl.Status.ProductsCutBatch + 1;
		MainCtrl.Status.ProductsCutTotal := MainCtrl.Status.ProductsCutTotal + 1;
	END_IF
	
	(* Batch finished, start next batch -> adjust cam automat parameters for next batches product length *)
	IF (MainCtrl.Status.ProductsCutBatch >= MainCtrl.Intern.ProductNumber[MainCtrl.Status.CurrentBatch])
		AND (MainCtrl.Status.ProductsCutBatch > 0) THEN
		(* Set new cam automat values *)
		MainCtrl.Status.CurrentBatch := MainCtrl.Status.CurrentBatch + 1;
		IF MainCtrl.Status.CurrentBatch > 4 THEN
			MainCtrl.Status.CurrentBatch := 0;
		END_IF
		MainCtrl.Status.ProductsCutBatch := 0;
		UpdateCamAutomat := TRUE;
	END_IF
	MainCtrl.Status.CurrentBatchTarget := MainCtrl.Intern.ProductNumber[MainCtrl.Status.CurrentBatch];
	MainCtrl.Status.CurrentBatchLength := MainCtrl.Intern.ProductLength[MainCtrl.Status.CurrentBatch];

	(* Action to handle cam automat updates *)
	UpdateCamAutomatAction;

END_ACTION
