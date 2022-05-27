(*Enumerations*)

TYPE
	MpRegMarkDetectionEdgeEnum : 
		( (*Defines which edge of the registration mark is detected.*)
		mpREGMARK_MARK_EDGE_RISING := 0, (*Rising edge is used for the evaluation of the sensor signal.*)
		mpREGMARK_MARK_EDGE_FALLING := 1, (*Falling edge is used for the evaluation of the sensor signal.*)
		mpREGMARK_MARK_EDGE_MIDDLE := 2 (*Middle position between rising and falling edge is used for the evaluation of the sensor signal.*)
		);
	MpRegMarkDetectionStateEnum : 
		( (*Registration mark detection states.*)
		mpREGMARK_STATE_DTN_WAIT := 0, (*No process is executed.*)
		mpREGMARK_STATE_DTN_INIT := 1, (*The detection process is initialized.*)
		mpREGMARK_STATE_DTN_ACTIVE := 2, (*The detection process is active.*)
		mpREGMARK_STATE_DTN_STOP := 3, (*The detection process has stopped.*)
		mpREGMARK_STATE_DTN_ERROR := 4 (*Component is in error state.*)
		);
	MpRegMarkExpWindowShiftEnum : 
		( (*Defines the length by which the expectation window is shifted.*)
		mpREGMARK_EW_SHIFT_BY_PRODUCT := 0, (*The expectation window is shifted by the product length.*)
		mpREGMARK_EW_SHIFT_BY_USER := 1 (*The expectation window is shifted by a user defined length.*)
		);
	MpRegMarkExpWindowShiftModeEnum : 
		( (*Defines from which position the expectation window is shifted.*)
		mpREGMARK_EW_SHIFT_FROM_MARK := 0, (*Expectation window is shifted from the actual mark position.*)
		mpREGMARK_EW_SHIFT_FROM_WINDOW := 1 (*Expectation window is shifted from the last expectation window.*)
		);
	MpRegMarkIntervalDelayEnum : 
		( (*Defines how the interval delay is found.*)
		mpREGMARK_INTERVAL_DELAY_USER := 0 (*The delay time that needs to be compensated is defined by the user.*)
		);
	MpRegMarkIntervalLengthTypeEnum : 
		( (*Defines the length of one interval.*)
		mpREGMARK_INTERVAL_LENGTH_USER := 0, (*The interval length is defined by the user.*)
		mpREGMARK_INTERVAL_LENGTH_AXIS := 1 (*The interval length is identical to the period of the defined axis.*)
		);
	MpRegMarkIntervalPositionEnum : 
		( (*Defines where the interval position is read from.*)
		mpREGMARK_INT_POSITION_FROM_AXIS := 0 (*The interval position is read from the axis.*)
		);
	MpRegMarkIntervalTypeEnum : 
		( (*Defines how the interval is generated.*)
		mpREGMARK_INTERVAL_POS_BASED := 0 (*The interval is based on a position.*)
		);
	MpRegMarkMeasurementTypeEnum : 
		( (*Defines which measurement method is used.*)
		mpREGMARK_MARK_TO_INTERVAL := 0, (*The mark is measured in relation to an interval.*)
		mpREGMARK_MARK_TO_CYLINDER := 1 (*The mark is measured in relation to the transport cylinder.*)
		);
	MpRegMarkMissedMarkPositionEnum : 
		( (*Defines which position will be output if no mark was found.*)
		mpREGMARK_MISSED_MARK_SET := 0, (*The set position is used for the mark position.*)
		mpREGMARK_MISSED_MARK_LAST := 1 (*The last position is used for the mark position.*)
		);
	MpRegMarkIntervalPositionSrcEnum : 
		( (*Defines the source of the product position.*)
		mpREGMARK_INTERVAL_POS_SRC_SET := 0, (*The set position of the axis is used.*)
		mpREGMARK_INTERVAL_POS_SRC_PARID := 1 (*The ParID used as position source is defined by the user*)
		);
	MpRegMarkProductPositionSrcEnum : 
		( (*Defines the source of the product position.*)
		mpREGMARK_PRODUCT_POS_SRC_ACT := 0, (*The actual position of the axis is used.*)
		mpREGMARK_PRODUCT_POS_SRC_SET := 1, (*The set position of the axis is used.*)
		mpREGMARK_PRODUCT_POS_SRC_PARID := 2 (*The ParID used as position source is defined by the user*)
		);
	MpRegMarkProductLengthTypeEnum : 
		( (*Defines the length of one product.*)
		mpREGMARK_PRODUCT_LENGTH_USER := 0, (*The product length is defined by the user.*)
		mpREGMARK_PRODUCT_LENGTH_AXIS := 1 (*The product length is identical to the period of the defined axis.*)
		);
	MpRegMarkProductPositionEnum : 
		( (*Defines where the product position is read from.*)
		mpREGMARK_PRO_POSITION_FROM_AXIS := 0 (*The product position is read from the axis.*)
		);
	MpRegMarkSensorDelayEnum : 
		( (*Defines how the sensor delay is found.*)
		mpREGMARK_SENSOR_DELAY_USER := 0 (*The delay time that needs to be compensated is defined by the user*)
		);
	MpRegMarkSensorSignalEnum : 
		( (*Defines where the sensor signal is read from.*)
		mpREGMARK_SIGNAL_FROM_DRIVE := 0, (*The sensor signal is read from the drive.*)
		mpREGMARK_SIGNAL_FROM_IO_CHANNEL := 1 (*The sensor signal is read from an I/O channel.*)
		);
	MpRegMarkSensorSignalSourceEnum : 
		( (*Defines the source of the sensor signal.*)
		mpREGMARK_SIGNAL_SRC_TRIGGER1 := 0, (*The sensor is connected to the trigger input 1 of the ACOPOS.*)
		mpREGMARK_SIGNAL_SRC_TRIGGER2 := 1, (*The sensor is connected to the trigger input 2 of the ACOPOS.*)
		mpREGMARK_SIGNAL_SRC_USER := 2 (*The ParID used as sensor source is defined by the user.*)
		);
END_TYPE

(*Information*)

TYPE
	MpRegMarkDetectionInfoType : 	STRUCT  (*Additional information for the component.*)
		State : MpRegMarkDetectionStateEnum; (*Registration mark detection state.*)
		Detection : MpRegMarkDtnDetectionInfoType; (*Information about the detection.*)
		Diag : MpRegMarkDiagType; (*Additional diagnostic information.*)
END_STRUCT;
	MpRegMarkDtnDetectionInfoType : 	STRUCT  (*Information about the registration mark.*)
		ConsecutiveValidMarks : UDINT; (*Number of valid registration marks in a row (set to 0 after no valid registration mark is detected).*)
		TotalValidMarks : UDINT; (*Number of total valid registration marks.*)
		ConsecutiveMissedMarks : UDINT; (*The number of undetected registration marks in a row (set to 0 after a valid registration mark is detected).*)
		TotalMissedMarks : UDINT; (*The number of total undetected registration marks.*)
		AutomaticSearchActive : BOOL; (*Indicates if the automatic search is active.*)
	END_STRUCT;
	MpRegMarkInfoType : 	STRUCT  (*Additional information for the component.*)
		Diag : MpRegMarkDiagType; (*Additional diagnostic information.*)
	END_STRUCT;
	MpRegMarkDiagType : 	STRUCT  (*Additional diagnostic information.*)
		StatusID : MpRegMarkStatusIDType; (*Segmented StatusID output.*)
	END_STRUCT;
	MpRegMarkStatusIDType : 	STRUCT  (*Segmented StatusID output.*)
		ID : MpRegMarkErrorEnum; (*StatusID as enumerator.*)
		Severity : MpComSeveritiesEnum; (*Severity of the error.*)
		Code : UINT; (*Error code.*)
	END_STRUCT;
END_TYPE

(*SENSOR SIGNAL*)

TYPE
	MpRegMarkSensorSignalType : 	STRUCT  (*Parameters for the sensor signal of the detection system.*)
		Type : MpRegMarkSensorSignalEnum := mpREGMARK_SIGNAL_FROM_DRIVE; (*Defines where the sensor signal is read from.*)
		AxisReference : STRING[255]; (*Axis reference for the sensor signal.*)
		Source : MpRegMarkSensorSignalSourceType; (*Parameters for the sensor signal source.*)
		DelayCompensation : MpRegMarkSensorDelayType; (*Parameters for the sensor delay compensation.*)
		RisingEdge : MpRegMarkSensorEdgeNettimeType; (*Parameters for the rising edge of the sensor signal.*)
		FallingEdge : MpRegMarkSensorEdgeNettimeType; (*Parameters for the falling edge of the sensor signal.*)
	END_STRUCT;
	MpRegMarkSensorSignalSourceType : 	STRUCT  (*Parameters for the sensos signal source.*)
		Type : MpRegMarkSensorSignalSourceEnum := mpREGMARK_SIGNAL_SRC_TRIGGER1; (*Defines the source of the sensor signal.*)
		ParID : UINT := 0; (*ParID which is used as sensor signal*)
	END_STRUCT;
	MpRegMarkSensorDelayType : 	STRUCT  (*Parameters for the sensor delay compensation.*)
		Type : MpRegMarkSensorDelayEnum := mpREGMARK_SENSOR_DELAY_USER; (*Defines how the sensor delay is found.*)
		ResponseTime : REAL := 0.0; (*Response time of the sensor when detecting a registration mark.*)
		AdditionalDelayTime : REAL := 0.0; (*Additional delay time that needs to be compensated.*)
	END_STRUCT;
	MpRegMarkSensorEdgeNettimeType : 	STRUCT 
		TimeStamp : MpRegMarkNettimeTimeStampType;
	END_STRUCT;
	MpRegMarkNettimeTimeStampType : 	STRUCT 
		ChannelMapping : STRING[255];
	END_STRUCT;
END_TYPE

(*MEASUREMENT*)

TYPE
	MpRegMarkMeasurementType : 	STRUCT  (*Parameters for the measurement of the registration mark.*)
		Type : MpRegMarkMeasurementTypeEnum := mpREGMARK_MARK_TO_INTERVAL; (*Defines which measurement method is used.*)
		Product : MpRegMarkProductType; (*Parameters of the product.*)
		Interval : MpRegMarkIntervalType; (*Parameters of the interval.*)
	END_STRUCT;
	MpRegMarkProductType : 	STRUCT  (*Parameters of the product.*)
		Position : MpRegMarkProductPositionType; (*Defines the product position.*)
		Length : MpRegMarkProductLengthType; (*Defines the length of one product.*)
	END_STRUCT;
	MpRegMarkProductPositionType : 	STRUCT  (*Defines the product position.*)
		Type : MpRegMarkProductPositionEnum := mpREGMARK_PRO_POSITION_FROM_AXIS; (*Defines where the product position is read from.*)
		AxisReference : STRING[255]; (*Axis reference for the product position.*)
		Source : MpRegMarkProductPositionSrcType; (*Defines the source of the product position.*)
	END_STRUCT;
	MpRegMarkProductPositionSrcType : 	STRUCT  (*Defines the source of the product position.*)
		Type : MpRegMarkProductPositionSrcEnum := mpREGMARK_PRODUCT_POS_SRC_ACT; (*Defines the source of the product position.*)
		ParID : UINT := 0; (*ParID which is used as position source.*)
	END_STRUCT;
	MpRegMarkProductLengthType : 	STRUCT  (*Defines the length of one product.*)
		Type : MpRegMarkProductLengthTypeEnum := mpREGMARK_PRODUCT_LENGTH_USER; (*Defines the length of one product.*)
		Value : LREAL := 1000.0; (*Length of the product.*)
	END_STRUCT;
	MpRegMarkIntervalType : 	STRUCT  (*Parameters of the interval.*)
		Type : MpRegMarkIntervalTypeEnum := mpREGMARK_INTERVAL_POS_BASED; (*Defines how the interval is generated.*)
		Position : MpRegMarkIntervalPositionType; (*Parameters for the interval position.*)
		Length : MpRegMarkIntervalLengthType; (*Parameters for the interval length.*)
		DelayCompensation : MpRegMarkIntervalDelayType; (*Parameters for the delay compensation.*)
	END_STRUCT;
	MpRegMarkIntervalPositionType : 	STRUCT  (*Parameters for the interval position.*)
		Type : MpRegMarkIntervalPositionEnum := mpREGMARK_INT_POSITION_FROM_AXIS; (*Defines where the interval position is read from.*)
		AxisReference : STRING[255]; (*Axis reference for the interval position.*)
		Source : MpRegMarkIntervalPositionSrcType; (*Source of the interval position.*)
	END_STRUCT;
	MpRegMarkIntervalPositionSrcType : 	STRUCT  (*Source of the interval position.*)
		Type : MpRegMarkIntervalPositionSrcEnum := mpREGMARK_INTERVAL_POS_SRC_SET; (*Defines the source of the product position.*)
		ParID : UINT := 0; (*ParID which is used as position source.*)
	END_STRUCT;
	MpRegMarkIntervalLengthType : 	STRUCT  (*Parameters for the interval length.*)
		Type : MpRegMarkIntervalLengthTypeEnum := mpREGMARK_INTERVAL_LENGTH_USER; (*Defines the length of one interval.*)
		Value : LREAL := 1000.0; (*Length of the interval.*)
	END_STRUCT;
	MpRegMarkIntervalDelayType : 	STRUCT  (*Parameters for the delay compensation.*)
		Type : MpRegMarkIntervalDelayEnum := mpREGMARK_INTERVAL_DELAY_USER; (*Defines how the interval delay is found.*)
		DelayTime : REAL := 0.0; (*Delay time that needs to be compensated.*)
	END_STRUCT;
END_TYPE

(*DETECTION*)

TYPE
	MpRegMarkDetectionType : 	STRUCT  (*Parameters for the functionality of the detection.*)
		Type : MpRegMarkDetectionEdgeEnum := mpREGMARK_MARK_EDGE_RISING; (*Defines which edge of the registration mark is detected.*)
		SetMarkPosition : LREAL := 100.0; (*Position where the mark is supposed to be on the product.*)
		ExpectationWindow : MpRegMarkExpectationWindowType; (*Defines where on the product a mark is expected.*)
		MarkWidthMonitoring : MpRegMarkWidthMonitoringType; (*Parameters for the mark width monitoring.*)
		MissedMarkReaction : MpRegMarkMissedMarkReactionType; (*Parameters for the missed mark reaction.*)
	END_STRUCT;
	MpRegMarkExpectationWindowType : 	STRUCT  (*Defines the expectation window.*)
		Enable : BOOL := TRUE; (*Enables the expectation window.*)
		Shift : MpRegMarkExpWindowShiftType; (*Defines how the expectation window is shifted.*)
		Width : LREAL := 40.0; (*Defines the width of the expectation window.*)
	END_STRUCT;
	MpRegMarkExpWindowShiftType : 	STRUCT  (*Defines from which position the expectation window is shifted.*)
		Type : MpRegMarkExpWindowShiftEnum := mpREGMARK_EW_SHIFT_BY_PRODUCT; (*Defines the length by which the expectation window is shifted.*)
		Length : LREAL := 1000.0; (*User defined length by which the expectation window is shifted.*)
		Mode : MpRegMarkExpWindowShiftModeEnum := mpREGMARK_EW_SHIFT_FROM_MARK; (*Defines from which position the expectation window is shifted.*)
	END_STRUCT;
	MpRegMarkWidthMonitoringType : 	STRUCT  (*Parameters for the mark width monitoring.*)
		Enable : BOOL := TRUE; (*Enables the mark width monitoring.*)
		MinimumWidth : LREAL := 8.0; (*Minimum width of a valid registration mark.*)
		MaximumWidth : LREAL := 12.0; (*Maximum width of a valid registration mark.*)
	END_STRUCT;
	MpRegMarkMissedMarkReactionType : 	STRUCT  (*Parameters for the missed mark reaction.*)
		MarkPosition : MpRegMarkMissedMarkPositionTyp; (*Defines which position will be output if no mark was found.*)
		AutomaticSearch : MpRegMarkMissedMarkSearchTyp; (*Parameters for the automatic search of registration marks.*)
	END_STRUCT;
	MpRegMarkMissedMarkPositionTyp : 	STRUCT  (*Defines which position will be output if no mark was found.*)
		Type : MpRegMarkMissedMarkPositionEnum := mpREGMARK_MISSED_MARK_SET; (*Defines which position will be output if no mark was found.*)
	END_STRUCT;
	MpRegMarkMissedMarkSearchTyp : 	STRUCT  (*Parameters for the missed mark reaction.*)
		Enable : BOOL := FALSE; (*Enables the automatic search of registration marks.*)
		MissedTriggerCount : UINT := 2; (*Number of consecutively missing trigger pulses after which automatic registration mark searching begins.*)
		AdditionalExpectationWindowShift : LREAL := 40.0; (*If the registration mark is no longer in the expectation window, the window is additionally shifted by this value.*)
	END_STRUCT;
END_TYPE

(*OUTPUT SIGNALS*)

TYPE
	MpRegMarkDtnOutSignalType : 	STRUCT  (*Data points for the output signals*)
		ActualMarkPosition : STRING[255]; (*Actual position of the registration mark.*)
		MarkPositionError : STRING[255]; (*Position error of the registration mark.*)
		ActualProductLength : STRING[255]; (*Actual length of the product.*)
		ActualIntervalLength : STRING[255]; (*Actual length of the interval.*)
	END_STRUCT;
END_TYPE

(*MAIN CONFIGURATION*)

TYPE
	MpRegMarkDetectionConfigType : 	STRUCT  (*Configuration parameters for the registration mark detection.*)
		SensorSignal : MpRegMarkSensorSignalType; (*Parameters for the sensor signal of the detection system.*)
		Measurement : MpRegMarkMeasurementType; (*Parameters for the measurement of the registration mark.*)
		Detection : MpRegMarkDetectionType; (*Parameters for the functionality of the detection.*)
		OutputSignals : MpRegMarkDtnOutSignalType; (*Data points for the output signals.*)
	END_STRUCT;
END_TYPE
