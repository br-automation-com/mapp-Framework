
ACTION StateMachine_Main:

	CASE MpPackMLModule_Main.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 1;
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 2;
			
			// Add STARTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_IDLE:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 3;
			
			// Add IDLE actions here
			
		mpPACKML_STATE_SUSPENDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 4;
			
			// Add SUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 5;
			
			// Add SUSPENDED actions here
			

		mpPACKML_STATE_UNSUSPENDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 6;
			
			// Add UNSUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_EXECUTE:

			HmiPackMLState := 7;
			
			// Add EXECUTE actions here
			
		mpPACKML_STATE_STOPPING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 8;
			
			// Add STOPPING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 9;
			
			// Add ABORTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 10;
			
			// Add ABORTED actions here
			
		mpPACKML_STATE_HOLDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 11;
			
			// Add HOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 12;
			
			// Add HELD actions here
			
		mpPACKML_STATE_UNHOLDING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 13;
			
			// Add UNHOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_COMPLETING:
			HmiPackMLState := 14;
			
			// Add COMPLETING actions here
			
			// NOTE: once COMPLETING actions that take more than one cyclic have been added, the below line
			// should be removed and replaced by the following line.
			MpPackMLModule_Main.Command.StateComplete := NOT MpPackMLModule_Main.Command.StateComplete;
			// MpPackMLModule_Main.Command.StateComplete := TRUE;
			

		mpPACKML_STATE_COMPLETE:

			HmiPackMLState := 15;
			
			// Add COMPLETE actions here
			
		mpPACKML_STATE_RESETTING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 16;
			
			// Add RESETTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:
			
			MpPackMLModule_Main.Command.StateComplete := FALSE;
			HmiPackMLState := 17;
			
			// Add CLEARING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:
			
			HmiPackMLState := 18;
			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:
			
			HmiPackMLState := 18;
			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:
			
			HmiPackMLState := 18;
			// Add ACTIVATING actions here	


		
	END_CASE
	
END_ACTION
