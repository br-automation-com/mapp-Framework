TYPE
	McPathGenDynModIdentModeEnum :
	(	(*Modes for dynamic model parameter identification*)
		mcPATHGEN_DMI_NO_FILE_OVR10, (*Identify the parameters for IdentTool without result file and override 10*)
		mcPATHGEN_DMI_NO_FILE_OVR50, (*Identify the parameters for IdentTool without result file and override 50*)
		mcPATHGEN_DMI_IDENTIFY (*Identify the parameters for IdentTool*)
	);

	McPathGenDynModIdentPhaseEnum :
	(	(*Phase of dynamic model parameter identification*)
		mcPATHGEN_DMI_INACTIVE, (*Parameter identification is inactive*)
		mcPATHGEN_DMI_READ_DATA, (*Parameter identification preparation: Read trajectory data*)
		mcPATHGEN_DMI_MOVE_TO_STARTPOS, (*Parameter identification preparation: Mechanical system moves to start position*)
		mcPATHGEN_DMI_AT_STARTPOS, (*Parameter identification preparation: Mechanical system has reached the start position*)
		mcPATHGEN_DMI_IDENTIFICATION, (*Parameter identification is active*)
		mcPATHGEN_DMI_CREATE_REPORT (*Parameter identification finished: Create report file*)
	);

	McPathGenCusMechStatusEnum :
	(
		mcPATHGEN_CUSMECH_SUCCESS, (*Custom mechanical system status: success*)
		mcPATHGEN_CUSMECH_INFO, (*Custom mechanical system status: informational*)
		mcPATHGEN_CUSMECH_WARNING, (*Custom mechanical system status: warning*)
		mcPATHGEN_CUSMECH_ERROR (*Custom mechanical system status: error*)
	);

	McPathGenMonElemFeedCharEnum :
	(
		mcPATHGEN_FCH_STANDARD,
		mcPATHGEN_FCH_LINEAR
	);

	McPathGenMonElemFeedTypeEnum :
	(
		mcPATHGEN_FT_FEEDRATE,
		mcPATHGEN_FT_INVERSETIMEFEEDRATE,
		mcPATHGEN_FT_FEEDRATEPERREV
	);

	McPathGenMonElemFeedReductEnum :
	(
		mcPATHGEN_FR_INACTIVE,
		mcPATHGEN_FR_ACTIVE
	);

	McPathGenMonElemFeedReductType : STRUCT
		State: McPathGenMonElemFeedReductEnum;
		ReductionFactor : LREAL; (*percent*)
		MinimumRadius : LREAL; (*Measurement units*)
		MaximumRadius : LREAL; (*Measurement units*)
	END_STRUCT;

	McPathGenDynModIdentSpParType : STRUCT (*Startpoint parameters for dynamic model identification*)
		Velocity : REAL; (**)
		Acceleration : REAL; (**)
		Deceleration : REAL; (**)
		Jerk : REAL; (**)
	END_STRUCT;

	McPathGenDynModIdentAdvIParType : STRUCT (*Advanced input parameters for dynamic model identification*)
		TestTrajFileName : STRING[260]; (**)
	END_STRUCT;

	McPathGenDynModIdentAdvOParType : STRUCT (*Advanced output parameters for dynamic model identification*)
		ResultFileName : STRING[260]; (**)
	END_STRUCT;

	McPathGenDynModIdentAdvParType : STRUCT (*Advanced parameters for dynamic model identification*)
		Input : McPathGenDynModIdentAdvIParType; (**)
		Output : McPathGenDynModIdentAdvOParType; (**)
	END_STRUCT;

	McPathGenMonElemPrgType : STRUCT (*Monitoring Element: Program*)
		FileName : STRING[260]; (**)
		FullPath : STRING[260]; (**)
		Number : UDINT; (**)
	END_STRUCT;

	McPathGenMonElemCurrentPrgType : STRUCT (*Monitoring Element: Current program*)
		FileName : STRING[260]; (**)
		FullPath : STRING[260]; (**)
		Number : UDINT; (**)
		CallLevel : UDINT; (**)
	END_STRUCT;

	McPathGenMonElemBlockMonType : STRUCT (*Monitoring Element: Block monitor*)
		BlockLast2 : STRING[260]; (**)
		BlockLast1 : STRING[260]; (**)
		BlockActual : STRING[260]; (**)
		BlockNext1 : STRING[260]; (**)
		BlockNext2 : STRING[260]; (**)
	END_STRUCT;

	McPathGenMonElemPrgSequenceType : STRUCT (*Monitoring Element: Nested program sequence*)
		CallLevel : UDINT; (**)
		Program : ARRAY [0..31] OF McPathGenMonElemPrgType; (**)
	END_STRUCT;

	McPathGenMonElemAxPositionsType : STRUCT (*Monitoring Element: Axes positions*)
		SetPosition : ARRAY [0..9] OF LREAL; (**)
	END_STRUCT;

	McPathGenMonElemPathSpeedType : STRUCT (*Monitoring Element: Programmed path speed*)
		UnitPerMinute : REAL; (**)
		UnitPerRevolution : REAL; (**)
		Inverse : REAL; (**)
	END_STRUCT;

	McPathGenMonElemFeedSettingsType : STRUCT (*Monitoring Element: Feed settings*)
		FeedPath : STRING[80]; (*Defines the path on which the feedrate is applied*)
		FeedCharacteristic : McPathGenMonElemFeedCharEnum; (**)
		FeedType : McPathGenMonElemFeedTypeEnum; (**)
		FeedReduction : McPathGenMonElemFeedReductType; (**)
		FeedRate : REAL; (*Measurement units/minute*)
		InverseTimeFeedRate : REAL; (*movements/minute*)
		FeedPerRevolution: REAL; (*Measurement units/revolution*)
	END_STRUCT;

	McPathGenMonElemPathInfoType: STRUCT (*Monitoring Element: Path information*)
		CurrentPathVelocity : REAL; (*Measurement units/second*)
		CurrentPathPosition : LREAL; (*Measurement units*)
		CurrentPathLength : LREAL; (*Measurement units*)
		RemainingDistance : LREAL; (*Measurement units*)
		Limits : McPathGenMonElemPathLimitsType;
	END_STRUCT;

	McPathGenMonElemToolTransType : STRUCT (*Monitoring Element: Tool description: Translation*)
		X : LREAL; (**)
		Y : LREAL; (**)
		Z : LREAL; (**)
	END_STRUCT;

	McPathGenMonElemToolOrientType : STRUCT (*Monitoring Element: Tool description: Orientation*)
		Angle1 : LREAL; (**)
		Angle2 : LREAL; (**)
		Angle3 : LREAL; (**)
	END_STRUCT;

	McPathGenMonElemToolDescType : STRUCT (*Monitoring Element: Tool description*)
		ToolTranslation : McPathGenMonElemToolTransType; (**)
		ToolOrientation : McPathGenMonElemToolOrientType; (**)
		ToolLength : LREAL; (**)
		ToolRadius : LREAL; (**)
		ToolVirtualToolTip : DINT; (**)
	END_STRUCT;

    McPathGenMonElemPathLimitsType : STRUCT (*Monitoring Element: Path information - Limits*)
        Velocity : REAL; (**)
        Acceleration : REAL; (**)
        Deceleration : REAL; (**)
        JerkAcceleration : REAL; (**)
        JerkDeceleration : REAL; (**)
    END_STRUCT;

	McPathGenMonElemAxLimitsType : STRUCT (*Monitoring Element: Axis limits*)
		UpperPositionLimit : LREAL; (**)
		LowerPositionLimit : LREAL; (**)
		VelocityPositive : REAL; (**)
		VelocityNegative : REAL; (**)
		AccelerationPositive : REAL; (**)
		AccelerationNegative : REAL; (**)
		DecelerationPositive : REAL; (**)
		DecelerationNegative : REAL; (**)
		JerkAccelerationPositive : REAL; (**)
		JerkAccelerationNegative : REAL; (**)
		JerkDecelerationPositive : REAL; (**)
		JerkDecelerationNegative : REAL; (**)
		LoadAccelerationPositive : REAL; (* Configured force resp. torque based on axis type (linear resp. rotary)*)
		LoadAccelerationNegative : REAL; (* Configured force resp. torque based on axis type (linear resp. rotary)*)
		LoadDecelerationPositive : REAL; (* Configured force resp. torque based on axis type (linear resp. rotary)*)
		LoadDecelerationNegative : REAL; (* Configured force resp. torque based on axis type (linear resp. rotary)*)
	END_STRUCT;

	McPathGenMonElemAxTorquesType : STRUCT (*Monitoring Element: Torques*)
		Torques : ARRAY [0..9] OF LREAL; (**)
	END_STRUCT;
	
	McPathGenMonElemGBTorquesType : STRUCT (*Monitoring Element: Gearbox torques*)
		Torques : ARRAY [0..9] OF LREAL; (**)
	END_STRUCT;

	McPathGenMonElemCSLoadsType : STRUCT (*Monitoring Element: Cross section loads*)
		Loads : ARRAY [0..249] OF LREAL; (**)
	END_STRUCT;	

	McPathGenMonElemBasicMonType : STRUCT (*Monitoring Element: Basic monitor*)
		CurrentProgram : McPathGenMonElemCurrentPrgType; (**)
		LineNumber : UDINT; (**)
		BlockNumber : UDINT; (**)
		Runtime : LREAL; (**)
		PathSpeed : REAL; (**)
		Axes : McPathGenMonElemAxPositionsType; (**)
		TCPInMCS : McPathGenMonElemAxPositionsType; (**)
		SlaveAxes : McPathGenMonElemAxPositionsType; (**)
	END_STRUCT;

    McPathGenCusMechStatusType : STRUCT (*Custom mechanical system: Status*)
		Code : UDINT; (**)
	END_STRUCT;

	McPathGenCusMechInfoType : STRUCT (*Custom mechanical system: Info*)
		Status : McPathGenCusMechStatusType; (**)
	END_STRUCT;

    McPathGenCusMechDirInType : STRUCT (*Custom mechanical system: Input for direct function*)
		JointPos :ARRAY [0..14] OF LREAL; (**)
		TcpRefPos : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechDirOutType : STRUCT (*Custom mechanical system: Output for direct function*)
		TcpPos : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechDirParType : STRUCT (*Custom mechanical system: Parameters for direct function*)
		MechDimensionsAddr : UDINT; (**)
		Tool : McToolGeometryType; (**)
		JointCount : UDINT; (**)
		TcpCount : UDINT; (**)
	END_STRUCT;

    McPathGenCusMechDirType : STRUCT (*Custom mechanical system: Data for direct function*)
		Input : McPathGenCusMechDirInType; (**)
		Output : McPathGenCusMechDirOutType; (**)
		Parameter : McPathGenCusMechDirParType; (**)
		Info : McPathGenCusMechInfoType; (**)
	END_STRUCT;

    McPathGenCusMechInvInType : STRUCT (*Custom mechanical system: Input for inverse function*)
		TcpPos : ARRAY [0..14] OF LREAL; (**)
		JointRefPos : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechInvOutType : STRUCT (*Custom mechanical system: Output for inverse function*)
		JointPos :  ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechInvParType : STRUCT (*Custom mechanical system: Parameters for inverse function*)
		MechDimensionsAddr : UDINT; (**)
		Tool : McToolGeometryType; (**)
		JointCount : UDINT; (**)
		TcpCount : UDINT; (**)
	END_STRUCT;

    McPathGenCusMechInvType : STRUCT (*Custom mechanical system: Data for inverse function*)
		Input : McPathGenCusMechInvInType; (**)
		Output : McPathGenCusMechInvOutType; (**)
		Parameter : McPathGenCusMechInvParType; (**)
		Info : McPathGenCusMechInfoType; (**)
	END_STRUCT;

    McPathGenCusMechDirDerInType : STRUCT (*Custom mechanical system: Input for direct derivative function*)
		JointPos : ARRAY [0..14] OF LREAL; (**)
		JointDer : ARRAY [0..14] OF LREAL; (**)
		TcpRefPos : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechDirDerOutType : STRUCT (*Custom mechanical system: Output for direct derivative function*)
		TcpDer : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechDirDerParType : STRUCT (*Custom mechanical system: Parameters for direct derivative function*)
		MechDimensionsAddr : UDINT; (**)
		Tool : McToolGeometryType; (**)
		JointCount : UDINT; (**)
		TcpCount : UDINT; (**)
	END_STRUCT;

    McPathGenCusMechDirDerType : STRUCT (*Custom mechanical system: Data for direct derivative function*)
		Input : McPathGenCusMechDirDerInType; (**)
		Output : McPathGenCusMechDirDerOutType; (**)
		Parameter : McPathGenCusMechDirDerParType; (**)
		Info : McPathGenCusMechInfoType; (**)
	END_STRUCT;

    McPathGenCusMechInvDerInType : STRUCT (*Custom mechanical system: Input for inverse derivative function*)
		TcpPos : ARRAY [0..14] OF LREAL; (**)
		TcpDer : ARRAY [0..14] OF LREAL; (**)
		JointRefPos : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechInvDerOutType : STRUCT (*Custom mechanical system: Output for inverse derivative function*)
		JointDer : ARRAY [0..14] OF LREAL; (**)
	END_STRUCT;

    McPathGenCusMechInvDerParType : STRUCT (*Custom mechanical system: Parameters for inverse derivative function*)
		MechDimensionsAddr : UDINT; (**)
		Tool : McToolGeometryType; (**)
		JointCount : UDINT; (**)
		TcpCount : UDINT; (**)
	END_STRUCT;

    McPathGenCusMechInvDerType : STRUCT (*Custom mechanical system: Data for inverse derivative function*)
		Input : McPathGenCusMechInvDerInType; (**)
		Output : McPathGenCusMechInvDerOutType; (**)
		Parameter : McPathGenCusMechInvDerParType; (**)
		Info : McPathGenCusMechInfoType; (**)
	END_STRUCT;

	McPathGenCusMechPointType : 	STRUCT  (*Custom mechanical system: Point cartesian coordinates*)
		X : LREAL;
		Y : LREAL;
		Z : LREAL;
	END_STRUCT;

	McPathGenCusMechWMInType : 	STRUCT  (*Custom mechanical system: Input for wireframe model function*)
		JointPos : ARRAY[0..14]OF LREAL;
	END_STRUCT;

	McPathGenCusMechWMEdgeType : 	STRUCT  (*Custom mechanical system: Wireframe model edge data*)
		ID : UDINT;
		Point1 : McPathGenCusMechPointType;
		Point2 : McPathGenCusMechPointType;
		Distance : LREAL;
	END_STRUCT;

	McPathGenCusMechWMOutType : 	STRUCT  (*Custom mechanical system: Output for wireframe model function*)
		Edge : ARRAY[0..15]OF McPathGenCusMechWMEdgeType;
		EdgeCount : UDINT;
	END_STRUCT;

	McPathGenCusMechWMParType : 	STRUCT  (*Custom mechanical system: Parameters for wireframe model function*)
		MechDimensionsAddr : UDINT;
		WfmDescriptionAddr : UDINT;
		Tool : McToolGeometryType;
		JointCount : UDINT;
		CheckSelfCollision : BOOL;
	END_STRUCT;

	McPathGenCusMechWMInfoType : 	STRUCT  (*Custom mechanical system: Wireframe model info*)
		Status : McPathGenCusMechStatusType;
		SelfCollision : McPathGenCusMechWMSelColType;
	END_STRUCT;

	McPathGenCusMechWMStatusType : 	STRUCT  (*Custom mechanical system: Wireframe model  status*)
		Code : UDINT;
	END_STRUCT;

	McPathGenCusMechWMSelColType : 	STRUCT  (*Custom mechanical system: Wireframe model  status*)
		Detected : BOOL;
		EdgeID1 : UDINT;
		EdgeID2 : UDINT;
	END_STRUCT;

	McPathGenCusMechWMType : 	STRUCT  (*Custom mechanical system: Data for wireframe model function*)
		Input : McPathGenCusMechWMInType;
		Output : McPathGenCusMechWMOutType;
		Parameter : McPathGenCusMechWMParType;
		Info : McPathGenCusMechWMInfoType;
	END_STRUCT;
END_TYPE
