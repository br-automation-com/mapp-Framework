(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   28 June, 2021/14:13 
 * This file contains the logic to control an axis
 *********************************************************************************)

ACTION AxisStateMachine:
	bStopMovementsReaction												:= EDGEPOS(MpAlarmXCheckReaction(gAlarmXMpLink, 'StopMovements'));
	FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
		(* Update parameters on recipe load *)
		IF MpRecipeRegPar_P.UpdateNotification THEN
			brsmemcpy(ADR(AxisControl[uAxIndex].Parameter.AxPar), ADR(MainCtrl.Para.AxPar[uAxIndex]), SIZEOF(AxisControl[uAxIndex].Parameter.AxPar));
		END_IF;

		CASE AxisControl[uAxIndex].AxisState OF
		 
			AX_STATE_WAIT: // Wait for command
				IF AxisControl[uAxIndex].Command.Home THEN
					AxisControl[uAxIndex].Parameter.AxPar.Homing.Mode	:= mcHOMING_DEFAULT;
					MpAxisBasic_x[uAxIndex].Home						:= TRUE;
					IF NOT MpAxisBasic_x[uAxIndex].IsHomed THEN
						AxisControl[uAxIndex].AxisState					:= AX_STATE_HOME;
					END_IF;
				ELSIF AxisControl[uAxIndex].Command.MoveJogPos THEN
//					MpAxisBasic_x[uAxIndex].JogPositive					:= TRUE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= TRUE;
					AxisControl[uAxIndex].Parameter.AxPar.Direction		:= mcDIR_POSITIVE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_JOG_POSITIVE;
				ELSIF AxisControl[uAxIndex].Command.MoveJogNeg THEN
//					MpAxisBasic_x[uAxIndex].JogNegative					:= TRUE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= TRUE;
					AxisControl[uAxIndex].Parameter.AxPar.Direction		:= mcDIR_NEGATIVE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_JOG_NEGATIVE;
				ELSIF AxisControl[uAxIndex].Command.MoveAbsolute THEN
					AxisControl[uAxIndex].Parameter.AxPar.Direction		:= mcDIR_SHORTEST_WAY;
					MpAxisBasic_x[uAxIndex].MoveAbsolute				:= TRUE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_MOVE_ABSOLUTE;
				ELSIF AxisControl[uAxIndex].Command.MoveAdditive THEN
					MpAxisBasic_x[uAxIndex].MoveAdditive				:= TRUE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_MOVE_ADDITIVE;
				ELSIF AxisControl[uAxIndex].Command.MoveVelocity THEN
					AxisControl[uAxIndex].Parameter.AxPar.Direction		:= mcDIR_POSITIVE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= TRUE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_MOVE_VELOCITY;
				ELSIF AxisControl[uAxIndex].Command.RunCamAutomat THEN
					AxisControl[uAxIndex].AxisState						:= AX_STATE_CAM_AUTOMAT;
				END_IF;

			AX_STATE_HOME:
				IF MpAxisBasic_x[uAxIndex].IsHomed THEN
					(* Homing done *)
					AxisControl[uAxIndex].Command.Home					:= FALSE;
					MpAxisBasic_x[uAxIndex].Home						:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				ELSIF (NOT AxisControl[uAxIndex].Command.Home) OR AxisControl[uAxIndex].Command.Stop THEN
					(* Homing canceled or stopped *)
					AxisControl[uAxIndex].Command.Home					:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					MpAxisBasic_x[uAxIndex].Home						:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;

			AX_STATE_JOG_POSITIVE:
				IF (NOT AxisControl[uAxIndex].Command.MoveJogPos) OR AxisControl[uAxIndex].Command.Stop THEN
					(* Jog done or stopped *)
//					MpAxisBasic_x[uAxIndex].JogPositive					:= FALSE;
					AxisControl[uAxIndex].Command.MoveJogPos			:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;
		
			AX_STATE_JOG_NEGATIVE:
				IF (NOT AxisControl[uAxIndex].Command.MoveJogNeg) OR AxisControl[uAxIndex].Command.Stop THEN
					(* Jog done or stopped *)
//					MpAxisBasic_x[uAxIndex].JogPositive					:= FALSE;
					AxisControl[uAxIndex].Command.MoveJogNeg			:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;

			AX_STATE_MOVE_ABSOLUTE:
				IF NOT AxisControl[uAxIndex].Command.MoveAbsolute OR MpAxisBasic_x[uAxIndex].MoveDone OR AxisControl[uAxIndex].Command.Stop THEN
					(* Move absolut done or stopped *)
					MpAxisBasic_x[uAxIndex].MoveAbsolute				:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					AxisControl[uAxIndex].Command.MoveAbsolute			:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;

			AX_STATE_MOVE_ADDITIVE:
				(* Move additive done or stopped *)
				IF NOT AxisControl[uAxIndex].Command.MoveAdditive OR MpAxisBasic_x[uAxIndex].MoveDone OR AxisControl[uAxIndex].Command.Stop THEN
					MpAxisBasic_x[uAxIndex].MoveAdditive				:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					AxisControl[uAxIndex].Command.MoveAdditive			:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;
			
			AX_STATE_MOVE_VELOCITY:
				IF (NOT AxisControl[uAxIndex].Command.MoveVelocity) OR AxisControl[uAxIndex].Command.Stop THEN
					(* Move velocity done or stopped *)
					AxisControl[uAxIndex].Command.MoveVelocity			:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					MpAxisBasic_x[uAxIndex].MoveVelocity				:= FALSE;
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;
			
			AX_STATE_CAM_AUTOMAT:
				(* Start synchronized movement *)
				IF MC_BR_CamAutomatCommand_0.Ready THEN
					MC_BR_CamAutomatCommand_0.Start						:= AxisControl[uAxIndex].Command.RunCamAutomat AND NOT MC_BR_CamAutomatCommand_0.Running;
				END_IF;
				(* Stop synchronized movement *)
				IF (NOT AxisControl[uAxIndex].Command.RunCamAutomat) OR AxisControl[uAxIndex].Command.Stop THEN
					AxisControl[uAxIndex].Command.RunCamAutomat			:= FALSE;
					AxisControl[uAxIndex].Command.Stop					:= FALSE;
					MC_BR_CamAutomatCommand_0.EndAutomat				:= MC_BR_CamAutomatCommand_0.Running;
					IF NOT MC_BR_CamAutomatCommand_0.Running THEN
						(* Automat has stopped *)
						AxisControl[uAxIndex].AxisState					:= AX_STATE_WAIT;
					END_IF;
				END_IF;

			AX_STATE_ERROR:
				(* Stop movements and reset .Power input if power is lost *)
				AxisControl[uAxIndex].Command.Home						:= FALSE;
				AxisControl[uAxIndex].Command.MoveAbsolute				:= FALSE;
				AxisControl[uAxIndex].Command.MoveAdditive				:= FALSE;
				AxisControl[uAxIndex].Command.MoveJogNeg				:= FALSE;
				AxisControl[uAxIndex].Command.MoveJogPos				:= FALSE;
				AxisControl[uAxIndex].Command.MoveVelocity				:= FALSE;
				AxisControl[uAxIndex].Command.RunCamAutomat				:= FALSE;
				MpAxisBasic_x[uAxIndex].Home							:= FALSE;
				MpAxisBasic_x[uAxIndex].JogNegative						:= FALSE;
				MpAxisBasic_x[uAxIndex].JogPositive						:= FALSE;
				MpAxisBasic_x[uAxIndex].MoveVelocity					:= FALSE;
				MpAxisBasic_x[uAxIndex].MoveAbsolute					:= FALSE;
				MpAxisBasic_x[uAxIndex].MoveAdditive					:= FALSE;
				MpAxisBasic_x[uAxIndex].Power							:= MpAxisBasic_x[uAxIndex].PowerOn AND AxisControl[uAxIndex].Command.Power;
				MC_BR_CamAutomatCommand_0.Start							:= FALSE;
				MC_BR_CamAutomatCommand_0.Stop							:= MC_BR_CamAutomatCommand_0.Running;
				IF NOT MpAxisBasic_x[uAxIndex].MoveActive AND NOT MC_BR_CamAutomatCommand_0.Running THEN
					(* Wait for error acknowledge *)
					IF uAxIndex = 0 THEN
						brsstrcpy(ADR(sReactionName), ADR('MasterWaitAcknowledge'));
					ELSIF uAxIndex = 1 THEN
						brsstrcpy(ADR(sReactionName), ADR('SlaveWaitAcknowledge'));
					END_IF;
					IF AxisControl[uAxIndex].Command.ErrorAcknowledge OR NOT MpAlarmXCheckReaction(gAlarmXMpLink, sReactionName)  THEN
						AxisControl[uAxIndex].Command.ErrorAcknowledge	:= FALSE;
						AxisControl[uAxIndex].AxisState					:= AX_STATE_ERROR_RESET;
					END_IF;
				END_IF;
			
			AX_STATE_ERROR_RESET:
				(* Check if CamAutomat needs to be reset *)
				MC_BR_CamAutomatCommand_0.Enable						:= NOT MC_BR_CamAutomatCommand_0.Error AND NOT MC_BR_CamAutomatCommand_0.CommandAborted;

				(* Reset MpAxisBasic errors *)
				MpAxisBasic_x[uAxIndex].ErrorReset						:= MpAxisBasic_x[uAxIndex].Error;
				MpAxisBasic_x[uAxIndex].Power							:= MpAxisBasic_x[uAxIndex].PowerOn AND AxisControl[uAxIndex].Command.Power;
	
				(* Back to wait state when errors are reset *)
				IF NOT MpAxisBasic_x[uAxIndex].Error AND NOT MC_BR_CamAutomatCommand_0.Error AND MC_BR_CamAutomatCommand_0.Valid THEN
					AxisControl[uAxIndex].AxisState						:= AX_STATE_WAIT;
				END_IF;
		END_CASE;
	
		(* Reset stop command when axis is not moving *)
		IF NOT MpAxisBasic_x[uAxIndex].MoveActive OR MpAxisBasic_x[uAxIndex].Stopped THEN
			AxisControl[uAxIndex].Command.Stop							:= FALSE;
		END_IF;

		(* Check alarm reaction *)
		IF bStopMovementsReaction THEN
			AxisControl[uAxIndex].Command.Home							:= FALSE;
			AxisControl[uAxIndex].Command.MoveAbsolute					:= FALSE;
			AxisControl[uAxIndex].Command.MoveAdditive					:= FALSE;
			AxisControl[uAxIndex].Command.MoveJogNeg					:= FALSE;
			AxisControl[uAxIndex].Command.MoveJogPos					:= FALSE;
			AxisControl[uAxIndex].Command.MoveVelocity					:= FALSE;
			AxisControl[uAxIndex].Command.RunCamAutomat					:= FALSE;
			AxisControl[uAxIndex].Command.Stop							:= MpAxisBasic_x[uAxIndex].MoveActive;
		END_IF;

		(* Reset power command if not ready to power on *)
		IF NOT MpAxisBasic_x[uAxIndex].Info.ReadyToPowerOn THEN
			AxisControl[uAxIndex].Command.Power							:= FALSE;
		END_IF;
		
		(* Always directly access power, stop, and torque control *)
		IF AxisControl[uAxIndex].AxisState < AX_STATE_ERROR THEN
			MpAxisBasic_x[uAxIndex].Power								:= AxisControl[uAxIndex].Command.Power;
			MpAxisBasic_x[uAxIndex].Stop								:= AxisControl[uAxIndex].Command.Stop;
			MpAxisBasic_x[uAxIndex].LimitLoad							:= AxisControl[uAxIndex].Command.TorqueControl AND MpAxisBasic_x[uAxIndex].PowerOn AND MpAxisBasic_x[uAxIndex].IsHomed;
		END_IF;
		
		(* Reset update command when update is done, or no movement is active *)
		IF MpAxisBasic_x[uAxIndex].UpdateDone OR NOT MpAxisBasic_x[uAxIndex].MoveActive THEN
			MpAxisBasic_x[uAxIndex].Update								:= FALSE;
		END_IF;
	END_FOR;
END_ACTION
