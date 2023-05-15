
ACTION HmiActions:
	
	// Connect HMIPackML Commands to function block
	MpPackMLModule_Main.Command.Abort := HmiPackML.Commands.Abort;
	MpPackMLModule_Main.Command.Clear := HmiPackML.Commands.Clear;
	MpPackMLModule_Main.Command.Hold := HmiPackML.Commands.Hold;
	MpPackMLModule_Main.Command.Reset := HmiPackML.Commands.Reset;
	MpPackMLModule_Main.Command.Start := HmiPackML.Commands.Start;
	MpPackMLModule_Main.Command.Stop := HmiPackML.Commands.Stop;
	MpPackMLModule_Main.Command.Suspend := HmiPackML.Commands.Suspend;
	MpPackMLModule_Main.Command.Unhold := HmiPackML.Commands.Unhold;
	MpPackMLModule_Main.Command.Unsuspend := HmiPackML.Commands.Unsuspend;
	
	// Allow user to command StateComplete only while machine is in state execute
	IF MpPackMLModule_Main.StateCurrent = mpPACKML_STATE_EXECUTE THEN
		MpPackMLModule_Main.Command.StateComplete := HmiPackML.Commands.Complete;
	END_IF
	
	// control state machine active state blinking
	CASE HmiPackML.Status.PackMLState OF
		
		0:	// Build the intital string to setup enabled states and reduce the opacity to 50% for inactive states
			
			PackMLBaseModel(HmiPackML.Parameters.StateEnabled,ADR(HmiPackML.Status.PackMLStateModel));
					
			//start timer before transitioning to the current state which turns the opacity to 100% creating a blinking effect
			TON_StateBlink.IN := TRUE;
			IF TON_StateBlink.Q THEN 
				HmiPackML.Status.PackMLState := MpPackMLModule_Main.StateCurrent;
				TON_StateBlink.IN := FALSE;
			END_IF	
			
		mpPACKML_STATE_CLEARING..mpPACKML_STATE_COMPLETE:	
									
			TON_StateBlink.IN := TRUE;
			IF TON_StateBlink.Q THEN 
				HmiPackML.Status.PackMLState := 0;
				TON_StateBlink.IN := FALSE;
			END_IF				
						
		ELSE	//if the state does't exist because of the synchronized mode use just go back to state 0
			HmiPackML.Status.PackMLState := 0;
	END_CASE

	// timer function block call
	TON_StateBlink(PT := t#1s);
	
	// copy status info to HMI structure
	HmiPackML.Status.StateCurrent := MpPackMLModule_Main.Info.StateCurrent;
	HmiPackML.Status.ModeCurrent := MpPackMLModule_Main.Info.ModeCurrent;
	
END_ACTION
	

