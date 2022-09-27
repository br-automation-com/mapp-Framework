//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Dec 1, 2022
// Description: Tasks for generating reports. 
//***********************************************************************

PROGRAM _INIT	
	TimeIndex := 0;
	FOR i:=0 TO NUM_TEMP_SAMPLES-1 DO
		ReportExample.SimpleReport.Line_OEE[0].TempSamples.TimeStamp[i] := TimeIndex;
		ReportExample.SimpleReport.Line_OEE[1].TempSamples.TimeStamp[i] := TimeIndex;
		ReportExample.SimpleReport.Line_OEE[2].TempSamples.TimeStamp[i] := TimeIndex;
		TimeIndex := TimeIndex + 15;
	END_FOR
	ReportExample.Format_21CFR1.BatchNumber := 325454685;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	MpReportCore_0.MpLink     := ADR(gSimpleReport);
	MpReportCore_0.Enable     := TRUE;
	MpReportCore_0.Name       := ADR('SimpleReport');
	MpReportCore_0.Language   := ADR('en');
	MpReportCore_0.DeviceName := ADR('mappReportFiles');
	MpReportCore_0();
	
	MpReportCore_1.MpLink     := ADR(gReport_21CFR1);
	MpReportCore_1.Enable     := TRUE;
	MpReportCore_1.Name       := ADR('Report_21CFR1');
	MpReportCore_1.Language   := ADR('en');
	MpReportCore_1.DeviceName := ADR('mappReportFiles');
	MpReportCore_1();
	
END_PROGRAM

PROGRAM _EXIT
	
	
	 
END_PROGRAM

