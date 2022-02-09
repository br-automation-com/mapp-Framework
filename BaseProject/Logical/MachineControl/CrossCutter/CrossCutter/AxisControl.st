(***********************************************************************************************************************
* Copyright: B&R Industrial Automation GmbH
* Description: This program implements an axis control
***********************************************************************************************************************)

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    RecipeInit;

    MpAlarmXCoreFB.Enable := TRUE;
    ConfigurationInit;
    
    MpAxisBasicFB.Enable := TRUE;

    AxisInit;
END_PROGRAM

PROGRAM _CYCLIC

    MpAxisBasicFB.MpLink := ADR(gAxisCrossCutter);
    MC_BR_CheckRestorePositionDataFB.Axis := ADR(gAxisCrossCutter);
    
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
    MpAlarmXCoreFB.MpLink := ADR(gAlarmXCore_Cutter);
    MpAlarmXCoreFB();
   
END_PROGRAM

PROGRAM _EXIT

    MpRecipeRegPar_MachineFB.Enable := FALSE;
    MpRecipeRegPar_MachineFB();
    
    MpRecipeRegPar_UserFB.Enable := FALSE;
    MpRecipeRegPar_UserFB();
    
    MpRecipeRegPar_PreFB.Enable := FALSE;
    MpRecipeRegPar_PreFB();
    
    MpRecipeRegPar_UserPreFB.Enable := FALSE;
    MpRecipeRegPar_UserPreFB();
    
    MpAxisBasicFB.Enable := FALSE;
    MpAxisBasicFB();

    MC_BR_CamAutomatCommandFB.Enable := FALSE;
    MC_BR_CamAutomatCommandFB();
    
    MpAlarmXCoreFB.Enable := FALSE;
    MpAlarmXCoreFB();

END_PROGRAM
