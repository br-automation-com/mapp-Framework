
ACTION HmiActions:
	
	IF HmiPackML.Status.LastState <> MpPackMLMode_0.StateCurrent THEN
		
		// Reset all commands on each state change
		MpPackMLBasicUIConnect.StateControl.Abort := MpPackMLMode_0.Abort := 0;
		MpPackMLBasicUIConnect.StateControl.Clear := MpPackMLMode_0.Clear := 0;
		MpPackMLBasicUIConnect.StateControl.Hold := MpPackMLMode_0.Hold := 0;
		MpPackMLBasicUIConnect.StateControl.Reset := MpPackMLMode_0.Reset := 0;
		MpPackMLBasicUIConnect.StateControl.Start := MpPackMLMode_0.Start := 0;
		MpPackMLBasicUIConnect.StateControl.StateComplete := MpPackMLMode_0.StateComplete := 0;
		MpPackMLBasicUIConnect.StateControl.Stop := MpPackMLMode_0.Stop := 0;
		MpPackMLBasicUIConnect.StateControl.Suspend := MpPackMLMode_0.Suspend := 0;
		MpPackMLBasicUIConnect.StateControl.Unhold := MpPackMLMode_0.Unhold := 0;
		MpPackMLBasicUIConnect.StateControl.Unsuspend := MpPackMLMode_0.Unsuspend := 0;
		
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
	

