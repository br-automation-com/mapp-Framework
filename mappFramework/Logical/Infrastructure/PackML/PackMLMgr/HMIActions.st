
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
	
	// Check current state and convert to a usable format by HMI
	CASE MpPackMLModule_Main.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
			HmiPackML.Status.CurrentPackMLState := 1;

		mpPACKML_STATE_STARTING:
			HmiPackML.Status.CurrentPackMLState := 2;
			
		mpPACKML_STATE_IDLE:
			HmiPackML.Status.CurrentPackMLState := 3;
			
		mpPACKML_STATE_SUSPENDING:
			HmiPackML.Status.CurrentPackMLState := 4;

		mpPACKML_STATE_SUSPENDED:
			HmiPackML.Status.CurrentPackMLState := 5;

		mpPACKML_STATE_UNSUSPENDING:
			HmiPackML.Status.CurrentPackMLState := 6;
			
		mpPACKML_STATE_EXECUTE:
			HmiPackML.Status.CurrentPackMLState := 7;
			
		mpPACKML_STATE_STOPPING:
			HmiPackML.Status.CurrentPackMLState := 8;
			
		mpPACKML_STATE_ABORTING:
			HmiPackML.Status.CurrentPackMLState := 9;

		mpPACKML_STATE_ABORTED:
			HmiPackML.Status.CurrentPackMLState := 10;

		mpPACKML_STATE_HOLDING:
			HmiPackML.Status.CurrentPackMLState := 11;
			
		mpPACKML_STATE_HELD:
			HmiPackML.Status.CurrentPackMLState := 12;

		mpPACKML_STATE_UNHOLDING:
			HmiPackML.Status.CurrentPackMLState := 13;
			
		mpPACKML_STATE_COMPLETING:
			HmiPackML.Status.CurrentPackMLState := 14;

		mpPACKML_STATE_COMPLETE:
			HmiPackML.Status.CurrentPackMLState := 15;
			
		mpPACKML_STATE_RESETTING:
			HmiPackML.Status.CurrentPackMLState := 16;
			
		mpPACKML_STATE_CLEARING:
			HmiPackML.Status.CurrentPackMLState := 17;
			
		mpPACKML_STATE_DEACTIVATING:
			HmiPackML.Status.CurrentPackMLState := 18;
			
		mpPACKML_STATE_DEACTIVATED:
			HmiPackML.Status.CurrentPackMLState := 18;
			
		mpPACKML_STATE_ACTIVATING:		
			HmiPackML.Status.CurrentPackMLState := 18;
		
	END_CASE

END_ACTION
	

