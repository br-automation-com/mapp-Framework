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

	// Call initialization variables
	RestorePosition_AppAxis_1;

	// Initialize homing mode
	MpAxisParameters.Homing.Mode := mcHOMING_DEFAULT;

	// Enable mapp function blocks
	MpAxisBasicAppAxis.Enable := TRUE;
	MpAlarmXCoreAxis.Enable := TRUE;

END_PROGRAM

PROGRAM _CYCLIC

	MpAxisBasicAppAxis.MpLink := ADR(gMpLinkAppAxis_1);

	// Call all actions
	SimulationControl;
	AxisStateMachine;
	AxisCyclic;
	RecipeCyclic;

	// Assign MpLink
	MpAlarmXCoreAxis.MpLink := ADR(gMpLinkAlarmXCoreAppAxis_1);

	// Call function block
	MpAlarmXCoreAxis();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks.
	// Do NOT disable MpAxisBasic, as this can cause problems during project transfer.
	MpRecipeRegParPar.Enable := FALSE;
	MpRecipeRegParCfg.Enable := FALSE;
	MpAlarmXCoreAxis.Enable := FALSE;

	// Call function blocks
	MpRecipeRegParPar();
	MpRecipeRegParCfg();
	MpAlarmXCoreAxis();

END_PROGRAM
