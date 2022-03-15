//******************************************************************************************************************** 
// Copyright: B&R Industrial Automation GmbH
// Description: This PROGRAM implements an axis control
//********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    
	// Inititialize mapp function blocks
	MpAlarmXCoreFB.Enable := TRUE;
	MpAlarmXCoreFB();
    ConfigurationInit;

    MpAxisBasicFB.Enable := TRUE;
	MpAxisBasicFB.MpLink := ADR(gAxisTemplate);
	MpAxisBasicFB();
    
    AxisInit;

END_PROGRAM

PROGRAM _CYCLIC
    
    MpAxisBasicFB.MpLink := ADR(gAxisTemplate);
    MC_BR_CheckRestorePositionDataFB.Axis := ADR(gAxisTemplate);
    
	// Call all actions
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
	RecipeCyclic;
	
    // Assign MpLink
    MpAlarmXCoreFB.MpLink := ADR(gAlarmXCore_AxisTemplate);
    
	// Call function block
	MpAlarmXCoreFB();
    
END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
    MpRecipeRegPar_Par.Enable := FALSE;
	MpRecipeRegPar_Cfg.Enable := FALSE;
	MpAxisBasicFB.Enable := FALSE;
	MpAlarmXCoreFB.Enable := FALSE;
	
	// Call function blocks
	MpRecipeRegPar_Par();
	MpRecipeRegPar_Cfg();
	MpAxisBasicFB();
	MpAlarmXCoreFB();

END_PROGRAM
