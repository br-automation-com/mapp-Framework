//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Tasks for axis control. 
//***********************************************************************

PROGRAM _INIT
	
	// Read current task name for category setup
	ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    
	// Call initialization actions
	RecipeInit;
	ConfigurationInit;
	ParameterInit;
	AxisInit;
	
	// Enable mapp function blocks
	MpAlarmXCore_0.Enable := TRUE;
	MpAxisBasic_0.Enable := TRUE;

END_PROGRAM

PROGRAM _CYCLIC
    
    MpAxisBasic_0.MpLink := ADR(gAxisTemplate);
    
	// Call all actions
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
	RecipeCyclic;
	
    // Assign MpLink
    MpAlarmXCore_0.MpLink := ADR(gAlarmXCore_AxisTemplate);
    
	// Call function block
	MpAlarmXCore_0();
    
END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks.
	// Do NOT disable MpAxisBasic, as this can cause problems during project transfer.
    MpRecipeRegPar_Par.Enable := FALSE;
	MpRecipeRegPar_Cfg.Enable := FALSE;
	MpAlarmXCore_0.Enable := FALSE;
	
	// Call function blocks
	MpRecipeRegPar_Par();
	MpRecipeRegPar_Cfg();
	MpAlarmXCore_0();

END_PROGRAM
