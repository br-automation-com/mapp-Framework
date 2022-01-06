
TYPE
	AxisMachineSettingsType : {REDUND_UNREPLICABLE} 	STRUCT 
		ReferencePosition : {REDUND_UNREPLICABLE} LREAL := 0.0; (*[deg] Position when the axis is referenced*)
		AxisFeatures : {REDUND_UNREPLICABLE} ARRAY[0..2]OF STRING[255] := ['CamAut_cutting',''];
		DriveConfiguration : {REDUND_UNREPLICABLE} McCfgPureVAxType := (0);
		BaseConfiguration : {REDUND_UNREPLICABLE} McCfgAxType;
	END_STRUCT;
	AxisControlCommandType : {REDUND_UNREPLICABLE} 	STRUCT 
		UpdatePreviewParameters : {REDUND_UNREPLICABLE} BOOL;
		ResetEditParameters : {REDUND_UNREPLICABLE} BOOL;
		Power : {REDUND_UNREPLICABLE} BOOL;
		Reference : {REDUND_UNREPLICABLE} BOOL;
		MoveToStart : {REDUND_UNREPLICABLE} BOOL;
		MoveAbsolute : {REDUND_UNREPLICABLE} BOOL;
		MoveAdditive : {REDUND_UNREPLICABLE} BOOL;
		Abort : {REDUND_UNREPLICABLE} BOOL;
		Stop : {REDUND_UNREPLICABLE} BOOL;
		Reset : {REDUND_UNREPLICABLE} BOOL;
		JogPositive : {REDUND_UNREPLICABLE} BOOL;
		JogNegative : {REDUND_UNREPLICABLE} BOOL;
		Start : {REDUND_UNREPLICABLE} BOOL;
	END_STRUCT;
	AxisControlParametersType : {REDUND_UNREPLICABLE} 	STRUCT 
		HomePosition : {REDUND_UNREPLICABLE} LREAL := 0;
		Position : {REDUND_UNREPLICABLE} LREAL := 0;
		Distance : {REDUND_UNREPLICABLE} LREAL := 180;
		Velocity : {REDUND_UNREPLICABLE} REAL := 360;
		Acceleration : {REDUND_UNREPLICABLE} REAL := 360;
		Deceleration : {REDUND_UNREPLICABLE} REAL := 360;
		JogVelocity : {REDUND_UNREPLICABLE} REAL := 360;
		StopDeceleration : {REDUND_UNREPLICABLE} REAL := 720; (*[mm/s2] Deceleration for stopping*)
		SyncAngle : {REDUND_UNREPLICABLE} LREAL := 45; (*Product Number*)
		DistanceFromSensorToCut : {REDUND_UNREPLICABLE} LREAL := 100; (*Real Product Length*)
		NumberOfKnives : {REDUND_UNREPLICABLE} USINT := 2;
		ProductLength : {REDUND_UNREPLICABLE} LREAL := 70;
		MinPrintMarkLength : {REDUND_UNREPLICABLE} LREAL := 7; (*[mm] Minimum product length, used for product detection*)
		MaxPrintMarkLength : {REDUND_UNREPLICABLE} LREAL := 15; (*[mm] Minimum print mark length, used for product detection*)
	END_STRUCT;
	AxisControlStatusType : {REDUND_UNREPLICABLE} 	STRUCT 
		TaskName : {REDUND_UNREPLICABLE} STRING[80];
		MachineSettingsName : {REDUND_UNREPLICABLE} STRING[255];
		ProductSettingsName : {REDUND_UNREPLICABLE} STRING[255];
		ProductPreviewSettingsName : {REDUND_UNREPLICABLE} STRING[255];
		Status : {REDUND_UNREPLICABLE} STRING[80]; (*Machine Status*)
		IsReady : {REDUND_UNREPLICABLE} BOOL;
		ErrorActive : {REDUND_UNREPLICABLE} BOOL;
		Busy : {REDUND_UNREPLICABLE} BOOL;
		ReferenceRequired : {REDUND_UNREPLICABLE} BOOL;
		Position : {REDUND_UNREPLICABLE} LREAL;
		Velocity : {REDUND_UNREPLICABLE} REAL;
		Current : {REDUND_UNREPLICABLE} REAL;
		LagError : {REDUND_UNREPLICABLE} LREAL;
		MotorTemperature : {REDUND_UNREPLICABLE} REAL;
		IsHomed : {REDUND_UNREPLICABLE} BOOL;
		IsPowered : {REDUND_UNREPLICABLE} BOOL;
		ActualProductLength : {REDUND_UNREPLICABLE} LREAL;
		ValidProducts : {REDUND_UNREPLICABLE} UDINT;
	END_STRUCT;
	AxisControlType : {REDUND_UNREPLICABLE} 	STRUCT 
		Command : {REDUND_UNREPLICABLE} AxisControlCommandType;
		Parameters : {REDUND_UNREPLICABLE} AxisControlParametersType;
		Status : {REDUND_UNREPLICABLE} AxisControlStatusType;
	END_STRUCT;
	stateEnum : 
		(
		STATE_INIT,
		STATE_POWER_ON,
		STATE_HOME,
		STATE_REFERENCE,
		STATE_MOVE_TO_HOME_POSITION,
		STATE_READY,
		STATE_MANUAL_OPERATION,
		STATE_AUTOMATIC_OPERATION,
		STATE_STOPPING,
		STATE_STOPPED,
		STATE_ABORTING,
		STATE_ABORTED,
		STATE_CLEARING,
		STATE_RESETTING
		);
	configurationStateEnum : 
		(
		CONFIG_STATE_INIT,
		CONFIG_STATE_READ,
		CONFIG_STATE_WRITE,
		CONFIG_STATE_READY
		);
	RegistrationStatusType : {REDUND_UNREPLICABLE} 	STRUCT 
		ActualMarkPosition : {REDUND_UNREPLICABLE} LREAL;
		MarkPositionError : {REDUND_UNREPLICABLE} LREAL;
		ActualProductLength : {REDUND_UNREPLICABLE} LREAL;
		ActualIntervalLength : {REDUND_UNREPLICABLE} LREAL;
		PhaseShift : {REDUND_UNREPLICABLE} LREAL;
		LastValidMarks : {REDUND_UNREPLICABLE} UDINT;
		Configuration : {REDUND_UNREPLICABLE} MpRegMarkDetectionConfigType;
	END_STRUCT;
END_TYPE
