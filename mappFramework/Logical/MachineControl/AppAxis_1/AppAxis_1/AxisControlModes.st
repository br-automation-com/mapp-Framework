ACTION AxisInit:
	// Action call during init
END_ACTION

ACTION AxisCyclic:
	// Cyclic action call
	AlarmSpeedNotSet.MpLink := ADR(gMpLinkAlarmXCoreAppAxis_1);
	AlarmSpeedNotSet.Enable := TRUE;
	AlarmSpeedNotSet.Name := ADR('AppAxis_1SpeedNotSet');
	AlarmSpeedNotSet();
	AlarmSpeedNotSet.Reset := FALSE;

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
			IF ((AxisControl.Command.JogNegative) OR (AxisControl.Command.JogPositive)) THEN
				ManualState := MANUAL_STATE_JOG;
			ELSIF ((AxisControl.Command.MoveAbsolute) OR (AxisControl.Command.MoveAdditive) OR (AxisControl.Command.MoveVelocity)) THEN
				MpAxisBasicAppAxis.MoveAbsolute := AxisControl.Command.MoveAbsolute;
				MpAxisBasicAppAxis.MoveAdditive := AxisControl.Command.MoveAdditive;
				MpAxisBasicAppAxis.MoveVelocity := AxisControl.Command.MoveVelocity;
				AlarmSpeedNotSet.Set := (MpAxisParameters.Velocity = 0);
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
			IF (AxisControl.Command.Stop) THEN
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.Stop := TRUE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF ((NOT AxisControl.Command.JogNegative) AND (NOT AxisControl.Command.JogPositive)) THEN
				MpAxisBasicAppAxis.Stop := FALSE;
				MpAxisBasicAppAxis.JogPositive := FALSE;
				MpAxisBasicAppAxis.JogNegative := FALSE;
				ManualState := MANUAL_STATE_STOPPING;
			END_IF
			// Direct move state
		MANUAL_STATE_MOVE:
			IF (AxisControl.Command.Stop) THEN
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisBasicAppAxis.MoveAdditive := FALSE;
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.Stop := TRUE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF (InPositionEdgePos.Q) THEN
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisBasicAppAxis.MoveAdditive := FALSE;
				ManualState := MANUAL_STATE_IDLE;
				State := STATE_READY;
			ELSIF (((NOT AxisControl.Command.MoveVelocity) AND (NOT MpAxisBasicAppAxis.MoveAbsolute) AND (NOT MpAxisBasicAppAxis.MoveAdditive)) OR AxisControl.Status.ErrorActive)	THEN
				MpAxisBasicAppAxis.MoveVelocity := FALSE;
				ManualState := MANUAL_STATE_STOPPING;
			ELSIF ((AxisControl.Command.JogNegative) OR (AxisControl.Command.JogPositive)) THEN
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

			IF (NOT MpAxisBasicAppAxis.MoveActive) THEN
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
			IF (AxisControl.Command.Start) THEN
				AlarmSpeedNotSet.Set := (AxisControl.Parameters.Velocity = 0);
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

			IF ((NOT AxisControl.Command.Start) OR (AxisControl.Command.Stop)) THEN
				AxisControl.Command.Start := FALSE;
				AxisControl.Command.Stop := FALSE;
				MpAxisBasicAppAxis.MoveVelocity := FALSE;
				State := STATE_READY;
				AutomaticState := AUTOMATIC_STATE_IDLE;
			ELSIF (AxisControl.Command.UpdateVelocity) THEN
				AxisControl.Command.UpdateVelocity := FALSE;
				AlarmSpeedNotSet.Set := (MpAxisParameters.Velocity = 0);
				MpAxisBasicAppAxis.Update := TRUE;
			ELSIF (MpAxisBasicAppAxis.UpdateDone) THEN
				MpAxisBasicAppAxis.Update := FALSE;
			END_IF
	END_CASE

END_ACTION

ACTION AxisReset:
	// AxisReset action call
END_ACTION