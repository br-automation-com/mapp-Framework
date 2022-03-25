//***********************************************************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Description: This program implements an axis control
//***********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    
	RecipeInit;
	ConfigurationInit;
    
	// Inititialize mapp function blocks
    MpAlarmXCore_0.Enable := TRUE;
	MpAxisBasic_0.Enable := TRUE;

	AxisInit;
END_PROGRAM

PROGRAM _CYCLIC

    MpAxisBasic_0.MpLink := ADR(gMpLinkAppAxis_1);
    MC_BR_CheckRestorePositionData_0.Axis := ADR(gMpLinkAppAxis_1);
    
	// Call all actions
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
	// Assign MpLink
	MpAlarmXCore_0.MpLink := ADR(gMpLinkAlarmXCoreAppAxis_1);
	
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
