//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: June 1, 2023
// Description: Task for handling PackML control.
//***********************************************************************

PROGRAM _INIT
	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappComponentFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF 
	
	// Initialize mapp function blocks
	MpPackMLCore_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLCore_0.Enable := TRUE;
	MpPackMLCore_0();
	
	MpPackMLMode_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLMode_0.Enable := TRUE;
	MpPackMLMode_0.ModeID := 1;
	MpPackMLMode_0();
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	// Call all cyclic actions
	
	
	// Assign MpLinks & UIConnects
	MpPackMLCore_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLMode_0.MpLink := ADR(gMpLinkPackMLCore);
	
	// Call function blocks
	MpPackMLCore_0();
	MpPackMLMode_0();
	 
END_PROGRAM

PROGRAM _EXIT
	// Disable the function blocks to unlink the MpLinks
	MpPackMLCore_0.Enable := FALSE;
	MpPackMLMode_0.Enable := FALSE;
	
	// Call function blocks
	MpPackMLCore_0();
	MpPackMLMode_0();
	 
END_PROGRAM

