ACTION AxisStateMachine:

    InPositionEdgePos.CLK := MpAxisBasic_0.InPosition;
    InPositionEdgePos();
    IsHomedEdgePos.CLK := MpAxisBasic_0.IsHomed;
    IsHomedEdgePos();
    ReferenceEdgePos.CLK := AxisControl.Command.Reference;
    ReferenceEdgePos();
    
    CASE State OF
        STATE_STOPPING..STATE_RESETTING:
            // Nothing to do as we are already handling any stop or errors in these states
            
        ELSE
            IF ((MpAxisBasic_0.Error = TRUE) OR MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error')) THEN
                // Check alarm reaction
                ResetAllAxisCommands;
                State := STATE_ABORTING;
            ELSIF ((AxisControl.Command.Power = FALSE) AND (State > STATE_POWER_ON)) THEN
                ResetAllAxisCommands;
                AxisControl.Status.Busy := TRUE;
                MpAxisBasic_0.Power := FALSE;
                State := STATE_POWER_ON;
            END_IF
    
    END_CASE
    
    CASE State OF
    	// Init state
        STATE_INIT:
            AxisControl.Status.Status := 'Initializing';
            ChangeConfiguration;
			ChangeParameter;
            IF ((ConfigurationState = CONFIG_STATE_READY) AND (ParameterState = PAR_STATE_READY) AND (MpAxisBasic_0.Active = TRUE)) THEN
                AxisControl.Status.IsReady := TRUE;
                State := STATE_POWER_ON;
            END_IF
        // Power on the axis    
        STATE_POWER_ON:
            AxisControl.Status.Status := 'Waiting for power on';
            IF (MpAxisBasic_0.Info.ReadyToPowerOn = TRUE) THEN
                MpAxisBasic_0.Power := AxisControl.Command.Power;
            END_IF
            
            AxisControl.Status.Busy := MpAxisBasic_0.Power;
            IF (MpAxisBasic_0.PowerOn = TRUE) THEN
                MC_BR_CheckRestorePositionData_0.Execute := (MpAxisBasic_0.Info.HardwareInfo.Axis.AxisType <> mcAX_TYPE_PURE_VIRT);
                AxisControl.Status.Busy := FALSE;
                State := STATE_HOME;
            ELSE
                ChangeConfiguration;
            END_IF
        // Restore home position    
        STATE_HOME:
            AxisControl.Status.Status := 'Waiting for home';
            IF ((MC_BR_CheckRestorePositionData_0.Done = TRUE) AND (MC_BR_CheckRestorePositionData_0.DataValid = TRUE)) THEN
                AxisControl.Status.ReferenceRequired := FALSE;
                MpAxisBasic_0.Home := TRUE;
                MpAxisParameters.Homing.Mode := mcHOMING_DEFAULT;
                AxisControl.Status.Busy := TRUE;
            ELSIF (MC_BR_CheckRestorePositionData_0.Busy = FALSE) THEN
                AxisControl.Status.ReferenceRequired := TRUE;
                State := STATE_REFERENCE;
            END_IF
            
            IF (MpAxisBasic_0.IsHomed = TRUE) THEN
                MC_BR_CheckRestorePositionData_0.Execute := FALSE;
                AxisControl.Status.ReferenceRequired := FALSE;
                AxisControl.Status.Busy := FALSE;
                AxisControl.Command.Reference := FALSE;
                MpAxisBasic_0.Home := FALSE;
                State := STATE_MOVE_TO_HOME_POSITION;
                ResetAllAxisCommands;
            END_IF
        // Create reference position    
        STATE_REFERENCE:
            IF (AxisControl.Command.Reference = TRUE) THEN
                AxisControl.Command.Reference := FALSE;
                MpAxisBasic_0.Home := TRUE;
                AxisControl.Status.Busy := TRUE;
                MpAxisParameters.Homing.Mode := mcHOMING_DIRECT;
                MpAxisParameters.Homing.Position := MachineSettings.ReferencePosition;
            END_IF
            
            IF (IsHomedEdgePos.Q  = TRUE) THEN
                MC_BR_CheckRestorePositionData_0.Execute := FALSE;
                AxisControl.Status.ReferenceRequired := FALSE;
                MpAxisBasic_0.Home := FALSE;
                State := STATE_MOVE_TO_HOME_POSITION;
                ResetAllAxisCommands;
            END_IF
        // Move to home position    
        STATE_MOVE_TO_HOME_POSITION:
            AxisControl.Status.Status := 'Moving to home position';
            MpAxisParameters.Position := AxisControl.Parameters.HomePosition;
            MpAxisParameters.Direction := mcDIR_SHORTEST_WAY;
            MpAxisBasic_0.MoveAbsolute := TRUE;
            IF (InPositionEdgePos.Q  = TRUE) THEN
                AxisControl.Status.Busy := FALSE;
                MpAxisBasic_0.MoveAbsolute := FALSE;
                State := STATE_READY;
            END_IF
            
        // In this State the module is error free and ready for a command (manual or automatic)
        STATE_READY:
            AxisControl.Status.Status := 'Ready';
            AxisControl.Status.Busy := FALSE;
            IF (ReferenceEdgePos.Q = TRUE) THEN
                State := STATE_REFERENCE;
            ELSIF ((MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Warning') = FALSE) AND (AutomaticCommand(AxisControl.Command) = TRUE)) THEN
                State := STATE_AUTOMATIC_OPERATION;
            ELSIF (ManualCommand(AxisControl.Command) = TRUE) THEN
                State := STATE_MANUAL_OPERATION;
            END_IF
        // Axis can be moved manually / jogged
        STATE_MANUAL_OPERATION:
            AxisControl.Status.Status := 'Manual running';
            AxisControl.Status.Busy := TRUE;
            AxisManual;
        // Axis put into automatic mode / camming    
        STATE_AUTOMATIC_OPERATION:
            AxisControl.Status.Status := 'Automatic running';
            AxisControl.Status.Busy := TRUE;
            IF MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error') THEN
                AxisControl.Command.Stop := TRUE;
            END_IF
            
            AxisAutomatic;
            
        // In this State the module will attempt to bring the axis to a controlled stop.
        STATE_STOPPING:
            AxisControl.Status.Status := 'Stopping';
            
            // Stop the axis if it is powered on
            MpAxisBasic_0.Stop := MpAxisBasic_0.PowerOn;
            MpAxisParameters.Deceleration := AxisControl.Parameters.StopDeceleration;
            IF ((MpAxisBasic_0.PowerOn = FALSE) OR (MpAxisBasic_0.Stopped = TRUE)) THEN
                MpAxisBasic_0.Stop := FALSE;
                State := STATE_STOPPED;
            END_IF

        // In this State the module is powered on and at standstill.
        STATE_STOPPED:
            State := STATE_RESETTING;

        // In this State the module will bring the axis to a rapid stop
        STATE_ABORTING:
            MpAxisParameters.Stop.Deceleration := 0;
            MpAxisBasic_0.Stop := MpAxisBasic_0.PowerOn;
            IF ((MpAxisBasic_0.PowerOn = FALSE) OR (MpAxisBasic_0.Stopped = TRUE)) THEN
                MpAxisBasic_0.Stop := FALSE;
                IF (MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'SafetyError') = TRUE) THEN
                    // Safety errors also power off the axis
                    MpAxisBasic_0.Power := FALSE;
                    IF (MpAxisBasic_0.PowerOn = FALSE) THEN
                        State := STATE_ABORTED;
                    END_IF
                ELSE
                    State := STATE_ABORTED;
                END_IF
            END_IF
            
        STATE_ABORTED:
            State := STATE_CLEARING;
            
        STATE_CLEARING:
            State := STATE_RESETTING;
        
        // In this State the module attempts to clear any outstanding errors.  No hazardous motion should occur in this State.
        STATE_RESETTING:
            ResetAllAxisCommands;
            IF (AxisControl.Command.Reset = TRUE) THEN
                AxisControl.Status.Busy := TRUE;
                AxisControl.Command.Reset := FALSE;
                MpAxisBasic_0.ErrorReset := TRUE;
                AxisReset;
            ELSE
                MpAxisBasic_0.ErrorReset := FALSE;
            END_IF
            
            IF ((MpAxisBasic_0.Error = FALSE) AND (MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error') = FALSE)) THEN
                AxisControl.Status.Busy := FALSE;
                IF (MpAxisBasic_0.PowerOn = FALSE) THEN
                    State := STATE_POWER_ON;
                ELSIF (MpAxisBasic_0.IsHomed = TRUE) THEN
                    State := STATE_READY;
                ELSE
                    State := STATE_HOME;
                END_IF
            END_IF
        
    END_CASE
    
	// Cyclic function block calls
    MpAxisBasic_0.Parameters := ADR(MpAxisParameters);
    MpAxisBasic_0();
    
    MC_BR_CheckRestorePositionData_0.DataAddress := ADR(RestorePosition);
    MC_BR_CheckRestorePositionData_0();
    
	// Status assignments
    AxisControl.Status.ErrorActive := MpAxisBasic_0.Error;
    AxisControl.Status.IsHomed := MpAxisBasic_0.IsHomed;
    AxisControl.Status.IsPowered := MpAxisBasic_0.PowerOn;
    AxisControl.Status.Position := MpAxisBasic_0.Position;
    AxisControl.Status.Velocity := MpAxisBasic_0.Velocity;

END_ACTION


ACTION ResetAllAxisCommands:
    
    MpAxisBasic_0.MoveAbsolute := FALSE;
    MpAxisBasic_0.MoveAdditive := FALSE;
    MpAxisBasic_0.MoveVelocity := FALSE;
    MpAxisBasic_0.ReleaseBrake := FALSE;
    MpAxisBasic_0.ErrorReset := FALSE;
    MpAxisBasic_0.JogPositive := FALSE;
    MpAxisBasic_0.JogNegative := FALSE;
    
END_ACTION