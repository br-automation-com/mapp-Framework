
ACTION AxisStateMachine: 

    InPositionEdgePos.CLK := MpAxisBasicFB.InPosition;
    InPositionEdgePos();
    IsHomedEdgePos.CLK := MpAxisBasicFB.IsHomed;
    IsHomedEdgePos();
    ReferenceEdgePos.CLK := AxisControl.Command.Reference;
    ReferenceEdgePos();
    
    CASE state OF
        STATE_STOPPING..STATE_RESETTING:
            // nothing to do as we are already handling any stop or errors in these states
            
        ELSE
            IF ((MpAxisBasicFB.Error = TRUE) OR MpAlarmXCheckReaction(gAlarmXMpLink, 'Error')) THEN
                (* Check alarm reaction *)
                ResetAllAxisCommands;
                state := STATE_ABORTING;
            ELSIF ((AxisControl.Command.Power = FALSE) AND (state > STATE_POWER_ON)) THEN
                AxisControl.Status.Busy := TRUE;
                MpAxisBasicFB.Power := FALSE;
                state := STATE_POWER_ON;
            END_IF
    
    END_CASE
    
    CASE state OF
    
        STATE_INIT:
            AxisControl.Status.Status := 'Initializing';
            ChangeConfiguration;
            IF ((configurationState = CONFIG_STATE_READY) AND (MpAxisBasicFB.Active = TRUE)) THEN
                AxisControl.Status.IsReady := TRUE;
                state := STATE_POWER_ON;
            END_IF
            
        STATE_POWER_ON:
            AxisControl.Status.Status := 'Waiting for power on';
            IF (MpAxisBasicFB.Info.ReadyToPowerOn = TRUE) THEN
                MpAxisBasicFB.Power := AxisControl.Command.Power;
            END_IF
            
            AxisControl.Status.Busy := MpAxisBasicFB.Power;
            IF (MpAxisBasicFB.PowerOn = TRUE) THEN
                MC_BR_CheckRestorePositionDataFB.Execute := (MpAxisBasicFB.Info.HardwareInfo.Axis.AxisType <> mcAX_TYPE_PURE_VIRT);
                AxisControl.Status.Busy := FALSE;
                state := STATE_HOME;
            ELSE
                ChangeConfiguration;
            END_IF
            
        STATE_HOME:
            AxisControl.Status.Status := 'Waiting for home';
            IF ((MC_BR_CheckRestorePositionDataFB.Done = TRUE) AND (MC_BR_CheckRestorePositionDataFB.DataValid = TRUE)) THEN
                AxisControl.Status.ReferenceRequired := FALSE;
                MpAxisBasicFB.Home := TRUE;
                MpAxisParameters.Homing.Mode := mcHOMING_DEFAULT;
                AxisControl.Status.Busy := TRUE;
            ELSIF (MC_BR_CheckRestorePositionDataFB.Busy = FALSE) THEN
                AxisControl.Status.ReferenceRequired := TRUE;
                state := STATE_REFERENCE;
            END_IF
            
            IF (MpAxisBasicFB.IsHomed = TRUE) THEN
                MC_BR_CheckRestorePositionDataFB.Execute := FALSE;
                AxisControl.Status.ReferenceRequired := FALSE;
                AxisControl.Status.Busy := FALSE;
                AxisControl.Command.Reference := FALSE;
                MpAxisBasicFB.Home := FALSE;
                state := STATE_MOVE_TO_HOME_POSITION;
                ResetAllAxisCommands;
            END_IF
            
        STATE_REFERENCE:
            IF (AxisControl.Command.Reference = TRUE) THEN
                AxisControl.Command.Reference := FALSE;
                MpAxisBasicFB.Home := TRUE;
                AxisControl.Status.Busy := TRUE;
                MpAxisParameters.Homing.Mode := mcHOMING_DIRECT;
                MpAxisParameters.Homing.Position := MachineSettings.ReferencePosition;
            END_IF
            
            IF (IsHomedEdgePos.Q  = TRUE) THEN
                MC_BR_CheckRestorePositionDataFB.Execute := FALSE;
                AxisControl.Status.ReferenceRequired := FALSE;
                MpAxisBasicFB.Home := FALSE;
                state := STATE_MOVE_TO_HOME_POSITION;
                ResetAllAxisCommands;
            END_IF
            
        STATE_MOVE_TO_HOME_POSITION:
            AxisControl.Status.Status := 'Moving to home position';
            MpAxisParameters.Position := AxisControl.Parameters.HomePosition;
            MpAxisParameters.Direction := mcDIR_SHORTEST_WAY;
            MpAxisBasicFB.MoveAbsolute := TRUE;
            IF (InPositionEdgePos.Q  = TRUE) THEN
                AxisControl.Status.Busy := FALSE;
                MpAxisBasicFB.MoveAbsolute := FALSE;
                state := STATE_READY;
            END_IF
            
            // in this state the module is error free and ready for a command (manual or automatic)
        STATE_READY:
            AxisControl.Status.Status := 'Ready';
            AxisControl.Status.Busy := FALSE;
            IF (ReferenceEdgePos.Q = TRUE) THEN
                state := STATE_REFERENCE;
            ELSIF ((MpAlarmXCheckReaction(gAlarmXMpLink, 'Warning') = FALSE) AND (AutomaticCommand(AxisControl.Command) = TRUE)) THEN
                state := STATE_AUTOMATIC_OPERATION;
            ELSIF (ManualCommand(AxisControl.Command) = TRUE) THEN
                state := STATE_MANUAL_OPERATION;
            END_IF
        
        STATE_MANUAL_OPERATION:
            AxisControl.Status.Status := 'Manual running';
            AxisControl.Status.Busy := TRUE;
            AxisManual;
            
        STATE_AUTOMATIC_OPERATION:
            AxisControl.Status.Status := 'Automatic running';
            AxisControl.Status.Busy := TRUE;
            IF MpAlarmXCheckReaction(gAlarmXMpLink, 'Error') THEN
                AxisControl.Command.Stop := TRUE;
            END_IF
            
            AxisAutomatic;
            
            // in this state the module will attempt to bring the axis to a controlled stop.
        STATE_STOPPING:
            AxisControl.Status.Status := 'Stopping';
            
            // stop the axis if it is powered on
            MpAxisBasicFB.Stop := MpAxisBasicFB.PowerOn;
            MpAxisParameters.Deceleration := AxisControl.Parameters.StopDeceleration;
            IF ((MpAxisBasicFB.PowerOn = FALSE) OR (MpAxisBasicFB.Stopped = TRUE)) THEN
                MpAxisBasicFB.Stop := FALSE;
                state := STATE_STOPPED;
            END_IF

            // in this state the module is powered on and at standstill.
        STATE_STOPPED:
            state := STATE_RESETTING;

            // in this state the module will bring the axis to a rapid stop
        STATE_ABORTING:
            MpAxisParameters.Stop.Deceleration := 0;
            MpAxisBasicFB.Stop := MpAxisBasicFB.PowerOn;
            IF ((MpAxisBasicFB.PowerOn = FALSE) OR (MpAxisBasicFB.Stopped = TRUE)) THEN
                MpAxisBasicFB.Stop := FALSE;
                IF (MpAlarmXCheckReaction(gAlarmXMpLink, 'SafetyError') = TRUE) THEN                
                    // safety errors also power off the axis
                    MpAxisBasicFB.Power := FALSE;
                    IF (MpAxisBasicFB.PowerOn = FALSE) THEN
                        state := STATE_ABORTED;
                    END_IF
                ELSE
                    state := STATE_ABORTED;
                END_IF
            END_IF
            
        STATE_ABORTED:
            state := STATE_CLEARING;
            
        STATE_CLEARING:
            state := STATE_RESETTING;
        
            // in this state the module attempts to clear any outstanding errors.  No hazardous motion should occur in this state.
        STATE_RESETTING:
            ResetAllAxisCommands;
            IF (AxisControl.Command.Reset = TRUE) THEN
                AxisControl.Status.Busy := TRUE;
                AxisControl.Command.Reset := FALSE;
                MpAxisBasicFB.ErrorReset := TRUE;
                AxisReset;
            ELSE
                MpAxisBasicFB.ErrorReset := FALSE;
            END_IF
            
            IF ((MpAxisBasicFB.Error = FALSE) AND (MpAlarmXCheckReaction(gAlarmXMpLink, 'Error') = FALSE)) THEN
                AxisControl.Status.Busy := FALSE;
                IF (MpAxisBasicFB.Info.ReadyToPowerOn = FALSE) THEN
                    state := STATE_POWER_ON;
                ELSIF (MpAxisBasicFB.IsHomed = TRUE) THEN
                    state := STATE_READY;
                ELSE
                    state := STATE_HOME;
                END_IF
            END_IF
        
    END_CASE
    
    MpAxisBasicFB.Parameters := ADR(MpAxisParameters);
    MpAxisBasicFB();
    
    MC_BR_CheckRestorePositionDataFB.DataAddress := ADR(restorePosition);
    MC_BR_CheckRestorePositionDataFB();
    
    AxisControl.Status.ErrorActive := MpAxisBasicFB.Error;
    AxisControl.Status.IsHomed := MpAxisBasicFB.IsHomed;
    AxisControl.Status.IsPowered := MpAxisBasicFB.PowerOn;
    AxisControl.Status.Position := MpAxisBasicFB.Position;
    AxisControl.Status.Velocity := MpAxisBasicFB.Velocity;

END_ACTION


ACTION ResetAllAxisCommands: 
    
    MpAxisBasicFB.MoveAbsolute := FALSE;
    MpAxisBasicFB.MoveAdditive := FALSE;
    MpAxisBasicFB.MoveVelocity := FALSE;
    MpAxisBasicFB.ReleaseBrake := FALSE;
    MpAxisBasicFB.ErrorReset := FALSE;
    MpAxisBasicFB.JogPositive := FALSE;
    MpAxisBasicFB.JogNegative := FALSE;
    
END_ACTION