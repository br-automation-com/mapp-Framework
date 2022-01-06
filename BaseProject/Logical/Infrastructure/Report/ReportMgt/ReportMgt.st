	(*********************************************************************************
	* Copyright: B&R Industrial Automation GmbH 
	* Author:    B&R Industrial Automation GmbH 
	* Created:   30. Sep 2020/08:00 
	* Description: Tasks FOR report control. The Report Control handling is done in this task.
	*********************************************************************************)

PROGRAM _INIT
	(* Init mapp function blocks *)
	MpReportCore_0.Enable		:= TRUE;
	MpReportCore_0.MpLink		:= ADR(gReportMpLink);
	MpReportCore_0.Name			:= ADR(REPORT_NAME);
	MpReportCore_0.DeviceName	:= ADR(REPORT_DEVICE);
	MpFileManagerUI_0.MpLink	:= ADR(gRprtFileMgrUIMpLink);
	MpFileManagerUI_0.UIConnect	:= ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.Enable	:= TRUE;
	(* Filter for pdf files *)
	MpFileManagerUIConnect.File.Filter	:= '*.pdf';
END_PROGRAM

PROGRAM _CYCLIC
	(* Configure visible file list *)
	brsstrcpy(ADR(sTableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpFileManagerUIConnect.File.PathInfo.FileCount, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
	brsstrcat(ADR(sTableConfig),  ADR(',"to":49, "visible":false}]}'));
	
	// Refresh report action
	RefreshReport;

	(* Reset ErrorReset command *)
	IF NOT MpReportCore_0.Error THEN
		MpReportCore_0.ErrorReset	:= FALSE;
	END_IF;
	
	(* Function block calls *)
	MpReportCore_0();
	MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	(* Disable and call mapp function blocks *)
	MpReportCore_0.Enable			:= FALSE;
	MpFileManagerUI_0.Enable		:= FALSE;
	MpReportCore_0();
	MpFileManagerUI_0();
END_PROGRAM