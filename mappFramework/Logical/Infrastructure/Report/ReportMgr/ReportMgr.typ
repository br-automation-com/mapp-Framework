(*Structure types*)

TYPE
	ReportHmiInterfaceType : 	STRUCT 
		Commands : ReportCommandsType;
		Status : ReportStatusType;
	END_STRUCT;
	ReportCommandsType : 	STRUCT 
		Generate : BOOL;
	END_STRUCT;
	ReportStatusType : 	STRUCT 
		PlaceHolder : BOOL;
	END_STRUCT;
END_TYPE

(*Enumerations*)
(*Structure for example information in the reports*)

TYPE
	ReportExampleType : 	STRUCT 
		SimpleReport : ExampleDataType;
		Format_21CFR1 : ExampleDataType;
	END_STRUCT;
	ExampleDataType : 	STRUCT 
		Line_OEE : ARRAY[0..2]OF OEE_Type := [(RunTime:=T#24h00m00s00ms,UpTime:=T#23h13m34s98ms,DownTime:=T#00h47m25s02ms,PartsMade:=67268,PPM:=46.7138,NumRejects:=1256,TempSamples:=(Temp:=[99,97,103,101,100,102,95,2(105),100,102,101,96,105,3(20),97,100,96,99,105,101,97,2(103),98,100,99,104,100,105,104,99,104,103,104,102,100,101,102,96,105,99,97,100,103,105,102,101,97,105,95,101,2(103),2(101),100,101,99,105,101,102,96,95,100,98,103,105,99,104,96,97,96,101,103,100,103,95,102,97,105,103,99,96,98,105,95,103,100,103,100,2(105),101])),(RunTime:=T#24h00m00s00ms,UpTime:=T#23h54m09s00ms,DownTime:=T#00h05m51s00ms,PartsMade:=75061,PPM:=52.1256,NumRejects:=805,TempSamples:=(Temp:=[98,104,103,97,98,95,101,97,104,96,100,101,103,105,95,103,96,96,98,104,97,102,100,96,96,102,101,95,104,99,104,96,99,104,96,101,105,98,101,99,105,100,97,101,101,96,101,100,100,99,96,101,100,105,97,100,101,99,97,99,104,105,102,97,105,104,98,102,103,102,98,105,103,100,99,104,101,99,105,100,105,102,99,95,95,103,96,97,95,100,99,96,102,105,95,96,95(0.0)])),(RunTime:=T#24h00m00s00ms,UpTime:=T#15h57m16s13ms,DownTime:=T#08h02m43s87ms,PartsMade:=40235,PPM:=27.9409,NumRejects:=742,TempSamples:=(Temp:=[2(97),100,105,104,101,105,97,103,16(20),96,103,100,101,99,102,95,99,102,99,103,95,102,99,96,2(102),103,2(99),102,3(97),101,105,103,2(101),104,101,104,105,97,100,2(99),100,103,101,103,95,103,96,100,99,20(20),99,96,95,96,98]))];
		BatchNumber : UDINT := 23561458;
	END_STRUCT;
	OEE_Type : 	STRUCT 
		RunTime : TIME;
		UpTime : TIME;
		DownTime : TIME;
		PartsMade : UDINT;
		PPM : REAL;
		NumRejects : UDINT;
		TempSamples : TempSampleType;
	END_STRUCT;
	TempSampleType : 	STRUCT 
		TimeStamp : ARRAY[0..95]OF INT;
		Temp : ARRAY[0..95]OF REAL;
	END_STRUCT;
END_TYPE
