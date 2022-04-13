ACTION AxisInit:
    // Action call during init
END_ACTION
    
ACTION AxisCyclic:
	// Cyclic action call
    IF (MpRecipeRegPar_Par.UpdateNotification) THEN
        
    END_IF

END_ACTION

ACTION AxisManual:
    // Action handling manual axis control
    MpAxisParameters.Jog.Velocity := AxisControl.Parameters.Velocity;
	MpAxisParameters.Velocity := AxisControl.Parameters.Velocity;
    MpAxisParameters.Position := AxisControl.Parameters.Position;
    MpAxisParameters.Distance := AxisControl.Parameters.Distance;
    MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
    MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
    
    CASE ManualState OF
		// Wait state
        MANUAL_STATE_IDLE:
            IF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                ManualState := MANUAL_STATE_JOG;
            ELSIF ((AxisControl.Command.MoveAbsolute = TRUE) OR (AxisControl.Command.MoveAdditive = TRUE)) THEN
                MpAxisBasic_0.MoveAbsolute := AxisControl.Command.MoveAbsolute;
                MpAxisBasic_0.MoveAdditive := AxisControl.Command.MoveAdditive;
                AxisControl.Command.MoveAbsolute := FALSE;
                AxisControl.Command.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_MOVE;
            END_IF
        // Jog state    
        MANUAL_STATE_JOG:
            MpAxisBasic_0.JogNegative := AxisControl.Command.JogNegative;
            MpAxisBasic_0.JogPositive := AxisControl.Command.JogPositive;
            IF (AxisControl.Command.Stop = TRUE) THEN
                AxisControl.Command.Stop := FALSE;
                MpAxisBasic_0.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF ((AxisControl.Command.JogNegative = FALSE) AND (AxisControl.Command.JogPositive = FALSE)) THEN
                MpAxisBasic_0.Stop := FALSE;
                MpAxisBasic_0.JogPositive := FALSE;
                MpAxisBasic_0.JogNegative := FALSE;
                ManualState := MANUAL_STATE_STOPPING;
            END_IF
        // Direct move state    
        MANUAL_STATE_MOVE:
            IF (AxisControl.Command.Stop = TRUE) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                AxisControl.Command.Stop := FALSE;
                MpAxisBasic_0.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF (InPositionEdgePos.Q = TRUE) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            ELSIF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_JOG;
            END_IF
        // Stopping active movements    
        MANUAL_STATE_STOPPING:
            MpAxisBasic_0.JogNegative := FALSE;
            MpAxisBasic_0.JogPositive := FALSE;
            MpAxisBasic_0.MoveAbsolute := FALSE;
            MpAxisBasic_0.MoveAdditive := FALSE;
			MpAxisBasic_0.Stop := TRUE;

            IF (MpAxisBasic_0.MoveActive = FALSE) THEN
				MpAxisBasic_0.Stop := FALSE;
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            END_IF
    END_CASE
    
END_ACTION

ACTION AxisAutomatic:
	// Action handling automatic mode
    CASE AutomaticState OF
		// Wait state
        AUTOMATIC_STATE_IDLE:
            IF (AxisControl.Command.Start = TRUE) THEN
                MpAlarmXControl_SpeedNotSet.Set := (MpAxisParameters.Velocity = 0);
                AxisControl.Command.Start := FALSE;
                AutomaticState := AUTOMATIC_STATE_RUNNING;
            END_IF
        // Automatic mode commands    
        AUTOMATIC_STATE_RUNNING:
            MpAxisBasic_0.MoveVelocity := TRUE;
            MpAxisParameters.Velocity := AxisControl.Parameters.Velocity;
            MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
            MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;

            IF (AxisControl.Command.Stop = TRUE) THEN
                AxisControl.Command.Stop := FALSE;
                MpAxisBasic_0.MoveVelocity := FALSE;
                state := STATE_READY;
                AutomaticState := AUTOMATIC_STATE_IDLE;
            END_IF
    END_CASE

END_ACTION


ACTION AxisReset:

END_ACTION