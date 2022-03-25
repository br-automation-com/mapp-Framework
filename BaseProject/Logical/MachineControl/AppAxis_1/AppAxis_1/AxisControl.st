//***********************************************************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Description: This program implements an axis control
//***********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    
	RecipeInit;
	ConfigurationInit;
    
	// Inititialize mapp function blocks
    MpAlarmXCoreFB.Enable := TRUE;
	MpAxisBasicFB.Enable := TRUE;

	AxisInit;
END_PROGRAM

PROGRAM _CYCLIC

    MpAxisBasicFB.MpLink := ADR(gMpLinkAppAxis_1);
    MC_BR_CheckRestorePositionDataFB.Axis := ADR(gMpLinkAppAxis_1);
    
	// Call all actions
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
	// Assign MpLink
	MpAlarmXCoreFB.MpLink := ADR(gMpLinkAlarmXCoreAppAxis_1);
	
	// Call function block
    MpAlarmXCoreFB();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks.
	// Do NOT disable MpAxisBasic, as this can cause problems during project transfer.
    MpRecipeRegPar_Par.Enable := FALSE;
	MpRecipeRegPar_Cfg.Enable := FALSE;
	MpAlarmXCoreFB.Enable := FALSE;
	
	// Call function blocks
	MpRecipeRegPar_Par();
	MpRecipeRegPar_Cfg();
	MpAlarmXCoreFB();

END_PROGRAM
