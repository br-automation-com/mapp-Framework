
ACTION StateMachine_Main:

	CASE MpPackMLModule_Main.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			
			// Add STARTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_IDLE:
			
			// Add IDLE actions here
			
		mpPACKML_STATE_SUSPENDING:
			
			// Add SUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:
			
			// Add SUSPENDED actions here
			

		mpPACKML_STATE_UNSUSPENDING:
	
			// Add UNSUSPENDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_EXECUTE:
			
			// Add EXECUTE actions here
			
		mpPACKML_STATE_STOPPING:
			
			// Add STOPPING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:
			
			// Add ABORTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			// Add ABORTED actions here
			
		mpPACKML_STATE_HOLDING:
			
			// Add HOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:
			
			// Add HELD actions here
			
		mpPACKML_STATE_UNHOLDING:
			
			// Add UNHOLDING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_COMPLETING:
			
			// Add COMPLETING actions here
			
			// NOTE: once COMPLETING actions that take more than one cyclic have been added, the below line
			// should be removed and replaced by the following line.
			MpPackMLModule_Main.Command.StateComplete := NOT MpPackMLModule_Main.Command.StateComplete;
			// MpPackMLModule_Main.Command.StateComplete := TRUE;
			

		mpPACKML_STATE_COMPLETE:
			
			// Add COMPLETE actions here
			
		mpPACKML_STATE_RESETTING:
			
			// Add RESETTING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:
			
			// Add CLEARING actions here
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:

			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:

			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:

			// Add ACTIVATING actions here	
			
			MpPackMLModule_Main.Command.StateComplete := TRUE;
		
	END_CASE
	
END_ACTION
