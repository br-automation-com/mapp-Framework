//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: June 1, 2023
// Description: Task for handling PackML control.
//***********************************************************************

PROGRAM _INIT
	
	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappPackMLFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF 
	
	// Initialize mapp function blocks
	MpPackMLModule_Main.Parameters := ADR(MpPackMLModulePar_Main);
	MpPackMLModule_Main.MpLink := ADR(gPackMLModule_Main);
	MpPackMLModule_Main.Enable := TRUE;
	MpPackMLModule_Main();
	
END_PROGRAM

PROGRAM _CYCLIC
	
	// Call all cyclic actions
	StateMachine_Main;
	HmiActions;
	
	// Assign MpLinks & UIConnects
	MpPackMLModule_Main.Parameters := ADR(MpPackMLModulePar_Main);
	MpPackMLModule_Main.MpLink := ADR(gPackMLModule_Main);

	// Call function blocks
	MpPackMLModule_Main();
	 
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocks to unlink the MpLinks
	MpPackMLModule_Main.Enable := FALSE;
	
	// Call function blocks
	MpPackMLModule_Main();
	 
END_PROGRAM

