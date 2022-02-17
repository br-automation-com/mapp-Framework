//******************************************************************************************************************** 
// Copyright: B&R Industrial Automation GmbH
// Description: This PROGRAM implements an axis control
//********************************************************************************************************************

PROGRAM _INIT
    
    ST_name(0, ADR(AxisControl.Status.TaskName), 0);
    
    MpAlarmXCoreFB.Enable := TRUE;
    ConfigurationInit;

    MpAxisBasicFB.Enable := TRUE;
    MpAxisBasicFB.MpLink := ADR(gAxisTemplate);
    
    AxisInit;

END_PROGRAM

PROGRAM _CYCLIC
    
    MpAxisBasicFB.MpLink := ADR(gAxisTemplate);
    MC_BR_CheckRestorePositionDataFB.Axis := ADR(gAxisTemplate);
    
    SimulationControl;
    AxisStateMachine;
    AxisCyclic;
    RecipeCyclic;
    
    MpAlarmXCoreFB.MpLink := ADR(gAlarmXCore_AxisTemplate);
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
