	(*********************************************************************************
	* Copyright: B&R Industrial Automation GmbH 
	* Author:    B&R Industrial Automation GmbH 
	* Created:   30. Sep 2020/08:00 
	* Description: Tasks for alarm control. The Alarm Management handling is done in this task.
	*********************************************************************************)
PROGRAM _INIT
	(* Init function blocks *)
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

    AlarmSamples;
	
	AlarmFilterCfg;
	AlarmSortCfg;
	AlarmHistFilterCfg;
	AlarmHistSortCfg;

END_PROGRAM

PROGRAM _CYCLIC
    
	(* Acknowledge Button *)
    IF EDGEPOS(SafetyInputs.AcknowledgeAlarms) THEN
        MpAlarmXListUIConnect.AcknowledgeAll := TRUE;
	END_IF

    GetBacktraceInformation;
    ExecuteQuery;
    AlarmHandling;
    AlarmSamples;
    
    (* Check if any reactions are active *)
    IF MpAlarmXCheckReaction(gAlarmXMpLink, 'Error') THEN
        (* Error is active *)
    ELSIF MpAlarmXCheckReaction(gAlarmXMpLink, 'Warning') THEN
        (* Warning is active *)
        
    ELSIF MpAlarmXCheckReaction(gAlarmXMpLink, 'Info') THEN
        (* Info is active *)
    
    END_IF
    
    (* Function block calls *)
    MpAlarmXCore_0.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXCore_0();
    MpAlarmXListUI_0.MpLink := ADR(gAlarmXMpLink);
    MpAlarmXListUI_0.UIConnect := ADR(MpAlarmXListUIConnect);
    MpAlarmXListUI_0();
    MpAlarmXHistory_0.MpLink := ADR(gAlarmXHistoryMpLink);
    IF (ExportAlarms = TRUE) THEN
        ExportAlarms := FALSE;
        MpAlarmXHistory_0.Export := TRUE;
    END_IF

    MpAlarmXHistory_0();
    IF ((MpAlarmXHistory_0.Export = TRUE) AND (MpAlarmXHistory_0.CommandDone = TRUE)) THEN
        MpAlarmXHistory_0.Export := FALSE;
    END_IF
    
    MpAlarmXHistoryUI_0.MpLink := ADR(gAlarmXHistoryMpLink);
    MpAlarmXHistoryUI_0.UIConnect := ADR(MpAlarmXHistoryUIConnect);
    MpAlarmXHistoryUI_0();

    (* Error reset *)
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
	(* Reset function blocks to unlink mapp links *)
    MpAlarmXCore_0.Enable := FALSE;
    MpAlarmXListUI_0.Enable := FALSE;
    MpAlarmXHistory_0.Enable := FALSE;
    MpAlarmXHistoryUI_0.Enable := FALSE;
    MpAlarmXCore_0();
    MpAlarmXListUI_0();
    MpAlarmXHistory_0();
    MpAlarmXHistoryUI_0();
    
    MpAlarmXQueryActiveAlarmsFB.Enable := FALSE;
    MpAlarmXQueryActiveAlarmsFB();
    
END_PROGRAM