
ACTION AxisInit:
    
END_ACTION
    

ACTION AxisCyclic: 

    IF (MpRecipeRegPar_UserFB.UpdateNotification) THEN
        
    END_IF
    
        
    MpAlarmXControlSpeedNotSetFB.MpLink := ADR(gAlarmXCore_Conveyor);
    MpAlarmXControlSpeedNotSetFB.Enable := TRUE;
    MpAlarmXControlSpeedNotSetFB.Name := ADR('ConveyorSpeedNotSet');
    MpAlarmXControlSpeedNotSetFB();
    MpAlarmXControlSpeedNotSetFB.Reset := FALSE;
    
END_ACTION

  
ACTION AxisManual:
    
    MpAxisParameters.Jog.Velocity := AxisControl.Parameters.JogVelocity;
    MpAxisParameters.Position := AxisControl.Parameters.Position;
    MpAxisParameters.Distance := AxisControl.Parameters.Distance;
    MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
    MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
    
    CASE ManualState OF
        MANUAL_STATE_IDLE:
            IF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                ManualState := MANUAL_STATE_JOG;
            ELSIF ((AxisControl.Command.MoveAbsolute = TRUE) OR (AxisControl.Command.MoveAdditive = TRUE)) THEN
                MpAxisBasicFB.MoveAbsolute := AxisControl.Command.MoveAbsolute;
                MpAxisBasicFB.MoveAdditive := AxisControl.Command.MoveAdditive;
                AxisControl.Command.MoveAbsolute := FALSE;
                AxisControl.Command.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_MOVE;
            END_IF
            
        MANUAL_STATE_JOG:
            MpAxisBasicFB.JogNegative := AxisControl.Command.JogNegative;
            MpAxisBasicFB.JogPositive := AxisControl.Command.JogPositive;
            IF (AxisControl.Command.Stop = TRUE) THEN
                AxisControl.Command.Stop := FALSE;
                MpAxisBasicFB.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF ((AxisControl.Command.JogNegative = FALSE) AND (AxisControl.Command.JogPositive = FALSE)) THEN
                MpAxisBasicFB.Stop := FALSE;
                MpAxisBasicFB.JogPositive := FALSE;
                MpAxisBasicFB.JogNegative := FALSE;
                ManualState := MANUAL_STATE_STOPPING;
            END_IF
            
        MANUAL_STATE_MOVE:
            IF (AxisControl.Command.Stop = TRUE) THEN
                MpAxisBasicFB.MoveAbsolute := FALSE;
                MpAxisBasicFB.MoveAdditive := FALSE;
                AxisControl.Command.Stop := FALSE;
                MpAxisBasicFB.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF (InPositionEdgePos.Q = TRUE) THEN
                MpAxisBasicFB.MoveAbsolute := FALSE;
                MpAxisBasicFB.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            ELSIF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                MpAxisBasicFB.MoveAbsolute := FALSE;
                MpAxisBasicFB.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_JOG;
            END_IF
            
        MANUAL_STATE_STOPPING:
            MpAxisBasicFB.JogNegative := FALSE;
            MpAxisBasicFB.JogPositive := FALSE;
            MpAxisBasicFB.MoveAbsolute := FALSE;
            MpAxisBasicFB.MoveAdditive := FALSE;

            IF (MpAxisBasicFB.MoveActive = FALSE) THEN
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            END_IF
    END_CASE
    
END_ACTION

ACTION AxisAutomatic:

    MpAlarmXControlSpeedNotSetFB.Set := (MpAxisParameters.Velocity = 0);
    
    MpAxisBasicFB.MoveVelocity := TRUE;
    MpAxisParameters.Velocity := AxisControl.Parameters.Velocity;
    MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
    MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;

    IF (AxisControl.Command.Stop = TRUE) THEN
        state := STATE_READY;
        MpAxisBasicFB.MoveVelocity := FALSE;
    END_IF
    
END_ACTION

ACTION AxisReset:

//    edge alarms don't require a reset
//    IF (MpAlarmXControlSpeedNotSetFB.Set = TRUE) THEN
//        MpAlarmXControlSpeedNotSetFB.Set := FALSE;
//        MpAlarmXControlSpeedNotSetFB.ID := MpAlarmXControlSpeedNotSetFB.InstanceID;
//        MpAlarmXControlSpeedNotSetFB.Reset := TRUE;
//    END_IF
    
END_ACTION