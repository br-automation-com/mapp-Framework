TYPE
	McAGPGSubtEnum :
		(
		mcAGPGS_GEN := 0, (*General*)
		mcAGPGS_ABB_ROB := 1 (*ABB robot*)
		);
	McAGPGLicEnum :
		( (*Defines whether to use single function licenses or a flat license for this axes group*)
		mcAGPGL_SNG := 0, (*Single - Single licenses*)
		mcAGPGL_FLT := 1 (*Flat - Flat license*)
		);
	McAGPGPAJntAxJntAxType : STRUCT
		Name : STRING[250];
		AxisReference : McCfgReferenceType;
	END_STRUCT;
	McAGPGPAJntAxType : STRUCT
		JointAxis : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGPGPASlAxSlAxType : STRUCT
		Name : STRING[250];
		AxisReference : McCfgReferenceType;
	END_STRUCT;
	McAGPGPASlAxType : STRUCT
		SlaveAxis : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGPGPASngAxSngAxType : STRUCT
		AxisReference : McCfgReferenceType;
	END_STRUCT;
	McAGPGPASngAxType : STRUCT
		SingleAxis : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGPGPAType : STRUCT
		JointAxes : McAGPGPAJntAxType;
		SlaveAxes : McAGPGPASlAxType;
		SingleAxes : McAGPGPASngAxType;
	END_STRUCT;
	McAGPGMSType : STRUCT
		MechanicalSystemReference : McCfgReferenceType; (*Name of the mechanical system reference*)
	END_STRUCT;
	McAGPGModalDatBxEnum :
		( (*Modal data behaviour selector setting*)
		mcCAGPGMDB_RST_TO_DEF := 0, (*Reset to default - The values are reseted to the configured/default values at program end.*)
		mcCAGPGMDB_KEEP_CUR_VAL := 1 (*Keep current values - The values at program end are used for the next program too.*)
		);
	McAGPGModalDatBxType : STRUCT (*All modal data is reset to the default/configured value for the next program*)
		Type : McAGPGModalDatBxEnum; (*Modal data behaviour selector setting*)
	END_STRUCT;
	McAGPGGeoPlanTCPResType : STRUCT
		LengthResolution : LREAL; (*Resolution of linear TCP coordinates [measurement units]*)
		AngleResolution : LREAL; (*Resolution of rotary TCP coordinates [measurement units]*)
	END_STRUCT;
	McAGPGGeoPlanRndModEnum :
		( (*Defines the used rounding mode*)
		mcAGPGGPRM_STD := 0, (*Standard - Standard calculation for rounding*)
		mcAGPGGPRM_ADV := 1 (*Advanced - Higher curvature but smoother run*)
		);
	McAGPGGeoPlanWrkPlEnum :
		( (*Defines the initial active working plane*)
		mcAGPGGPWP_PL_XY := 0, (*Plane XY*)
		mcAGPGGPWP_PL_YZ := 1, (*Plane YZ*)
		mcAGPGGPWP_PL_ZX := 2 (*Plane ZX*)
		);
	McAGPGGeoPlanType : STRUCT
		TCPResolution : McAGPGGeoPlanTCPResType;
		RoundingMode : McAGPGGeoPlanRndModEnum; (*Defines the used rounding mode*)
		MaxCornerDeviation : LREAL; (*Defines the maximum corner deviation for non tangential path transitions [measurement units]*)
		MaxTangentialTransitionDeviation : LREAL; (*Defines the maximum contour deviation for tangential path transitions [measurement units]*)
		MaxRadiusDeviation : LREAL; (*Defines the tolerance if circle interpolation is programmed with numeric inconsistencies [measurement units]*)
		WorkingPlane : McAGPGGeoPlanWrkPlEnum; (*Defines the initial active working plane*)
	END_STRUCT;
	McAGPGTrajPlanEnum :
		( (*Trajectory planning selector setting*)
		mcAGPGTP_BASIC := 0 (*Basic -*)
		);
	McAGPGTPBLimCkResEnum :
		( (*Limit check resolution selector setting*)
		mcAGPGTPBLCR_USR_DEF := 0, (*User defined -*)
		mcAGPGTPBLCR_AUT := 1 (*Automatic -*)
		);
	McAGPGTPBLimCkResUsrDefType : STRUCT (*Type mcAGPGTPBLCR_USR_DEF settings*)
		Time : REAL; (*[s]*)
	END_STRUCT;
	McAGPGTPBLimCkResType : STRUCT (*Time resolution of the trajectory planner in which the limits are checked*)
		Type : McAGPGTPBLimCkResEnum; (*Limit check resolution selector setting*)
		UserDefined : McAGPGTPBLimCkResUsrDefType; (*Type mcAGPGTPBLCR_USR_DEF settings*)
	END_STRUCT;
	McAGPGTPBBuffTimeEnum :
		( (*Buffer time selector setting*)
		mcAGPGTPBBT_USR_DEF := 0, (*User defined -*)
		mcAGPGTPBBT_AUT := 1 (*Automatic -*)
		);
	McAGPGTPBBuffTimeUsrDefType : STRUCT (*Type mcAGPGTPBBT_USR_DEF settings*)
		Time : REAL; (*[s]*)
	END_STRUCT;
	McAGPGTPBBuffTimeType : STRUCT (*Maximum buffered timespan which is precomputed*)
		Type : McAGPGTPBBuffTimeEnum; (*Buffer time selector setting*)
		UserDefined : McAGPGTPBBuffTimeUsrDefType; (*Type mcAGPGTPBBT_USR_DEF settings*)
	END_STRUCT;
	McAGPGTPBType : STRUCT (*Type mcAGPGTP_BASIC settings*)
		LimitCheckResolution : McAGPGTPBLimCkResType; (*Time resolution of the trajectory planner in which the limits are checked*)
		BufferTime : McAGPGTPBBuffTimeType; (*Maximum buffered timespan which is precomputed*)
	END_STRUCT;
	McAGPGTrajPlanType : STRUCT
		Type : McAGPGTrajPlanEnum; (*Trajectory planning selector setting*)
		Basic : McAGPGTPBType; (*Type mcAGPGTP_BASIC settings*)
	END_STRUCT;
	McAGPGMiscNonMoveLimEnum :
		( (*Non-movements limit selector setting*)
		mcAGPGMNML_NOT_USE := 0, (*Not Used -*)
		mcAGPGMNML_USE := 1 (*Used -*)
		);
	McAGPGMNMLUADEnum :
		( (*Action selector setting*)
		mcAGPGMNMLUAD_DELAYED_EXE := 0 (*Delayed execution - Execute only the allowed count and postpone the others to the next cycle*)
		);
	McAGPGMNMLUADType : STRUCT (*Action when the configured maximum count is exceeded*)
		Type : McAGPGMNMLUADEnum; (*Action selector setting*)
	END_STRUCT;
	McAGPGMiscNonMoveLimUseType : STRUCT (*Type mcAGPGMNML_USE settings*)
		Count : UDINT; (*Maximum count of non-movements executed in one cycle*)
		Action : McAGPGMNMLUADType; (*Action when the configured maximum count is exceeded*)
	END_STRUCT;
	McAGPGMiscNonMoveLimType : STRUCT (*Limit the count of non-movements executed in one cycle*)
		Type : McAGPGMiscNonMoveLimEnum; (*Non-movements limit selector setting*)
		Used : McAGPGMiscNonMoveLimUseType; (*Type mcAGPGMNML_USE settings*)
	END_STRUCT;
	McAGPGMiscType : STRUCT
		NonMovementsLimit : McAGPGMiscNonMoveLimType; (*Limit the count of non-movements executed in one cycle*)
	END_STRUCT;
	McAGPGBSType : STRUCT
		ModalDataBehaviour : McAGPGModalDatBxType; (*All modal data is reset to the default/configured value for the next program*)
		GeometryPlanning : McAGPGGeoPlanType;
		TrajectoryPlanning : McAGPGTrajPlanType;
		Miscellaneous : McAGPGMiscType;
	END_STRUCT;
	McCfgAxGrpPathGenType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_PATHGEN*)
		Subtype : McAGPGSubtEnum;
		ProcessingTaskClass : McPTCEnum; (*Cyclic task class for command processing*)
		License : McAGPGLicEnum; (*Defines whether to use single function licenses or a flat license for this axes group*)
		PhysicalAxes : McAGPGPAType;
		MechanicalSystem : McAGPGMSType;
		BasicSettings : McAGPGBSType;
		AxesGroupFeatures : McAGAGFType;
	END_STRUCT;
	McCfgAxGrpPathGenBaseSetType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_PATHGEN_BASE_SET*)
		BasicSettings : McAGPGBSType;
	END_STRUCT;
	McAGFPRGIPSIntrplTypEnum :
		( (*Interpolation type selector setting*)
		mcAGFPRGIPSIT_RPD_LIN := 0, (*Rapid linear - Rapid linear interpolation*)
		mcAGFPRGIPSIT_LIN := 1, (*Linear - Linear interpolation*)
		mcAGFPRGIPSIT_CIR_CW := 2, (*Circular clockwise - Circular clockwise interpolation*)
		mcAGFPRGIPSIT_CIR_CNTCW := 3, (*Circular counter-clockwise - Circular counter-clockwise interpolation*)
		mcAGFPRGIPSIT_CIR_IN_GEN_ORIENT := 4, (*Circular in general orientation - Circular interpolation in general orientation*)
		mcAGFPRGIPSIT_RPD_PTTOPT := 5, (*Rapid point-to-point - Rapid point-to-point movement*)
		mcAGFPRGIPSIT_PTTOPT := 6 (*Point-to-point - Point-to-point movement*)
		);
	McAGFPRGIPSIntrplTypType : STRUCT (*Defines the interpolation type of movement commands*)
		Type : McAGFPRGIPSIntrplTypEnum; (*Interpolation type selector setting*)
	END_STRUCT;
	McAGFPRGIPSAbsRelPosCoorEnum :
		( (*Absolute/relative position coordinates selector setting*)
		mcAGFPRGIPSARPC_ABS := 0, (*Absolute - Absolute position coordinates*)
		mcAGFPRGIPSARPC_REL := 1 (*Relative - Relative position coordinates*)
		);
	McAGFPRGIPSAbsRelPosCoorType : STRUCT (*Defines the absolute or relative target position coordinates*)
		Type : McAGFPRGIPSAbsRelPosCoorEnum; (*Absolute/relative position coordinates selector setting*)
	END_STRUCT;
	McAGFPRGIPSAbsRelCirCoorEnum :
		( (*Absolute/relative circle coordinates selector setting*)
		mcAGFPRGIPSARCC_ABS := 0, (*Absolute - Absolute position coordinates*)
		mcAGFPRGIPSARCC_REL := 1 (*Relative - Relative position coordinates*)
		);
	McAGFPRGIPSAbsRelCirCoorType : STRUCT (*Defines the absolute or relative circle coordinates*)
		Type : McAGFPRGIPSAbsRelCirCoorEnum; (*Absolute/relative circle coordinates selector setting*)
	END_STRUCT;
	McAGFPRGIPSJACSACSPrgEnum :
		( (*JACS/ACS programming selector setting*)
		mcAGFPRGIPSJAP_JACS := 0, (*JACS - Programming in joint axes coordinate system*)
		mcAGFPRGIPSJAP_ACS := 1 (*ACS - Programming in axis coordinate system*)
		);
	McAGFPRGIPSJACSACSPrgType : STRUCT (*Switches between programming in JACS and ACS*)
		Type : McAGFPRGIPSJACSACSPrgEnum; (*JACS/ACS programming selector setting*)
	END_STRUCT;
	McAGFPRGIPSCtrCxnEnum :
		( (*Contour connection selector setting*)
		mcAGFPRGIPSCC_INACT := 0, (*Inactive - No edge transition*)
		mcAGFPRGIPSCC_TAN_ARC := 1, (*Tangential arcs - Connect two contour elements via an arc*)
		mcAGFPRGIPSCC_CH := 2 (*Chamfers - Connect two contour elements via a straight line*)
		);
	McAGFPRGIPSCtrCxnTanArcType : STRUCT (*Type mcAGFPRGIPSCC_TAN_ARC settings*)
		Radius : LREAL; (*Radius of inserted arcs [measurement units]*)
	END_STRUCT;
	McAGFPRGIPSCtrCxnChChSpecEnum :
		( (*Chamfer specification selector setting*)
		mcAGFPRGIPSCCCCS_CH_LEN := 0, (*Chamfer length - Chamfer is specified by chamfer length*)
		mcAGFPRGIPSCCCCS_SHORT_PATH := 1 (*Shortened path - Chamfer is specified by shortened path*)
		);
	McAGFPRGIPSCtrCxnChChSpecType : STRUCT (*Defines how the chamfer is specified*)
		Type : McAGFPRGIPSCtrCxnChChSpecEnum; (*Chamfer specification selector setting*)
	END_STRUCT;
	McAGFPRGIPSCtrCxnChType : STRUCT (*Type mcAGFPRGIPSCC_CH settings*)
		ChamferSpecification : McAGFPRGIPSCtrCxnChChSpecType; (*Defines how the chamfer is specified*)
		Length : LREAL; (*Length of chamfer [measurement units]*)
	END_STRUCT;
	McAGFPRGIPSCtrCxnType : STRUCT (*Defines automatic insertion of connecting element between two contours*)
		Type : McAGFPRGIPSCtrCxnEnum; (*Contour connection selector setting*)
		TangentialArcs : McAGFPRGIPSCtrCxnTanArcType; (*Type mcAGFPRGIPSCC_TAN_ARC settings*)
		Chamfers : McAGFPRGIPSCtrCxnChType; (*Type mcAGFPRGIPSCC_CH settings*)
	END_STRUCT;
	McAGFPRGIPSPrgUnitEnum :
		( (*Programming units selector setting*)
		mcAGFPRGIPSPU_USE_AXESGROUP_SET := 0, (*Use AxesGroup settings - The measurement units from AxesGroup settings are used*)
		mcAGFPRGIPSPU_INCH := 1, (*Inches - Programming in inches*)
		mcAGFPRGIPSPU_MILL := 2 (*Millimeters - Programming in millimeters*)
		);
	McAGFPRGIPSPrgUnitType : STRUCT (*Specifies the units of programmed values*)
		Type : McAGFPRGIPSPrgUnitEnum; (*Programming units selector setting*)
	END_STRUCT;
	McAGFPRGIPSFSetFPathEnum :
		( (*Feed path selector setting*)
		mcAGFPRGIPSFSFP_STD := 0, (*Standard - Standard (first cartesian path)*)
		mcAGFPRGIPSFSFP_CUS_F_PATH := 1 (*Custom feed path - Selects the path by name*)
		);
	McAGFPRGIPSFSetFPathCusFPathType : STRUCT (*Type mcAGFPRGIPSFSFP_CUS_F_PATH settings*)
		PathName : McCfgString250Type; (*Name of the path on which the feedrate settings is applied*)
	END_STRUCT;
	McAGFPRGIPSFSetFPathType : STRUCT (*Defines the path to which the feedrate is applied*)
		Type : McAGFPRGIPSFSetFPathEnum; (*Feed path selector setting*)
		CustomFeedPath : McAGFPRGIPSFSetFPathCusFPathType; (*Type mcAGFPRGIPSFSFP_CUS_F_PATH settings*)
	END_STRUCT;
	McAGFPRGIPSFSetFChEnum :
		( (*Feed characteristic selector setting*)
		mcAGFPRGIPSFSFC_STD := 0, (*Standard - Standard feed characteristic*)
		mcAGFPRGIPSFSFC_LIN := 1 (*Linear - Linear feed characteristic*)
		);
	McAGFPRGIPSFSetFChType : STRUCT (*Defines the feed characteristic*)
		Type : McAGFPRGIPSFSetFChEnum; (*Feed characteristic selector setting*)
	END_STRUCT;
	McAGFPRGIPSFSetFTypEnum :
		( (*Feed type selector setting*)
		mcAGFPRGIPSFSFT_F_RATE := 0, (*Feed rate - Feed rate in units/minute*)
		mcAGFPRGIPSFSFT_INVTIME_F_RATE := 1, (*Inverse-time feed rate - Inverse-time feed rate*)
		mcAGFPRGIPSFSFT_F_RATE_PER_REV := 2 (*Feed rate per revolution - Feed rate per revolution in units/revolution*)
		);
	McAGFPRGIPSFSetFTypType : STRUCT (*Defines the feed rate programming type*)
		Type : McAGFPRGIPSFSetFTypEnum; (*Feed type selector setting*)
	END_STRUCT;
	McAGFPRGIPSFSetFRedEnum :
		( (*Feed reduction selector setting*)
		mcAGFPRGIPSFSFR_INACT := 0, (*Inactive - Deactivate feed reduction*)
		mcAGFPRGIPSFSFR_ACT := 1 (*Active - Activate feed reduction*)
		);
	McAGFPRGIPSFSetFRedActType : STRUCT (*Type mcAGFPRGIPSFSFR_ACT settings*)
		ReductionFactor : LREAL; (*Percent of the programmed feedrate [%]*)
		MinimumRadius : LREAL; (*Minimum radius, for this and smaller radii, the maximum reduced feedrate is used [measurement units]*)
		MaximumRadius : LREAL; (*Maximum radius, for this and greater radii, the programmed feedrate is used [measurement units]*)
	END_STRUCT;
	McAGFPRGIPSFSetFRedType : STRUCT (*Defines the feed rate programming type*)
		Type : McAGFPRGIPSFSetFRedEnum; (*Feed reduction selector setting*)
		Active : McAGFPRGIPSFSetFRedActType; (*Type mcAGFPRGIPSFSFR_ACT settings*)
	END_STRUCT;
	McAGFPRGIPSFSetType : STRUCT (*Defines initial settings of feeds*)
		FeedPath : McAGFPRGIPSFSetFPathType; (*Defines the path to which the feedrate is applied*)
		FeedCharacteristic : McAGFPRGIPSFSetFChType; (*Defines the feed characteristic*)
		FeedType : McAGFPRGIPSFSetFTypType; (*Defines the feed rate programming type*)
		FeedReduction : McAGFPRGIPSFSetFRedType; (*Defines the feed rate programming type*)
		FeedRate : LREAL; (*Value of feed rate in units/minute*)
		InverseTimeFeedRate : LREAL; (*Value of inverse-time feed rate*)
		FeedPerRevolution : LREAL; (*Value of feed rate per revolution in units/revolution*)
	END_STRUCT;
	McAGFPRGIPSType : STRUCT (*Defines initial values of modal data*)
		InterpolationType : McAGFPRGIPSIntrplTypType; (*Defines the interpolation type of movement commands*)
		AbsRelPositionCoordinates : McAGFPRGIPSAbsRelPosCoorType; (*Defines the absolute or relative target position coordinates*)
		AbsRelCircleCoordinates : McAGFPRGIPSAbsRelCirCoorType; (*Defines the absolute or relative circle coordinates*)
		JACSACSProgramming : McAGFPRGIPSJACSACSPrgType; (*Switches between programming in JACS and ACS*)
		ContourConnection : McAGFPRGIPSCtrCxnType; (*Defines automatic insertion of connecting element between two contours*)
		ProgrammingUnits : McAGFPRGIPSPrgUnitType; (*Specifies the units of programmed values*)
		FeedSettings : McAGFPRGIPSFSetType; (*Defines initial settings of feeds*)
	END_STRUCT;
	McAGFPRGDLEnum :
		( (*Default language selector setting*)
		mcAGFPRGDL_GC_BR := 0, (*G-code B&R - G-code B&R language*)
		mcAGFPRGDL_GC_ALT1 := 1, (*G-code Alternative-1 - G-code Alternative-1 language*)
		mcAGFPRGDL_STRUC_TXT := 2, (*Structured text - Structured text language*)
		mcAGFPRGDL_MOT_PKT_LOG := 3, (*Motion packet log - Motion packet log language*)
		mcAGFPRGDL_CUS_LANG_1 := 4 (*Custom language 1 - First custom language defined*)
		);
	McAGFPRGDLType : STRUCT (*Language to use when no file extension is provided*)
		Type : McAGFPRGDLEnum; (*Default language selector setting*)
	END_STRUCT;
	McAGFPRGLEnum :
		( (*Location selector setting*)
		mcAGFPRGL_DEF := 0, (*Default - Default program location*)
		mcAGFPRGL_USR := 1 (*User - User program location*)
		);
	McAGFPRGLDefType : STRUCT (*Type mcAGFPRGL_DEF settings*)
		FileDevice : STRING[250]; (*Program file device*)
	END_STRUCT;
	McAGFPRGLUsrUsrPrgLocType : STRUCT
		FileDevice : STRING[250]; (*Program file device*)
	END_STRUCT;
	McAGFPRGLUsrType : STRUCT (*Type mcAGFPRGL_USR settings*)
		UserProgramLocation : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPRGLType : STRUCT (*Program location*)
		Type : McAGFPRGLEnum; (*Location selector setting*)
		Default : McAGFPRGLDefType; (*Type mcAGFPRGL_DEF settings*)
		User : McAGFPRGLUsrType; (*Type mcAGFPRGL_USR settings*)
	END_STRUCT;
	McAGFPRGPEPVAdvSynEnum :
		( (*Synchronization selector setting*)
		mcAGFPRGPEPVAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcAGFPRGPEPVAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McAGFPRGPEPVAdvSynType : STRUCT (*Synchronization*)
		Type : McAGFPRGPEPVAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McAGFPRGPEPVAdvRefEnum :
		( (*Reference selector setting*)
		mcAGFPRGPEPVAR_NO := 0, (*No -*)
		mcAGFPRGPEPVAR_YES := 1 (*Yes -*)
		);
	McAGFPRGPEPVAdvRefType : STRUCT (*Variable is a reference*)
		Type : McAGFPRGPEPVAdvRefEnum; (*Reference selector setting*)
	END_STRUCT;
	McAGFPRGPEPVAdvType : STRUCT
		Alias : STRING[250]; (*Alternative name of process variable*)
		Synchronization : McAGFPRGPEPVAdvSynType; (*Synchronization*)
		Reference : McAGFPRGPEPVAdvRefType; (*Variable is a reference*)
	END_STRUCT;
	McAGFPRGPEPVType : STRUCT
		ProcessVariableName : STRING[250]; (*Name of the process variable*)
		Advanced : McAGFPRGPEPVAdvType;
	END_STRUCT;
	McAGFPRGPEPVSType : STRUCT (*Declaration of process variables*)
		ProcessVariable : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPRGPEIVAdvArrDimType : STRUCT (*Array dimensions*)
		SizeOfArrayDimemsion : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPRGPEIVAdvSynEnum :
		( (*Synchronization selector setting*)
		mcAGFPRGPEIVAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcAGFPRGPEIVAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McAGFPRGPEIVAdvSynType : STRUCT (*Synchronization*)
		Type : McAGFPRGPEIVAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McAGFPRGPEIVAdvConstEnum :
		( (*Constant selector setting*)
		mcAGFPRGPEIVAC_NO := 0, (*No -*)
		mcAGFPRGPEIVAC_YES := 1 (*Yes -*)
		);
	McAGFPRGPEIVAdvConstYesType : STRUCT (*Type mcAGFPRGPEIVAC_YES settings*)
		Value : STRING[250]; (*Value of the variable*)
	END_STRUCT;
	McAGFPRGPEIVAdvConstType : STRUCT (*Variable is a constant*)
		Type : McAGFPRGPEIVAdvConstEnum; (*Constant selector setting*)
		Yes : McAGFPRGPEIVAdvConstYesType; (*Type mcAGFPRGPEIVAC_YES settings*)
	END_STRUCT;
	McAGFPRGPEIVAdvType : STRUCT
		ArrayDimensions : McAGFPRGPEIVAdvArrDimType; (*Array dimensions*)
		Synchronization : McAGFPRGPEIVAdvSynType; (*Synchronization*)
		Constant : McAGFPRGPEIVAdvConstType; (*Variable is a constant*)
	END_STRUCT;
	McAGFPRGPEIVType : STRUCT
		VariableName : STRING[250]; (*Name of the variable*)
		DataType : McCfgVarDatTypType; (*Data type*)
		Advanced : McAGFPRGPEIVAdvType;
	END_STRUCT;
	McAGFPRGPEIVSType : STRUCT (*Declaration of variables*)
		InterpreterVariable : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPRGPEPPSRIsPatEnum :
		( (*Is pattern selector setting*)
		mcAGFPRGPEPPSRIP_NO := 0, (*No -*)
		mcAGFPRGPEPPSRIP_YES := 1 (*Yes -*)
		);
	McAGFPRGPEPPSRIsPatType : STRUCT (*The search string is a regular expression instead of a plain text string.*)
		Type : McAGFPRGPEPPSRIsPatEnum; (*Is pattern selector setting*)
	END_STRUCT;
	McAGFPRGPEPreProSubstRuleType : STRUCT
		SearchString : STRING[250]; (*The string to search for. The search is case sensitive.*)
		IsPattern : McAGFPRGPEPPSRIsPatType; (*The search string is a regular expression instead of a plain text string.*)
		ReplaceString : STRING[250]; (*The replacement text string*)
	END_STRUCT;
	McAGFPRGPEPreProSubstType : STRUCT (*Substitutions rules are applied to the CNC program prior its parsing*)
		SubstitutionRule : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPRGPEAlsAxDefType : STRUCT
		AliasAxis : McCfgUnboundedArrayType; (*Name of the alias axis*)
	END_STRUCT;
	McAGFPRGPEType : STRUCT (*Program elements*)
		ProcessVariables : McAGFPRGPEPVSType; (*Declaration of process variables*)
		InterpreterVariables : McAGFPRGPEIVSType; (*Declaration of variables*)
		PreprocessorSubstitutions : McAGFPRGPEPreProSubstType; (*Substitutions rules are applied to the CNC program prior its parsing*)
		AliasAxesDefinitions : McAGFPRGPEAlsAxDefType;
	END_STRUCT;
	McCfgAxGrpFeatPrgType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_PRG*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		InitialProgramSettings : McAGFPRGIPSType; (*Defines initial values of modal data*)
		DefaultLanguage : McAGFPRGDLType; (*Language to use when no file extension is provided*)
		Location : McAGFPRGLType; (*Program location*)
		ProgramElements : McAGFPRGPEType; (*Program elements*)
	END_STRUCT;
	McAGFFFFwdModEnum :
		( (*Feed-forward mode selector setting*)
		mcAGFFFFM_COMP_AND_TRANS := 0, (*Compute and transmit - Compute feed-forward torques and transmit to drives*)
		mcAGFFFFM_DIS := 1, (*Disabled - Feed-forward feature is disabled*)
		mcAGFFFFM_COMP := 2 (*Compute - Compute feed-forward torques*)
		);
	McAGFFFFwdModType : STRUCT (*Defines if feed-forward is only computed or computed and transmitted*)
		Type : McAGFFFFwdModEnum; (*Feed-forward mode selector setting*)
	END_STRUCT;
	McAGFFExJntAxType : STRUCT
		JointAxisName : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFFParIdentEnum :
		( (*Parameter identification selector setting*)
		mcAGFFPI_NOT_USE := 0, (*Not used -*)
		mcAGFFPI_USE := 1 (*Used -*)
		);
	McAGFFParIdentUseInFType : STRUCT (*Defines names of the input files (from IdentTool)*)
		TesttrajectoryData : STRING[250]; (*File with data for testtrajectory*)
	END_STRUCT;
	McAGFFParIdentUseOutFType : STRUCT (*Defines names of the output files (for IdentTool)*)
		IdentificationResultData : STRING[250]; (*File with data for dynamic parameter calculation*)
	END_STRUCT;
	McAGFFParIdentUseType : STRUCT (*Type mcAGFFPI_USE settings*)
		FileDevice : STRING[250]; (*File device for file sharing*)
		InputFiles : McAGFFParIdentUseInFType; (*Defines names of the input files (from IdentTool)*)
		OutputFiles : McAGFFParIdentUseOutFType; (*Defines names of the output files (for IdentTool)*)
	END_STRUCT;
	McAGFFParIdentType : STRUCT (*Dynamic model parameter identification*)
		Type : McAGFFParIdentEnum; (*Parameter identification selector setting*)
		Used : McAGFFParIdentUseType; (*Type mcAGFFPI_USE settings*)
	END_STRUCT;
	McCfgAxGrpFeatFfType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_FF*)
		FeedForwardMode : McAGFFFFwdModType; (*Defines if feed-forward is only computed or computed and transmitted*)
		RiseTime : REAL; (*[s]*)
		ExcludedJointAxes : McAGFFExJntAxType;
		ParameterIdentification : McAGFFParIdentType; (*Dynamic model parameter identification*)
	END_STRUCT;
	McAGFFHSProdFrmType : STRUCT (*The product coordinate system is based on the last system coordinate system.*)
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
	END_STRUCT;
	McAGFFHSSysFrm5Type : STRUCT
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
		ProductFrame : McAGFFHSProdFrmType; (*The product coordinate system is based on the last system coordinate system.*)
	END_STRUCT;
	McAGFFHSSysFrm4Type : STRUCT
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
		SystemFrame5 : McAGFFHSSysFrm5Type;
	END_STRUCT;
	McAGFFHSSysFrm3Type : STRUCT
		FrameTable : McCfgReferenceType; (*Defines the initial frame table*)
		FrameIndex : UINT; (*Defines the initial frame index in the initial frame table*)
		SystemFrame4 : McAGFFHSSysFrm4Type;
	END_STRUCT;
	McAGFFHSSysFrm2Type : STRUCT
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
		SystemFrame3 : McAGFFHSSysFrm3Type;
	END_STRUCT;
	McAGFFHSSysFrm1Type : STRUCT (*System frames are based on the machine coordinate system and form a chain.*)
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
		SystemFrame2 : McAGFFHSSysFrm2Type;
	END_STRUCT;
	McAGFFHSBaseFrmType : STRUCT (*Is the base for a kinematic transformation (robot).*)
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
	END_STRUCT;
	McAGFFHSMachFrmType : STRUCT (*Base of all other coordinate systems of the axes group.*)
		SystemFrame1 : McAGFFHSSysFrm1Type; (*System frames are based on the machine coordinate system and form a chain.*)
		BaseFrame : McAGFFHSBaseFrmType; (*Is the base for a kinematic transformation (robot).*)
	END_STRUCT;
	McCfgAxGrpFeatFrmHierStdType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_FRM_HIER_STD*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		MachineFrame : McAGFFHSMachFrmType; (*Base of all other coordinate systems of the axes group.*)
	END_STRUCT;
	McAGFFHCFrmPropMappType : STRUCT
		BCS : STRING[250]; (*Name of the frame that should be mapped to BCS (mandatory)*)
		PCS : STRING[250]; (*Name of the frame that should be mapped to PCS (mandatory)*)
		SCS1 : STRING[250]; (*Name of the frame that should be mapped to SCS1*)
		SCS2 : STRING[250]; (*Name of the frame that should be mapped to SCS2*)
		SCS3 : STRING[250]; (*Name of the frame that should be mapped to SCS3*)
		SCS4 : STRING[250]; (*Name of the frame that should be mapped to SCS4*)
		SCS5 : STRING[250]; (*Name of the frame that should be mapped to SCS5*)
	END_STRUCT;
	McAGFFHCFTypeEnum :
		( (*Type selector setting*)
		mcAGFFHCFT_STD_FRM := 0, (*Standard frame -*)
		mcAGFFHCFT_FRM_TBL_FRM := 1, (*Frame table frame -*)
		mcAGFFHCFT_PRG_MOVE_FRM := 2 (*Programmed moving frame -*)
		);
	McAGFFHCFTStdFrmType : STRUCT (*Type mcAGFFHCFT_STD_FRM settings*)
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
	END_STRUCT;
	McAGFFHCFTFrmTblFrmType : STRUCT (*Type mcAGFFHCFT_FRM_TBL_FRM settings*)
		FrameTable : McCfgReferenceType; (*Defines the initial frame table*)
		FrameIndex : UINT; (*Defines the initial frame index in the initial frame table*)
	END_STRUCT;
	McAGFFHCFTPMFMoveTypEnum :
		( (*Movement type selector setting*)
		mcAGFFHCFTPMFMT_TRANS_X := 0, (*Translation X - Translation in X-direction*)
		mcAGFFHCFTPMFMT_TRANS_Y := 1, (*Translation Y - Translation in Y-direction*)
		mcAGFFHCFTPMFMT_TRANS_Z := 2, (*Translation Z - Translation in Z-direction*)
		mcAGFFHCFTPMFMT_ROT_X := 3, (*Rotation X - Rotation around X*)
		mcAGFFHCFTPMFMT_ROT_Y := 4, (*Rotation Y - Rotation around Y*)
		mcAGFFHCFTPMFMT_ROT_Z := 5 (*Rotation Z - Rotation around Z*)
		);
	McAGFFHCFTPMFMoveTypType : STRUCT (*Direction of the movement*)
		Type : McAGFFHCFTPMFMoveTypEnum; (*Movement type selector setting*)
	END_STRUCT;
	McAGFFHCFTPMFType : STRUCT (*Type mcAGFFHCFT_PRG_MOVE_FRM settings*)
		MovementType : McAGFFHCFTPMFMoveTypType; (*Direction of the movement*)
		SlaveAxisName : STRING[250]; (*Name of the slave axes that is mapped to the frame*)
	END_STRUCT;
	McAGFFHCFTypeType : STRUCT (*Frame type*)
		Type : McAGFFHCFTypeEnum; (*Type selector setting*)
		StandardFrame : McAGFFHCFTStdFrmType; (*Type mcAGFFHCFT_STD_FRM settings*)
		FrameTableFrame : McAGFFHCFTFrmTblFrmType; (*Type mcAGFFHCFT_FRM_TBL_FRM settings*)
		ProgrammedMovingFrame : McAGFFHCFTPMFType; (*Type mcAGFFHCFT_PRG_MOVE_FRM settings*)
	END_STRUCT;
	McAGFFHCFramesType : STRUCT
		ParentFrameName : STRING[250]; (*Parent frame name*)
		Name : STRING[250]; (*Frame name*)
		Type : McAGFFHCFTypeType; (*Frame type*)
	END_STRUCT;
	McAGFFHCMachFrmType : STRUCT (*Base of all other coordinate systems of the axes group.*)
		Name : STRING[250]; (*Frame name*)
		Frame : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFFHCType : STRUCT (*Custom frame-hierarchy of an axes group*)
		FramePropertyMapping : McAGFFHCFrmPropMappType;
		MachineFrame : McAGFFHCMachFrmType; (*Base of all other coordinate systems of the axes group.*)
	END_STRUCT;
	McCfgAxGrpFeatFrmHierCusType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_FRM_HIER_CUS*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		CustomFrameHierarchy : McAGFFHCType; (*Custom frame-hierarchy of an axes group*)
	END_STRUCT;
	McAGFMFunIdxTypEnum :
		( (*Index type selector setting*)
		mcAGFMFIT_SNG := 0, (*Single - Single M-Function*)
		mcAGFMFIT_RNG := 1 (*Range - Range of M-Functions*)
		);
	McAGFMFunIdxTypSngType : STRUCT (*Type mcAGFMFIT_SNG settings*)
		Index : UINT; (*Index of the M-Function*)
	END_STRUCT;
	McAGFMFunIdxTypRngType : STRUCT (*Type mcAGFMFIT_RNG settings*)
		IndexFrom : UINT; (*Start index of the M-Functions range*)
		IndexTo : UINT; (*End index of the M-Functions range*)
	END_STRUCT;
	McAGFMFunIdxTypType : STRUCT (*Single M-Function or Range of M-Functions*)
		Type : McAGFMFunIdxTypEnum; (*Index type selector setting*)
		Single : McAGFMFunIdxTypSngType; (*Type mcAGFMFIT_SNG settings*)
		Range : McAGFMFunIdxTypRngType; (*Type mcAGFMFIT_RNG settings*)
	END_STRUCT;
	McAGFMFunBlkEnum :
		( (*Blocking selector setting*)
		mcAGFMFB_EN := 0, (*Enabled - Blocking M-Function*)
		mcAGFMFB_DIS := 1 (*Disabled - Non-blocking M-Function*)
		);
	McAGFMFunBlkType : STRUCT (*M-Function blocking / non-blocking*)
		Type : McAGFMFunBlkEnum; (*Blocking selector setting*)
	END_STRUCT;
	McAGFMFunOutEnum :
		( (*Output selector setting*)
		mcAGFMFO_B4 := 0, (*Before - The M-Function will be set before the movement is executed*)
		mcAGFMFO_A := 1 (*After - The M-Function will be set after the movement is executed*)
		);
	McAGFMFunOutType : STRUCT (*Output position of the M-Function programmed with movement*)
		Type : McAGFMFunOutEnum; (*Output selector setting*)
	END_STRUCT;
	McAGFMFunInSimEnum :
		( (*In simulation selector setting*)
		mcAGFMFIS_NOT_USE := 0, (*Not used - The M-Function is not set*)
		mcAGFMFIS_SET := 1 (*Set - The M-Function is set*)
		);
	McAGFMFunInSimType : STRUCT (*Behaviour of M-Function during simulation run*)
		Type : McAGFMFunInSimEnum; (*In simulation selector setting*)
	END_STRUCT;
	McAGFMFunType : STRUCT
		IndexType : McAGFMFunIdxTypType; (*Single M-Function or Range of M-Functions*)
		Blocking : McAGFMFunBlkType; (*M-Function blocking / non-blocking*)
		Output : McAGFMFunOutType; (*Output position of the M-Function programmed with movement*)
		InSimulation : McAGFMFunInSimType; (*Behaviour of M-Function during simulation run*)
		PVMapping : STRING[250]; (*Name of the process variable representing M-Function*)
		Counter : STRING[250]; (*Name of the process variable representing M-Function occurrence counter*)
	END_STRUCT;
	McCfgAxGrpFeatMFunType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_MFUN*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		MFunction : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPDPathTypEnum :
		( (*Type selector setting*)
		mcAGFPDPT_CART_PATH := 0, (*Cartesian path - The path is calculated from all Cartesian coordinates*)
		mcAGFPDPT_ORIENT_PATH := 1, (*Orientation path - The path is calculated from the orientation coordinates. Only available for mechanical systems with orientation axis.*)
		mcAGFPDPT_PHS_AX_PATH := 2, (*Physical axes path - Path definition containing all path controlled physical axes*)
		mcAGFPDPT_CUS_PHS_AX_PATH := 3 (*Custom physical axes path - Path definition containing all selected path controlled physical axes*)
		);
	McAGFPDCalcInEnum :
		( (*Calculated in selector setting*)
		mcAGFPDCI_MCS := 0, (*MCS - Machine coordinate system*)
		mcAGFPDCI_PCS := 1, (*PCS - Product coordinate system*)
		mcAGFPDCI_SEL_BY_NAME := 2 (*Selected by name - Select the frame by name.*)
		);
	McAGFPDCalcInSelByNameType : STRUCT (*Type mcAGFPDCI_SEL_BY_NAME settings*)
		FrameName : STRING[250]; (*Name of the frame in which the path is calculated.*)
	END_STRUCT;
	McAGFPDCalcInType : STRUCT (*In this frame the path is calculated.*)
		Type : McAGFPDCalcInEnum; (*Calculated in selector setting*)
		SelectedByName : McAGFPDCalcInSelByNameType; (*Type mcAGFPDCI_SEL_BY_NAME settings*)
	END_STRUCT;
	McAGFPDPathTypCartPathType : STRUCT (*Type mcAGFPDPT_CART_PATH settings*)
		CalculatedIn : McAGFPDCalcInType; (*In this frame the path is calculated.*)
	END_STRUCT;
	McAGFPDPathTypOrientPathType : STRUCT (*Type mcAGFPDPT_ORIENT_PATH settings*)
		CalculatedIn : McAGFPDCalcInType; (*In this frame the path is calculated.*)
	END_STRUCT;
	McAGFPDPathTypCusPhsAxPathType : STRUCT (*Type mcAGFPDPT_CUS_PHS_AX_PATH settings*)
		AxisName : McCfgUnboundedArrayType; (*Name of the axis which is included in limiting the physical axes path*)
	END_STRUCT;
	McAGFPDPathTypType : STRUCT (*Type of the path*)
		Type : McAGFPDPathTypEnum; (*Type selector setting*)
		CartesianPath : McAGFPDPathTypCartPathType; (*Type mcAGFPDPT_CART_PATH settings*)
		OrientationPath : McAGFPDPathTypOrientPathType; (*Type mcAGFPDPT_ORIENT_PATH settings*)
		CustomPhysicalAxesPath : McAGFPDPathTypCusPhsAxPathType; (*Type mcAGFPDPT_CUS_PHS_AX_PATH settings*)
	END_STRUCT;
	McAGFPDPathLimEnum :
		( (*Path limits selector setting*)
		mcAGFPDPL_INT := 0, (*Internal - Internal definition of path limits*)
		mcAGFPDPL_EXT := 1 (*External - External definition of path limits*)
		);
	McAGFPDPathLimIntVelEnum :
		( (*Velocity selector setting*)
		mcAGFPDPLIV_NOT_USE := 0, (*Not used -*)
		mcAGFPDPLIV_BASIC := 1 (*Basic -*)
		);
	McAGFPDPathLimIntVelType : STRUCT (*Velocity limit*)
		Type : McAGFPDPathLimIntVelEnum; (*Velocity selector setting*)
		Basic : McCfgLimVelBaseType; (*Type mcAGFPDPLIV_BASIC settings*)
	END_STRUCT;
	McAGFPDPathLimIntAccEnum :
		( (*Acceleration selector setting*)
		mcAGFPDPLIA_NOT_USE := 0, (*Not used -*)
		mcAGFPDPLIA_BASIC := 1 (*Basic -*)
		);
	McAGFPDPathLimIntAccType : STRUCT (*Acceleration limit*)
		Type : McAGFPDPathLimIntAccEnum; (*Acceleration selector setting*)
		Basic : McCfgLimAccBaseType; (*Type mcAGFPDPLIA_BASIC settings*)
	END_STRUCT;
	McAGFPDPathLimIntDecEnum :
		( (*Deceleration selector setting*)
		mcAGFPDPLID_NOT_USE := 0, (*Not used -*)
		mcAGFPDPLID_BASIC := 1 (*Basic -*)
		);
	McAGFPDPathLimIntDecType : STRUCT (*Deceleration limit*)
		Type : McAGFPDPathLimIntDecEnum; (*Deceleration selector setting*)
		Basic : McCfgLimDecBaseType; (*Type mcAGFPDPLID_BASIC settings*)
	END_STRUCT;
	McAGFPDPathLimIntJerkEnum :
		( (*Jerk selector setting*)
		mcAGFPDPLIJ_NOT_USE := 0, (*Not used -*)
		mcAGFPDPLIJ_BASIC := 1 (*Basic -*)
		);
	McAGFPDPathLimIntJerkType : STRUCT (*Jerk limit*)
		Type : McAGFPDPathLimIntJerkEnum; (*Jerk selector setting*)
		Basic : McCfgLimJerkBaseType; (*Type mcAGFPDPLIJ_BASIC settings*)
	END_STRUCT;
	McAGFPDPathLimIntType : STRUCT (*Type mcAGFPDPL_INT settings*)
		Velocity : McAGFPDPathLimIntVelType; (*Velocity limit*)
		Acceleration : McAGFPDPathLimIntAccType; (*Acceleration limit*)
		Deceleration : McAGFPDPathLimIntDecType; (*Deceleration limit*)
		Jerk : McAGFPDPathLimIntJerkType; (*Jerk limit*)
	END_STRUCT;
	McAGFPDPathLimType : STRUCT (*Defines the path limits*)
		Type : McAGFPDPathLimEnum; (*Path limits selector setting*)
		Internal : McAGFPDPathLimIntType; (*Type mcAGFPDPL_INT settings*)
		External : McCfgExtLimRefType; (*Type mcAGFPDPL_EXT settings*)
	END_STRUCT;
	McAGFPDPathType : STRUCT (*Predefined path definitions can be used*)
		Name : STRING[250]; (*Name of the path in a NC program*)
		Type : McAGFPDPathTypType; (*Type of the path*)
		PathLimits : McAGFPDPathLimType; (*Defines the path limits*)
	END_STRUCT;
	McCfgAxGrpFeatPathDefType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_PATH_DEF*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		Path : McCfgUnboundedArrayType; (*Predefined path definitions can be used*)
	END_STRUCT;
	McAGFSSpdlType : STRUCT
		SlaveAxisName : STRING[250];
	END_STRUCT;
	McCfgAxGrpFeatSpindlesType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_SPINDLES*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		Spindle : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFTToolEnum :
		( (*Tools selector setting*)
		mcAGFTT_TOOL_TBL := 0, (*Tool table -*)
		mcAGFTT_SNG_TOOL := 1 (*Single tool -*)
		);
	McAGFTToolToolTblType : STRUCT (*Type mcAGFTT_TOOL_TBL settings*)
		ToolTable : McCfgReferenceType; (*Name of the initial tool table*)
		ToolIdentifier : STRING[250]; (*Defines the initial tool identifier in the tool table*)
	END_STRUCT;
	McAGFTToolSngToolType : STRUCT (*Type mcAGFTT_SNG_TOOL settings*)
		Tool : McCfgReferenceType; (*Name of the tool*)
		DynamicParameter : McCfgReferenceType; (*Name of the dynamic parameter*)
	END_STRUCT;
	McAGFTToolType : STRUCT (*Defines the initial tool settings*)
		Type : McAGFTToolEnum; (*Tools selector setting*)
		ToolTable : McAGFTToolToolTblType; (*Type mcAGFTT_TOOL_TBL settings*)
		SingleTool : McAGFTToolSngToolType; (*Type mcAGFTT_SNG_TOOL settings*)
	END_STRUCT;
	McCfgAxGrpFeatToolType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_TOOL*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		Tools : McAGFTToolType; (*Defines the initial tool settings*)
	END_STRUCT;
	McAGFWSelfColDetectEnum :
		( (*Self-collision detection selector setting*)
		mcAGFWSCD_NOT_USE := 0, (*Not used - Self-collision detection is not used*)
		mcAGFWSCD_EN := 1 (*Enabled - Self-collision detection is enabled*)
		);
	McAGFWSelfColDetectType : STRUCT (*Self-collision detection*)
		Type : McAGFWSelfColDetectEnum; (*Self-collision detection selector setting*)
	END_STRUCT;
	McAGFWFlgWsEnum :
		( (*Flange workspace selector setting*)
		mcAGFWFW_NOT_USE := 0, (*Not used - Workspace monitoring of flange is not used*)
		mcAGFWFW_EN := 1 (*Enabled - Workspace monitoring of flange is enabled*)
		);
	McAGFWFlgWsEnType : STRUCT (*Type mcAGFWFW_EN settings*)
		WorkspaceReference : McCfgReferenceType; (*Name of the workspace reference*)
	END_STRUCT;
	McAGFWFlgWsType : STRUCT (*Additional workspace monitoring of flange*)
		Type : McAGFWFlgWsEnum; (*Flange workspace selector setting*)
		Enabled : McAGFWFlgWsEnType; (*Type mcAGFWFW_EN settings*)
	END_STRUCT;
	McCfgAxGrpFeatWsmType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_WSM*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		WorkspaceReference : McCfgReferenceType; (*Name of the workspace reference*)
		SelfCollisionDetection : McAGFWSelfColDetectType; (*Self-collision detection*)
		FlangeWorkspace : McAGFWFlgWsType; (*Additional workspace monitoring of flange*)
	END_STRUCT;
	McAGFEPCAGrpIntrplExType : STRUCT
		AxisName : McCfgUnboundedArrayType; (*Name of the axis in axes group*)
	END_STRUCT;
	McCfgAxGrpFeatExPathAxType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_EX_PATH_AX*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		GroupInterpolationExclusion : McAGFEPCAGrpIntrplExType;
	END_STRUCT;
	McAGFPTrgTypEnum :
		( (*Type selector setting*)
		mcAGFPTT_ACP := 0, (*ACOPOS - Trigger source ACOPOS*)
		mcAGFPTT_VAR := 1 (*Variable - Trigger source Variable*)
		);
	McAGFPTrgTypAcpDigInEnum :
		( (*Digital input selector setting*)
		mcAGFPTTADI_TRG_1 := 0, (*Trigger 1 - Hardware trigger input 1*)
		mcAGFPTTADI_TRG_2 := 1 (*Trigger 2 - Hardware trigger input 2*)
		);
	McAGFPTrgTypAcpDigInType : STRUCT (*Hardware trigger input*)
		Type : McAGFPTrgTypAcpDigInEnum; (*Digital input selector setting*)
	END_STRUCT;
	McAGFPTrgTypAcpEdgEnum :
		( (*Edge selector setting*)
		mcAGFPTTAE_POS := 0, (*Positive - Positive edge*)
		mcAGFPTTAE_NEG := 1 (*Negative - Negative edge*)
		);
	McAGFPTrgTypAcpEdgType : STRUCT (*Trigger edge*)
		Type : McAGFPTrgTypAcpEdgEnum; (*Edge selector setting*)
	END_STRUCT;
	McAGFPTrgTypAcpType : STRUCT (*Type mcAGFPTT_ACP settings*)
		AxisReference : McCfgReferenceType; (*Name of the axis reference*)
		DigitalInput : McAGFPTrgTypAcpDigInType; (*Hardware trigger input*)
		Edge : McAGFPTrgTypAcpEdgType; (*Trigger edge*)
	END_STRUCT;
	McAGFPTrgTypVarEdgEnum :
		( (*Edge selector setting*)
		mcAGFPTTVE_POS := 0, (*Positive - Positive edge*)
		mcAGFPTTVE_NEG := 1 (*Negative - Negative edge*)
		);
	McAGFPTrgTypVarEdgType : STRUCT (*Trigger edge*)
		Type : McAGFPTrgTypVarEdgEnum; (*Edge selector setting*)
	END_STRUCT;
	McAGFPTrgTypVarTimeStampEnum :
		( (*Time stamp selector setting*)
		mcAGFPTTVTS_NOT_USE := 0, (*Not used - Not used*)
		mcAGFPTTVTS_USE := 1 (*Used - Used*)
		);
	McAGFPTrgTypVarTimeStampUseType : STRUCT (*Type mcAGFPTTVTS_USE settings*)
		PVMapping : STRING[250]; (*Name of the process variable (DINT) representing trigger time stamp*)
	END_STRUCT;
	McAGFPTrgTypVarTimeStampType : STRUCT (*Trigger time stamp*)
		Type : McAGFPTrgTypVarTimeStampEnum; (*Time stamp selector setting*)
		Used : McAGFPTrgTypVarTimeStampUseType; (*Type mcAGFPTTVTS_USE settings*)
	END_STRUCT;
	McAGFPTrgTypVarType : STRUCT (*Type mcAGFPTT_VAR settings*)
		PVMapping : STRING[250]; (*Name of the process variable (BOOL) representing trigger*)
		Edge : McAGFPTrgTypVarEdgType; (*Trigger edge*)
		TimeStamp : McAGFPTrgTypVarTimeStampType; (*Trigger time stamp*)
	END_STRUCT;
	McAGFPTrgTypType : STRUCT (*Type of the trigger source*)
		Type : McAGFPTrgTypEnum; (*Type selector setting*)
		ACOPOS : McAGFPTrgTypAcpType; (*Type mcAGFPTT_ACP settings*)
		Variable : McAGFPTrgTypVarType; (*Type mcAGFPTT_VAR settings*)
	END_STRUCT;
	McAGFPTrgType : STRUCT
		Name : STRING[250]; (*Name of the trigger in a NC program*)
		Type : McAGFPTrgTypType; (*Type of the trigger source*)
	END_STRUCT;
	McAGFPTrgsType : STRUCT
		Trigger : McCfgUnboundedArrayType;
	END_STRUCT;
	McCfgAxGrpFeatProbeType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_PROBE*)
		Triggers : McAGFPTrgsType;
	END_STRUCT;
	McAGF2DCCompTypEnum :
		( (*Type selector setting*)
		mcAGF2DCCT_JNT_AX := 0 (*Joint Axis - Joint axis compensation*)
		);
	McAGF2DCCompTypJntAxType : STRUCT (*Type mcAGF2DCCT_JNT_AX settings*)
		Source : McCfgReferenceType; (*Source axis*)
		Compensated : McCfgReferenceType; (*Compensated axis*)
	END_STRUCT;
	McAGF2DCCompTypType : STRUCT (*Type of compensation*)
		Type : McAGF2DCCompTypEnum; (*Type selector setting*)
		JointAxis : McAGF2DCCompTypJntAxType; (*Type mcAGF2DCCT_JNT_AX settings*)
	END_STRUCT;
	McAGF2DCCompDatEnum :
		( (*Compensation data selector setting*)
		mcAGF2DCCD_PT_LST := 0, (*Points list - Compensation data specified using list of points*)
		mcAGF2DCCD_CSV_F := 1 (*CSV file - Reference to CSV file with compensation data*)
		);
	McAGF2DCCompDatPtLstPtType : STRUCT
		Source : LREAL; (*Position of source*)
		Compensation : LREAL; (*Compensation value*)
	END_STRUCT;
	McAGF2DCCompDatPtLstType : STRUCT (*Type mcAGF2DCCD_PT_LST settings*)
		Point : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGF2DCCompDatCSVFType : STRUCT (*Type mcAGF2DCCD_CSV_F settings*)
		FileDevice : STRING[250]; (*File device*)
		FileName : STRING[250]; (*File name*)
	END_STRUCT;
	McAGF2DCCompDatType : STRUCT (*Compensation data*)
		Type : McAGF2DCCompDatEnum; (*Compensation data selector setting*)
		PointsList : McAGF2DCCompDatPtLstType; (*Type mcAGF2DCCD_PT_LST settings*)
		CSVFile : McAGF2DCCompDatCSVFType; (*Type mcAGF2DCCD_CSV_F settings*)
	END_STRUCT;
	McAGF2DCCompType : STRUCT
		ID : UINT; (*Compensation ID*)
		Type : McAGF2DCCompTypType; (*Type of compensation*)
		Data : McAGF2DCCompDatType; (*Compensation data*)
	END_STRUCT;
	McCfgAxGrpFeat2DCompType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_2D_COMP*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		Compensation : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGF3DCCompTypEnum :
		( (*Type selector setting*)
		mcAGF3DCCT_JNT_AX := 0 (*Joint Axis - Joint axis compensation*)
		);
	McAGF3DCCompTypJntAxType : STRUCT (*Type mcAGF3DCCT_JNT_AX settings*)
		Source1 : McCfgReferenceType; (*First source axis*)
		Source2 : McCfgReferenceType; (*Second source axis*)
		Compensated : McCfgReferenceType; (*Compensated axis*)
	END_STRUCT;
	McAGF3DCCompTypType : STRUCT (*Type of compensation*)
		Type : McAGF3DCCompTypEnum; (*Type selector setting*)
		JointAxis : McAGF3DCCompTypJntAxType; (*Type mcAGF3DCCT_JNT_AX settings*)
	END_STRUCT;
	McAGF3DCCompDatEnum :
		( (*Compensation data selector setting*)
		mcAGF3DCCD_PT_LST := 0, (*Points list - Compensation data specified using list of points*)
		mcAGF3DCCD_CSV_F := 1 (*CSV file - Reference to CSV file with compensation data*)
		);
	McAGF3DCCompDatPtLstPtType : STRUCT
		Source1 : LREAL; (*Position of source 1*)
		Source2 : LREAL; (*Position of source 2*)
		Compensation : LREAL; (*Compensation value*)
	END_STRUCT;
	McAGF3DCCompDatPtLstType : STRUCT (*Type mcAGF3DCCD_PT_LST settings*)
		Point : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGF3DCCompDatCSVFType : STRUCT (*Type mcAGF3DCCD_CSV_F settings*)
		FileDevice : STRING[250]; (*File device*)
		FileName : STRING[250]; (*File name*)
	END_STRUCT;
	McAGF3DCCompDatType : STRUCT (*Compensation data*)
		Type : McAGF3DCCompDatEnum; (*Compensation data selector setting*)
		PointsList : McAGF3DCCompDatPtLstType; (*Type mcAGF3DCCD_PT_LST settings*)
		CSVFile : McAGF3DCCompDatCSVFType; (*Type mcAGF3DCCD_CSV_F settings*)
	END_STRUCT;
	McAGF3DCCompType : STRUCT
		ID : UINT; (*Compensation ID*)
		Type : McAGF3DCCompTypType; (*Type of compensation*)
		Data : McAGF3DCCompDatType; (*Compensation data*)
	END_STRUCT;
	McCfgAxGrpFeat3DCompType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_3D_COMP*)
		ModalDataBehaviour : McAGFModalDatBxType; (*Defines the modal data behaviour of the feature.*)
		Compensation : McCfgUnboundedArrayType;
	END_STRUCT;
	McMSCSDescEnum :
		( (*Description selector setting*)
		mcMSCSD_STD := 0 (*Standard - Standard description*)
		);
	McMSCSDSType : STRUCT (*Type mcMSCSD_STD settings*)
		Dimensions : STRING[250]; (*Name of the process variable for the dimensions of the mechanical system*)
	END_STRUCT;
	McMSCSDescType : STRUCT (*Description of the mechanical system*)
		Type : McMSCSDescEnum; (*Description selector setting*)
		Standard : McMSCSDSType; (*Type mcMSCSD_STD settings*)
	END_STRUCT;
	McMSCSJntAxType : STRUCT (*Joint axes*)
		JointAxesCount : UINT; (*Number of joint axes of the mechanical system*)
	END_STRUCT;
	McMSCSCNCCEnum :
		( (*Cartesian coordinates selector setting*)
		mcMSCSCNCC_XYZ := 0, (*XYZ - Cartesian coordinates X,Y and Z*)
		mcMSCSCNCC_XY := 1, (*XY - Cartesian coordinates X and Y*)
		mcMSCSCNCC_XZ := 2, (*XZ - Cartesian coordinates X and Z*)
		mcMSCSCNCC_YZ := 3 (*YZ - Cartesian coordinates Y and Z*)
		);
	McMSCSCNCCXYZType : STRUCT (*Type mcMSCSCNCC_XYZ settings*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMSCSCNCCXYType : STRUCT (*Type mcMSCSCNCC_XY settings*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
	END_STRUCT;
	McMSCSCNCCXZType : STRUCT (*Type mcMSCSCNCC_XZ settings*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMSCSCNCCYZType : STRUCT (*Type mcMSCSCNCC_YZ settings*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMSCSCNCCType : STRUCT (*Cartesian coordinates*)
		Type : McMSCSCNCCEnum; (*Cartesian coordinates selector setting*)
		XYZ : McMSCSCNCCXYZType; (*Type mcMSCSCNCC_XYZ settings*)
		XY : McMSCSCNCCXYType; (*Type mcMSCSCNCC_XY settings*)
		XZ : McMSCSCNCCXZType; (*Type mcMSCSCNCC_XZ settings*)
		YZ : McMSCSCNCCYZType; (*Type mcMSCSCNCC_YZ settings*)
	END_STRUCT;
	McMSCSCNOCEnum :
		( (*Orientation coordinates selector setting*)
		mcMSCSCNOC_NOT_USE := 0, (*Not used - Not used*)
		mcMSCSCNOC_ANGLES := 1 (*Angles - Angles*)
		);
	McMSCSCNOCAnglesCoorType : STRUCT
		Name : STRING[250]; (*Name of coordinate*)
	END_STRUCT;
	McMSCSCNOCAnglesType : STRUCT (*Type mcMSCSCNOC_ANGLES settings*)
		Coordinate : McCfgUnboundedArrayType;
	END_STRUCT;
	McMSCSCNOCType : STRUCT (*Orientation coordinates*)
		Type : McMSCSCNOCEnum; (*Orientation coordinates selector setting*)
		Angles : McMSCSCNOCAnglesType; (*Type mcMSCSCNOC_ANGLES settings*)
	END_STRUCT;
	McMSCSCoorNameType : STRUCT (*Coordinate names*)
		CartesianCoordinates : McMSCSCNCCType; (*Cartesian coordinates*)
		OrientationCoordinates : McMSCSCNOCType; (*Orientation coordinates*)
	END_STRUCT;
	McMSCSWFrmMdlType : STRUCT (*Wire frame model*)
		Description : STRING[250]; (*Name of the process variable for the description of the wire frame model*)
	END_STRUCT;
	McMSCSFunTrfEnum :
		( (*Transformations selector setting*)
		mcMSCSFT_STD := 0 (*Standard - Standard transformation functions*)
		);
	McMSCSFunTrfStdDerType : STRUCT (*Functions for derivatives*)
		DirectDerivative : STRING[250]; (*Direct transformation for the first derivatives*)
		InverseDerivative : STRING[250]; (*Inverse transformation for the first derivatives*)
	END_STRUCT;
	McMSCSFunTrfStdType : STRUCT (*Type mcMSCSFT_STD settings*)
		Direct : STRING[250]; (*Direct transformation*)
		Inverse : STRING[250]; (*Inverse transformation*)
		Derivatives : McMSCSFunTrfStdDerType; (*Functions for derivatives*)
	END_STRUCT;
	McMSCSFunTrfType : STRUCT (*Transformation functions*)
		Type : McMSCSFunTrfEnum; (*Transformations selector setting*)
		Standard : McMSCSFunTrfStdType; (*Type mcMSCSFT_STD settings*)
	END_STRUCT;
	McMSCSFunWsMonType : STRUCT (*Functions for workspace monitoring*)
		WireFrameModel : STRING[250]; (*Name of the function for wire frame model calculation*)
	END_STRUCT;
	McMSCSFunType : STRUCT (*Functions*)
		Transformations : McMSCSFunTrfType; (*Transformation functions*)
		WorkspaceMonitoring : McMSCSFunWsMonType; (*Functions for workspace monitoring*)
	END_STRUCT;
	McMSCplgCLinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : UINT; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : UINT; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMSCSCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJntAxPosLimEnum :
		( (*Joint axis 1-15 selector setting*)
		mcMSJAPL_USE_AX_LIM := 0, (*Use axis limits - Use position limits already configured for the single axes*)
		mcMSJAPL_CFG_JNT_AX_LIM := 1 (*Configure joint axes limits - Configure position limits*)
		);
	McMSJntAxPosLimCfgJntAxLimType : STRUCT (*Type mcMSJAPL_CFG_JNT_AX_LIM settings*)
		LowerLimit : LREAL; (*Lower position limit [measurement units]*)
		UpperLimit : LREAL; (*Upper position limit [measurement units]*)
	END_STRUCT;
	McMSJntAxPosLimType : STRUCT (*Limits for joint axis*)
		Type : McMSJntAxPosLimEnum; (*Joint axis 1-15 selector setting*)
		ConfigureJointAxesLimits : McMSJntAxPosLimCfgJntAxLimType; (*Type mcMSJAPL_CFG_JNT_AX_LIM settings*)
	END_STRUCT;
	McMSJnt15AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..14] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMSCusStdType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_CUS_STD*)
		Description : McMSCSDescType; (*Description of the mechanical system*)
		JointAxes : McMSCSJntAxType; (*Joint axes*)
		CoordinateNames : McMSCSCoorNameType; (*Coordinate names*)
		WireFrameModel : McMSCSWFrmMdlType; (*Wire frame model*)
		Functions : McMSCSFunType; (*Functions*)
		Couplings : McMSCSCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt15AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMSCNEnum :
		( (*Coordinates names selector setting*)
		mcMSCN_DEF := 0, (*Default*)
		mcMSCN_USR := 1 (*User*)
		);
	McMS2ACXYCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
	END_STRUCT;
	McMS2ACXYCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS2ACXYCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS2ACXYWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS2ACXYWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMSFrmMdlStdEdgeEnum :
		( (*Flange to TCP selector setting*)
		mcMSFMSE_CXN_LIN := 0, (*Connection line - Edge is considered as a whole connection line*)
		mcMSFMSE_PT := 1, (*Point - Only the end point of the edge is considered*)
		mcMSFMSE_NOT_USE := 2 (*Not used - Edge is not considered*)
		);
	McMSFrmMdlStdEdgeCxnLinType : STRUCT (*Type mcMSFMSE_CXN_LIN settings*)
		Distance : LREAL; (*Edge distance to prevent collisions [measurement units]*)
	END_STRUCT;
	McMSFrmMdlStdEdgePtType : STRUCT (*Type mcMSFMSE_PT settings*)
		Distance : LREAL; (*Edge distance to prevent collisions [measurement units]*)
	END_STRUCT;
	McMSFrmMdlStdEdgeType : STRUCT (*Wire frame model edge*)
		Type : McMSFrmMdlStdEdgeEnum; (*Flange to TCP selector setting*)
		ConnectionLine : McMSFrmMdlStdEdgeCxnLinType; (*Type mcMSFMSE_CXN_LIN settings*)
		Point : McMSFrmMdlStdEdgePtType; (*Type mcMSFMSE_PT settings*)
	END_STRUCT;
	McMS2ACXYWFrmMdlStdType : STRUCT (*Type mcMS2ACXYWFM_STD settings*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS2ACXYWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS2ACXYWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS2ACXYWFrmMdlStdType; (*Type mcMS2ACXYWFM_STD settings*)
	END_STRUCT;
	McMSCplg2LinCplgSrcAxEnum :
		( (*Index of the axis which influences the joint axis*)
		mcMSC2LCSA_AX_1 := 0, (*Axis 1 - Axis 1*)
		mcMSC2LCSA_AX_2 := 1 (*Axis 2 - Axis 2*)
		);
	McMSCplg2LinCplgTgtJntAxEnum :
		( (*Index of the joint axis which is influenced*)
		mcMSC2LCTJA_JNT_AX_1 := 0, (*Joint axis 1 - Joint axis 1*)
		mcMSC2LCTJA_JNT_AX_2 := 1 (*Joint axis 2 - Joint axis 2*)
		);
	McMSCplg2LinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : McMSCplg2LinCplgSrcAxEnum; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : McMSCplg2LinCplgTgtJntAxEnum; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMS2ACXYCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJnt2AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..1] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMS2AxCncXYType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_2AX_CNC_XY*)
		CoordinatesNames : McMS2ACXYCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS2ACXYWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS2ACXYCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt2AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS2ACXZCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS2ACXZCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS2ACXZCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS2ACXZWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS2ACXZWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS2ACXZWFrmMdlStdType : STRUCT (*Type mcMS2ACXZWFM_STD settings*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS2ACXZWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS2ACXZWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS2ACXZWFrmMdlStdType; (*Type mcMS2ACXZWFM_STD settings*)
	END_STRUCT;
	McMS2ACXZCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS2AxCncXZType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_2AX_CNC_XZ*)
		CoordinatesNames : McMS2ACXZCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS2ACXZWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS2ACXZCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt2AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS2ACYZCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS2ACYZCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS2ACYZCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS2ACYZWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS2ACYZWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS2ACYZWFrmMdlStdType : STRUCT (*Type mcMS2ACYZWFM_STD settings*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS2ACYZWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS2ACYZWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS2ACYZWFrmMdlStdType; (*Type mcMS2ACYZWFM_STD settings*)
	END_STRUCT;
	McMS2ACYZCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS2AxCncYZType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_2AX_CNC_YZ*)
		CoordinatesNames : McMS2ACYZCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS2ACYZWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS2ACYZCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt2AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ACXYZCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS3ACXYZCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ACXYZCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ACXYZWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ACXYZWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ACXYZWFrmMdlStdType : STRUCT (*Type mcMS3ACXYZWFM_STD settings*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ACXYZWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ACXYZWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ACXYZWFrmMdlStdType; (*Type mcMS3ACXYZWFM_STD settings*)
	END_STRUCT;
	McMSCplg3LinCplgSrcAxEnum :
		( (*Index of the axis which influences the joint axis*)
		mcMSC3LCSA_AX_1 := 0, (*Axis 1 - Axis 1*)
		mcMSC3LCSA_AX_2 := 1, (*Axis 2 - Axis 2*)
		mcMSC3LCSA_AX_3 := 2 (*Axis 3 - Axis 3*)
		);
	McMSCplg3LinCplgTgtJntAxEnum :
		( (*Index of the joint axis which is influenced*)
		mcMSC3LCTJA_JNT_AX_1 := 0, (*Joint axis 1 - Joint axis 1*)
		mcMSC3LCTJA_JNT_AX_2 := 1, (*Joint axis 2 - Joint axis 2*)
		mcMSC3LCTJA_JNT_AX_3 := 2 (*Joint axis 3 - Joint axis 3*)
		);
	McMSCplg3LinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : McMSCplg3LinCplgSrcAxEnum; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : McMSCplg3LinCplgTgtJntAxEnum; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMS3ACXYZCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJnt3AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..2] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMS3AxCncXYZType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_CNC_XYZ*)
		CoordinatesNames : McMS3ACXYZCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS3ACXYZWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS3ACXYZCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ACXZCDescEnum :
		( (*Description selector setting*)
		mcMS3ACXZCD_STD := 0 (*Standard - Standard description*)
		);
	McMS3ACXZCDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQX : McCfgTransXType; (*Translation from base to QX*)
		TranslationFromQXToQZ : McCfgTransZType; (*Translation from QX to QZ*)
		TranslationFromQZToQC : McCfgTransXYZType; (*Translation from QZ to QC*)
		TranslationFromQCToFlange : McCfgTransXYZType; (*Translation from QC to flange*)
	END_STRUCT;
	McMSMdl3ZeroPosOffType : STRUCT (*Offsets between desired and internal zero position*)
		JointAxis : ARRAY[0..2] OF LREAL; (*Offset for joint axis [measurement units]*)
	END_STRUCT;
	McMSMdl3CntDirJntAxEnum :
		( (*Count direction for joint axis*)
		mcMSM3CDJA_STD := 0, (*Standard - Equal to the mechanical system definition*)
		mcMSM3CDJA_INV := 1 (*Inverse - Inverse to the mechanical system definition*)
		);
	McMSMdl3CntDirType : STRUCT (*Count direction for joint axes relative to the internal model*)
		JointAxis : ARRAY[0..2] OF McMSMdl3CntDirJntAxEnum; (*Count direction for joint axis*)
	END_STRUCT;
	McMS3ACXZCDSType : STRUCT (*Type mcMS3ACXZCD_STD settings*)
		Dimensions : McMS3ACXZCDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ACXZCDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ACXZCDescEnum; (*Description selector setting*)
		Standard : McMS3ACXZCDSType; (*Type mcMS3ACXZCD_STD settings*)
	END_STRUCT;
	McMS3ACXZCCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS3ACXZCCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ACXZCCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ACXZCWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ACXZCWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ACXZCWFrmMdlStdType : STRUCT (*Type mcMS3ACXZCWFM_STD settings*)
		QZToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ACXZCWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ACXZCWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ACXZCWFrmMdlStdType; (*Type mcMS3ACXZCWFM_STD settings*)
	END_STRUCT;
	McMS3ACXZCCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxCncXZCType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_CNC_XZC*)
		Description : McMS3ACXZCDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ACXZCCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS3ACXZCWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS3ACXZCCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ACXZBDescEnum :
		( (*Description selector setting*)
		mcMS3ACXZBD_STD := 0 (*Standard - Standard description*)
		);
	McMS3ACXZBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQX : McCfgTransXType; (*Translation from base to QX*)
		TranslationFromQXToQZ : McCfgTransZType; (*Translation from QX to QZ*)
		TranslationFromQZToQB : McCfgTransXZType; (*Translation from QZ to QB*)
		TranslationFromQBToFlange : McCfgTransXZType; (*Translation from QB to flange*)
	END_STRUCT;
	McMS3ACXZBDSType : STRUCT (*Type mcMS3ACXZBD_STD settings*)
		Dimensions : McMS3ACXZBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ACXZBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ACXZBDescEnum; (*Description selector setting*)
		Standard : McMS3ACXZBDSType; (*Type mcMS3ACXZBD_STD settings*)
	END_STRUCT;
	McMS3ACXZBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
	END_STRUCT;
	McMS3ACXZBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ACXZBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMSTCPOFrmEnum :
		( (*Frames selector setting*)
		mcMSTCPOF_USE := 0, (*Used - Orientation of frames influences TCP orientation coordinates*)
		mcMSTCPOF_NOT_USE := 1 (*Not used - Orientation of frames does not have influence on TCP orientation coordinates*)
		);
	McMSTCPOFrmType : STRUCT (*Influence of frames on TCP orientation coordinates*)
		Type : McMSTCPOFrmEnum; (*Frames selector setting*)
	END_STRUCT;
	McMSTCPOType : STRUCT (*Handling of TCP orientation coordinates*)
		Frames : McMSTCPOFrmType; (*Influence of frames on TCP orientation coordinates*)
	END_STRUCT;
	McMS3ACXZBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ACXZBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ACXZBWFrmMdlStdType : STRUCT (*Type mcMS3ACXZBWFM_STD settings*)
		QZToQB : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QBToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ACXZBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ACXZBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ACXZBWFrmMdlStdType; (*Type mcMS3ACXZBWFM_STD settings*)
	END_STRUCT;
	McMS3ACXZBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxCncXZBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_CNC_XZB*)
		Description : McMS3ACXZBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ACXZBCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS3ACXZBWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS3ACXZBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ACXYZBDescEnum :
		( (*Description selector setting*)
		mcMS4ACXYZBD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ACXYZBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQX : McCfgTransXType; (*Translation from base of the mechanical system to QX*)
		TranslationFromQXToQY : McCfgTransYType; (*Translation from QX to QY*)
		TranslationFromQYToQZ : McCfgTransZType; (*Translation from QY to QZ*)
		TranslationFromQZToQB : McCfgTransXYZType; (*Translation from QZ to QB*)
		TranslationFromQBToFlange : McCfgTransXYZType; (*Translation from QB to flange*)
	END_STRUCT;
	McMSMdl4ZeroPosOffType : STRUCT (*Offsets between desired and internal zero position*)
		JointAxis : ARRAY[0..3] OF LREAL; (*Offset for joint axis [measurement units]*)
	END_STRUCT;
	McMSMdl4CntDirJntAxEnum :
		( (*Count direction for joint axis*)
		mcMSM4CDJA_STD := 0, (*Standard - Equal to the mechanical system definition*)
		mcMSM4CDJA_INV := 1 (*Inverse - Inverse to the mechanical system definition*)
		);
	McMSMdl4CntDirType : STRUCT (*Count direction for joint axes relative to the internal model*)
		JointAxis : ARRAY[0..3] OF McMSMdl4CntDirJntAxEnum; (*Count direction for joint axis*)
	END_STRUCT;
	McMS4ACXYZBDSType : STRUCT (*Type mcMS4ACXYZBD_STD settings*)
		Dimensions : McMS4ACXYZBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ACXYZBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ACXYZBDescEnum; (*Description selector setting*)
		Standard : McMS4ACXYZBDSType; (*Type mcMS4ACXYZBD_STD settings*)
	END_STRUCT;
	McMS4ACXYZBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
	END_STRUCT;
	McMS4ACXYZBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ACXYZBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ACXYZBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ACXYZBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ACXYZBWFrmMdlStdType : STRUCT (*Type mcMS4ACXYZBWFM_STD settings*)
		QZToQB : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QBToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ACXYZBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ACXYZBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ACXYZBWFrmMdlStdType; (*Type mcMS4ACXYZBWFM_STD settings*)
	END_STRUCT;
	McMSCplg4LinCplgSrcAxEnum :
		( (*Index of the axis which influences the joint axis*)
		mcMSC4LCSA_AX_1 := 0, (*Axis 1 - Axis 1*)
		mcMSC4LCSA_AX_2 := 1, (*Axis 2 - Axis 2*)
		mcMSC4LCSA_AX_3 := 2, (*Axis 3 - Axis 3*)
		mcMSC4LCSA_AX_4 := 3 (*Axis 4 - Axis 4*)
		);
	McMSCplg4LinCplgTgtJntAxEnum :
		( (*Index of the joint axis which is influenced*)
		mcMSC4LCTJA_JNT_AX_1 := 0, (*Joint axis 1 - Joint axis 1*)
		mcMSC4LCTJA_JNT_AX_2 := 1, (*Joint axis 2 - Joint axis 2*)
		mcMSC4LCTJA_JNT_AX_3 := 2, (*Joint axis 3 - Joint axis 3*)
		mcMSC4LCTJA_JNT_AX_4 := 3 (*Joint axis 4 - Joint axis 4*)
		);
	McMSCplg4LinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : McMSCplg4LinCplgSrcAxEnum; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : McMSCplg4LinCplgTgtJntAxEnum; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMS4ACXYZBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJnt4AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..3] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMS4AxCncXYZBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_CNC_XYZB*)
		Description : McMS4ACXYZBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ACXYZBCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ACXYZBWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS4ACXYZBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ACXYZCDescEnum :
		( (*Description selector setting*)
		mcMS4ACXYZCD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ACXYZCDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQX : McCfgTransXType; (*Translation from base of the mechanical system to QX*)
		TranslationFromQXToQY : McCfgTransYType; (*Translation from QX to QY*)
		TranslationFromQYToQZ : McCfgTransZType; (*Translation from QY to QZ*)
		TranslationFromQZToQC : McCfgTransXYZType; (*Translation from QZ to QC*)
		TranslationFromQCToFlange : McCfgTransXYZType; (*Translation from QC to flange*)
	END_STRUCT;
	McMS4ACXYZCDSType : STRUCT (*Type mcMS4ACXYZCD_STD settings*)
		Dimensions : McMS4ACXYZCDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ACXYZCDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ACXYZCDescEnum; (*Description selector setting*)
		Standard : McMS4ACXYZCDSType; (*Type mcMS4ACXYZCD_STD settings*)
	END_STRUCT;
	McMS4ACXYZCCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ACXYZCCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ACXYZCCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ACXYZCWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ACXYZCWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ACXYZCWFrmMdlStdType : STRUCT (*Type mcMS4ACXYZCWFM_STD settings*)
		QZToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ACXYZCWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ACXYZCWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ACXYZCWFrmMdlStdType; (*Type mcMS4ACXYZCWFM_STD settings*)
	END_STRUCT;
	McMS4ACXYZCCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS4AxCncXYZCType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_CNC_XYZC*)
		Description : McMS4ACXYZCDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ACXYZCCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ACXYZCWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS4ACXYZCCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS5ACXYZCADescEnum :
		( (*Description selector setting*)
		mcMS5ACXYZCAD_STD := 0 (*Standard - Standard description*)
		);
	McMS5ACXYZCADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQX : McCfgTransXType; (*Translation from base of the mechanical system to QX*)
		TranslationFromQXToQY : McCfgTransYType; (*Translation from QX to QY*)
		TranslationFromQYToQZ : McCfgTransZType; (*Translation from QY to QZ*)
		TranslationFromQZToQC : McCfgTransXYZType; (*Translation from QZ to QC*)
		TranslationFromQCToQA : McCfgTransXYZType; (*Translation from QC to QA*)
		TranslationFromQAToFlange : McCfgTransXYZType; (*Translation from QA to flange*)
	END_STRUCT;
	McMSMdl5ZeroPosOffType : STRUCT (*Offsets between desired and internal zero position*)
		JointAxis : ARRAY[0..4] OF LREAL; (*Offset for joint axis [measurement units]*)
	END_STRUCT;
	McMSMdl5CntDirJntAxEnum :
		( (*Count direction for joint axis*)
		mcMSM5CDJA_STD := 0, (*Standard - Equal to the mechanical system definition*)
		mcMSM5CDJA_INV := 1 (*Inverse - Inverse to the mechanical system definition*)
		);
	McMSMdl5CntDirType : STRUCT (*Count direction for joint axes relative to the internal model*)
		JointAxis : ARRAY[0..4] OF McMSMdl5CntDirJntAxEnum; (*Count direction for joint axis*)
	END_STRUCT;
	McMS5ACXYZCADSType : STRUCT (*Type mcMS5ACXYZCAD_STD settings*)
		Dimensions : McMS5ACXYZCADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl5ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl5CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS5ACXYZCADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS5ACXYZCADescEnum; (*Description selector setting*)
		Standard : McMS5ACXYZCADSType; (*Type mcMS5ACXYZCAD_STD settings*)
	END_STRUCT;
	McMS5ACXYZCACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
	END_STRUCT;
	McMS5ACXYZCACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS5ACXYZCACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS5ACXYZCAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS5ACXYZCAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS5ACXYZCAWFrmMdlStdType : STRUCT (*Type mcMS5ACXYZCAWFM_STD settings*)
		QZToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToQA : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QAToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS5ACXYZCAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS5ACXYZCAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS5ACXYZCAWFrmMdlStdType; (*Type mcMS5ACXYZCAWFM_STD settings*)
	END_STRUCT;
	McMSCplg5LinCplgSrcAxEnum :
		( (*Index of the axis which influences the joint axis*)
		mcMSC5LCSA_AX_1 := 0, (*Axis 1 - Axis 1*)
		mcMSC5LCSA_AX_2 := 1, (*Axis 2 - Axis 2*)
		mcMSC5LCSA_AX_3 := 2, (*Axis 3 - Axis 3*)
		mcMSC5LCSA_AX_4 := 3, (*Axis 4 - Axis 4*)
		mcMSC5LCSA_AX_5 := 4 (*Axis 5 - Axis 5*)
		);
	McMSCplg5LinCplgTgtJntAxEnum :
		( (*Index of the joint axis which is influenced*)
		mcMSC5LCTJA_JNT_AX_1 := 0, (*Joint axis 1 - Joint axis 1*)
		mcMSC5LCTJA_JNT_AX_2 := 1, (*Joint axis 2 - Joint axis 2*)
		mcMSC5LCTJA_JNT_AX_3 := 2, (*Joint axis 3 - Joint axis 3*)
		mcMSC5LCTJA_JNT_AX_4 := 3, (*Joint axis 4 - Joint axis 4*)
		mcMSC5LCTJA_JNT_AX_5 := 4 (*Joint axis 5 - Joint axis 5*)
		);
	McMSCplg5LinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : McMSCplg5LinCplgSrcAxEnum; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : McMSCplg5LinCplgTgtJntAxEnum; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMS5ACXYZCACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJnt5AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..4] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMS5AxCncXYZCAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_5AX_CNC_XYZCA*)
		Description : McMS5ACXYZCADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS5ACXYZCACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS5ACXYZCAWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS5ACXYZCACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt5AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS6ACZXYBCADescEnum :
		( (*Description selector setting*)
		mcMS6ACZXYBCAD_STD := 0 (*Standard - Standard description*)
		);
	McMS6ACZXYBCADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQZ : McCfgTransZType; (*Translation from base of the mechanical system to QZ*)
		TranslationFromQZToQX : McCfgTransXType; (*Translation from QZ to QX*)
		TranslationFromQXToQY : McCfgTransYType; (*Translation from QX to QY*)
		TranslationFromQYToQB : McCfgTransXYZType; (*Translation from QY to QB*)
		TranslationFromQBToQC : McCfgTransXYZType; (*Translation from QB to QC*)
		TranslationFromQCToQA : McCfgTransXYZType; (*Translation from QC to QA*)
		TranslationFromQAToFlange : McCfgTransXYZType; (*Translation from QA to flange*)
	END_STRUCT;
	McMSMdl6ZeroPosOffType : STRUCT (*Offsets between desired and internal zero position*)
		JointAxis : ARRAY[0..5] OF LREAL; (*Offset for joint axis [measurement units]*)
	END_STRUCT;
	McMSMdl6CntDirJntAxEnum :
		( (*Count direction for joint axis*)
		mcMSM6CDJA_STD := 0, (*Standard - Equal to the mechanical system definition*)
		mcMSM6CDJA_INV := 1 (*Inverse - Inverse to the mechanical system definition*)
		);
	McMSMdl6CntDirType : STRUCT (*Count direction for joint axes relative to the internal model*)
		JointAxis : ARRAY[0..5] OF McMSMdl6CntDirJntAxEnum; (*Count direction for joint axis*)
	END_STRUCT;
	McMS6ACZXYBCADSType : STRUCT (*Type mcMS6ACZXYBCAD_STD settings*)
		Dimensions : McMS6ACZXYBCADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl6ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl6CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS6ACZXYBCADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS6ACZXYBCADescEnum; (*Description selector setting*)
		Standard : McMS6ACZXYBCADSType; (*Type mcMS6ACZXYBCAD_STD settings*)
	END_STRUCT;
	McMS6ACZXYBCACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS6ACZXYBCACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS6ACZXYBCACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS6ACZXYBCAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS6ACZXYBCAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS6ACZXYBCAWFrmMdlStdType : STRUCT (*Type mcMS6ACZXYBCAWFM_STD settings*)
		QYToQB : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QBToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToQA : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QAToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS6ACZXYBCAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS6ACZXYBCAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS6ACZXYBCAWFrmMdlStdType; (*Type mcMS6ACZXYBCAWFM_STD settings*)
	END_STRUCT;
	McMSCplg6LinCplgSrcAxEnum :
		( (*Index of the axis which influences the joint axis*)
		mcMSC6LCSA_AX_1 := 0, (*Axis 1 - Axis 1*)
		mcMSC6LCSA_AX_2 := 1, (*Axis 2 - Axis 2*)
		mcMSC6LCSA_AX_3 := 2, (*Axis 3 - Axis 3*)
		mcMSC6LCSA_AX_4 := 3, (*Axis 4 - Axis 4*)
		mcMSC6LCSA_AX_5 := 4, (*Axis 5 - Axis 5*)
		mcMSC6LCSA_AX_6 := 5 (*Axis 6 - Axis 6*)
		);
	McMSCplg6LinCplgTgtJntAxEnum :
		( (*Index of the joint axis which is influenced*)
		mcMSC6LCTJA_JNT_AX_1 := 0, (*Joint axis 1 - Joint axis 1*)
		mcMSC6LCTJA_JNT_AX_2 := 1, (*Joint axis 2 - Joint axis 2*)
		mcMSC6LCTJA_JNT_AX_3 := 2, (*Joint axis 3 - Joint axis 3*)
		mcMSC6LCTJA_JNT_AX_4 := 3, (*Joint axis 4 - Joint axis 4*)
		mcMSC6LCTJA_JNT_AX_5 := 4, (*Joint axis 5 - Joint axis 5*)
		mcMSC6LCTJA_JNT_AX_6 := 5 (*Joint axis 6 - Joint axis 6*)
		);
	McMSCplg6LinCplgType : STRUCT (*Linear coupling*)
		SourceAxis : McMSCplg6LinCplgSrcAxEnum; (*Index of the axis which influences the joint axis*)
		SourceAxisUnits : LREAL; (*Units of the axis which influences the joint axis [measurement units]*)
		TargetJointAxis : McMSCplg6LinCplgTgtJntAxEnum; (*Index of the joint axis which is influenced*)
		TargetJointAxisUnits : LREAL; (*Units of the joint axis due to influence [measurement units]*)
	END_STRUCT;
	McMS6ACZXYBCACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSJnt6AxPosLimType : STRUCT (*Position limits for joint axis*)
		JointAxis : ARRAY[0..5] OF McMSJntAxPosLimType; (*Limits for joint axis*)
	END_STRUCT;
	McCfgMS6AxCncZXYBCAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_6AX_CNC_ZXYBCA*)
		Description : McMS6ACZXYBCADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS6ACZXYBCACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS6ACZXYBCAWFrmMdlType; (*Wire frame model of mechanical system*)
		Couplings : McMS6ACZXYBCACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt6AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ASADescEnum :
		( (*Description selector setting*)
		mcMS4ASAD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ASADSDimTransFromQ1ToQ2Type : STRUCT (*Translation from Q1 to Q2*)
		XY : LREAL; (*Distance in the plane XY [measurement units]*)
		Z : LREAL; (*Translation in Z direction [measurement units]*)
	END_STRUCT;
	McMS4ASADSDimTransFromQ2ToQZType : STRUCT (*Translation from Q2 to QZ*)
		XY : LREAL; (*Distance in the plane XY [measurement units]*)
		Z : LREAL; (*Translation in Z direction [measurement units]*)
	END_STRUCT;
	McMS4ASADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McMS4ASADSDimTransFromQ1ToQ2Type; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQZ : McMS4ASADSDimTransFromQ2ToQZType; (*Translation from Q2 to QZ*)
		TranslationFromQZToQC : McCfgTransZType; (*Translation from QZ to QC*)
		TranslationFromQCToFlange : McCfgTransXYZType; (*Translation from QC to flange*)
	END_STRUCT;
	McMS4ASADSType : STRUCT (*Type mcMS4ASAD_STD settings*)
		Dimensions : McMS4ASADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ASADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ASADescEnum; (*Description selector setting*)
		Standard : McMS4ASADSType; (*Type mcMS4ASAD_STD settings*)
	END_STRUCT;
	McMS4ASACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ASACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ASACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ASAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ASAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ASAWFrmMdlStdType : STRUCT (*Type mcMS4ASAWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQZ : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QZToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ASAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ASAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ASAWFrmMdlStdType; (*Type mcMS4ASAWFM_STD settings*)
	END_STRUCT;
	McMSDynMdlEnum :
		( (*Dynamic model selector setting*)
		mcMSDM_DYNPARTABLE := 0 (*DynParTable - Table definition of dynamic model parameters*)
		);
	McMSDynMdlDynParTableType : STRUCT (*Type mcMSDM_DYNPARTABLE settings*)
		TableReference : McCfgReferenceType; (*Name of the table reference*)
	END_STRUCT;
	McMSDynMdlType : STRUCT (*Dynamic model of the mechanical system*)
		Type : McMSDynMdlEnum; (*Dynamic model selector setting*)
		DynParTable : McMSDynMdlDynParTableType; (*Type mcMSDM_DYNPARTABLE settings*)
	END_STRUCT;
	McMS4ASACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMS4ASAMonPtEnum :
		( (*Monitoring points selector setting*)
		mcMS4ASAMP_NOT_USE := 0, (*Not used - Monitoring points not used*)
		mcMS4ASAMP_STD := 1 (*Standard - Monitoring points used*)
		);
	McMS4ASAMonPtType : STRUCT (*Enable robot monitoring points*)
		Type : McMS4ASAMonPtEnum; (*Monitoring points selector setting*)
	END_STRUCT;
	McCfgMS4AxScaraAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_SCARA_A*)
		Description : McMS4ASADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ASACoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ASAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS4ASACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
		MonitoringPoints : McMS4ASAMonPtType; (*Enable robot monitoring points*)
	END_STRUCT;
	McMS2ADADescEnum :
		( (*Description selector setting*)
		mcMS2ADAD_STD := 0 (*Standard - Standard description*)
		);
	McMS2ADADSDBPltArmLinkPtType : STRUCT (*Geometrical resource to define the position of a joint*)
		X : LREAL; (*X-offset from the center [measurement units]*)
		Z : LREAL; (*Z-offset from the center [measurement units]*)
	END_STRUCT;
	McMS2ADADSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..1] OF McMS2ADADSDBPltArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMSDeltaDSDArmType : STRUCT (*Serial kinematic chain connecting base platform and end-effector platform*)
		UpperArmLength : LREAL; (*Length of the upper arm [measurement units]*)
		LowerArmLength : LREAL; (*Length of the lower arm [measurement units]*)
	END_STRUCT;
	McMS2ADADSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..1] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS2ADADSDEEPltArmLinkPtType : STRUCT (*Point where the arm is linked to the end-effector platform*)
		X : LREAL; (*X-offset from the center of the end-effector platform [measurement units]*)
		Z : LREAL; (*Z-offset from the center of the end-effector platform [measurement units]*)
	END_STRUCT;
	McMS2ADADSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..1] OF McMS2ADADSDEEPltArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS2ADADSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS2ADADSDBPltType; (*Fixed platform*)
		Arms : McMS2ADADSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS2ADADSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMSMdl2ZeroPosOffType : STRUCT (*Offsets between desired and internal zero position*)
		JointAxis : ARRAY[0..1] OF LREAL; (*Offset for joint axis [measurement units]*)
	END_STRUCT;
	McMSMdl2CntDirJntAxEnum :
		( (*Count direction for joint axis*)
		mcMSM2CDJA_STD := 0, (*Standard - Equal to the mechanical system definition*)
		mcMSM2CDJA_INV := 1 (*Inverse - Inverse to the mechanical system definition*)
		);
	McMSMdl2CntDirType : STRUCT (*Count direction for joint axes relative to the internal model*)
		JointAxis : ARRAY[0..1] OF McMSMdl2CntDirJntAxEnum; (*Count direction for joint axis*)
	END_STRUCT;
	McMS2ADADSType : STRUCT (*Type mcMS2ADAD_STD settings*)
		Dimensions : McMS2ADADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl2ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl2CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS2ADADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS2ADADescEnum; (*Description selector setting*)
		Standard : McMS2ADADSType; (*Type mcMS2ADAD_STD settings*)
	END_STRUCT;
	McMS2ADACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS2ADACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS2ADACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS2ADAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS2ADAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS2ADAWFrmMdlStdType : STRUCT (*Type mcMS2ADAWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS2ADAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS2ADAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS2ADAWFrmMdlStdType; (*Type mcMS2ADAWFM_STD settings*)
	END_STRUCT;
	McMS2ADACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS2AxDeltaAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_2AX_DELTA_A*)
		Description : McMS2ADADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS2ADACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS2ADAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS2ADACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt2AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ADADescEnum :
		( (*Description selector setting*)
		mcMS3ADAD_STD := 0 (*Standard - Standard description*)
		);
	McMSDeltaDSDBPArmLinkPtType : STRUCT (*Geometrical resource to define the position of a joint*)
		Angle : LREAL; (*Angular distance from the center (starting from zero) [measurement units]*)
		Radius : LREAL; (*Distance from the center [measurement units]*)
		Z : LREAL; (*Z-offset from the center [measurement units]*)
	END_STRUCT;
	McMS3ADADSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS3ADADSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMSDeltaDSDEEPArmLinkPtType : STRUCT (*Point where the arm is linked to the end-effector platform*)
		Radius : LREAL; (*Distance from the center of the end-effector platform [measurement units]*)
		Z : LREAL; (*Z-offset from the center of the end-effector platform [measurement units]*)
	END_STRUCT;
	McMS3ADADSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXYZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS3ADADSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS3ADADSDBPltType; (*Fixed platform*)
		Arms : McMS3ADADSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS3ADADSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMS3ADADSType : STRUCT (*Type mcMS3ADAD_STD settings*)
		Dimensions : McMS3ADADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ADADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ADADescEnum; (*Description selector setting*)
		Standard : McMS3ADADSType; (*Type mcMS3ADAD_STD settings*)
	END_STRUCT;
	McMS3ADACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS3ADACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ADACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ADAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ADAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ADAWFrmMdlStdType : STRUCT (*Type mcMS3ADAWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ADAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ADAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ADAWFrmMdlStdType; (*Type mcMS3ADAWFM_STD settings*)
	END_STRUCT;
	McMS3ADACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxDeltaAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_DELTA_A*)
		Description : McMS3ADADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ADACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS3ADAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS3ADACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ADXZBDescEnum :
		( (*Description selector setting*)
		mcMS3ADXZBD_STD := 0 (*Standard - Standard description*)
		);
	McMS3ADXZBDSDBPltArmLinkPtType : STRUCT (*Geometrical resource to define the position of a joint*)
		X : LREAL; (*X-offset from the center [measurement units]*)
		Z : LREAL; (*Z-offset from the center [measurement units]*)
	END_STRUCT;
	McMS3ADXZBDSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..1] OF McMS3ADXZBDSDBPltArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS3ADXZBDSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..1] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS3ADXZBDSDEEPltType : STRUCT (*Moving platform*)
		TranslationToFlange : McCfgTransXZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS3ADXZBDSDPPMBrktMntArmEnum :
		( (*Specifies which arm is the passive parallel mechanism mounted to*)
		mcMS3ADXZBDSDPPMBMA_ARM_1 := 0, (*Arm 1*)
		mcMS3ADXZBDSDPPMBMA_ARM_2 := 1 (*Arm 2*)
		);
	McMS3ADXZBDSDPPMQ3ZeroPosEnum :
		( (*Q3 zero position property*)
		mcMS3ADXZBDSDPPMQZP_INNER := 0, (*Inner*)
		mcMS3ADXZBDSDPPMQZP_OUTER := 1 (*Outer*)
		);
	McMS3ADXZBDSDPPMType : STRUCT (*Description of the passive parallel mechanism between Q3 and B*)
		TranslationFromBaseToQ3 : McCfgTransXZType; (*Translation from base to Q3*)
		Q3Radius : LREAL; (*Radius of Q3 [measurement units]*)
		BracketLength : LREAL; (*Length of the upper part of the bracket [measurement units]*)
		BracketMountingArm : McMS3ADXZBDSDPPMBrktMntArmEnum; (*Specifies which arm is the passive parallel mechanism mounted to*)
		Q3ZeroPosition : McMS3ADXZBDSDPPMQ3ZeroPosEnum; (*Q3 zero position property*)
	END_STRUCT;
	McMS3ADXZBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS3ADXZBDSDBPltType; (*Fixed platform*)
		Arms : McMS3ADXZBDSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS3ADXZBDSDEEPltType; (*Moving platform*)
		PassiveParallelMechanism : McMS3ADXZBDSDPPMType; (*Description of the passive parallel mechanism between Q3 and B*)
	END_STRUCT;
	McMS3ADXZBDSType : STRUCT (*Type mcMS3ADXZBD_STD settings*)
		Dimensions : McMS3ADXZBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ADXZBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ADXZBDescEnum; (*Description selector setting*)
		Standard : McMS3ADXZBDSType; (*Type mcMS3ADXZBD_STD settings*)
	END_STRUCT;
	McMS3ADXZBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
	END_STRUCT;
	McMS3ADXZBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ADXZBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ADXZBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ADXZBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ADXZBWFrmMdlStdType : STRUCT (*Type mcMS3ADXZBWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToBracket : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		BracketToArm : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ADXZBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ADXZBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ADXZBWFrmMdlStdType; (*Type mcMS3ADXZBWFM_STD settings*)
	END_STRUCT;
	McMS3ADXZBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxDeltaXZBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_DELTA_XZB*)
		Description : McMS3ADXZBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ADXZBCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS3ADXZBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS3ADXZBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS3ADBDescEnum :
		( (*Description selector setting*)
		mcMS3ADBD_STD := 0 (*Standard - Standard description*)
		);
	McMS3ADBDSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS3ADBDSDAArmType : STRUCT (*Serial kinematic chain connecting base platform and end-effector platform*)
		ArmLength : LREAL; (*Length of the arm [measurement units]*)
		ArmOffset : LREAL; (*Offset from the arm link point [measurement units]*)
		ArmAngle : LREAL; (*Angle from the perpendicular direction (starting from zero) [measurement units]*)
	END_STRUCT;
	McMS3ADBDSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMS3ADBDSDAArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS3ADBDSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXYZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS3ADBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS3ADBDSDBPltType; (*Fixed platform*)
		Arms : McMS3ADBDSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS3ADBDSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMS3ADBDSType : STRUCT (*Type mcMS3ADBD_STD settings*)
		Dimensions : McMS3ADBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ADBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ADBDescEnum; (*Description selector setting*)
		Standard : McMS3ADBDSType; (*Type mcMS3ADBD_STD settings*)
	END_STRUCT;
	McMS3ADBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS3ADBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ADBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ADBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ADBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ADBWFrmMdlStdType : STRUCT (*Type mcMS3ADBWFM_STD settings*)
		LinkPointToArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LinkPointToArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LinkPointToArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ADBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ADBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ADBWFrmMdlStdType; (*Type mcMS3ADBWFM_STD settings*)
	END_STRUCT;
	McMS3ADBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxDeltaBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_DELTA_B*)
		Description : McMS3ADBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ADBCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS3ADBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS3ADBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ADADescEnum :
		( (*Description selector setting*)
		mcMS4ADAD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ADADSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS4ADADSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS4ADADSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXYZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS4ADADSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS4ADADSDBPltType; (*Fixed platform*)
		Arms : McMS4ADADSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS4ADADSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMS4ADADSType : STRUCT (*Type mcMS4ADAD_STD settings*)
		Dimensions : McMS4ADADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ADADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ADADescEnum; (*Description selector setting*)
		Standard : McMS4ADADSType; (*Type mcMS4ADAD_STD settings*)
	END_STRUCT;
	McMS4ADACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ADACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ADACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ADAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ADAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ADAWFrmMdlStdType : STRUCT (*Type mcMS4ADAWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ADAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ADAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ADAWFrmMdlStdType; (*Type mcMS4ADAWFM_STD settings*)
	END_STRUCT;
	McMSDynLimEnum :
		( (*Dynamic limits selector setting*)
		mcMSDL_DYNPARTABLES := 0 (*DynParTables - Table definition of dynamic model parameters*)
		);
	McMSDynLimDynParTablesType : STRUCT (*Type mcMSDL_DYNPARTABLES settings*)
		GearboxLimitsTableReference : McCfgReferenceType; (*Name of the table reference*)
		CrossSecLimTableReference : McCfgReferenceType; (*Name of the table reference*)
	END_STRUCT;
	McMSDynLimType : STRUCT (*Dynamic limits of the mechanical system*)
		Type : McMSDynLimEnum; (*Dynamic limits selector setting*)
		DynParTables : McMSDynLimDynParTablesType; (*Type mcMSDL_DYNPARTABLES settings*)
	END_STRUCT;
	McMS4ADACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMSDeltaWrkRngEnum :
		( (*Working range selector setting*)
		mcMSDWR_NOT_USE := 0, (*Not used -*)
		mcMSDWR_STD := 1 (*Standard -*)
		);
	McMSDeltaWrkRngStdType : STRUCT (*Type mcMSDWR_STD settings*)
		BaseToTop : LREAL; (*Distance from base platform center point to the top of the working range area [measurement units]*)
		TopHeight : LREAL; (*Height of the top truncated cone [measurement units]*)
		MiddleHeight : LREAL; (*Height of the middle cylindrical part [measurement units]*)
		BottomHeight : LREAL; (*Height of the bottom truncated cone [measurement units]*)
		TopRadius : LREAL; (*Radius of top truncated cone upperside [measurement units]*)
		MiddleRadius : LREAL; (*Radius of middle cylindrical part [measurement units]*)
		BottomRadius : LREAL; (*Radius of bottom truncated cone underside [measurement units]*)
	END_STRUCT;
	McMSDeltaWrkRngType : STRUCT (*Working range description related to end-effector platform center point*)
		Type : McMSDeltaWrkRngEnum; (*Working range selector setting*)
		Standard : McMSDeltaWrkRngStdType; (*Type mcMSDWR_STD settings*)
	END_STRUCT;
	McCfgMS4AxDeltaAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_DELTA_A*)
		Description : McMS4ADADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ADACoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ADAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		DynamicLimits : McMSDynLimType; (*Dynamic limits of the mechanical system*)
		Couplings : McMS4ADACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
		WorkingRange : McMSDeltaWrkRngType; (*Working range description related to end-effector platform center point*)
	END_STRUCT;
	McMS4ADBDescEnum :
		( (*Description selector setting*)
		mcMS4ADBD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ADBDSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMSDeltaDSDArmLinType : STRUCT (*Serial kinematic chain connecting base platform and end-effector platform*)
		ArmLength : LREAL; (*Length of the arm [measurement units]*)
		Z : LREAL; (*Z-offset from the arm link point [measurement units]*)
	END_STRUCT;
	McMS4ADBDSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMSDeltaDSDArmLinType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS4ADBDSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXYZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS4ADBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS4ADBDSDBPltType; (*Fixed platform*)
		Arms : McMS4ADBDSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS4ADBDSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMS4ADBDSType : STRUCT (*Type mcMS4ADBD_STD settings*)
		Dimensions : McMS4ADBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ADBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ADBDescEnum; (*Description selector setting*)
		Standard : McMS4ADBDSType; (*Type mcMS4ADBD_STD settings*)
	END_STRUCT;
	McMS4ADBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ADBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ADBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ADBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ADBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ADBWFrmMdlStdType : STRUCT (*Type mcMS4ADBWFM_STD settings*)
		LinkPointToArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LinkPointToArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LinkPointToArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Arm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ADBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ADBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ADBWFrmMdlStdType; (*Type mcMS4ADBWFM_STD settings*)
	END_STRUCT;
	McMS4ADBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS4AxDeltaBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_DELTA_B*)
		Description : McMS4ADBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ADBCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ADBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS4ADBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
		WorkingRange : McMSDeltaWrkRngType; (*Working range description related to end-effector platform center point*)
	END_STRUCT;
	McMS4ADCDescEnum :
		( (*Description selector setting*)
		mcMS4ADCD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ADCDSDBPArmLinkPtType : STRUCT (*Geometrical resource to define the position of a joint*)
		Angle : LREAL; (*Angular distance from the center (starting from zero) [measurement units]*)
		X : LREAL; (*X-offset from the center in the coordinate system rotated by Angle [measurement units]*)
		Y : LREAL; (*Y-offset from the center in the coordinate system rotated by Angle [measurement units]*)
		Z : LREAL; (*Z-offset from the center in the coordinate system rotated by Angle [measurement units]*)
	END_STRUCT;
	McMS4ADCDSDBPltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMS4ADCDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS4ADCDSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS4ADCDSDEEPArmLinkPtType : STRUCT (*Point where the arm is linked to the end-effector platform*)
		X : LREAL; (*X-offset from the center of lower platform (in coordinate system rotated by the corresponding angle of upper platform) [measurement units]*)
		Z : LREAL; (*Z-offset from the center of lower platform (in coordinate system rotated by the corresponding angle of upper platform) [measurement units]*)
	END_STRUCT;
	McMS4ADCDSDEEPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMS4ADCDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToFlange : McCfgTransXYZType; (*Translation from the center of the end-effector platform to flange*)
	END_STRUCT;
	McMS4ADCDSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS4ADCDSDBPltType; (*Fixed platform*)
		Arms : McMS4ADCDSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS4ADCDSDEEPltType; (*Moving platform*)
	END_STRUCT;
	McMS4ADCDSType : STRUCT (*Type mcMS4ADCD_STD settings*)
		Dimensions : McMS4ADCDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ADCDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ADCDescEnum; (*Description selector setting*)
		Standard : McMS4ADCDSType; (*Type mcMS4ADCD_STD settings*)
	END_STRUCT;
	McMS4ADCCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ADCCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ADCCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ADCWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ADCWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ADCWFrmMdlStdType : STRUCT (*Type mcMS4ADCWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ADCWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ADCWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ADCWFrmMdlStdType; (*Type mcMS4ADCWFM_STD settings*)
	END_STRUCT;
	McMS4ADCCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS4AxDeltaCType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_DELTA_C*)
		Description : McMS4ADCDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ADCCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ADCWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS4ADCCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
		WorkingRange : McMSDeltaWrkRngType; (*Working range description related to end-effector platform center point*)
	END_STRUCT;
	McMS5ADADescEnum :
		( (*Description selector setting*)
		mcMS5ADAD_STD := 0 (*Standard - Standard description*)
		);
	McMS5ADADSDimBasePltType : STRUCT (*Fixed platform*)
		Center : McCfgTransXYZType; (*Center of the base platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDBPArmLinkPtType; (*Geometrical resource to define the position of a joint*)
	END_STRUCT;
	McMS5ADADSDimArmType : STRUCT (*Description of arms*)
		Arm : ARRAY[0..2] OF McMSDeltaDSDArmType; (*Serial kinematic chain connecting base platform and end-effector platform*)
	END_STRUCT;
	McMS5ADADSDimEndEffPltType : STRUCT (*Moving platform*)
		ArmLinkPoint : ARRAY[0..2] OF McMSDeltaDSDEEPArmLinkPtType; (*Point where the arm is linked to the end-effector platform*)
		TranslationToQC : McCfgTransXYZType; (*Translation from the center of the end-effector platform to QC*)
		TranslationFromQCToQA : McCfgTransXYZType; (*Translation from QC to QA*)
		TranslationFromQAToFlange : McCfgTransXYZType; (*Translation from QA to flange*)
	END_STRUCT;
	McMS5ADADSDimType : STRUCT (*Dimensions of the mechanical system*)
		BasePlatform : McMS5ADADSDimBasePltType; (*Fixed platform*)
		Arms : McMS5ADADSDimArmType; (*Description of arms*)
		EndEffectorPlatform : McMS5ADADSDimEndEffPltType; (*Moving platform*)
	END_STRUCT;
	McMS5ADADSType : STRUCT (*Type mcMS5ADAD_STD settings*)
		Dimensions : McMS5ADADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl5ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl5CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS5ADADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS5ADADescEnum; (*Description selector setting*)
		Standard : McMS5ADADSType; (*Type mcMS5ADAD_STD settings*)
	END_STRUCT;
	McMS5ADACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
	END_STRUCT;
	McMS5ADACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS5ADACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS5ADAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS5ADAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS5ADAWFrmMdlStdType : STRUCT (*Type mcMS5ADAWFM_STD settings*)
		UpperArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		UpperArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		LowerArm3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		EndEffectorPlatformToQC : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QCToQA : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		QAToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS5ADAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS5ADAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS5ADAWFrmMdlStdType; (*Type mcMS5ADAWFM_STD settings*)
	END_STRUCT;
	McMS5ADACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS5AxDeltaAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_5AX_DELTA_A*)
		Description : McMS5ADADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS5ADACoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS5ADAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS5ADACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt5AxPosLimType; (*Position limits for joint axis*)
		WorkingRange : McMSDeltaWrkRngType; (*Working range description related to end-effector platform center point*)
	END_STRUCT;
	McMS3ARADescEnum :
		( (*Description selector setting*)
		mcMS3ARAD_STD := 0 (*Standard - Standard description*)
		);
	McMS3ARADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToFlange : McCfgTransXYZType; (*Translation from Q3 to flange*)
	END_STRUCT;
	McMS3ARADSType : STRUCT (*Type mcMS3ARAD_STD settings*)
		Dimensions : McMS3ARADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl3ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl3CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS3ARADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS3ARADescEnum; (*Description selector setting*)
		Standard : McMS3ARADSType; (*Type mcMS3ARAD_STD settings*)
	END_STRUCT;
	McMS3ARACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
	END_STRUCT;
	McMS3ARACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS3ARACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS3ARAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS3ARAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS3ARAWFrmMdlStdType : STRUCT (*Type mcMS3ARAWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS3ARAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS3ARAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS3ARAWFrmMdlStdType; (*Type mcMS3ARAWFM_STD settings*)
	END_STRUCT;
	McMS3ARACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS3AxRobAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_3AX_ROB_A*)
		Description : McMS3ARADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS3ARACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS3ARAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS3ARACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt3AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ARADescEnum :
		( (*Description selector setting*)
		mcMS4ARAD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ARADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToPQ1 : McCfgTransXYZType; (*Translation from Q3 to PQ1*)
		TranslationFromPQ1ToQ4 : McCfgTransXYZType; (*Translation from PQ1 to Q4*)
		TranslationFromQ4ToFlange : McCfgTransXYZType; (*Translation from Q4 to flange*)
	END_STRUCT;
	McMS4ARADSType : STRUCT (*Type mcMS4ARAD_STD settings*)
		Dimensions : McMS4ARADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl4ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl4CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS4ARADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ARADescEnum; (*Description selector setting*)
		Standard : McMS4ARADSType; (*Type mcMS4ARAD_STD settings*)
	END_STRUCT;
	McMS4ARACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ARACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ARACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ARAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ARAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ARAWFrmMdlStdType : STRUCT (*Type mcMS4ARAWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToPQ1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		PQ1ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ARAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ARAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ARAWFrmMdlStdType; (*Type mcMS4ARAWFM_STD settings*)
	END_STRUCT;
	McMS4ARACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS4AxRobAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_ROB_A*)
		Description : McMS4ARADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ARACoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ARAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS4ARACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS4ARBDescEnum :
		( (*Description selector setting*)
		mcMS4ARBD_STD := 0 (*Standard - Standard description*)
		);
	McMS4ARBDSDimQ2CylinderType : STRUCT (*Q2 cylinder*)
		TranslationFromQ1ToAnchor : McCfgTransXYZType; (*Translation from Q1 to anchor*)
		TranslationFromQ2ToActuator : McCfgTransXYZType; (*Translation from Q2 to actuator*)
	END_STRUCT;
	McMS4ARBDSDimQ3CylinderType : STRUCT (*Q3 cylinder*)
		TranslationFromQ2ToAnchor : McCfgTransXYZType; (*Translation from Q2 to anchor*)
		TranslationFromQ3ToActuator : McCfgTransXYZType; (*Translation from Q3 to actuator*)
	END_STRUCT;
	McMS4ARBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToPQ1 : McCfgTransXYZType; (*Translation from Q3 to PQ1*)
		TranslationFromPQ1ToQ4 : McCfgTransXYZType; (*Translation from PQ1 to Q4*)
		TranslationFromQ4ToFlange : McCfgTransXYZType; (*Translation from Q4 to flange*)
		Q2Cylinder : McMS4ARBDSDimQ2CylinderType; (*Q2 cylinder*)
		Q3Cylinder : McMS4ARBDSDimQ3CylinderType; (*Q3 cylinder*)
	END_STRUCT;
	McMS4ARBDSType : STRUCT (*Type mcMS4ARBD_STD settings*)
		Dimensions : McMS4ARBDSDimType; (*Dimensions of the mechanical system*)
	END_STRUCT;
	McMS4ARBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS4ARBDescEnum; (*Description selector setting*)
		Standard : McMS4ARBDSType; (*Type mcMS4ARBD_STD settings*)
	END_STRUCT;
	McMS4ARBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS4ARBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS4ARBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS4ARBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS4ARBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS4ARBWFrmMdlStdType : STRUCT (*Type mcMS4ARBWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToPQ1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		PQ1ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2AnchorToQ2Actuator : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3AnchorToQ3Actuator : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS4ARBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS4ARBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS4ARBWFrmMdlStdType; (*Type mcMS4ARBWFM_STD settings*)
	END_STRUCT;
	McCfgMS4AxRobBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_4AX_ROB_B*)
		Description : McMS4ARBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS4ARBCoorNameType; (*Coordinates names*)
		TCPOrientation : McMSTCPOType; (*Handling of TCP orientation coordinates*)
		WireFrameModel : McMS4ARBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		JointAxesPositionLimits : McMSJnt4AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS5ARADescEnum :
		( (*Description selector setting*)
		mcMS5ARAD_STD := 0 (*Standard - Standard description*)
		);
	McMS5ARADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToQ4 : McCfgTransXYZType; (*Translation from Q3 to Q4*)
		TranslationFromQ4ToQ5 : McCfgTransXYZType; (*Translation from Q4 to Q5*)
		TranslationFromQ5ToFlange : McCfgTransXYZType; (*Translation from Q5 to flange*)
	END_STRUCT;
	McMS5ARADSType : STRUCT (*Type mcMS5ARAD_STD settings*)
		Dimensions : McMS5ARADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl5ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl5CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS5ARADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS5ARADescEnum; (*Description selector setting*)
		Standard : McMS5ARADSType; (*Type mcMS5ARAD_STD settings*)
	END_STRUCT;
	McMS5ARACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS5ARACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS5ARACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS5ARAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS5ARAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS5ARAWFrmMdlStdType : STRUCT (*Type mcMS5ARAWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToQ5 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q5ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS5ARAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS5ARAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS5ARAWFrmMdlStdType; (*Type mcMS5ARAWFM_STD settings*)
	END_STRUCT;
	McMS5ARACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS5AxRobAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_5AX_ROB_A*)
		Description : McMS5ARADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS5ARACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS5ARAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS5ARACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt5AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS5ARBDescEnum :
		( (*Description selector setting*)
		mcMS5ARBD_STD := 0 (*Standard - Standard description*)
		);
	McMS5ARBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base of the mechanical system to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToQ4 : McCfgTransXYZType; (*Translation from Q3 to Q4*)
		TranslationFromQ4ToQ5 : McCfgTransXYZType; (*Translation from Q4 to Q5*)
		TranslationFromQ5ToFlange : McCfgTransXYZType; (*Translation from Q5 to flange*)
	END_STRUCT;
	McMS5ARBDSType : STRUCT (*Type mcMS5ARBD_STD settings*)
		Dimensions : McMS5ARBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl5ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl5CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS5ARBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS5ARBDescEnum; (*Description selector setting*)
		Standard : McMS5ARBDSType; (*Type mcMS5ARBD_STD settings*)
	END_STRUCT;
	McMS5ARBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS5ARBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS5ARBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS5ARBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS5ARBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS5ARBWFrmMdlStdType : STRUCT (*Type mcMS5ARBWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToQ5 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q5ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS5ARBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS5ARBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS5ARBWFrmMdlStdType; (*Type mcMS5ARBWFM_STD settings*)
	END_STRUCT;
	McMS5ARBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS5AxRobBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_5AX_ROB_B*)
		Description : McMS5ARBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS5ARBCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS5ARBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS5ARBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt5AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS6ARADescEnum :
		( (*Description selector setting*)
		mcMS6ARAD_STD := 0 (*Standard - Standard description*)
		);
	McMS6ARADSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToQ4 : McCfgTransXYZType; (*Translation from Q3 to Q4*)
		TranslationFromQ4ToQ5 : McCfgTransXType; (*Translation from Q4 to Q5*)
		TranslationFromQ5ToQ6 : McCfgTransXType; (*Translation from Q5 to Q6*)
		TranslationFromQ6ToFlange : McCfgTransXYZType; (*Translation from Q6 to flange*)
	END_STRUCT;
	McMS6ARADSType : STRUCT (*Type mcMS6ARAD_STD settings*)
		Dimensions : McMS6ARADSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl6ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl6CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS6ARADescType : STRUCT (*Description of the mechanical system*)
		Type : McMS6ARADescEnum; (*Description selector setting*)
		Standard : McMS6ARADSType; (*Type mcMS6ARAD_STD settings*)
	END_STRUCT;
	McMS6ARACoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS6ARACoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS6ARACoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS6ARAWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS6ARAWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS6ARAWFrmMdlStdType : STRUCT (*Type mcMS6ARAWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToQ5 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q5ToQ6 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q6ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS6ARAWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS6ARAWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS6ARAWFrmMdlStdType; (*Type mcMS6ARAWFM_STD settings*)
	END_STRUCT;
	McMS6ARACplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS6AxRobAType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_6AX_ROB_A*)
		Description : McMS6ARADescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS6ARACoorNameType; (*Coordinates names*)
		WireFrameModel : McMS6ARAWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		DynamicLimits : McMSDynLimType; (*Dynamic limits of the mechanical system*)
		Couplings : McMS6ARACplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt6AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS6ARBDescEnum :
		( (*Description selector setting*)
		mcMS6ARBD_STD := 0 (*Standard - Standard description*)
		);
	McMS6ARBDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToQ4 : McCfgTransXYZType; (*Translation from Q3 to Q4*)
		TranslationFromQ4ToQ5 : McCfgTransZType; (*Translation from Q4 to Q5*)
		TranslationFromQ5ToQ6 : McCfgTransZType; (*Translation from Q5 to Q6*)
		TranslationFromQ6ToFlange : McCfgTransXYZType; (*Translation from Q6 to flange*)
	END_STRUCT;
	McMS6ARBDSType : STRUCT (*Type mcMS6ARBD_STD settings*)
		Dimensions : McMS6ARBDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl6ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl6CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS6ARBDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS6ARBDescEnum; (*Description selector setting*)
		Standard : McMS6ARBDSType; (*Type mcMS6ARBD_STD settings*)
	END_STRUCT;
	McMS6ARBCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS6ARBCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS6ARBCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS6ARBWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS6ARBWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS6ARBWFrmMdlStdType : STRUCT (*Type mcMS6ARBWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToQ5 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q5ToQ6 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q6ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS6ARBWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS6ARBWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS6ARBWFrmMdlStdType; (*Type mcMS6ARBWFM_STD settings*)
	END_STRUCT;
	McMS6ARBCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McCfgMS6AxRobBType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_6AX_ROB_B*)
		Description : McMS6ARBDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS6ARBCoorNameType; (*Coordinates names*)
		WireFrameModel : McMS6ARBWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS6ARBCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt6AxPosLimType; (*Position limits for joint axis*)
	END_STRUCT;
	McMS6ARCDescEnum :
		( (*Description selector setting*)
		mcMS6ARCD_STD := 0 (*Standard - Standard description*)
		);
	McMS6ARCDSDTFQ4ToQ5Type : STRUCT (*Translation from Q4 to Q5*)
		YZ : LREAL; (*Length of the link between Q4 and Q5 [measurement units]*)
		Angle : LREAL; (*Angle of the link between Q4 and Q5 [measurement units]*)
	END_STRUCT;
	McMS6ARCDSDTFQ5ToPQ1Type : STRUCT (*Translation from Q5 to PQ1*)
		YZ : LREAL; (*Length of the link between Q5 and PQ1 [measurement units]*)
		Angle : LREAL; (*Angle of the link between Q5 and PQ1 [measurement units]*)
	END_STRUCT;
	McMS6ARCDSDimType : STRUCT (*Dimensions of the mechanical system*)
		TranslationFromBaseToQ1 : McCfgTransXYZType; (*Translation from base to Q1*)
		TranslationFromQ1ToQ2 : McCfgTransXYZType; (*Translation from Q1 to Q2*)
		TranslationFromQ2ToQ3 : McCfgTransXYZType; (*Translation from Q2 to Q3*)
		TranslationFromQ3ToQ4 : McCfgTransXYZType; (*Translation from Q3 to Q4*)
		TranslationFromQ4ToQ5 : McMS6ARCDSDTFQ4ToQ5Type; (*Translation from Q4 to Q5*)
		TranslationFromQ5ToPQ1 : McMS6ARCDSDTFQ5ToPQ1Type; (*Translation from Q5 to PQ1*)
		TranslationFromPQ1ToQ6 : McCfgTransYType; (*Translation from PQ1 to Q6*)
		TranslationFromQ6ToFlange : McCfgTransXYZType; (*Translation from Q6 to flange*)
	END_STRUCT;
	McMS6ARCDSType : STRUCT (*Type mcMS6ARCD_STD settings*)
		Dimensions : McMS6ARCDSDimType; (*Dimensions of the mechanical system*)
		ModelZeroPositionOffsets : McMSMdl6ZeroPosOffType; (*Offsets between desired and internal zero position*)
		ModelCountDirections : McMSMdl6CntDirType; (*Count direction for joint axes relative to the internal model*)
	END_STRUCT;
	McMS6ARCDescType : STRUCT (*Description of the mechanical system*)
		Type : McMS6ARCDescEnum; (*Description selector setting*)
		Standard : McMS6ARCDSType; (*Type mcMS6ARCD_STD settings*)
	END_STRUCT;
	McMS6ARCCoorNameCmnType : STRUCT (*Common settings for all Type values*)
		XCoordinateName : STRING[250]; (*X coordinate name*)
		YCoordinateName : STRING[250]; (*Y coordinate name*)
		ZCoordinateName : STRING[250]; (*Z coordinate name*)
		ACoordinateName : STRING[250]; (*A coordinate name*)
		BCoordinateName : STRING[250]; (*B coordinate name*)
		CCoordinateName : STRING[250]; (*C coordinate name*)
	END_STRUCT;
	McMS6ARCCoorNameType : STRUCT (*Coordinates names*)
		Type : McMSCNEnum; (*Coordinates names selector setting*)
		Common : McMS6ARCCoorNameCmnType; (*Common settings for all Type values*)
	END_STRUCT;
	McMS6ARCSingHndlgEnum :
		( (*Singularity handling selector setting*)
		mcMS6ARCSH_STD := 0, (*Standard - Move through singularity with high TCP precision*)
		mcMS6ARCSH_ORIENT_COMP := 1 (*Orientation compliance - TCP orientation is modified near and inside singularities*)
		);
	McMS6ARCSingHndlgOrientCompType : STRUCT (*Type mcMS6ARCSH_ORIENT_COMP settings*)
		AngleTolerance : LREAL; (*Angle tolerance for TCP orientation modifications [measurement units]*)
	END_STRUCT;
	McMS6ARCSingHndlgType : STRUCT (*Behaviour near and inside mechanical singularities*)
		Type : McMS6ARCSingHndlgEnum; (*Singularity handling selector setting*)
		OrientationCompliance : McMS6ARCSingHndlgOrientCompType; (*Type mcMS6ARCSH_ORIENT_COMP settings*)
	END_STRUCT;
	McMS6ARCWFrmMdlEnum :
		( (*Wire frame model selector setting*)
		mcMS6ARCWFM_STD := 0 (*Standard - Standard wire-frame model*)
		);
	McMS6ARCWFrmMdlStdType : STRUCT (*Type mcMS6ARCWFM_STD settings*)
		Q1ToQ2 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q2ToQ3 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q3ToP1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		P1ToQ4 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q4ToQ5 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q5ToPQ1 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		PQ1ToQ6 : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		Q6ToFlange : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
		FlangeToTCP : McMSFrmMdlStdEdgeType; (*Wire frame model edge*)
	END_STRUCT;
	McMS6ARCWFrmMdlType : STRUCT (*Wire frame model of mechanical system*)
		Type : McMS6ARCWFrmMdlEnum; (*Wire frame model selector setting*)
		Standard : McMS6ARCWFrmMdlStdType; (*Type mcMS6ARCWFM_STD settings*)
	END_STRUCT;
	McMS6ARCCplgType : STRUCT (*Couplings between selected axes and the joint axis*)
		LinearCoupling : McCfgUnboundedArrayType; (*Linear coupling*)
	END_STRUCT;
	McMS6ARCMonPtEnum :
		( (*Monitoring points selector setting*)
		mcMS6ARCMP_NOT_USE := 0, (*Not used - Monitoring points not used*)
		mcMS6ARCMP_STD := 1 (*Standard - Monitoring points used*)
		);
	McMS6ARCMonPtType : STRUCT (*Enable robot monitoring points*)
		Type : McMS6ARCMonPtEnum; (*Monitoring points selector setting*)
	END_STRUCT;
	McCfgMS6AxRobCType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_MS_6AX_ROB_C*)
		Description : McMS6ARCDescType; (*Description of the mechanical system*)
		CoordinatesNames : McMS6ARCCoorNameType; (*Coordinates names*)
		SingularityHandling : McMS6ARCSingHndlgType; (*Behaviour near and inside mechanical singularities*)
		WireFrameModel : McMS6ARCWFrmMdlType; (*Wire frame model of mechanical system*)
		DynamicModel : McMSDynMdlType; (*Dynamic model of the mechanical system*)
		Couplings : McMS6ARCCplgType; (*Couplings between selected axes and the joint axis*)
		JointAxesPositionLimits : McMSJnt6AxPosLimType; (*Position limits for joint axis*)
		MonitoringPoints : McMS6ARCMonPtType; (*Enable robot monitoring points*)
	END_STRUCT;
END_TYPE