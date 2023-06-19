//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Dec 1, 2022
// Description: Task for generating reports with VC4 front-end.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappReportFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF
	
	// Parameterize the report function block with the simple report
	MpReportCore_0.Language := ADR('en');
	MpReportCore_0.DeviceName := ADR('mappReportFiles');
	MpReportCore_0.MpLink := ADR(gMpLinkSimpleReport);
	MpReportCore_0.Name := ADR(HmiReport.Parameters.Name);
	HmiReport.Parameters.Name := 'SimpleReport';
	MpReportCore_0();

	// Parameterize the file mangement function block
	MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIReport);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0();

	// Fill an array to create example data for the example report
	TimeIndex := 0;
	FOR i:=0 TO ((SIZEOF(ReportExample.SimpleReport.OeeLine[0].TemperatureSample.TimeStamp)/SIZEOF(ReportExample.SimpleReport.OeeLine[0].TemperatureSample.TimeStamp[0])) - 1) DO
		ReportExample.SimpleReport.OeeLine[0].TemperatureSample.TimeStamp[i] := TimeIndex;
		ReportExample.SimpleReport.OeeLine[1].TemperatureSample.TimeStamp[i] := TimeIndex;
		ReportExample.SimpleReport.OeeLine[2].TemperatureSample.TimeStamp[i] := TimeIndex;
		ReportExample.AdvancedReport.OeeLine[0].TemperatureSample.TimeStamp[i] := TimeIndex;
		ReportExample.AdvancedReport.OeeLine[1].TemperatureSample.TimeStamp[i] := TimeIndex;
		ReportExample.AdvancedReport.OeeLine[2].TemperatureSample.TimeStamp[i] := TimeIndex;
		TimeIndex := TimeIndex + 15;
	END_FOR

	// Ficticious number to serve as an example in the report
	ReportExample.AdvancedReport.BatchNumber := 325454685;

END_PROGRAM

PROGRAM _CYCLIC

	// Once a report has been generated, clear the generate command
	IF MpReportCore_0.CommandDone THEN
		MpFileManagerUIConnect.File.Refresh := TRUE;
		HmiReport.Commands.Generate := FALSE;
	END_IF

	// Call all cyclic actions
	ReportFormat;
	ReportFileExplorer;
	
	// Generate command
	MpReportCore_0.Generate := HmiReport.Commands.Generate;
	MpReportCore_0.Name := ADR(HmiReport.Parameters.Name);

	// Call function blocks
	MpReportCore_0();
	MpFileManagerUI_0();

END_PROGRAM

PROGRAM _EXIT

	MpReportCore_0.Enable := FALSE;
	MpFileManagerUI_0.Enable := FALSE;
	MpReportCore_0();
	MpFileManagerUI_0();

END_PROGRAM

