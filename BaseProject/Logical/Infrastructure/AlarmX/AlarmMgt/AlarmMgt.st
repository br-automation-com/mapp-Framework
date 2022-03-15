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

	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0.MpLink := ADR(gAlarmXMpLink);
	MpAlarmXCore_0();

	MpAlarmXHistory_0.Enable := TRUE;
	MpAlarmXHistory_0.DeviceName := ADR('mappAlarmX');
	MpAlarmXHistory_0.MpLink := ADR(gAlarmXHistoryMpLink);
	MpAlarmXHistory_0();
    
	MpAlarmXListUI_0.Enable := TRUE;
	MpAlarmXListUI_0.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXListUI_0.UISetup.AlarmListSize := 50;
	MpAlarmXListUI_0.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';
	
	MpAlarmXHistoryUI_0.Enable := TRUE;
	MpAlarmXHistoryUI_0.UISetup.AlarmListScrollWindow := 10;
	MpAlarmXHistoryUI_0.UISetup.AlarmListSize := (SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID)/SIZEOF(MpAlarmXListUIConnect.AlarmList.InstanceID[0]));
	MpAlarmXHistoryUI_0.UISetup.TimeStampPattern := '%Y %m %d %H:%M:%S';

END_PROGRAM

PROGRAM _CYCLIC
    
	IF EDGEPOS(SafetyInputs.AcknowledgeAlarms) THEN
        MpAlarmXListUIConnect.AcknowledgeAll := TRUE;
	END_IF
	
	IF (hmiAlarmX.Commands.ExportAlarms = TRUE) THEN
		MpAlarmXHistory_0.Export := TRUE;
	END_IF

	// Call all actions 
    AlarmHandling;
	GetBacktraceInformation;
    ExecuteQuery;
	AlarmSamples;
	QueryTableConfig;
    
    // Check if any reactions are active 
    IF MpAlarmXCheckReaction(gAlarmXMpLink, 'Error') THEN
        // Error is active. Add code here to respond to error situation.
    ELSIF MpAlarmXCheckReaction(gAlarmXMpLink, 'Warning') THEN
        // Warning is active. Add code here to respond to warning situation.
	ELSIF MpAlarmXCheckReaction(gAlarmXMpLink, 'Info') THEN
        // Info is active. Add code here to resond to info situation.
	END_IF

	// Call function blocks 
	MpAlarmXCore_0.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXCore_0();
    MpAlarmXListUI_0.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXListUI_0.UIConnect := ADR(MpAlarmXListUIConnect);
    MpAlarmXListUI_0();
    MpAlarmXHistory_0.MpLink := ADR(gAlarmXHistoryMpLink);
	MpAlarmXHistory_0();
	MpAlarmXHistoryUI_0.MpLink := ADR(gAlarmXHistoryMpLink);
    MpAlarmXHistoryUI_0.UIConnect := ADR(MpAlarmXHistoryUIConnect);
	MpAlarmXHistoryUI_0();
	
	IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
		hmiAlarmX.Commands.ExportAlarms := FALSE;
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
    
END_PROGRAM

PROGRAM _EXIT
	// Reset function blocks to unlink mapp links 
    MpAlarmXCore_0.Enable := FALSE;
    MpAlarmXListUI_0.Enable := FALSE;
    MpAlarmXHistory_0.Enable := FALSE;
	MpAlarmXHistoryUI_0.Enable := FALSE;
	QueryActiveAlarms.Enable := FALSE;
    MpAlarmXCore_0();
    MpAlarmXListUI_0();
    MpAlarmXHistory_0();
    MpAlarmXHistoryUI_0();
    QueryActiveAlarms();
    
END_PROGRAM