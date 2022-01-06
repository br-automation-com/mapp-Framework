	(*********************************************************************************
	* Copyright: B&R Industrial Automation GmbH 
	* Author:    B&R Industrial Automation GmbH 
	* Created:   30. Sep 2020/08:00 
	* Description: Tasks for axis control. The Main Cross Cutter handling is done in this task.
	*********************************************************************************)

PROGRAM _INIT
	(* Register parameters to MpRecipe *)
	MpRecipeRegPar_M.MpLink						:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_M.Enable						:= TRUE;
	MpRecipeRegPar_M.Category					:= ADR('Machine');
	MpRecipeRegPar_M.PVName						:= ADR('MainCtrl:MainCtrl.FixPar');
	MpRecipeRegPar_P.MpLink						:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_P.Enable						:= TRUE;
	MpRecipeRegPar_P.Category					:= ADR('Product');
	MpRecipeRegPar_P.PVName						:= ADR('MainCtrl:MainCtrl.Para');
	MpRecipeRegPar_Pre1.MpLink					:= ADR(gRecipeXmlPreviewMpLink);
	MpRecipeRegPar_Pre1.Enable					:= TRUE;
	MpRecipeRegPar_Pre1.Category				:= ADR('Preview');
	MpRecipeRegPar_Pre1.PVName					:= ADR('MainCtrl:PreviewParameters');
	MpRecipeRegPar_Pre2.MpLink					:= ADR(gRecipeXmlMpLink);
	MpRecipeRegPar_Pre2.Enable					:= TRUE;
	MpRecipeRegPar_Pre2.Category				:= ADR('Product');
	MpRecipeRegPar_Pre2.PVName					:= ADR('MainCtrl:PreviewParameters');
	
	(* Activate RegPar FUBs *)
	WHILE NOT MpRecipeRegPar_M.Active DO
		MpRecipeRegPar_M();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_P.Active DO
		MpRecipeRegPar_P();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_Pre1.Active DO
		MpRecipeRegPar_Pre1();
	END_WHILE;
	WHILE NOT MpRecipeRegPar_Pre2.Active DO
		MpRecipeRegPar_Pre2();
	END_WHILE;
	
    // Init Cam automat related function blocks ***************************************
	InitCamAutFunctionBlocks;

	// Axis No.0 initialization *********************************************************************************
	MpAxisBasic_x[0].MpLink						:= ADR(gAxisMaster);
	MpAxisBasic_x[0].Enable						:= TRUE;
	MpAxisBasic_x[0].Parameters					:= ADR(AxisControl[0].Parameter.AxPar);
	MC_ReadAxisError_x[0].Axis					:= ADR(gAxisMaster);
	MC_ReadActualTorque_x[0].Axis				:= ADR(gAxisMaster);
	
	// Axis No.1 initialization *********************************************************************************
	MpAxisBasic_x[1].MpLink						:= ADR(gAxisSlave);
	MpAxisBasic_x[1].Enable						:= TRUE;
	MpAxisBasic_x[1].Parameters					:= ADR(AxisControl[1].Parameter.AxPar);
	MC_ReadAxisError_x[1].Axis					:= ADR(gAxisSlave);
	MC_ReadActualTorque_x[1].Axis				:= ADR(gAxisSlave);
END_PROGRAM

PROGRAM _CYCLIC
	
	(********************* Init cam automat parameters *********************)
	GetCamAutPar;

	(********************* Axis status updates *********************)
	(********************* Status information is read before the state machine to attain a shorter reaction time in case of error *********************)
	AxisStatusUpdate;

	(********************* Axis control *********************)
	AxisStateMachine;

	(********************* Crosscutter control *********************)
	CrossCutter;
	
	//*************************************************	

	(********************* Copy preview parameters before creating or saving a recipe *********************)
	IF bCopyPreviewParameters THEN
		PreviewParameters				:= MainCtrl.Para;
		bCopyPreviewParameters			:= FALSE;
	END_IF;
	IF bResetEditValues THEN
		MainCtrl.Para					:= PreviewParameters;
		bResetEditValues				:= FALSE;
	END_IF;

	(********************* MpAxisBasic function block calls *********************)
	FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
		MpAxisBasic_x[uAxIndex]();
	END_FOR;

	(********************* CamAutomat function block calls *********************)
	MC_BR_CamAutomatSetPar_AcpAx_0();
	MC_BR_CamAutomatGetPar_AcpAx_0();
	MC_BR_CamAutomatCommand_0();

	(********************* MpRecipeRegPar FB calls *********************)
	MpRecipeRegPar_M();
	MpRecipeRegPar_P();
	MpRecipeRegPar_Pre1();
	MpRecipeRegPar_Pre2();
END_PROGRAM

PROGRAM _EXIT
	MpRecipeRegPar_M.Enable				:= FALSE;
	MpRecipeRegPar_M();
	MpRecipeRegPar_P.Enable				:= FALSE;
	MpRecipeRegPar_P();
	MpRecipeRegPar_Pre1.Enable			:= FALSE;
	MpRecipeRegPar_Pre1();
	MpRecipeRegPar_Pre2.Enable			:= FALSE;
	MpRecipeRegPar_Pre2();
	FOR uAxIndex := 0 TO MAX_IDX_AXIS DO
		MpAxisBasic_x[uAxIndex].Enable	:= FALSE;
		MpAxisBasic_x[uAxIndex]();
	END_FOR;
END_PROGRAM