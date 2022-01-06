
TYPE
	AxisState_enum : 
		(
		AX_STATE_WAIT := 0,
		AX_STATE_POWER_ON,
		AX_STATE_HOME,
		AX_STATE_READY,
		AX_STATE_STOP,
		AX_STATE_JOG_POSITIVE,
		AX_STATE_JOG_NEGATIVE,
		AX_STATE_MOVE_ABSOLUTE,
		AX_STATE_MOVE_ADDITIVE,
		AX_STATE_MOVE_VELOCITY,
		AX_STATE_HALT,
		AX_STATE_TORQUE_CONTROL,
		AX_STATE_CAM_AUTOMAT,
		AX_STATE_ERROR := 90,
		AX_STATE_ERROR_RESET
		);
	AxControl_Command_typ : 	STRUCT  (*command structure*)
		Power : BOOL; (*switch on the controller*)
		Home : BOOL; (*reference the axis*)
		MoveAbsolute : BOOL; (*move to an defined position*)
		MoveAdditive : BOOL; (*move a defiened distance*)
		MoveVelocity : BOOL; (*start a movement with a defiened velocity*)
		MoveJogPos : BOOL; (*move in positive direction as long as is set*)
		MoveJogNeg : BOOL; (*move in negative direction as long as is set*)
		TorqueControl : BOOL; (*Activate torque limitation*)
		Stop : BOOL; (*stop every active movement as long as is set*)
		RunCamAutomat : BOOL; (*start coupling beetween master and slave*)
		ErrorAcknowledge : BOOL; (*reset active errors*)
		Reset : BOOL;
	END_STRUCT;
	AxControl_Parameter_typ : 	STRUCT  (*parameter structure*)
		AxPar : MpAxisBasicParType; (*Cutter axis parameters*)
	END_STRUCT;
	AxControl_Status_typ : 	STRUCT  (*status structure*)
		ErrorID : UDINT; (*ErrorID of any occured error*)
		Error : BOOL; (*Error on MpAxisBasic*)
		ActPosition : LREAL; (*actual position of the axis [mm OR °]*)
		ActVelocity : LREAL; (*actual velocity of the axis [mm/s OR °]*)
		ActTorque : REAL; (*actual torque [Nm]*)
		ActualPLCOpenState : McAxisPLCopenStateEnum; (*actual PLCopen state*)
		TorqueLimited : BOOL; (*Torque is currently being limited*)
		MovementActive : BOOL; (*A movement is currently active*)
		PowerOn : BOOL; (*Axis is powered on*)
		IsHomed : BOOL; (*Axis is homed*)
	END_STRUCT;
	AxControl_typ : 	STRUCT  (*control structure*)
		Command : AxControl_Command_typ; (*command structure*)
		Parameter : AxControl_Parameter_typ; (*parameter structure*)
		Status : AxControl_Status_typ; (*status structure*)
		AxisState : AxisState_enum;
	END_STRUCT;
END_TYPE

(*Main Control-----------------------------------------------------*)

TYPE
	MainStatus_typ : 	STRUCT  (*Structure Type for Main Control Status*)
		sMachineStatus : STRING[80]; (*Machine Status*)
		CurrentBatch : INT; (*Cutting Batch Index*)
		bCuttingProcessFinished : BOOL; (*Cutting process Finished*)
		iBatchIdxCutNumber : INT; (*Batch Index Cut Number*)
		iCuttingCycle : INT; (*Cutting Cycle*)
		ProductsCutTotal : UINT;
		ProductsCutBatch : UINT; (*Product Cut Numbebr*)
		CurrentBatchLength : REAL; (*Current batch product length [mm]*)
		CurrentBatchTarget : UINT; (*Current batch production target*)
	END_STRUCT;
	MainCmd_typ : 	STRUCT  (*Structure Type for Main Control Commands*)
		AutoModeOn : BOOL; (*Power on axes*)
		RunFeeder : BOOL; (*Run the process*)
		RunCutter : BOOL; (*Homing of the Axis*)
	END_STRUCT;
	MainFixParameters_typ : 	STRUCT 
		MinProductLength : REAL := 50; (*Minimum product length [mm]*)
		MaxProductLength : REAL := 1000; (*Maximum product length [mm]*)
		SyncAngle : REAL := 20; (*Sync Angle [°]*)
		NrOfKnives : USINT := 1; (*Number of knives*)
		CutDiameter : REAL := 90; (*Cutter radius [mm]*)
	END_STRUCT;
	MainParameters_typ : 	STRUCT 
		ProductNumber : ARRAY[0..4]OF INT; (*Product Number*)
		ProductLength : ARRAY[0..4]OF REAL; (*Real Product Length*)
		AxPar : ARRAY[0..MAX_IDX_AXIS]OF MpAxisBasicParType; (*Axis parameters*)
	END_STRUCT;
	MainIntern_typ : 	STRUCT  (*Structure Type for Main Control Parameters*)
		ProductNumber : ARRAY[0..4]OF UINT; (*Product Number*)
		ProductLength : ARRAY[0..4]OF REAL; (*Real Product Length*)
	END_STRUCT;
	MainCtrl_typ : 	STRUCT  (*Structure Type for Main Control *)
		Cmd : MainCmd_typ; (*Main Control Command*)
		FixPar : MainFixParameters_typ; (*Main Control Parameters*)
		Para : MainParameters_typ; (*Main Control Parameters*)
		Status : MainStatus_typ; (*Main Control Status*)
		Intern : MainIntern_typ;
	END_STRUCT;
END_TYPE
