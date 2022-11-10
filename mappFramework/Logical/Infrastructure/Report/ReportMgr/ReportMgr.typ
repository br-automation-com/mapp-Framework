(*Structure types*)

TYPE
	ReportHmiInterfaceType : 	STRUCT 
		Commands : ReportCommandsType; (*Structure to hold the commands from the HMI*)
		Parameters : ReportParametersType; (*Structure to hold the parameters from the HMI*)
		Status : ReportStatusType; (*Structure to hold the status information from the HMI*)
	END_STRUCT;
	ReportCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		Generate : BOOL; (*Generate a report*)
		Reset : BOOL; (*Reset the report function block*)
	END_STRUCT;
	ReportParametersType : 	STRUCT  (*Structure to hold the parameters from the HMI*)
		Name : STRING[50]; (*Name of the report*)
		FormatTo21CFR1 : BOOL; (*Whether or not the report should be in the 21CFR1 format*)
		PathOfReportToView : STRING[255]; (*The file path of the selected report*)
		SelectedLanguage : STRING[10] := 'en';
	END_STRUCT;
	ReportStatusType : 	STRUCT  (*Structure to hold the status information from the HMI*)
		ViewAllowed : BOOL; (*Bit to indicate it is allowable to view a report right now*)
		DeleteAllowed : BOOL; (*Bit to indicate it is allowable to delete a report right now*)
		CreateAllowed : BOOL; (*Bit to indicate it is allowable to create a report right now*)
		Busy : BOOL; (*Report is busy executing an action*)
		Error : BOOL; (*Error flag*)
		FileOverMax : BOOL; (*Active when more than 50 items detected*)
		FileNames : ARRAY[0..49]OF STRING[50]; (*Existing report file names*)
		TempFilePath : ARRAY[0..49]OF STRING[255]; (*A temporary variable used to concatonate and build the full file path of the selected file*)
		FilePath : ARRAY[0..49]OF STRING[255]; (*The full file path of the selcted file*)
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME; (*Time stamps for existing reports*)
		Size : {REDUND_UNREPLICABLE} ARRAY[0..49]OF UDINT; (*Sizes of existing report files*)
		SelectedIndex : USINT; (*Index of the selected file*)
		LastSelectedIndex : USINT := 255; (*Index of the last selected report file*)
		LastSelectedDeviceIndex : UINT; (*Index of the last selected file device. Compared with MpFileManagerUIConnect.DeviceList.SelectedIndex*)
		TableConfig : ARRAY[0..1]OF STRING[120]; (*Table configuration for the list of available reports*)
		FilterString : STRING[1000]; (*String used to filter out any file that is not a PDF*)
	END_STRUCT;
	ReportExampleType : 	STRUCT  (*Structure for the example data used by the two types of reports*)
		SimpleReport : ExampleDataType; (*Structure for the simple report's example data*)
		Format_21CFR1 : ExampleDataType; (*Structure for the 21CFR1 formatted report's example data*)
	END_STRUCT;
	ExampleDataType : 	STRUCT  (*Structure to hold a report's example data*)
		Line_OEE : ARRAY[0..2]OF OEEType := [(RunTime:=T#24h00m00s00ms,UpTime:=T#23h13m34s98ms,DownTime:=T#00h47m25s02ms,PartsMade:=67268,PPM:=46.7138,NumRejects:=1256,TempSamples:=(Temp:=[99,97,103,101,100,102,95,2(105),100,102,101,96,105,3(20),97,100,96,99,105,101,97,2(103),98,100,99,104,100,105,104,99,104,103,104,102,100,101,102,96,105,99,97,100,103,105,102,101,97,105,95,101,2(103),2(101),100,101,99,105,101,102,96,95,100,98,103,105,99,104,96,97,96,101,103,100,103,95,102,97,105,103,99,96,98,105,95,103,100,103,100,2(105),101])),(RunTime:=T#24h00m00s00ms,UpTime:=T#23h54m09s00ms,DownTime:=T#00h05m51s00ms,PartsMade:=75061,PPM:=52.1256,NumRejects:=805,TempSamples:=(Temp:=[98,104,103,97,98,95,101,97,104,96,100,101,103,105,95,103,2(96),98,104,97,102,100,2(96),102,101,95,104,99,104,96,99,104,96,101,105,98,101,99,105,100,97,2(101),96,101,2(100),99,96,101,100,105,97,100,101,99,97,99,104,105,102,97,105,104,98,102,103,102,98,105,103,100,99,104,101,99,105,100,105,102,99,2(95),103,96,97,95,100,99,96,102,105,95,96])),(RunTime:=T#24h00m00s00ms,UpTime:=T#15h57m16s13ms,DownTime:=T#08h02m43s87ms,PartsMade:=40235,PPM:=27.9409,NumRejects:=742,TempSamples:=(Temp:=[2(97),100,105,104,101,105,97,103,16(20),96,103,100,101,99,102,95,99,102,99,103,95,102,99,96,2(102),103,2(99),102,3(97),101,105,103,2(101),104,101,104,105,97,100,2(99),100,103,101,103,95,103,96,100,99,20(20),99,96,95,96,98]))]; (*Structure to hold example data of a line's OEE statistics*)
		BatchNumber : UDINT := 23561458; (*An example of a batch number used for a 21CFR1 formatted report*)
	END_STRUCT;
	OEEType : 	STRUCT  (*Structure to hold example data of a line's OEE statistics*)
		RunTime : TIME; (*How long the line has been running*)
		UpTime : TIME; (*How long the line has been up*)
		DownTime : TIME; (*How long the line has been down*)
		PartsMade : UDINT; (*How many parts the line has made*)
		PPM : REAL; (*The average parts per minute made by the line*)
		NumRejects : UDINT; (*The number of rejected parts made by the line*)
		TempSamples : TempSampleType; (*Temperature samples from the line*)
	END_STRUCT;
	TempSampleType : 	STRUCT  (*Temperature samples from the line*)
		TimeStamp : ARRAY[0..95]OF INT; (*The time the temperature sample was taken*)
		Temp : ARRAY[0..95]OF REAL; (*The actual temperature reading*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	ReportFormatEnum : 
		( (*An enumeration of the format selected by the user for the report*)
		FORMAT_SIMPLE, (*A simple report to showcase some features of MpReport*)
		FORMAT_21CFR1 (*A 21CFR1 formatted report to showcase some features of MpReport*)
		);
END_TYPE
