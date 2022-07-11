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
	MpAuditTrail_0();

	MpAuditTrailUI_0.Enable := TRUE;
	MpAuditTrailUI_0.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrailUI_0.UIConnect := ADR(MpAuditTrailUIConnect);	
	MpAuditTrailUI_0.UISetup.ScrollWindow := 10;
	MpAuditTrailUI_0.UISetup.EventListSize := 50;
	MpAuditTrailUI_0();
	
	// Initialize additional PVs
	HmiAudit;
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
    // Error reset
    IF NOT MpAuditTrail_0.Error THEN
        MpAuditTrail_0.ErrorReset := FALSE;
    END_IF
    IF NOT MpAuditTrailUI_0.Error THEN
        MpAuditTrailUI_0.ErrorReset := FALSE;
    END_IF
    
	// Assign MpLinks & UIConnects
	MpAuditTrail_0.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrailUI_0.MpLink := ADR(gMpLinkAuditTrail);
	MpAuditTrailUI_0.UIConnect := ADR(MpAuditTrailUIConnect);
		
	// Call function blocks
	MpAuditTrail_0();
	MpAuditTrailUI_0();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocls to unlink the MpLinks
    MpAuditTrail_0.Enable := FALSE;
    MpAuditTrailUI_0.Enable := FALSE;
	
	// Call function blocks
    MpAuditTrail_0();
    MpAuditTrailUI_0();
	 
END_PROGRAM

