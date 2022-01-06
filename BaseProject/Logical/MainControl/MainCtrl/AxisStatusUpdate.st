(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   29 June, 2021/09:58 
 * This file contains the logic to update the axis status information
 *********************************************************************************)

ACTION AxisStatusUpdate:
	FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
		(************************ MpAxisBasic_x information *************************)
		AxisControl[uAxIndex].Status.ActualPLCOpenState			:= MpAxisBasic_x[uAxIndex].Info.PLCopenState;
		AxisControl[uAxIndex].Status.MovementActive				:= MpAxisBasic_x[uAxIndex].MoveActive;
		AxisControl[uAxIndex].Status.TorqueLimited				:= MpAxisBasic_x[uAxIndex].Info.LimitLoadActive;
		AxisControl[uAxIndex].Status.ActPosition				:= MpAxisBasic_x[uAxIndex].Position;
		AxisControl[uAxIndex].Status.ActVelocity				:= MpAxisBasic_x[uAxIndex].Velocity;
		AxisControl[uAxIndex].Status.Error						:= MpAxisBasic_x[uAxIndex].Error;
		AxisControl[uAxIndex].Status.PowerOn					:= MpAxisBasic_x[uAxIndex].PowerOn;
		AxisControl[uAxIndex].Status.IsHomed					:= MpAxisBasic_x[uAxIndex].IsHomed;
	
		IF MpAxisBasic_x[uAxIndex].Active AND (MpAxisBasic_x[uAxIndex].Info.CommunicationState = mcCOMM_STATE_ACTIVE) THEN
			(******************** MC_READACTUALTORQUE *********************)
			MC_ReadActualTorque_x[uAxIndex].Enable				:= NOT(MC_ReadActualTorque_x[uAxIndex].Error);
			MC_ReadActualTorque_x[uAxIndex]();
			IF MC_ReadActualTorque_x[uAxIndex].Valid THEN
				AxisControl[uAxIndex].Status.ActTorque			:= MC_ReadActualTorque_x[uAxIndex].Torque;
			END_IF;
	
			(************************ MC_READAXISERROR **********************)
			MC_ReadAxisError_x[uAxIndex].Enable					:= NOT(MC_ReadAxisError_x[uAxIndex].Error);
			MC_ReadAxisError_x[uAxIndex]();
			IF MC_ReadAxisError_x[uAxIndex].Valid THEN
				AxisControl[uAxIndex].Status.ErrorID			:= MC_ReadAxisError_x[uAxIndex].AxisErrorID;
			END_IF;
		END_IF;
		
		(**************** CHECK FOR GENERAL AXIS ERROR ******************)
		IF ((MC_ReadAxisError_x[uAxIndex].AxisErrorID <> 0) AND MC_ReadAxisError_x[uAxIndex].Valid) OR MpAxisBasic_x[uAxIndex].Error THEN
			(* Set error state if not already in error state / or error reset state *)
			IF AxisControl[uAxIndex].AxisState < AX_STATE_ERROR THEN
				AxisControl[uAxIndex].AxisState					:= AX_STATE_ERROR;
			END_IF;
		ELSIF AxisControl[uAxIndex].AxisState < AX_STATE_ERROR THEN
			AxisControl[uAxIndex].Command.ErrorAcknowledge		:= FALSE ; 
		END_IF;
	END_FOR; // FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
END_ACTION
