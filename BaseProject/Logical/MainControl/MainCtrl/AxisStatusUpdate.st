(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH
 * Created:   29 June, 2021/09:58
 * This file contains the logic to update the axis status information
 *********************************************************************************)

ACTION AxisStatusUpdate:
	FOR AxIndex := 0 TO MAX_IDX_AXIS DO
		(************************ MpAxisBasic_x information *************************)
		AxisControl[AxIndex].Status.ActualPLCOpenState := MpAxisBasic_x[AxIndex].Info.PLCopenState;
		AxisControl[AxIndex].Status.MovementActive := MpAxisBasic_x[AxIndex].MoveActive;
		AxisControl[AxIndex].Status.TorqueLimited := MpAxisBasic_x[AxIndex].Info.LimitLoadActive;
		AxisControl[AxIndex].Status.ActPosition := MpAxisBasic_x[AxIndex].Position;
		AxisControl[AxIndex].Status.ActVelocity := MpAxisBasic_x[AxIndex].Velocity;
		AxisControl[AxIndex].Status.Error := MpAxisBasic_x[AxIndex].Error;
		AxisControl[AxIndex].Status.PowerOn := MpAxisBasic_x[AxIndex].PowerOn;
		AxisControl[AxIndex].Status.IsHomed := MpAxisBasic_x[AxIndex].IsHomed;
	
		IF MpAxisBasic_x[AxIndex].Active AND (MpAxisBasic_x[AxIndex].Info.CommunicationState = mcCOMM_STATE_ACTIVE) THEN
			(******************** MC_READACTUALTORQUE *********************)
			MC_ReadActualTorque_x[AxIndex].Enable := NOT(MC_ReadActualTorque_x[AxIndex].Error);
			MC_ReadActualTorque_x[AxIndex]();
			IF MC_ReadActualTorque_x[AxIndex].Valid THEN
				AxisControl[AxIndex].Status.ActTorque := MC_ReadActualTorque_x[AxIndex].Torque;
			END_IF
	
			(************************ MC_READAXISERROR **********************)
			MC_ReadAxisError_x[AxIndex].Enable := NOT(MC_ReadAxisError_x[AxIndex].Error);
			MC_ReadAxisError_x[AxIndex]();
			IF MC_ReadAxisError_x[AxIndex].Valid THEN
				AxisControl[AxIndex].Status.ErrorID := MC_ReadAxisError_x[AxIndex].AxisErrorID;
			END_IF
		END_IF
	
		(**************** CHECK FOR GENERAL AXIS ERROR ******************)
		IF ((MC_ReadAxisError_x[AxIndex].AxisErrorID <> 0) AND MC_ReadAxisError_x[AxIndex].Valid) OR MpAxisBasic_x[AxIndex].Error THEN
			(* Set error state if not already in error state / or error reset state *)
			IF AxisControl[AxIndex].AxisState < AX_STATE_ERROR THEN
				AxisControl[AxIndex].AxisState := AX_STATE_ERROR;
			END_IF
		ELSIF AxisControl[AxIndex].AxisState < AX_STATE_ERROR THEN
			AxisControl[AxIndex].Command.ErrorAcknowledge := FALSE ;
		END_IF
	END_FOR // FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
END_ACTION
