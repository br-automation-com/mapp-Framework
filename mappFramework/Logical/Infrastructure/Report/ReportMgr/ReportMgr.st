//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Dec 1, 2022
// Description: Task for generating reports.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreateReport(enable := TRUE, pDevice := ADR('mappReportFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreateReport.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreateReport(enable := FALSE);
	END_IF
	
	// Initialize mapp function blocks
	MpReportCoreSys.Language := ADR('en');
	MpReportCoreSys.DeviceName := ADR('mappReportFiles');
	MpReportCoreSys.MpLink := ADR(gMpLinkSimpleReport);
	MpReportCoreSys.Name := ADR(HmiReport.Parameters.Name);
	HmiReport.Parameters.Name := 'SimpleReport';
	HmiReport.Parameters.SortType := 'NameAsc';
	MpReportCoreSys();

	MpFileManagerUIReport.MpLink := ADR(gMpLinkFileManagerUIReport);
	MpFileManagerUIReport.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUIReport.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUIReport.Enable := TRUE;
	MpFileManagerUIReport();
	
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappReportFiles';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[7] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[8] := '';
	MpFileManagerUIConnect.DeviceList.DeviceNames[9] := '';

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
	IF MpReportCoreSys.CommandDone THEN
		MpFileManagerUIConnect.File.Refresh := TRUE;
		HmiReport.Commands.Generate := FALSE;
	END_IF

	// Call all cyclic actions
	ReportFormat;
	ReportFileExplorer;
	
	// Generate command
	MpReportCoreSys.Generate := HmiReport.Commands.Generate;
	MpReportCoreSys.Name := ADR(HmiReport.Parameters.Name);
	
	// Assign address references
	MpFileManagerUIReport.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUIReport.MpLink := ADR(gMpLinkFileManagerUIReport);
	MpFileManagerUIReport.UIConnect := ADR(MpFileManagerUIConnect);

	// Call function blocks
	MpReportCoreSys();
	MpFileManagerUIReport();

END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocks to unlink the MpLinks
	MpReportCoreSys.Enable := FALSE;
	MpFileManagerUIReport.Enable := FALSE;
	
	// Call function blocks
	MpReportCoreSys();
	MpFileManagerUIReport();

END_PROGRAM

