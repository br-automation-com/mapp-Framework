
TYPE
	AxisSettingsType : 	STRUCT 
		AxisFeatures : {REDUND_UNREPLICABLE} ARRAY[0..2]OF STRING[255];
		DriveConfiguration : {REDUND_UNREPLICABLE} McCfgPureVAxType;
		BaseConfiguration : {REDUND_UNREPLICABLE} McCfgAxType;
	END_STRUCT;
	AxisMachineSettingsType : {REDUND_UNREPLICABLE} 	STRUCT 
		ReferencePosition : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Axis position after reference*)
	END_STRUCT;
	AxisControlCommandType : {REDUND_UNREPLICABLE} 	STRUCT 
		UpdatePreviewParameters : {REDUND_UNREPLICABLE} BOOL;
		LoadRecipeParameters : {REDUND_UNREPLICABLE} BOOL;
		SaveRecipeParameters : {REDUND_UNREPLICABLE} BOOL;
		Power : {REDUND_UNREPLICABLE} BOOL;
		Reference : {REDUND_UNREPLICABLE} BOOL;
		MoveAbsolute : {REDUND_UNREPLICABLE} BOOL;
		MoveAdditive : {REDUND_UNREPLICABLE} BOOL;
		MoveToStart : {REDUND_UNREPLICABLE} BOOL;
		Abort : {REDUND_UNREPLICABLE} BOOL;
		Stop : {REDUND_UNREPLICABLE} BOOL;
		Reset : {REDUND_UNREPLICABLE} BOOL;
		JogPositive : {REDUND_UNREPLICABLE} BOOL;
		JogNegative : {REDUND_UNREPLICABLE} BOOL;
		Start : {REDUND_UNREPLICABLE} BOOL;
	END_STRUCT;
	AxisControlParametersType : {REDUND_UNREPLICABLE} 	STRUCT 
		HomePosition : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Home Position*)
		Position : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Position for absolute move*)
		Distance : {REDUND_UNREPLICABLE} LREAL := 50; (*[mm] Distance for relative move*)
		Velocity : {REDUND_UNREPLICABLE} REAL := 100; (*[mm/s] Velocity for absoluate and relative moves*)
		Acceleration : {REDUND_UNREPLICABLE} REAL := 360; (*[mm/s2] Acceleration for absoluate and relative moves*)
		Deceleration : {REDUND_UNREPLICABLE} REAL := 360; (*[mm/s2] Deceleration for absoluate and relative moves*)
		JogVelocity : {REDUND_UNREPLICABLE} REAL := 100; (*[mm/s] Velocity used when jogging the axis*)
		StopDeceleration : {REDUND_UNREPLICABLE} REAL := 720; (*[mm/s2] Deceleration for stopping*)
	END_STRUCT;
	AxisControlStatusType : {REDUND_UNREPLICABLE} 	STRUCT 
		TaskName : {REDUND_UNREPLICABLE} STRING[80];
		MachineSettingsName : {REDUND_UNREPLICABLE} STRING[255];
		ProductSettingsName : {REDUND_UNREPLICABLE} STRING[255];
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
	manualStateEnum : 
		(
		MANUAL_STATE_IDLE,
		MANUAL_STATE_JOG,
		MANUAL_STATE_MOVE,
		MANUAL_STATE_STOPPING
		);
	automaticStateEnum : 
		(
		AUTOMATIC_STATE_IDLE,
		AUTOMATIC_STATE_RUNNING
		);
END_TYPE
