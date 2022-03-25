//***********************************************************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Description: This program implements an axis control
//***********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    RecipeInit;

    ConfigurationInit;
	ParameterInit;
    
    MpAlarmXCoreFB.Enable := TRUE;
    
    MpAxisBasicFB.Enable := TRUE;

	AxisInit;
END_PROGRAM

PROGRAM _CYCLIC

    MpAxisBasicFB.MpLink := ADR(gMpLinkAppAxis_1);
    MC_BR_CheckRestorePositionDataFB.Axis := ADR(gMpLinkAppAxis_1);
    
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
    MpAlarmXCoreFB.MpLink := ADR(gMpLinkAlarmXCoreAppAxis_1);
    MpAlarmXCoreFB();

END_PROGRAM

PROGRAM _EXIT

    MpRecipeRegPar_Par.Enable := FALSE;
    MpRecipeRegPar_Par();
    
    MpRecipeRegPar_Cfg.Enable := FALSE;
    MpRecipeRegPar_Cfg();
       
    MpAxisBasicFB.Enable := FALSE;
    MpAxisBasicFB();
    
    MpAlarmXCoreFB.Enable := FALSE;
    MpAlarmXCoreFB();

END_PROGRAM
