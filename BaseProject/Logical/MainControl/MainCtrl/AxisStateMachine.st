(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   28 June, 2021/14:13 
 * This file contains the logic to control an axis
 *********************************************************************************)

ACTION AxisStateMachine:
	StopMovementsReaction := EDGEPOS(MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'StopMovements'));
	FOR AxIndex := 0 TO MAX_IDX_AXIS DO
		(* Update parameters on recipe load *)
		IF MpRecipeRegPar_P.UpdateNotification THEN
			brsmemcpy(ADR(AxisControl[AxIndex].Parameter.AxPar), ADR(MainCtrl.Parameter.AxPar[AxIndex]), SIZEOF(AxisControl[AxIndex].Parameter.AxPar));
		END_IF

		CASE AxisControl[AxIndex].AxisState OF
		 
			AX_STATE_WAIT: // Wait for command
				IF AxisControl[AxIndex].Command.Home THEN
					AxisControl[AxIndex].Parameter.AxPar.Homing.Mode := mcHOMING_DEFAULT;
					MpAxisBasic_x[AxIndex].Home := TRUE;
					IF NOT MpAxisBasic_x[AxIndex].IsHomed THEN
						AxisControl[AxIndex].AxisState := AX_STATE_HOME;
					END_IF
				ELSIF AxisControl[AxIndex].Command.MoveJogPos THEN
//					MpAxisBasic_x[AxIndex].JogPositive := TRUE;
					MpAxisBasic_x[AxIndex].MoveVelocity := TRUE;
					AxisControl[AxIndex].Parameter.AxPar.Direction := mcDIR_POSITIVE;
					AxisControl[AxIndex].AxisState := AX_STATE_JOG_POSITIVE;
				ELSIF AxisControl[AxIndex].Command.MoveJogNeg THEN
//					MpAxisBasic_x[AxIndex].JogNegative := TRUE;
					MpAxisBasic_x[AxIndex].MoveVelocity := TRUE;
					AxisControl[AxIndex].Parameter.AxPar.Direction := mcDIR_NEGATIVE;
					AxisControl[AxIndex].AxisState := AX_STATE_JOG_NEGATIVE;
				ELSIF AxisControl[AxIndex].Command.MoveAbsolute THEN
					AxisControl[AxIndex].Parameter.AxPar.Direction := mcDIR_SHORTEST_WAY;
					MpAxisBasic_x[AxIndex].MoveAbsolute := TRUE;
					AxisControl[AxIndex].AxisState := AX_STATE_MOVE_ABSOLUTE;
				ELSIF AxisControl[AxIndex].Command.MoveAdditive THEN
					MpAxisBasic_x[AxIndex].MoveAdditive := TRUE;
					AxisControl[AxIndex].AxisState := AX_STATE_MOVE_ADDITIVE;
				ELSIF AxisControl[AxIndex].Command.MoveVelocity THEN
					AxisControl[AxIndex].Parameter.AxPar.Direction := mcDIR_POSITIVE;
					MpAxisBasic_x[AxIndex].MoveVelocity := TRUE;
					AxisControl[AxIndex].AxisState := AX_STATE_MOVE_VELOCITY;
				ELSIF AxisControl[AxIndex].Command.RunCamAutomat THEN
					AxisControl[AxIndex].AxisState := AX_STATE_CAM_AUTOMAT;
				END_IF

			AX_STATE_HOME:
				IF MpAxisBasic_x[AxIndex].IsHomed THEN
					(* Homing done *)
					AxisControl[AxIndex].Command.Home := FALSE;
					MpAxisBasic_x[AxIndex].Home := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				ELSIF (NOT AxisControl[AxIndex].Command.Home) OR AxisControl[AxIndex].Command.Stop THEN
					(* Homing canceled or stopped *)
					AxisControl[AxIndex].Command.Home := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					MpAxisBasic_x[AxIndex].Home := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF

			AX_STATE_JOG_POSITIVE:
				IF (NOT AxisControl[AxIndex].Command.MoveJogPos) OR AxisControl[AxIndex].Command.Stop THEN
					(* Jog done or stopped *)
//					MpAxisBasic_x[AxIndex].JogPositive := FALSE;
					AxisControl[AxIndex].Command.MoveJogPos := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					MpAxisBasic_x[AxIndex].MoveVelocity := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF
		
			AX_STATE_JOG_NEGATIVE:
				IF (NOT AxisControl[AxIndex].Command.MoveJogNeg) OR AxisControl[AxIndex].Command.Stop THEN
					(* Jog done or stopped *)
//					MpAxisBasic_x[AxIndex].JogPositive := FALSE;
					AxisControl[AxIndex].Command.MoveJogNeg := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					MpAxisBasic_x[AxIndex].MoveVelocity := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF

			AX_STATE_MOVE_ABSOLUTE:
				IF NOT AxisControl[AxIndex].Command.MoveAbsolute OR MpAxisBasic_x[AxIndex].MoveDone OR AxisControl[AxIndex].Command.Stop THEN
					(* Move absolut done or stopped *)
					MpAxisBasic_x[AxIndex].MoveAbsolute := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					AxisControl[AxIndex].Command.MoveAbsolute := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF

			AX_STATE_MOVE_ADDITIVE:
				(* Move additive done or stopped *)
				IF NOT AxisControl[AxIndex].Command.MoveAdditive OR MpAxisBasic_x[AxIndex].MoveDone OR AxisControl[AxIndex].Command.Stop THEN
					MpAxisBasic_x[AxIndex].MoveAdditive := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					AxisControl[AxIndex].Command.MoveAdditive := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF
			
			AX_STATE_MOVE_VELOCITY:
				IF (NOT AxisControl[AxIndex].Command.MoveVelocity) OR AxisControl[AxIndex].Command.Stop THEN
					(* Move velocity done or stopped *)
					AxisControl[AxIndex].Command.MoveVelocity := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					MpAxisBasic_x[AxIndex].MoveVelocity := FALSE;
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF
			
			AX_STATE_CAM_AUTOMAT:
				(* Start synchronized movement *)
				IF MC_BR_CamAutomatCommand_0.Ready THEN
					MC_BR_CamAutomatCommand_0.Start := AxisControl[AxIndex].Command.RunCamAutomat AND NOT MC_BR_CamAutomatCommand_0.Running;
				END_IF
				(* Stop synchronized movement *)
				IF (NOT AxisControl[AxIndex].Command.RunCamAutomat) OR AxisControl[AxIndex].Command.Stop THEN
					AxisControl[AxIndex].Command.RunCamAutomat := FALSE;
					AxisControl[AxIndex].Command.Stop := FALSE;
					MC_BR_CamAutomatCommand_0.EndAutomat := MC_BR_CamAutomatCommand_0.Running;
					IF NOT MC_BR_CamAutomatCommand_0.Running THEN
						(* Automat has stopped *)
						AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
					END_IF
				END_IF

			AX_STATE_ERROR:
				(* Stop movements and reset .Power input if power is lost *)
				AxisControl[AxIndex].Command.Home := FALSE;
				AxisControl[AxIndex].Command.MoveAbsolute := FALSE;
				AxisControl[AxIndex].Command.MoveAdditive := FALSE;
				AxisControl[AxIndex].Command.MoveJogNeg := FALSE;
				AxisControl[AxIndex].Command.MoveJogPos := FALSE;
				AxisControl[AxIndex].Command.MoveVelocity := FALSE;
				AxisControl[AxIndex].Command.RunCamAutomat := FALSE;
				MpAxisBasic_x[AxIndex].Home := FALSE;
				MpAxisBasic_x[AxIndex].JogNegative := FALSE;
				MpAxisBasic_x[AxIndex].JogPositive := FALSE;
				MpAxisBasic_x[AxIndex].MoveVelocity := FALSE;
				MpAxisBasic_x[AxIndex].MoveAbsolute := FALSE;
				MpAxisBasic_x[AxIndex].MoveAdditive := FALSE;
				MpAxisBasic_x[AxIndex].Power := MpAxisBasic_x[AxIndex].PowerOn AND AxisControl[AxIndex].Command.Power;
				MC_BR_CamAutomatCommand_0.Start := FALSE;
				MC_BR_CamAutomatCommand_0.Stop := MC_BR_CamAutomatCommand_0.Running;
				IF NOT MpAxisBasic_x[AxIndex].MoveActive AND NOT MC_BR_CamAutomatCommand_0.Running THEN
					(* Wait for error acknowledge *)
					IF AxIndex = 0 THEN
						brsstrcpy(ADR(ReactionName), ADR('MasterWaitAcknowledge'));
					ELSIF AxIndex = 1 THEN
						brsstrcpy(ADR(ReactionName), ADR('SlaveWaitAcknowledge'));
					END_IF
					IF AxisControl[AxIndex].Command.ErrorAcknowledge OR NOT MpAlarmXCheckReaction(gMpLinkAlarmXCore, ReactionName)  THEN
						AxisControl[AxIndex].Command.ErrorAcknowledge := FALSE;
						AxisControl[AxIndex].AxisState := AX_STATE_ERROR_RESET;
					END_IF
				END_IF
			
			AX_STATE_ERROR_RESET:
				(* Check if CamAutomat needs to be reset *)
				MC_BR_CamAutomatCommand_0.Enable := NOT MC_BR_CamAutomatCommand_0.Error AND NOT MC_BR_CamAutomatCommand_0.CommandAborted;

				(* Reset MpAxisBasic errors *)
				MpAxisBasic_x[AxIndex].ErrorReset := MpAxisBasic_x[AxIndex].Error;
				MpAxisBasic_x[AxIndex].Power := MpAxisBasic_x[AxIndex].PowerOn AND AxisControl[AxIndex].Command.Power;
	
				(* Back to wait state when errors are reset *)
				IF NOT MpAxisBasic_x[AxIndex].Error AND NOT MC_BR_CamAutomatCommand_0.Error AND MC_BR_CamAutomatCommand_0.Valid THEN
					AxisControl[AxIndex].AxisState := AX_STATE_WAIT;
				END_IF
		END_CASE;
	
		(* Reset stop command when axis is not moving *)
		IF NOT MpAxisBasic_x[AxIndex].MoveActive OR MpAxisBasic_x[AxIndex].Stopped THEN
			AxisControl[AxIndex].Command.Stop := FALSE;
		END_IF

		(* Check alarm reaction *)
		IF StopMovementsReaction THEN
			AxisControl[AxIndex].Command.Home := FALSE;
			AxisControl[AxIndex].Command.MoveAbsolute := FALSE;
			AxisControl[AxIndex].Command.MoveAdditive := FALSE;
			AxisControl[AxIndex].Command.MoveJogNeg := FALSE;
			AxisControl[AxIndex].Command.MoveJogPos := FALSE;
			AxisControl[AxIndex].Command.MoveVelocity := FALSE;
			AxisControl[AxIndex].Command.RunCamAutomat := FALSE;
			AxisControl[AxIndex].Command.Stop := MpAxisBasic_x[AxIndex].MoveActive;
		END_IF

		(* Reset power command if not ready to power on *)
		IF NOT MpAxisBasic_x[AxIndex].Info.ReadyToPowerOn THEN
			AxisControl[AxIndex].Command.Power := FALSE;
		END_IF
		
		(* Always directly access power, stop, and torque control *)
		IF AxisControl[AxIndex].AxisState < AX_STATE_ERROR THEN
			MpAxisBasic_x[AxIndex].Power := AxisControl[AxIndex].Command.Power;
			MpAxisBasic_x[AxIndex].Stop := AxisControl[AxIndex].Command.Stop;
			MpAxisBasic_x[AxIndex].LimitLoad := AxisControl[AxIndex].Command.TorqueControl AND MpAxisBasic_x[AxIndex].PowerOn AND MpAxisBasic_x[AxIndex].IsHomed;
		END_IF
		
		(* Reset update command when update is done, or no movement is active *)
		IF MpAxisBasic_x[AxIndex].UpdateDone OR NOT MpAxisBasic_x[AxIndex].MoveActive THEN
			MpAxisBasic_x[AxIndex].Update := FALSE;
		END_IF
	END_FOR
END_ACTION
