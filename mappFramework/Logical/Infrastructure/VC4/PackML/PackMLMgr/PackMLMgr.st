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
	DirCreatePackML(enable := TRUE, pDevice := ADR('mappPackMLFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreatePackML.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreatePackML(enable := FALSE);
	END_IF 
	
	// Initialize mapp function blocks
	MpPackMLCoreMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLCoreMain.Enable := TRUE;
	MpPackMLCoreMain();
	
	MpPackMLModeMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLModeMain.Enable := TRUE;
	MpPackMLModeMain.ModeID := 1;
	MpPackMLModeMain();
	
	MpPackMLBasicUIMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLBasicUIMain.Enable := TRUE;
	MpPackMLBasicUIMain.UIConnect := ADR(MpPackMLBasicUIConnect);
	MpPackMLBasicUIMain();
	
	MpPackMLStatisticsUIMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLStatisticsUIMain.Enable := TRUE;
	MpPackMLStatisticsUIMain.UIConnect := ADR(MpPackMLStatisticsUIConnect);
	MpPackMLStatisticsUIMain();
	
	// Assign Production mode as selected Index since it's the start mode and preselected
	MpPackMLBasicUIConnect.ModeControl.SelectedIndex := 1; 
	
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all cyclic actions
	StateMachine;
	
	// Assign MpLinks & UIConnects
	MpPackMLCoreMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLModeMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLBasicUIMain.MpLink := ADR(gMpLinkPackMLCore);
	MpPackMLStatisticsUIMain.MpLink := ADR(gMpLinkPackMLCore);

	// Call function blocks
	MpPackMLCoreMain();
	MpPackMLModeMain();
	MpPackMLBasicUIMain();
	MpPackMLStatisticsUIMain();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocks to unlink the MpLinks
	MpPackMLCoreMain.Enable := FALSE;
	MpPackMLModeMain.Enable := FALSE;
	MpPackMLBasicUIMain.Enable := FALSE;
	MpPackMLStatisticsUIMain.Enable := TRUE;
	
	// Call function blocks
	MpPackMLCoreMain();
	MpPackMLModeMain();
	MpPackMLBasicUIMain();
	MpPackMLStatisticsUIMain();
	 
END_PROGRAM

