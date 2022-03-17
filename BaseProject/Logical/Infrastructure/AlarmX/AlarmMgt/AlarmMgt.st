//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Jan 1, 2022
// Description: Tasks for alarm control. The Alarm Management handling is
// done in this task.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF

	// Initialize mapp function blocks
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXCore_0();

	MpAlarmXHistory_0.Enable := TRUE;
	MpAlarmXHistory_0.DeviceName := ADR('mappAlarmX');
	MpAlarmXHistory_0.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistory_0();
    
	MpAlarmXListUI_0.Enable := TRUE;
	MpAlarmXListUI_0.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXListUI_0.UISetup.AlarmListSize := 50;
	MpAlarmXListUI_0.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';
	MpAlarmXListUI_0();
	
	MpAlarmXHistoryUI_0.Enable := TRUE;
	MpAlarmXHistoryUI_0.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXHistoryUI_0.UISetup.AlarmListSize := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID)/SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0]));
	MpAlarmXHistoryUI_0.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';
	MpAlarmXHistoryUI_0();
	
END_PROGRAM

PROGRAM _CYCLIC
    
	IF EDGEPOS(SafetyInputs.AcknowledgeAlarms) THEN
        MpAlarmXListUIConnect.AcknowledgeAll := TRUE;
	END_IF
	
	IF (HmiAlarmX.Commands.ExportAlarms = TRUE) THEN
		MpAlarmXHistory_0.Export := TRUE;
	END_IF

	// Call all actions
    AlarmHandling;// PROBLEM RIGHT NOW. SHOULD MOVE THIS TO INIT, IF WE REMOVE THE FUB EXAMPLE
	GetBacktraceInformation;
    ExecuteQuery;
	QueryTableConfig;
	AlarmSamples;
    
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
	
	IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
		HmiAlarmX.Commands.ExportAlarms := FALSE;
		MpAlarmXHistory_0.Export := FALSE;
	END_IF

    // Error reset
    IF NOT MpAlarmXCore_0.Error THEN
        MpAlarmXCore_0.ErrorReset := FALSE;
    END_IF
    IF NOT MpAlarmXListUI_0.Error THEN
        MpAlarmXListUI_0.ErrorReset := FALSE;
    END_IF
    IF NOT MpAlarmXHistory_0.Error THEN
        MpAlarmXHistory_0.ErrorReset := FALSE;
    END_IF
    IF NOT MpAlarmXHistoryUI_0.Error THEN
        MpAlarmXHistoryUI_0.ErrorReset := FALSE;
    END_IF
    
	// Assign MpLinks & UIConnects
	MpAlarmXCore_0.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXListUI_0.MpLink := ADR(gMpLinkAlarmXCore);
	MpAlarmXListUI_0.UIConnect := ADR(MpAlarmXListUIConnect);
	MpAlarmXHistory_0.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryUI_0.MpLink := ADR(gMpLinkAlarmXHistory);
	MpAlarmXHistoryUI_0.UIConnect := ADR(MpAlarmXHistoryUIConnect);
	
	// Call function blocks
	MpAlarmXCore_0();
	MpAlarmXListUI_0();
	MpAlarmXHistory_0();
	MpAlarmXHistoryUI_0();
	
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the function blocls to unlink the MpLinks
    MpAlarmXCore_0.Enable := FALSE;
    MpAlarmXListUI_0.Enable := FALSE;
    MpAlarmXHistory_0.Enable := FALSE;
	MpAlarmXHistoryUI_0.Enable := FALSE;
	QueryActiveAlarms.Enable := FALSE;
	
	// Call function blocks
    MpAlarmXCore_0();
    MpAlarmXListUI_0();
    MpAlarmXHistory_0();
    MpAlarmXHistoryUI_0();
    QueryActiveAlarms();
    
END_PROGRAM