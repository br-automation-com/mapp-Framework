
ACTION StateMachine:

	CASE MpPackMLCoreMain.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
		   
			// Add STOPPED actions here			
			MpPackMLModeMain.StateComplete := FALSE;
					   
		mpPACKML_STATE_STARTING:
					   
			// Add STARTING actions here			
			MpPackMLModeMain.StateComplete := TRUE;
					
		mpPACKML_STATE_IDLE:
		
			// Add IDLE actions here
			MpPackMLModeMain.StateComplete := FALSE;
						
		mpPACKML_STATE_SUSPENDING:
			
			// Add SUSPENDING actions here			 
			MpPackMLModeMain.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:

			// Add SUSPENDED actions here			
			MpPackMLModeMain.StateComplete := FALSE;
			
		mpPACKML_STATE_UNSUSPENDING:

			// Add UNSUSPENDING actions here
			MpPackMLModeMain.StateComplete := TRUE;
					  
		mpPACKML_STATE_EXECUTE:

			// Add EXECUTE actions here			
			MpPackMLModeMain.StateComplete := FALSE;
			
		mpPACKML_STATE_STOPPING:

			// Add STOPPING actions here		   
			MpPackMLModeMain.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:

			// Add ABORTING actions here		   
			MpPackMLModeMain.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:

			// Add ABORTED actions here			
			MpPackMLModeMain.StateComplete := FALSE;
						
		mpPACKML_STATE_HOLDING:

			// Add HOLDING actions here			   
			MpPackMLModeMain.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:

			// Add HELD actions here			
			MpPackMLModeMain.StateComplete := FALSE;
	   
		mpPACKML_STATE_UNHOLDING:

			// Add UNHOLDING actions here
			MpPackMLModeMain.StateComplete := TRUE;
						
		mpPACKML_STATE_COMPLETING:

			// Add COMPLETING actions here
			MpPackMLModeMain.StateComplete := TRUE;
			
			// NOTE: To allow the state machine to move forward, the StateComplete command has been connected
			// to the HMI button. The user should change this to set StateComplete to TRUE upon COMPLETING actions.

		mpPACKML_STATE_COMPLETE:

			// Add COMPLETE actions here
			MpPackMLModeMain.StateComplete := FALSE;
			
		mpPACKML_STATE_RESETTING:

			// Add RESETTING actions here			
			MpPackMLModeMain.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:

			// Add CLEARING actions here
			MpPackMLModeMain.StateComplete := TRUE;
			
		mpPACKML_STATE_UNDEFINED:
			
			// Add UNDEFINED actions here		   
			MpPackMLModeMain.Activate := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:

			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:

			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:

			// Add ACTIVATING actions here	
			
			MpPackMLModeMain.StateComplete := TRUE;
		
	END_CASE
	
END_ACTION
