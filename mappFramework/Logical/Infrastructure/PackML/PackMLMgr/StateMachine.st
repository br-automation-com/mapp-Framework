
ACTION StateMachine:

	CASE MpPackMLCore_0.StateCurrent OF
		
		
		mpPACKML_STATE_UNDEFINED:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Undefined';
			
			// Add UNDEFINED actions here
			
			MpPackMLMode_0.Activate := TRUE;

		mpPACKML_STATE_CLEARING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Clearing';
			
			// Add CLEARING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_STOPPED:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Stopped';
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Starting';
			
			// Add STARTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_IDLE:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Idle';
			
			// Add IDLE actions here

		mpPACKML_STATE_SUSPENDED:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Suspended';
			
			// Add SUSPENDED actions here

		mpPACKML_STATE_EXECUTE:

			HmiPackMLState := 'Execute';
			
			// Add EXECUTE actions here

		mpPACKML_STATE_STOPPING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Stopping';
			
			// Add STOPPING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Aborting';
			
			// Add ABORTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Aborted';
			
 			// Add ABORTED actions here

		mpPACKML_STATE_HOLDING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Holding';
			
			// Add HOLDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_HELD:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Held';
			
			// Add HELD actions here

		mpPACKML_STATE_UNHOLDING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Unholding';
			
			// Add UNHOLDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Suspending';
			
			// Add SUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_UNSUSPENDING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Unsuspending';
			
			// Add UNSUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_RESETTING:
			
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Resetting';
			
			// Add RESETTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_COMPLETING:
			MpPackMLMode_0.StateComplete := FALSE;
			HmiPackMLState := 'Completing';
			
			// Add COMPLETING actions here
			// NOTE: once COMPLETING actions that take more than one cyclic have been added, the below may be commented out and replaced by the following line.
			Completing_TON.PT := T#100ms;
			Completing_TON.IN := TRUE;
			IF Completing_TON.Q THEN
				Completing_TON.IN := FALSE;
				MpPackMLMode_0.StateComplete := TRUE;
			END_IF
			Completing_TON();
			// MpPackMLMode_0.StateComplete := TRUE;
			

		mpPACKML_STATE_COMPLETE:

			HmiPackMLState := 'Complete';
			
			// Add COMPLETE actions here
		
	END_CASE
	
END_ACTION
