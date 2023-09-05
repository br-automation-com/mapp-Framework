ACTION AxisStateMachine:

	InPositionEdgePos.CLK := MpAxisBasicAppAxis.InPosition;
	InPositionEdgePos();
	IsHomedEdgePos.CLK := MpAxisBasicAppAxis.IsHomed;
	IsHomedEdgePos();
	ReferenceEdgePos.CLK := AxisControl.Command.Reference;
	ReferenceEdgePos();
	ZeroPendingAlarmsEdgePos.CLK := (MpAlarmXCoreAxis.PendingAlarms = 0);
	ZeroPendingAlarmsEdgePos();

	CASE State OF
		STATE_STOPPING..STATE_RESETTING:
			// Nothing to do as we are already handling any stop or errors in these states

		ELSE
			IF ((MpAxisBasicAppAxis.Error) OR MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error')) THEN
				// Check alarm reaction
				ResetAllAxisCommands;
				State := STATE_ABORTING;
			ELSIF ((NOT AxisControl.Command.Power) AND (State > STATE_POWER_ON)) THEN
				ResetAllAxisCommands;
				AxisControl.Status.Busy := TRUE;
				MpAxisBasicAppAxis.Power := FALSE;
				State := STATE_POWER_ON;
			END_IF

	END_CASE

	CASE State OF
		// Init state
		STATE_INIT:
			AxisControl.Status.Status := 'Initializing';
			ChangeConfiguration;
			ChangeParameter;
			IF (((ConfigurationState = CONFIG_STATE_READY) OR (ConfigurationState = CONFIG_STATE_NOT_USED)) AND ((ParameterState = PAR_STATE_READY) OR (ParameterState = PAR_STATE_NOT_USED)) AND (MpAxisBasicAppAxis.Active)) THEN
				AxisControl.Status.IsReady := TRUE;

				State := STATE_POWER_ON;
			END_IF

		// Power on the axis
		STATE_POWER_ON:
			AxisControl.Status.Status := 'Waiting for power on';
			IF (MpAxisBasicAppAxis.Info.ReadyToPowerOn) THEN
				MpAxisBasicAppAxis.Power := AxisControl.Command.Power;
			END_IF

			AxisControl.Status.Busy := MpAxisBasicAppAxis.Power;
			IF (MpAxisBasicAppAxis.PowerOn) THEN
				AxisControl.Status.Busy := FALSE;
				State := STATE_HOME;
			ELSE
				ChangeConfiguration;
			END_IF

		// Restore home position
		STATE_HOME:
			AxisControl.Status.Status := 'Waiting for home';
			IF ((NOT MpAxisBasicAppAxis.IsHomed) AND (MpAxisBasicAppAxis.PowerOn)) THEN
				AxisControl.Status.ReferenceRequired := TRUE;
				State := STATE_REFERENCE;
			END_IF

			IF (MpAxisBasicAppAxis.IsHomed) THEN
				AxisControl.Status.ReferenceRequired := FALSE;
				AxisControl.Status.Busy := FALSE;
				AxisControl.Command.Reference := FALSE;
				State := STATE_MOVE_TO_HOME_POSITION;
				ResetAllAxisCommands;
			END_IF

		// Create reference position
		STATE_REFERENCE:
			IF (AxisControl.Command.Reference) THEN
				AxisControl.Command.Reference := FALSE;
				MpAxisBasicAppAxis.Home := TRUE;
				AxisControl.Status.Busy := TRUE;
				MpAxisParameters.Homing.Mode := mcHOMING_DIRECT;
				MpAxisParameters.Homing.Position := MachineSettings.ReferencePosition;
			END_IF

			IF (IsHomedEdgePos.Q	= TRUE) THEN
				AxisControl.Status.ReferenceRequired := FALSE;
				State := STATE_MOVE_TO_HOME_POSITION;
				ResetAllAxisCommands;
			END_IF

		// Move to home position
		STATE_MOVE_TO_HOME_POSITION:
			AxisControl.Status.Status := 'Moving to home position';
			MpAxisParameters.Position := AxisControl.Parameters.HomePosition;
			MpAxisParameters.Direction := mcDIR_SHORTEST_WAY;
			MpAxisBasicAppAxis.MoveAbsolute := TRUE;
			IF (InPositionEdgePos.Q	= TRUE) THEN
				AxisControl.Status.Busy := FALSE;
				MpAxisBasicAppAxis.MoveAbsolute := FALSE;
				MpAxisParameters.Direction := mcDIR_POSITIVE;
				State := STATE_READY;
			END_IF

		// In this State the module is error free and ready for a command (manual or automatic)
		STATE_READY:
			AxisControl.Status.Status := 'Ready';
			AxisControl.Status.Busy := FALSE;
			IF (ReferenceEdgePos.Q) THEN
				State := STATE_REFERENCE;
			ELSIF ((NOT MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Warning')) AND (AutomaticCommand(AxisControl.Command))) THEN
				State := STATE_AUTOMATIC_OPERATION;
			ELSIF (ManualCommand(AxisControl.Command)) THEN
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
			MpAxisBasicAppAxis.Stop := MpAxisBasicAppAxis.PowerOn;
			MpAxisParameters.Stop.Deceleration := AxisControl.Parameters.StopDeceleration;
			IF ((NOT MpAxisBasicAppAxis.PowerOn) OR (MpAxisBasicAppAxis.Stopped)) THEN
				MpAxisBasicAppAxis.Stop := FALSE;
				State := STATE_STOPPED;
			END_IF

		// In this State the module is powered on and at standstill.
		STATE_STOPPED:
			State := STATE_RESETTING;

		// In this State the module will bring the axis to a rapid stop
		STATE_ABORTING:
			MpAxisParameters.Stop.Deceleration := 0;
			MpAxisBasicAppAxis.Stop := MpAxisBasicAppAxis.PowerOn;
			IF ((NOT MpAxisBasicAppAxis.PowerOn) OR (MpAxisBasicAppAxis.Stopped)) THEN
				MpAxisBasicAppAxis.Stop := FALSE;
				IF (MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'SafetyError')) THEN
					// Safety errors also power off the axis
					MpAxisBasicAppAxis.Power := FALSE;
					IF (NOT MpAxisBasicAppAxis.PowerOn) THEN
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
			IF (AxisControl.Command.Reset) OR ((NOT MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error')) AND ZeroPendingAlarmsEdgePos.Q) THEN
				AxisControl.Status.Busy := TRUE;
				AxisControl.Command.Reset := FALSE;
				MpAxisBasicAppAxis.ErrorReset := TRUE;
				AxisReset;
				ManualState := MANUAL_STATE_IDLE;
				AutomaticState := AUTOMATIC_STATE_IDLE;
			ELSE
				MpAxisBasicAppAxis.ErrorReset := FALSE;
			END_IF

			IF ((NOT MpAxisBasicAppAxis.Error) AND (NOT MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error'))) THEN
				AxisControl.Status.Busy := FALSE;
				IF (NOT MpAxisBasicAppAxis.PowerOn) THEN
					State := STATE_POWER_ON;
				ELSIF (MpAxisBasicAppAxis.IsHomed) THEN
					State := STATE_READY;
				ELSE
					State := STATE_HOME;
				END_IF
			END_IF

	END_CASE

	// Cyclic function block calls
	MpAxisBasicAppAxis.Parameters := ADR(MpAxisParameters);
	MpAxisBasicAppAxis();

	// Status assignments
	AxisControl.Status.ErrorActive := MpAxisBasicAppAxis.Error OR (MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error'));
	AxisControl.Status.IsHomed := MpAxisBasicAppAxis.IsHomed;
	AxisControl.Status.IsPowered := MpAxisBasicAppAxis.PowerOn;
	AxisControl.Status.PLCopenState := MpAxisBasicAppAxis.Info.PLCopenState;
	AxisControl.Status.Position := MpAxisBasicAppAxis.Position;
	AxisControl.Status.Velocity := MpAxisBasicAppAxis.Velocity;
	AxisControl.Status.ModeManual := (State <> STATE_AUTOMATIC_OPERATION);
	//VC4 related code
	AxisControl.Status.StatusPointControl[0].0 := NOT AxisControl.Status.StatusPointControl[1].0;
	AxisControl.Status.StatusPointControl[0].1 := NOT AxisControl.Status.ModeManual;

END_ACTION


ACTION ResetAllAxisCommands:

	MpAxisBasicAppAxis.MoveAbsolute := FALSE;
	MpAxisBasicAppAxis.MoveAdditive := FALSE;
	MpAxisBasicAppAxis.MoveVelocity := FALSE;
	MpAxisBasicAppAxis.ReleaseBrake := FALSE;
	MpAxisBasicAppAxis.ErrorReset := FALSE;
	MpAxisBasicAppAxis.JogPositive := FALSE;
	MpAxisBasicAppAxis.JogNegative := FALSE;
	MpAxisBasicAppAxis.Home := FALSE;

END_ACTION