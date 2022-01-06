TYPE
	McProgIntIpMonitorType : STRUCT
		Handshake : BOOL;
		Reserve : ARRAY[0..2] OF BOOL;
		StatusMsg : STRING[263];
		LastErrorMsg : STRING[119];
		LastErrorCode : UINT;
		LoadedProgCount : UINT;
		ProgName : STRING[263];
		NcblockL2 : STRING[263];
		NcblockL1 : STRING[263];
		Ncblock : STRING[263];
		NcblockN1 : STRING[263];
		NcblockN2 : STRING[263];
		CurLineNum : UDINT;
		CurBlockNum : UDINT;
		LoadFreadTime : UDINT;
		LoadPrepTime : UDINT;
		LoadSepLinesTime : UDINT;
		LoadParseTime : UDINT;
 		LoadParseLexTime : UDINT;
		BreakpointCount : UDINT;
		IpvarAccessCount : UDINT;
		ExecTime : UDINT;
		IdleTime : UDINT;
		NumParallelEvents : UDINT;
		ParallelCycleCount : UDINT;
		ParallelActionText : ARRAY[0..11] OF STRING[263];
		ParallelEvalCount : ARRAY[0..11] OF UDINT;
		ParallelExecCount : ARRAY[0..11] OF UDINT;
		NumFubsExecIpsynch : UDINT;
		NumFubsExecPpsynch : UDINT;
		Callstack : ARRAY[0..11] OF STRING[263];
		SharedMem_size : UDINT;
		IpMemSize : UDINT;
		IpCurFileMemSize : UDINT;
		SysFreeMem : UDINT;
		ReadingLineNum : UDINT;
		TranslatingLineNuM : UDINT;
		GeneratingAilLineNum : UDINT;
		ParsingAilLineNum : UDINT;
		ParallelEnabled : BOOL;
		ParallelRdisableSet : BOOL;
		StopAtM1 : BOOL;
		Unused : BOOL;
		CurProgFileName : STRING[263];
		CurProgName : STRING[263];
	END_STRUCT;
	McProgIntFileMonitorEntryType : STRUCT
		Name : REFERENCE TO STRING[263];
  		PathName : REFERENCE TO STRING[263];
  		DirName : REFERENCE TO STRING[263];
  		DeviceName : REFERENCE TO STRING[263];
		ProgramNumber : UDINT;
		StorageType : UDINT;
		TimeStamp : UDINT;
		PrecompiledLCF : BOOL;
  		Next : REFERENCE TO McProgIntFileMonitorEntryType;
	END_STRUCT;
	McProgIntFileMonitorAccessType : STRUCT
		Valid : BOOL;
		First : REFERENCE TO McProgIntFileMonitorEntryType;
	END_STRUCT;
 	McProgIntFileMonitorLineType : STRUCT
		Name : STRING[31];
		ProgramNumber : UDINT;
		StorageType : UDINT;
	END_STRUCT;
	McProgIntFileMonitorType : STRUCT
		Handshake : BOOL;
		SetOffset : UDINT;
		Offset : UDINT;
   		File : ARRAY[0..31] OF McProgIntFileMonitorLineType;
   		DirectAccess : McProgIntFileMonitorAccessType;
	END_STRUCT;
END_TYPE
TYPE
	McJointAxisType :ARRAY[0..5] OF LREAL;
	McSlaveAxisType :ARRAY[0..14] OF LREAL;
	McPointType : 	STRUCT
		Pos : McPosType;
		Orient : McOrientType;
		SlaveAxis : McSlaveAxisType;
	END_STRUCT;
	McAxisTargetType : 	STRUCT
		JointAxis : McJointAxisType;
		SlaveAxis : McSlaveAxisType;
	END_STRUCT;
	McRotationMatrixType : ARRAY[0..8] OF LREAL;
	McLatchPositionsType : STRUCT
		TriggerEvent : BOOL;
		CoordSystem : UDINT;
		Position : ARRAY[0..14] OF LREAL;
	END_STRUCT;
END_TYPE
