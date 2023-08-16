ACTION AxisInit:
	// Action call during init
END_ACTION

ACTION AxisCyclic:
	// Cyclic action call
END_ACTION

ACTION AxisManual:
	// Action handling manual axis control
	MpAxisParameters.Jog.Velocity := AxisControl.Parameters.JogVelocity;
	MpAxisParameters.Velocity := AxisControl.Parameters.Velocity;
	MpAxisParameters.Position := AxisControl.Parameters.Position;
	MpAxisParameters.Distance := AxisControl.Parameters.Distance;
	MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
	MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
	MpAxisParameters.Stop.Deceleration := AxisControl.Parameters.StopDeceleration;

	CASE ManualState OF
		// Wait state
		MANUAL_STATE_IDLE:
			IF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
				ManualState := MANUAL_STATE_JOG;
			ELSIF ((AxisControl.Command.MoveAbsolute = TRUE) OR (AxisControl.Command.MoveAdditive = TRUE) OR (AxisControl.Command.MoveVelocity = TRUE)) THEN
				MpAxisBasicAppAxis.MoveAbsolute := AxisControl.Command.MoveAbsolute;
				MpAxisBasicAppAxis.MoveAdditive := AxisControl.Command.MoveAdditive;
				MpAxisBasicAppAxis.MoveVelocity := AxisControl.Command.MoveVelocity;
				AxisControl.Command.MoveAbsolute := FALSE;
				AxisControl.Command.MoveAdditive := FALSE;
				ManualState := MANUAL_STATE_MOVE;
			ELSE
				State := STATE_READY;	
			END_IF
			// Jog state
		MANUAL_STATE_JOG:
			MpAxisBasicAppAxis.JogNegative := AxisControl.Command.JogNegative;
			MpAxisBasicAppAxis.JogPositive := AxisControl.Command.JogPositive;
			IF (AxisControl.Command.Stop = TRUE) THEN
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.Stop := TRUE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF ((AxisControl.Command.JogNegative = FALSE) AND (AxisControl.Command.JogPositive = FALSE)) THEN
				MpAxisBasicAppAxis.Stop := FALSE;
				MpAxisBasicAppAxis.JogPositive := FALSE;
				MpAxisBasicAppAxis.JogNegative := FALSE;
				ManualState := MANUAL_STATE_STOPPING;
			END_IF
			// Direct move state
		MANUAL_STATE_MOVE:
			IF (AxisControl.Command.Stop = TRUE) THEN
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisBasicAppAxis.MoveAdditive := FALSE;
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.Stop := TRUE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF (InPositionEdgePos.Q = TRUE) THEN
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisBasicAppAxis.MoveAdditive := FALSE;
				ManualState := MANUAL_STATE_IDLE;
				State := STATE_READY;
			ELSIF (((AxisControl.Command.MoveVelocity = FALSE) AND (MpAxisBasicAppAxis.MoveAbsolute = FALSE) AND (MpAxisBasicAppAxis.MoveAdditive = FALSE)) OR AxisControl.Status.ErrorActive)	THEN
				MpAxisBasicAppAxis.MoveVelocity := FALSE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisBasicAppAxis.MoveAdditive := FALSE;
				ManualState := MANUAL_STATE_JOG;
			END_IF
			// Stopping active movements
		MANUAL_STATE_STOPPING:
			MpAxisBasicAppAxis.JogNegative := FALSE;
			MpAxisBasicAppAxis.JogPositive := FALSE;
			MpAxisBasicAppAxis.MoveAbsolute := FALSE;
			MpAxisBasicAppAxis.MoveAdditive := FALSE;
			AxisControl.Command.MoveVelocity := FALSE;
			MpAxisBasicAppAxis.Stop := TRUE;

			IF (MpAxisBasicAppAxis.MoveActive = FALSE) THEN
				MpAxisBasicAppAxis.Stop := FALSE;
				MpAxisBasicAppAxis.MoveVelocity := FALSE;
				ManualState := MANUAL_STATE_IDLE;
				State := STATE_READY;
			END_IF
	END_CASE

END_ACTION

ACTION AxisAutomatic:

	CASE AutomaticState OF
		AUTOMATIC_STATE_IDLE:
			IF (AxisControl.Command.Start = TRUE) THEN
				AutomaticState := AUTOMATIC_STATE_RUNNING;
			END_IF

		AUTOMATIC_STATE_RUNNING:
			MpAxisBasicAppAxis.MoveVelocity := TRUE;
			MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
			MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
			MpAxisParameters.Velocity := ABS(AxisControl.Parameters.Velocity);
			IF (AxisControl.Parameters.Velocity < 0) THEN
				MpAxisParameters.Direction := mcDIR_NEGATIVE;
			ELSE
				MpAxisParameters.Direction := mcDIR_POSITIVE;
			END_IF

			IF ((AxisControl.Command.Start = FALSE) OR (AxisControl.Command.Stop = TRUE)) THEN
				AxisControl.Command.Start := FALSE;
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.MoveVelocity := FALSE;
				State := STATE_READY;
				AutomaticState := AUTOMATIC_STATE_IDLE;
			ELSIF (AxisControl.Command.UpdateVelocity = TRUE) THEN
				AxisControl.Command.UpdateVelocity := FALSE;
				MpAxisBasicAppAxis.Update := TRUE;
			ELSIF (MpAxisBasicAppAxis.UpdateDone = TRUE) THEN
				MpAxisBasicAppAxis.Update := FALSE;
			END_IF
	END_CASE

END_ACTION

ACTION AxisReset:
	// AxisReset action call
END_ACTION