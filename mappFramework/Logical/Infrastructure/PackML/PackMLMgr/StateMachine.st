
ACTION StateMachine:

	// Check active state and change mode if allowed
	IF MpPackMLModeChangeIsAllowed(gMpLinkPackMLCore,HmiPackML.Commands.Mode) = 0 THEN
		MpPackMLChangeMode(gMpLinkPackMLCore,HmiPackML.Commands.Mode);
	END_IF	

	CASE MpPackMLModuleMain.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
			
			// Add STOPPED actions here

		mpPACKML_STATE_STARTING:
			
			// Add STARTING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_IDLE:
			
			// Add IDLE actions here
			
		mpPACKML_STATE_SUSPENDING:
			
			// Add SUSPENDING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:
			
			// Add SUSPENDED actions here
			
		mpPACKML_STATE_UNSUSPENDING:
	
			// Add UNSUSPENDING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_EXECUTE:
			
			// Add EXECUTE actions here
			
		mpPACKML_STATE_STOPPING:
			
			// Add STOPPING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:
			
			// Add ABORTING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			// Add ABORTED actions here
			
		mpPACKML_STATE_HOLDING:
			
			// Add HOLDING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:
			
			// Add HELD actions here
			
		mpPACKML_STATE_UNHOLDING:
			
			// Add UNHOLDING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_COMPLETING:
			
			// Add COMPLETING actions here
			
			// NOTE: once COMPLETING actions that take more than one cyclic have been added, the below line
			// should be removed and replaced by the following line.
			MpPackMLModuleMain.Command.StateComplete := NOT MpPackMLModuleMain.Command.StateComplete;
			// MpPackMLModuleMain.Command.StateComplete := TRUE;
			

		mpPACKML_STATE_COMPLETE:
			
			// Add COMPLETE actions here
			
		mpPACKML_STATE_RESETTING:
			
			// Add RESETTING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:
			
			// Add CLEARING actions here
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:

			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:

			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:

			// Add ACTIVATING actions here	
			
			MpPackMLModuleMain.Command.StateComplete := TRUE;
		
	END_CASE
	
END_ACTION
