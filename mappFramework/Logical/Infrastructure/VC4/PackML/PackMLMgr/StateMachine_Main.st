
ACTION StateMachine_Main:

	CASE MpPackMLCore_0.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
		   
			// Add STOPPED actions here			
			MpPackMLMode_0.StateComplete := FALSE;
					   
		mpPACKML_STATE_STARTING:
					   
			// Add STARTING actions here			
			MpPackMLMode_0.StateComplete := TRUE;
					
		mpPACKML_STATE_IDLE:
		
			// Add IDLE actions here
			MpPackMLMode_0.StateComplete := FALSE;
						
		mpPACKML_STATE_SUSPENDING:
			
			// Add SUSPENDING actions here			 
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:

			// Add SUSPENDED actions here			
			MpPackMLMode_0.StateComplete := FALSE;
			
		mpPACKML_STATE_UNSUSPENDING:

			// Add UNSUSPENDING actions here
			MpPackMLMode_0.StateComplete := TRUE;
					  
		mpPACKML_STATE_EXECUTE:

			// Add EXECUTE actions here			
			MpPackMLMode_0.StateComplete := FALSE;
			
		mpPACKML_STATE_STOPPING:

			// Add STOPPING actions here		   
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:

			// Add ABORTING actions here		   
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:

			// Add ABORTED actions here			
			MpPackMLMode_0.StateComplete := FALSE;
						
		mpPACKML_STATE_HOLDING:

			// Add HOLDING actions here			   
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:

			// Add HELD actions here			
			MpPackMLMode_0.StateComplete := FALSE;
	   
		mpPACKML_STATE_UNHOLDING:

			// Add UNHOLDING actions here
			MpPackMLMode_0.StateComplete := TRUE;
						
		mpPACKML_STATE_COMPLETING:

			// Add COMPLETING actions here
			MpPackMLMode_0.StateComplete := TRUE;
			
			// NOTE: To allow the state machine to move forward, the StateComplete command has been connected
			// to the HMI button. The user should change this to set StateComplete to TRUE upon COMPLETING actions.

		mpPACKML_STATE_COMPLETE:

			// Add COMPLETE actions here
			MpPackMLMode_0.StateComplete := FALSE;
			
		mpPACKML_STATE_RESETTING:

			// Add RESETTING actions here			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:

			// Add CLEARING actions here
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_UNDEFINED:
			
			// Add UNDEFINED actions here		   
			MpPackMLMode_0.Activate := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:

			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:

			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:

			// Add ACTIVATING actions here	
			
			MpPackMLMode_0.StateComplete := TRUE;
		
	END_CASE
	
END_ACTION
