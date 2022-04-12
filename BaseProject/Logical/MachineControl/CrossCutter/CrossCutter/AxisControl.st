//***********************************************************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Description: This program implements an axis control
//**********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    RecipeInit;

    MpAlarmXCore_0.Enable := TRUE;
    ConfigurationInit;
        
    MpAxisBasic_0.Enable := TRUE;

    AxisInit;
END_PROGRAM

PROGRAM _CYCLIC

    MpAxisBasic_0.MpLink := ADR(gAxisCrossCutter);
    MC_BR_CheckRestorePositionData_0.Axis := ADR(gAxisCrossCutter);
    
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
    MpAlarmXCore_0.MpLink := ADR(gAlarmXCore_Cutter);
    MpAlarmXCore_0();
   
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
    
    MpAxisBasic_0.Enable := FALSE;
    MpAxisBasic_0();

    MC_BR_CamAutomatCommandFB.Enable := FALSE;
    MC_BR_CamAutomatCommandFB();
    
    MpAlarmXCore_0.Enable := FALSE;
    MpAlarmXCore_0();

END_PROGRAM
