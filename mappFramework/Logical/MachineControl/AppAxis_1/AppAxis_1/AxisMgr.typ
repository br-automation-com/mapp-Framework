(*Structure types*)

TYPE
	AxisSettingsType : 	STRUCT 
		AxisFeatures : {REDUND_UNREPLICABLE} ARRAY[0..2]OF STRING[255]; (*Variable to write axis features into*)
		DriveConfiguration : {REDUND_UNREPLICABLE} McCfgPureVAxType; (*Drive configuration structure*)
		BaseConfiguration : {REDUND_UNREPLICABLE} McCfgAxType; (*Base axis type configuration *)
		BaseParam : {REDUND_UNREPLICABLE} McCfgAxMoveLimType; (*Base axis movement configuration*)
	END_STRUCT;
	AxisMachineSettingsType : {REDUND_UNREPLICABLE} 	STRUCT 
		ReferencePosition : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Axis position after reference*)
	END_STRUCT;
	AxisControlCommandType : {REDUND_UNREPLICABLE} 	STRUCT 
		UpdatePreviewParameters : {REDUND_UNREPLICABLE} BOOL; (*Cmd to load new preview*)
		LoadRecipeParameters : {REDUND_UNREPLICABLE} BOOL; (*Load selected recipe file into active parameters *)
		SaveRecipeParameters : {REDUND_UNREPLICABLE} BOOL; (*Save current parameters*)
		Power : {REDUND_UNREPLICABLE} BOOL; (*Cmd power*)
		Reference : {REDUND_UNREPLICABLE} BOOL; (*Cmd home / reference*)
		MoveAbsolute : {REDUND_UNREPLICABLE} BOOL; (*Cmd move absolute*)
		MoveAdditive : {REDUND_UNREPLICABLE} BOOL; (*Cmd move additive*)
		MoveVelocity : {REDUND_UNREPLICABLE} BOOL; (*Cmd move velocity*)
		MoveToStart : {REDUND_UNREPLICABLE} BOOL; (*Cmd move the start position*)
		Abort : {REDUND_UNREPLICABLE} BOOL; (*Cmd abort*)
		Stop : {REDUND_UNREPLICABLE} BOOL; (*Cmd stop all movement*)
		Reset : {REDUND_UNREPLICABLE} BOOL; (*Cmd reset axis state*)
		JogPositive : {REDUND_UNREPLICABLE} BOOL; (*Cmd jog positive*)
		JogNegative : {REDUND_UNREPLICABLE} BOOL; (*Cmd jog negative*)
		Start : {REDUND_UNREPLICABLE} BOOL; (*Cmd start motion*)
		UpdateVelocity : {REDUND_UNREPLICABLE} BOOL; (*Cmd update velocity for automatic mode*)
	END_STRUCT;
	AxisControlParametersType : {REDUND_UNREPLICABLE} 	STRUCT 
		HomePosition : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Home Position*)
		Position : {REDUND_UNREPLICABLE} LREAL := 0; (*[mm] Position for absolute move*)
		Distance : {REDUND_UNREPLICABLE} LREAL := 50; (*[mm] Distance for relative move*)
		Velocity : {REDUND_UNREPLICABLE} REAL := 100; (*[mm/s] Velocity for absoluate and relative moves*)
		Acceleration : {REDUND_UNREPLICABLE} REAL := 360; (*[mm/s2] Acceleration for absoluate and relative moves*)
		Deceleration : {REDUND_UNREPLICABLE} REAL := 360; (*[mm/s2] Deceleration for absoluate and relative moves*)
		JogVelocity : {REDUND_UNREPLICABLE} REAL := 100; (*[mm/s] Velocity used when jogging the axis*)
		StopDeceleration : {REDUND_UNREPLICABLE} REAL := 0; (*[mm/s2] Deceleration for stopping*)
		ProductNumber : {REDUND_UNREPLICABLE} INT := 0; (*Product Number*)
		ProductLength : {REDUND_UNREPLICABLE} REAL := 70; (*Real Product Length*)
	END_STRUCT;
	AxisControlStatusType : {REDUND_UNREPLICABLE} 	STRUCT 
		TaskName : {REDUND_UNREPLICABLE} STRING[80]; (*Current task name for configuration changes*)
		MachineSettingsName : {REDUND_UNREPLICABLE} STRING[255]; (*Category name for machine settings*)
		ProductSettingsName : {REDUND_UNREPLICABLE} STRING[255]; (*Category name for product settings*)
		Status : {REDUND_UNREPLICABLE} STRING[80]; (*Machine Status*)
		IsReady : {REDUND_UNREPLICABLE} BOOL; (*Axis is ready*)
		ErrorActive : {REDUND_UNREPLICABLE} BOOL; (*Error active*)
		Busy : {REDUND_UNREPLICABLE} BOOL; (*Cmd execution*)
		ReferenceRequired : {REDUND_UNREPLICABLE} BOOL; (*Reference cmd required*)
		Position : {REDUND_UNREPLICABLE} LREAL; (*Current position*)
		Velocity : {REDUND_UNREPLICABLE} REAL; (*Current position*)
		Current : {REDUND_UNREPLICABLE} REAL; (*Drive current*)
		LagError : {REDUND_UNREPLICABLE} LREAL; (*Axis lag error *)
		MotorTemperature : {REDUND_UNREPLICABLE} REAL; (*Motor temperature*)
		IsHomed : {REDUND_UNREPLICABLE} BOOL; (*Axis is referenced*)
		IsPowered : {REDUND_UNREPLICABLE} BOOL; (*Axis is powered*)
		PLCopenState : McAxisPLCopenStateEnum; (*Axis PLCopenState*)
	END_STRUCT;
	AxisControlType : {REDUND_UNREPLICABLE} 	STRUCT 
		Command : {REDUND_UNREPLICABLE} AxisControlCommandType; (*Cmd structure*)
		Parameters : {REDUND_UNREPLICABLE} AxisControlParametersType; (*Parameter structure*)
		Status : {REDUND_UNREPLICABLE} AxisControlStatusType; (*Status structure*)
	END_STRUCT;
	AxisRecipeType : 	STRUCT 
		EditDialogOpened : BOOL; (*HMI edit dialog open*)
		CreateDialogOpened : BOOL; (*HMI create dialog open*)
		SaveRecipe : BOOL; (*Cmd save current values*)
		LoadRecipe : BOOL; (*Cmd load exiting recipe*)
		CreateRecipe : BOOL; (*Cmd create new recipe*)
		State : AxisRecipeStepEnum; (*Recipe handling state*)
		CategoryDropdown : STRING[50]; (*HMI selector*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	StateEnum : 
		(
		STATE_INIT, (*Axis initialization state*)
		STATE_POWER_ON, (*Axis powering on state*)
		STATE_HOME, (*Axis homing state*)
		STATE_REFERENCE, (*Axis reference state*)
		STATE_MOVE_TO_HOME_POSITION, (*Axis moving to reference position state*)
		STATE_READY, (*Axis ready state*)
		STATE_MANUAL_OPERATION, (*Axis manual state*)
		STATE_AUTOMATIC_OPERATION, (*Axis automatic state*)
		STATE_STOPPING, (*Axis stopping state*)
		STATE_STOPPED, (*Axis stopped state*)
		STATE_ABORTING, (*Axis aborting state*)
		STATE_ABORTED, (*Axis aborted state*)
		STATE_CLEARING, (*Axis clearing state*)
		STATE_RESETTING (*Axis resetting state*)
		);
	ParameterStateEnum : 
		(
		PAR_STATE_INIT, (*Param initialization state*)
		PAR_STATE_READ, (*Param read state*)
		PAR_STATE_WRITE, (*Param write state*)
		PAR_STATE_READY (*Param ready state*)
		);
	ConfigurationStateEnum : 
		(
		CONFIG_STATE_INIT, (*Config initialization state*)
		CONFIG_STATE_READ, (*Config read state*)
		CONFIG_STATE_WRITE, (*Config write state*)
		CONFIG_STATE_READY (*Config ready state*)
		);
	ManualStateEnum : 
		(
		MANUAL_STATE_IDLE, (*Idle state*)
		MANUAL_STATE_JOG, (*Jog state*)
		MANUAL_STATE_MOVE, (*Move state*)
		MANUAL_STATE_STOPPING (*Stopping state*)
		);
	AutomaticStateEnum : 
		(
		AUTOMATIC_STATE_IDLE, (*Idle state*)
		AUTOMATIC_STATE_RUNNING (*Run state*)
		);
	AxisRecipeStepEnum : 
		(
		REC_AXIS_WAIT, (*Wait state*)
		REC_AXIS_LOAD, (*Load product parameters*)
		REC_AXIS_SAVE, (*Save product parameters*)
		REC_AXIS_CREATE, (*Create new axis recipe*)
		REC_AXIS_STORE_MACH_SETTINGS, (*Save machine parameter settings*)
		REC_AXIS_FACTORY_RESET (*Factory reset*)
		);
END_TYPE
