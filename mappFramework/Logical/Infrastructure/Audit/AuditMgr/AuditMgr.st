//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Sept 1, 2022
// Description: Task for audit management. 
//***********************************************************************

PROGRAM _INIT
		
	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF
	
	// Initialize mapp function blocks
	MpAuditTrail_0.Enable := TRUE;
	MpAuditTrail_0.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrail_0.Language := ADR('en');
	MpAuditTrail_0.DeviceName := ADR('mappAuditFiles');
	MpAuditTrail_0();
	
	// Initialize mapp function blocks
	MpAuditTrail_CEvents.Enable := TRUE;
	MpAuditTrail_CEvents.MpLink := ADR(gMpLinkCustomEvents);
	MpAuditTrail_CEvents();
	
	// Initialize custom events
	CustomEvent[0].Type := "Custom Event Type";
	CustomEvent[0].Msg := "Custom Event Message";
	CustomEvent[0].Comment := "Custom Event Comment";	
		
	CustomEvent[1].Type := "Audit Test";
	CustomEvent[1].Msg := "This is a custom event test msg";
	CustomEvent[1].Comment := "If you see this it was a success!";	
	
	CustomEvent[2].Type := "Cmd Exe";
	CustomEvent[2].Msg := "The run query command was pressed on the HMI";
	CustomEvent[2].Comment := "Result can be seen in the Query tab";
	
	HmiAudit.Status.Query.Name := 'UserEvents';
	HmiAudit.Status.Query.Option := 1;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all cyclic actions
	CustomEvents;
	ExecuteQuery;
    QueryTableConfig;
	ArchiveExport;

    // Error reset
    IF NOT MpAuditTrail_0.Error THEN
        MpAuditTrail_0.ErrorReset := FALSE;
    END_IF
    
	// Assign MpLinks and HMI connections
	MpAuditTrail_0.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrail_CEvents.MpLink := ADR(gMpLinkCustomEvents);
		
	// Call function blocks
	MpAuditTrail_0();
	MpAuditTrail_CEvents();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocls to unlink the MpLinks
    MpAuditTrail_0.Enable := FALSE;
	MpAuditTrail_CEvents.Enable := FALSE;
	
	// Call function blocks
    MpAuditTrail_0();
	MpAuditTrail_CEvents();
	 
END_PROGRAM

