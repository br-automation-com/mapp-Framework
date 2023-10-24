
ACTION StateInitialize: 

	//Initialize the PackML framework
	
	Manual.Clearing:=FALSE;
	Manual.Stopped:=TRUE;
	Manual.Starting:=TRUE;
	Manual.Idle:=TRUE;
	Manual.Suspended:=FALSE;
	Manual.Execute:=TRUE;
	Manual.Stopping:=TRUE;
	Manual.Aborting:=TRUE;
	Manual.Aborted:=TRUE;
	Manual.Holding:=FALSE;
	Manual.Held:=FALSE;
	Manual.Unholding:=FALSE;
	Manual.Suspending:=FALSE;
	Manual.Unsuspending:=FALSE;
	Manual.Resetting:=TRUE;
	Manual.Completing:=FALSE;
	Manual.Complete:=FALSE; 
	
	Maintenance.Clearing:=TRUE;
	Maintenance.Stopped:=TRUE;
	Maintenance.Starting:=TRUE;
	Maintenance.Idle:=TRUE;
	Maintenance.Suspended:=FALSE;
	Maintenance.Execute:=TRUE;
	Maintenance.Stopping:=TRUE;
	Maintenance.Aborting:=TRUE;
	Maintenance.Aborted:=TRUE;
	Maintenance.Holding:=TRUE;
	Maintenance.Held:=TRUE;
	Maintenance.Unholding:=TRUE;
	Maintenance.Suspending:=FALSE;
	Maintenance.Unsuspending:=FALSE;
	Maintenance.Resetting:=TRUE;
	Maintenance.Completing:=FALSE;
	Maintenance.Complete:=FALSE;
	
	AutomaticMode.Clearing:=TRUE;
	AutomaticMode.Stopped:=TRUE;
	AutomaticMode.Starting:=TRUE;
	AutomaticMode.Idle:=TRUE;
	AutomaticMode.Suspended:=TRUE;
	AutomaticMode.Execute:=TRUE;
	AutomaticMode.Stopping:=TRUE;
	AutomaticMode.Aborting:=TRUE;
	AutomaticMode.Aborted:=TRUE;
	AutomaticMode.Holding:=TRUE;
	AutomaticMode.Held:=TRUE;
	AutomaticMode.Unholding:=TRUE;
	AutomaticMode.Suspending:=TRUE;
	AutomaticMode.Unsuspending:=TRUE;
	AutomaticMode.Resetting:=TRUE;
	AutomaticMode.Completing:=TRUE;
	AutomaticMode.Complete:=TRUE;
	
	HmiPackML.Parameters.StateEnabled.Clearing:=TRUE;
	HmiPackML.Parameters.StateEnabled.Stopped:=TRUE;
	HmiPackML.Parameters.StateEnabled.Starting:=TRUE;
	HmiPackML.Parameters.StateEnabled.Idle:=TRUE;
	HmiPackML.Parameters.StateEnabled.Suspended:=TRUE;
	HmiPackML.Parameters.StateEnabled.Execute:=TRUE;
	HmiPackML.Parameters.StateEnabled.Stopping:=TRUE;
	HmiPackML.Parameters.StateEnabled.Aborting:=TRUE;
	HmiPackML.Parameters.StateEnabled.Aborted:=TRUE;
	HmiPackML.Parameters.StateEnabled.Holding:=TRUE;
	HmiPackML.Parameters.StateEnabled.Held:=TRUE;
	HmiPackML.Parameters.StateEnabled.Unholding:=TRUE;
	HmiPackML.Parameters.StateEnabled.Suspending:=TRUE;
	HmiPackML.Parameters.StateEnabled.Unsuspending:=TRUE;
	HmiPackML.Parameters.StateEnabled.Resetting:=TRUE;
	HmiPackML.Parameters.StateEnabled.Completing:=TRUE;
	HmiPackML.Parameters.StateEnabled.Complete:=TRUE;
	

END_ACTION
