
ACTION StateMachine_Main:

	CASE MpPackMLCore_0.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
		   
			// Add STOPPED actions here
					   
		mpPACKML_STATE_STARTING:
					   
			// Add STARTING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_IDLE:
		
			// Add IDLE actions here
						
		mpPACKML_STATE_SUSPENDING:
			
			// Add SUSPENDING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:

			// Add SUSPENDED actions here
			
		mpPACKML_STATE_UNSUSPENDING:

			// Add UNSUSPENDING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;			
			
		mpPACKML_STATE_EXECUTE:

			// Add EXECUTE actions here
			
		mpPACKML_STATE_STOPPING:

			// Add STOPPING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:

			// Add ABORTING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:

			// Add ABORTED actions here
						
		mpPACKML_STATE_HOLDING:

			// Add HOLDING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:

			// Add HELD actions here
	   
		mpPACKML_STATE_UNHOLDING:

			// Add UNHOLDING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_COMPLETING:

			// Add COMPLETING actions here
			
			// NOTE: To allow the state machine to move forward, the StateComplete command has been connected
			// to the HMI button. The user should change this to set StateComplete to TRUE upon COMPLETING actions.

		mpPACKML_STATE_COMPLETE:

			// Add COMPLETE actions here
			
		mpPACKML_STATE_RESETTING:

			// Add RESETTING actions here
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:

			// Add CLEARING actions here

			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
			
		mpPACKML_STATE_UNDEFINED:
			
			// Add UNDEFINED actions here
			
			MpPackMLMode_0.Activate := TRUE;
			
		mpPACKML_STATE_DEACTIVATING:

			// Add DEACTIVATING actions here
			
		mpPACKML_STATE_DEACTIVATED:

			// Add DEACTIVATED actions here
			
		mpPACKML_STATE_ACTIVATING:

			// Add ACTIVATING actions here	
			
			MpPackMLBasicUIConnect.StateControl.StateComplete := TRUE;
		
	END_CASE
	
END_ACTION
