
ACTION StateMachine_Main:

	CASE MpPackMLCore_0.StateCurrent OF
		
		mpPACKML_STATE_STOPPED:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Stopped := 2;
			
			// Add STOPPED actions here
			
			MpPackMLMode_0.Reset := MpPackMLBasicUIConnect.StateControl.Reset;
			
		mpPACKML_STATE_STARTING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Starting := 1;
			
			// Add STARTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_IDLE:
		
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Idle := 2;
			
			// Add IDLE actions here
			
			MpPackMLMode_0.Start := MpPackMLBasicUIConnect.StateControl.Start;
			
		mpPACKML_STATE_SUSPENDING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Suspending := 1;
			
			// Add SUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_SUSPENDED:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Suspended := 2;
			
			// Add SUSPENDED actions here
			
			MpPackMLMode_0.Unsuspend := MpPackMLBasicUIConnect.StateControl.Unsuspend;

		mpPACKML_STATE_UNSUSPENDING:
	
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Unsuspending := 1;
			
			// Add UNSUSPENDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
			
		mpPACKML_STATE_EXECUTE:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Execute := 3;
			
			// Add EXECUTE actions here
			
			MpPackMLMode_0.StateComplete := MpPackMLBasicUIConnect.StateControl.StateComplete;
			MpPackMLMode_0.Suspend := MpPackMLBasicUIConnect.StateControl.Suspend;
			MpPackMLMode_0.Hold := MpPackMLBasicUIConnect.StateControl.Hold;
			
		mpPACKML_STATE_STOPPING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Stopping := 1;
			
			// Add STOPPING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_ABORTING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Aborting := 1;
			
			// Add ABORTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;

		mpPACKML_STATE_ABORTED:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Aborted := 2;
			
			// Add ABORTED actions here
			
			MpPackMLMode_0.Clear := MpPackMLBasicUIConnect.StateControl.Clear;
			
		mpPACKML_STATE_HOLDING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Holding := 1;
			
			// Add HOLDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_HELD:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Held := 2;
			
			// Add HELD actions here
			
			MpPackMLMode_0.Unhold := MpPackMLBasicUIConnect.StateControl.Unhold;
			
		mpPACKML_STATE_UNHOLDING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Unholding := 1;
			
			// Add UNHOLDING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_COMPLETING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Completing := 1;
			
			// Add COMPLETING actions here
			
			// NOTE: To allow the state machine to move forward, the StateComplete command has been connected
			// to the HMI button. The user should change this to set StateComplete to TRUE upon COMPLETING actions.
			MpPackMLMode_0.StateComplete := MpPackMLBasicUIConnect.StateControl.StateComplete;
			

		mpPACKML_STATE_COMPLETE:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Complete := 2;
			
			// Add COMPLETE actions here
			
			MpPackMLMode_0.Reset := MpPackMLBasicUIConnect.StateControl.Reset;
			
		mpPACKML_STATE_RESETTING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Resetting := 1;
			
			// Add RESETTING actions here
			
			MpPackMLMode_0.StateComplete := TRUE;
			
		mpPACKML_STATE_CLEARING:
			
			MpPackMLBasicUIConnect.StateControl.ColorIndex.Clearing := 1;
			
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
