
ACTION VC4_Cyclic:
	
	IF HmiPackML.Status.LastState <> MpPackMLMode_0.StateCurrent THEN
		
		// Reset all commands on each state change
		MpPackMLBasicUIConnect.StateControl.Abort := MpPackMLMode_0.Abort := FALSE;
		MpPackMLBasicUIConnect.StateControl.Clear := MpPackMLMode_0.Clear := FALSE;
		MpPackMLBasicUIConnect.StateControl.Hold := MpPackMLMode_0.Hold := FALSE;
		MpPackMLBasicUIConnect.StateControl.Reset := MpPackMLMode_0.Reset := FALSE;
		MpPackMLBasicUIConnect.StateControl.Start := MpPackMLMode_0.Start := FALSE;
		MpPackMLBasicUIConnect.StateControl.StateComplete := MpPackMLMode_0.StateComplete := FALSE;
		MpPackMLBasicUIConnect.StateControl.Stop := MpPackMLMode_0.Stop := FALSE;
		MpPackMLBasicUIConnect.StateControl.Suspend := MpPackMLMode_0.Suspend := FALSE;
		MpPackMLBasicUIConnect.StateControl.Unhold := MpPackMLMode_0.Unhold := FALSE;
		MpPackMLBasicUIConnect.StateControl.Unsuspend := MpPackMLMode_0.Unsuspend := FALSE;
		
		// Reset all ColorIndexes on each state change
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Stopped := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Stopping := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Clearing := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Aborted := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Aborting := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Resetting := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Unsuspending := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Suspended := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Suspending := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Idle := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Starting := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Execute := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Completing := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Complete := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Unholding := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Held := 0;
		MpPackMLBasicUIConnect.StateControl.ColorIndex.Holding := 0;

		HmiPackML.Status.LastState := MpPackMLMode_0.StateCurrent;
		
	END_IF
	
	// Connect UIConnect Commands to function block
	MpPackMLMode_0.Abort := MpPackMLBasicUIConnect.StateControl.Abort;
	MpPackMLMode_0.Stop := MpPackMLBasicUIConnect.StateControl.Stop;
	
	MpPackMLBasicUIConnect.ModeCurrent := MpPackMLMode_0.ModeID;
	MpPackMLBasicUIConnect.StateCurrent := MpPackMLMode_0.StateCurrent;
	
END_ACTION
	

