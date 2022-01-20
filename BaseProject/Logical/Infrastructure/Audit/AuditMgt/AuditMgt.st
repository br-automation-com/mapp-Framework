(*********************************************************************************
* Copyright: B&R Industrial Automation GmbH 
* Author:    B&R Industrial Automation GmbH 
* Created:   30. Dec 2020/08:00 
* Description: Tasks FOR Audit Management.  The Audit Management is done in this task.
*********************************************************************************)

PROGRAM _INIT

	(*Create folder for this component on the user file device*)
	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));		
	
	(*Check if folder already exist and if so disabled the function block call*)
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF	

	(* Init function blocks *)
	MpAuditTrail_0.MpLink			:= ADR(gAuditTrailMpLink);
	MpAuditTrail_0.Enable			:= TRUE;
	MpAuditTrail_0.DeviceName		:= ADR('mappAudit');

	MpFileManagerUI_0.Enable		:= TRUE;
	MpFileManagerUI_0.MpLink		:= ADR(gAuditFileMgrUIMpLink);
	MpFileManagerUI_0.UIConnect		:= ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize	:= 50;

	(* Filter files for pdf type *)
	MpFileManagerUIConnect.File.Filter		:= '*.pdf';
END_PROGRAM

PROGRAM _CYCLIC
	(* Reset export command *)
	IF MpAuditTrail_0.CommandDone THEN
		MpAuditTrail_0.Export		:= FALSE;
		MpFileManagerUIConnect.File.Refresh	:= TRUE;
	END_IF

	(* Reset error reset *)
	IF NOT MpAuditTrail_0.Error THEN
	  MpAuditTrail_0.ErrorReset		:= FALSE;
	END_IF;

//	IF TEST THEN
//		MpAuditCustomEvent(gMpLinkAuditTrail,"mpAUDIT_TEXT_SOURCE_NONE","test","audit");
//	END_IF
	
	FOR i := 0 TO 49 DO							// Save Filenames to a seperate array for display in Table
		sDisplayFileName[i]                                      := MpFileManagerUIConnect.File.List.Items[i].Name;
		IF uDisplayFileNameIndex = INT_TO_USINT(i) THEN		// if selected set a index for display selected file in table
			MpFileManagerUIConnect.File.List.Items[i].IsSelected	:= TRUE;	
		END_IF
	END_FOR
	sStrSelectedFile				:= CONCAT(STR_FILE_DEVICE, MpFileManagerUIConnect.File.List.Items[uDisplayFileNameIndex].Name);		// String for pdfViewer to display right report

	(* Configure visible file list *)
	brsstrcpy(ADR(sTableConfig), ADR('{ "specRows": [{"from":'));
	brsitoa(MpFileManagerUIConnect.File.PathInfo.FileCount, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
	brsstrcat(ADR(sTableConfig),  ADR(',"to":49, "visible":false}]}'));
   
	(* Call function blocks *)
	MpAuditTrail_0();
	MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

