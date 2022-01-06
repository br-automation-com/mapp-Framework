
TYPE
	PidState_enum : 
		(
		PID_IDLE := 0,
		PID_ACTIVE := 1,
		PID_TUNING := 2,
		PID_ERROR := 3
		);
	PidControlParameters_type : 	STRUCT 
		PidParameters : MTPIDParametersType;
		SetValue : REAL;
		MinOut : REAL;
		MaxOut : REAL;
		Invert : BOOL;
	END_STRUCT;
END_TYPE
