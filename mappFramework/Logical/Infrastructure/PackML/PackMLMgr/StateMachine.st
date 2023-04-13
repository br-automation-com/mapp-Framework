
ACTION StateMachine:

	CASE MpPackMLMode_0.StateCurrent OF
		
		
		mpPACKML_STATE_UNDEFINED:
			HmiPackMLState := 'Undefined';
			
			// Add UNDEFINED actions here

		mpPACKML_STATE_CLEARING:
			HmiPackMLState := 'Clearing';
			
			// Add CLEARING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_STOPPED:
			HmiPackMLState := 'Stopped';
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			HmiPackMLState := 'Starting';
			
			// Add STARTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_IDLE:
			HmiPackMLState := 'Idle';
			
			// Add IDLE actions here

		mpPACKML_STATE_SUSPENDED:
			HmiPackMLState := 'Suspended';
			
			// Add SUSPENDED actions here

		mpPACKML_STATE_EXECUTE:
			HmiPackMLState := 'Execute';
			
			// Add EXECUTE actions here

		mpPACKML_STATE_STOPPING:
			HmiPackMLState := 'Stopping';
			
			// Add STOPPING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTING:
			HmiPackMLState := 'Aborting';
			
			// Add ABORTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			HmiPackMLState := 'Aborted';
			
 			// Add ABORTED actions here

		mpPACKML_STATE_HOLDING:
			// Add HOLDING actions here
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_HELD:
			HmiPackMLState := 'Held';
			
			// Add HELD actions here

		mpPACKML_STATE_UNHOLDING:
			HmiPackMLState := 'Unholding';
			
			// Add UNHOLDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDING:
			HmiPackMLState := 'Suspending';
			
			// Add SUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_UNSUSPENDING:
			HmiPackMLState := 'Unsuspending';
			
			// Add UNSUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_RESETTING:
			HmiPackMLState := 'Resetting';
			
			// Add RESETTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_COMPLETING:
			HmiPackMLState := 'Completing';
			
			// Add COMPLETING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_COMPLETE:
			HmiPackMLState := 'Complete';
			
			// Add COMPLETE actions here
		
	END_CASE
	
END_ACTION
