//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: June 1, 2023
// Description: Task for handling PackML control.
//***********************************************************************

PROGRAM _INIT
	
	// Create folder for this component on the user file device
	DirCreatePackML(enable := TRUE, pDevice := ADR('mappPackMLFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreatePackML.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreatePackML(enable := FALSE);
	END_IF 
	
	// Initialize mapp function blocks
	MpPackMLModuleMain.Parameters := ADR(MpPackMLModuleParMain);
	MpPackMLModuleMain.MpLink := ADR(gMpPackMLModuleMain);
	MpPackMLModuleMain.Enable := TRUE;
	MpPackMLModuleMain();
	
	//PackML Mode Initializations
	StateInitialize;
	
	// Initialize startup mode - Automatic Mode
	HmiPackML.Commands.Mode := 1; 
	
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all cyclic actions
	StateMachine;
	HmiActions;
	
	// Assign MpLinks & UIConnects
	MpPackMLModuleMain.Parameters := ADR(MpPackMLModuleParMain);
	MpPackMLModuleMain.MpLink := ADR(gMpPackMLModuleMain);

	// Call function blocks
	MpPackMLModuleMain();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocks to unlink the MpLinks
	MpPackMLModuleMain.Enable := FALSE;
	
	// Call function blocks
	MpPackMLModuleMain();
	 
END_PROGRAM

