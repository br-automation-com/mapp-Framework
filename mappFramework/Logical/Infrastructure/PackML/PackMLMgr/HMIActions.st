
ACTION HmiActions:
	
	// Connect HMIPackML Commands to function block
	MpPackMLModuleMain.Command.Abort := HmiPackML.Commands.Abort;
	MpPackMLModuleMain.Command.Clear := HmiPackML.Commands.Clear;
	MpPackMLModuleMain.Command.Hold := HmiPackML.Commands.Hold;
	MpPackMLModuleMain.Command.Reset := HmiPackML.Commands.Reset;
	MpPackMLModuleMain.Command.Start := HmiPackML.Commands.Start;
	MpPackMLModuleMain.Command.Stop := HmiPackML.Commands.Stop;
	MpPackMLModuleMain.Command.Suspend := HmiPackML.Commands.Suspend;
	MpPackMLModuleMain.Command.Unhold := HmiPackML.Commands.Unhold;
	MpPackMLModuleMain.Command.Unsuspend := HmiPackML.Commands.Unsuspend;
	
	// Allow user to command StateComplete only while machine is in state execute
	IF MpPackMLModuleMain.StateCurrent = mpPACKML_STATE_EXECUTE THEN
		MpPackMLModuleMain.Command.StateComplete := HmiPackML.Commands.Complete;
	END_IF
	
	// Assign mode configuration based on active mode
	CASE MpPackMLModuleMain.ModeID OF	
		1:
			HmiPackML.Parameters.StateEnabled := AutomaticMode;
		2:
			HmiPackML.Parameters.StateEnabled := Maintenance;
		3:
			HmiPackML.Parameters.StateEnabled := Manual;
	END_CASE		
	
	// control state machine active state blinking
	CASE HmiPackML.Status.PackMLState OF
		
		0:	// Build the intital string to setup enabled states and reduce the opacity to 50% for inactive states
			
			PackMLBaseModel(HmiPackML.Parameters.StateEnabled,ADR(HmiPackML.Status.PackMLStateModel));
					
			//start timer before transitioning to the current state which turns the opacity to 100% creating a blinking effect
			StateBlinkTimer.IN := TRUE;
			IF StateBlinkTimer.Q THEN 
				HmiPackML.Status.PackMLState := MpPackMLModuleMain.StateCurrent;
				StateBlinkTimer.IN := FALSE;
			END_IF	
			
		mpPACKML_STATE_CLEARING..mpPACKML_STATE_COMPLETE:	
									
			StateBlinkTimer.IN := TRUE;
			IF StateBlinkTimer.Q THEN 
				HmiPackML.Status.PackMLState := 0;
				StateBlinkTimer.IN := FALSE;
			END_IF				
						
		ELSE	//if the state does't exist because of the synchronized mode use just go back to state 0
			HmiPackML.Status.PackMLState := 0;
	END_CASE

	// timer function block call
	StateBlinkTimer(PT := t#1s);
	
	// copy status info to HMI structure
	HmiPackML.Status.StateCurrent := MpPackMLModuleMain.Info.StateCurrent;
	HmiPackML.Status.ModeCurrent := MpPackMLModuleMain.Info.ModeCurrent;
	
END_ACTION
	

