
ACTION StateMachine_Main:

	CASE MpPackMLModule_Main.StateCurrent OF

		mpPACKML_STATE_DEACTIVATING:
			
			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:
			
			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:
			
			// Add ACTIVATING actions here	
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
		
		mpPACKML_STATE_STOPPED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Stopped';
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Starting';
			
			// Add STARTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_IDLE:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Idle';
			
			// Add IDLE actions here

		mpPACKML_STATE_SUSPENDED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Suspended';
			
			// Add SUSPENDED actions here

		mpPACKML_STATE_EXECUTE:

			HmiPackMLState := 'Execute';
			
			// Add EXECUTE actions here

		mpPACKML_STATE_STOPPING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Stopping';
			
			// Add STOPPING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Clearing';
			
			// Add CLEARING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;


		mpPACKML_STATE_ABORTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Aborting';
			
			// Add ABORTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Aborted';
			
 			// Add ABORTED actions here

		mpPACKML_STATE_HOLDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Holding';
			
			// Add HOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_HELD:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Held';
			
			// Add HELD actions here

		mpPACKML_STATE_UNHOLDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Unholding';
			
			// Add UNHOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Suspending';
			
			// Add SUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_UNSUSPENDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Unsuspending';
			
			// Add UNSUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_RESETTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Resetting';
			
			// Add RESETTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_COMPLETING:
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 'Completing';
			
			// Add COMPLETING actions here
			// NOTE: once COMPLETING actions that take more than one cyclic have been added, the below may be removed and replaced by the following line.
			Completing_TON.PT := T#100ms;
			Completing_TON.IN := TRUE;
			IF Completing_TON.Q THEN
				Completing_TON.IN := FALSE;
				MpPackMLModule_Main.Command.StateComplete := TRUE;
			END_IF
			Completing_TON();
			
			// MpPackMLModule_Main.Command.StateComplete := TRUE;
			

		mpPACKML_STATE_COMPLETE:

			HmiPackMLState := 'Complete';
			
			// Add COMPLETE actions here
		
	END_CASE
	
END_ACTION
