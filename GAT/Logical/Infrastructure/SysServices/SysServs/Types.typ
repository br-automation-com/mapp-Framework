
TYPE
	CpuIoMapType : 	STRUCT 
		SerialNumber_CPU : UDINT;
		ModuleID_CPU : UINT;
		HardwareVariant : UINT;
		FirmwareVersion : UINT;
		TemperatureCPU : INT;
		TemperatureENV : INT;
		SystemTime : DINT;
		TerminalOK : BOOL;
		TerminalStatus : USINT;
		TerminalTemperatureCPU : INT;
		TerminalLoadCPU0 : USINT;
		TerminalLoadCPU1 : USINT;
	END_STRUCT;
	LanguageSelect : 	STRUCT 
		LanguageSelection : ARRAY[0..1]OF STRING[80] := ['en','de'];
		SelectedIndex : INT := 0;
	END_STRUCT;
	EthConfigType : 	STRUCT 
		Ip : STRING[15];
		Gateway : STRING[15];
		SubnetMask : STRING[15];
		Device : STRING[20];
	END_STRUCT;
	ClientInfoType : 	STRUCT 
		userId : STRING[40];
		ipAddress : STRING[15];
		activityCount : USINT;
		languageId : STRING[10];
		isValid : BOOL;
		currentPageId : STRING[40];
		measurementSystemId : STRING[10];
	END_STRUCT;
END_TYPE
