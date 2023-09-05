//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Tasks for alarm management with VC4 front-end.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreateAlarm(enable := TRUE, pDevice := ADR('mappAlarmXFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreateAlarm.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreateAlarm(enable := FALSE);
	END_IF
	
	 // Initial visibility setup
	VC4_Init;
	
	// Call action to intialize alarm samples
	AlarmSampleInit;

	// Initialize mapp function blocks
	MpAlarmXCoreMain.Enable := TRUE;
	MpAlarmXCoreMain.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXCoreMain();

	MpAlarmXHistoryMain.Enable := TRUE;
	MpAlarmXHistoryMain.DeviceName := ADR('mappAlarmXFiles');
	MpAlarmXHistoryMain.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryMain();

	MpAlarmXListUIMain.Enable := TRUE;
	MpAlarmXListUIMain.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXListUIMain.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXListUIMain.UISetup.AlarmListSize := 50;
	MpAlarmXListUIMain.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';
	MpAlarmXListUIMain();

	MpAlarmXHistoryUIMain.Enable := TRUE;
	MpAlarmXHistoryUIMain.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryUIMain.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXHistoryUIMain.UISetup.AlarmListSize := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID) / SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0]));
	MpAlarmXHistoryUIMain.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';
	MpAlarmXHistoryUIMain();

END_PROGRAM

PROGRAM _CYCLIC

	IF EDGEPOS(SafetyInputs.AcknowledgeAlarms) THEN
		MpAlarmXListUIConnect.AcknowledgeAll := TRUE;
	END_IF

	IF (HmiAlarmX.Commands.ExportAlarms) THEN
		MpAlarmXHistoryMain.Export := TRUE;
	END_IF

	// Call all cyclic actions
	AlarmHandling;
	ExecuteQuery;
	AlarmSampleFub;
	VC4_Cyclic;


	// Check if any reactions are active.
	// Typically the MpAlarmXCheckReaction() function is called from other tasks within the application.
	// For example, the axis control task might check for the 'Error' reaction to determine whether to send a stop command to the axes.
	// Therefore, copy/paste these IF statements to other places in the application as needed.
	IF MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Error') THEN
		// Error is active. Add code here to respond to error situation.
	ELSIF MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Warning') THEN
		// Warning is active. Add code here to respond to warning situation.
	ELSIF MpAlarmXCheckReaction(gMpLinkAlarmXCore, 'Info') THEN
		// Info is active. Add code here to resond to info situation.
	END_IF

	IF ((MpAlarmXHistoryMain.Export) AND (MpAlarmXHistoryMain.CommandDone)) THEN
		HmiAlarmX.Commands.ExportAlarms := FALSE;
		MpAlarmXHistoryMain.Export := FALSE;
	END_IF

	// Error reset
	IF NOT MpAlarmXCoreMain.Error THEN
		MpAlarmXCoreMain.ErrorReset := FALSE;
	END_IF
	IF NOT MpAlarmXListUIMain.Error THEN
		MpAlarmXListUIMain.ErrorReset := FALSE;
	END_IF
	IF NOT MpAlarmXHistoryMain.Error THEN
		MpAlarmXHistoryMain.ErrorReset := FALSE;
	END_IF
	IF NOT MpAlarmXHistoryUIMain.Error THEN
		MpAlarmXHistoryUIMain.ErrorReset := FALSE;
	END_IF

	// Assign MpLinks & address references
	MpAlarmXCoreMain.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXListUIMain.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXListUIMain.UIConnect := ADR(MpAlarmXListUIConnect);
	MpAlarmXHistoryMain.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryMain.DeviceName := ADR('mappAlarmXFiles');
	MpAlarmXHistoryUIMain.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryUIMain.UIConnect := ADR(MpAlarmXHistoryUIConnect);

	// Call function blocks
	MpAlarmXCoreMain();
	MpAlarmXListUIMain();
	MpAlarmXHistoryMain();
	MpAlarmXHistoryUIMain();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
	MpAlarmXCoreMain.Enable := FALSE;
	MpAlarmXListUIMain.Enable := FALSE;
	MpAlarmXHistoryMain.Enable := FALSE;
	MpAlarmXHistoryUIMain.Enable := FALSE;
	QueryActiveAlarms.Enable := FALSE;

	// Call function blocks
	MpAlarmXCoreMain();
	MpAlarmXListUIMain();
	MpAlarmXHistoryMain();
	MpAlarmXHistoryUIMain();
	QueryActiveAlarms();

END_PROGRAM