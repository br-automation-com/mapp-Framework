//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: June 1, 2023
// Description: Task for handling PackML control with VC4 front-end.
//***********************************************************************

PROGRAM _INIT
	
	// NOTE: For VC4 implementations, the MpPackMLCore must be configured in "standalone" mode.
	// For additional information, see "Required Modifications" in AS Mapp Framework Help.
	
	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappPackMLFiles'), pName := ADR('/'));

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
	
	MpPackMLBasicUI_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLBasicUI_0.Enable := TRUE;
	MpPackMLBasicUI_0.UIConnect := ADR(MpPackMLBasicUIConnect);
	MpPackMLBasicUI_0();
	
	MpPackMLStatisticsUI_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLStatisticsUI_0.Enable := TRUE;
	MpPackMLStatisticsUI_0.UIConnect := ADR(MpPackMLStatisticsUIConnect);
	MpPackMLStatisticsUI_0();
	
	// Assign Production mode as selected Index since it's the start mode and preselected
	MpPackMLBasicUIConnect.ModeControl.SelectedIndex := 1; 
	
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all cyclic actions
	StateMachine;
	
	// Assign MpLinks & UIConnects
	MpPackMLCore_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLMode_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLBasicUI_0.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLStatisticsUI_0.MpLink := ADR(gMpLinkPackMLCore);

	// Call function blocks
	MpPackMLCore_0();
	MpPackMLMode_0();
	MpPackMLBasicUI_0();
	MpPackMLStatisticsUI_0();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocks to unlink the MpLinks
	MpPackMLCore_0.Enable := FALSE;
	MpPackMLMode_0.Enable := FALSE;
	MpPackMLBasicUI_0.Enable := FALSE;
	MpPackMLStatisticsUI_0.Enable := TRUE;
	
	// Call function blocks
	MpPackMLCore_0();
	MpPackMLMode_0();
	MpPackMLBasicUI_0();
	MpPackMLStatisticsUI_0();
	 
END_PROGRAM

