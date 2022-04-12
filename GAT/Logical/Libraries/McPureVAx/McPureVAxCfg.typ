TYPE
	McPVAHModEnum :
		( (*Mode selector setting*)
		mcPVAHM_DIR := 0, (*Direct - Direct homing*)
		mcPVAHM_ABS_SW := 1, (*Absolute switch - Homing with absolute reference switch*)
		mcPVAHM_SW_GATE := 2, (*Switch gate - Homing with reference switch gate*)
		mcPVAHM_LIM_SW := 3, (*Limit switch - Homing with hardware end switch*)
		mcPVAHM_ABS := 4, (*Absolute - Homing by setting the home offset*)
		mcPVAHM_ABS_CORR := 5, (*Absolute correction - Homing by setting the home offset with counting range correction*)
		mcPVAHM_BLK_LAG_ERR := 9, (*Block lag error - Homing on block, criterion for homing event: lag error*)
		mcPVAHM_RES_POS := 10, (*Restore position - Homing by restoring the position from remanent variable data*)
		mcPVAHM_NOT_USE := 100 (*Not used - No preconfigured homing settings used*)
		);
	McPVAHModDirRefPEnum :
		( (*Reference pulse selector setting*)
		mcPVAHMDRP_NOT_USE := 0, (*Not used - Reference pulse is not used*)
		mcPVAHMDRP_USE := 1 (*Used - Reference pulse is used*)
		);
	McPVAHModHomeDirEnum :
		( (*Movement direction in which the homing event is evaluated*)
		mcPVAHMHD_POS := 0, (*Positive - Positive movement direction*)
		mcPVAHMHD_NEG := 1 (*Negative - Negative movement direction*)
		);
	McPVAHModKeepDirEnum :
		( (*Keep direction (move only in one direction)*)
		mcPVAHMKD_NO := 0, (*No - mcSWITCH_OFF*)
		mcPVAHMKD_YES := 1 (*Yes - mcSWITCH_ON*)
		);
	McPVAHModDirRefPUseType : STRUCT (*Type mcPVAHMDRP_USE settings*)
		HomingVelocity : REAL; (*Speed which is used while searching for the homing event (e.g. after reference switch has been reached) [Measurement units/s]*)
		Acceleration : REAL; (*Acceleration for homing movement [Measurement units/s²]*)
		HomingDirection : McPVAHModHomeDirEnum; (*Movement direction in which the homing event is evaluated*)
		KeepDirection : McPVAHModKeepDirEnum; (*Keep direction (move only in one direction)*)
		ReferencePulseBlockingDistance : LREAL; (*Distance for blocking the activation of triggering reference pulse [Measurement units]*)
	END_STRUCT;
	McPVAHModDirRefPType : STRUCT (*Use reference pulse of encoder*)
		Type : McPVAHModDirRefPEnum; (*Reference pulse selector setting*)
		Used : McPVAHModDirRefPUseType; (*Type mcPVAHMDRP_USE settings*)
	END_STRUCT;
	McPVAHModDirType : STRUCT (*Type mcPVAHM_DIR settings*)
		Position : LREAL; (*Home position [Measurement units]*)
		ReferencePulse : McPVAHModDirRefPType; (*Use reference pulse of encoder*)
	END_STRUCT;
	McPVAHModSwEdgEnum :
		( (*Edge of reference switch*)
		mcPVAHMSE_POS := 0, (*Positive - Positive switch edge*)
		mcPVAHMSE_NEG := 1 (*Negative - Negative switch edge*)
		);
	McPVAHModRefPEnum :
		( (*Reference pulse selector setting*)
		mcPVAHMRP_NOT_USE := 0, (*Not used - Reference pulse is not used*)
		mcPVAHMRP_USE := 1 (*Used - Reference pulse is used*)
		);
	McPVAHModRefPUseType : STRUCT (*Type mcPVAHMRP_USE settings*)
		ReferencePulseBlockingDistance : LREAL; (*Distance for blocking the activation of triggering reference pulse [Measurement units]*)
	END_STRUCT;
	McPVAHModRefPType : STRUCT (*Use reference pulse of encoder*)
		Type : McPVAHModRefPEnum; (*Reference pulse selector setting*)
		Used : McPVAHModRefPUseType; (*Type mcPVAHMRP_USE settings*)
	END_STRUCT;
	McPVAHModAbsSwType : STRUCT (*Type mcPVAHM_ABS_SW settings*)
		Position : LREAL; (*Home position [Measurement units]*)
		StartVelocity : REAL; (*Speed for searching the reference switch [Measurement units/s]*)
		HomingVelocity : REAL; (*Speed which is used while searching for the homing event (e.g. after reference switch has been reached) [Measurement units/s]*)
		Acceleration : REAL; (*Acceleration for homing movement [Measurement units/s²]*)
		SwitchEdge : McPVAHModSwEdgEnum; (*Edge of reference switch*)
		HomingDirection : McPVAHModHomeDirEnum; (*Movement direction in which the homing event is evaluated*)
		KeepDirection : McPVAHModKeepDirEnum; (*Keep direction (move only in one direction)*)
		ReferencePulse : McPVAHModRefPType; (*Use reference pulse of encoder*)
	END_STRUCT;
	McPVAHModStartDirEnum :
		( (*Start direction of movement for searching the reference switch*)
		mcPVAHMSD_POS := 0, (*Positive - Positive movement direction*)
		mcPVAHMSD_NEG := 1 (*Negative - Negative movement direction*)
		);
	McPVAHModSwGateType : STRUCT (*Type mcPVAHM_SW_GATE settings*)
		Position : LREAL; (*Home position [Measurement units]*)
		StartVelocity : REAL; (*Speed for searching the reference switch [Measurement units/s]*)
		HomingVelocity : REAL; (*Speed which is used while searching for the homing event (e.g. after reference switch has been reached) [Measurement units/s]*)
		Acceleration : REAL; (*Acceleration for homing movement [Measurement units/s²]*)
		SwitchEdge : McPVAHModSwEdgEnum; (*Edge of reference switch*)
		StartDirection : McPVAHModStartDirEnum; (*Start direction of movement for searching the reference switch*)
		HomingDirection : McPVAHModHomeDirEnum; (*Movement direction in which the homing event is evaluated*)
		KeepDirection : McPVAHModKeepDirEnum; (*Keep direction (move only in one direction)*)
		ReferencePulse : McPVAHModRefPType; (*Use reference pulse of encoder*)
	END_STRUCT;
	McPVAHModLimSwType : STRUCT (*Type mcPVAHM_LIM_SW settings*)
		Position : LREAL; (*Home position [Measurement units]*)
		StartVelocity : REAL; (*Speed for searching the reference switch [Measurement units/s]*)
		HomingVelocity : REAL; (*Speed which is used while searching for the homing event (e.g. after reference switch has been reached) [Measurement units/s]*)
		Acceleration : REAL; (*Acceleration for homing movement [Measurement units/s²]*)
		SwitchEdge : McPVAHModSwEdgEnum; (*Edge of reference switch*)
		HomingDirection : McPVAHModHomeDirEnum; (*Movement direction in which the homing event is evaluated*)
		KeepDirection : McPVAHModKeepDirEnum; (*Keep direction (move only in one direction)*)
		ReferencePulse : McPVAHModRefPType; (*Use reference pulse of encoder*)
	END_STRUCT;
	McPVAHModAbsType : STRUCT (*Type mcPVAHM_ABS settings*)
		Position : LREAL; (*Home offset [Measurement units]*)
	END_STRUCT;
	McPVAHModAbsCorrType : STRUCT (*Type mcPVAHM_ABS_CORR settings*)
		Position : LREAL; (*Home offset [Measurement units]*)
	END_STRUCT;
	McPVAHModBlkRefPNotUseType : STRUCT (*Type mcPVAHMRP_NOT_USE settings*)
		MinimumReturnDistance : LREAL; (*Minimum return distance after the blockade is reached [Measurement units]*)
	END_STRUCT;
	McPVAHModBlkRefPUseType : STRUCT (*Type mcPVAHMRP_USE settings*)
		ReferencePulseBlockingDistance : LREAL; (*Distance for blocking the activation of triggering reference pulse [Measurement units]*)
	END_STRUCT;
	McPVAHModBlkRefPType : STRUCT (*Use reference pulse of encoder*)
		Type : McPVAHModRefPEnum; (*Reference pulse selector setting*)
		NotUsed : McPVAHModBlkRefPNotUseType; (*Type mcPVAHMRP_NOT_USE settings*)
		Used : McPVAHModBlkRefPUseType; (*Type mcPVAHMRP_USE settings*)
	END_STRUCT;
	McPVAHModBlkLagErrType : STRUCT (*Type mcPVAHM_BLK_LAG_ERR settings*)
		Position : LREAL; (*Home position [Measurement units]*)
		StartVelocity : REAL; (*Speed for searching the reference switch [Measurement units/s]*)
		HomingVelocity : REAL; (*Speed which is used while searching for the homing event (e.g. after reference switch has been reached) [Measurement units/s]*)
		Acceleration : REAL; (*Acceleration for homing movement [Measurement units/s²]*)
		StartDirection : McPVAHModStartDirEnum; (*Start direction of movement for searching the reference switch*)
		HomingDirection : McPVAHModHomeDirEnum; (*Movement direction in which the homing event is evaluated*)
		ReferencePulse : McPVAHModBlkRefPType; (*Use reference pulse of encoder*)
		PositionErrorStopLimit : LREAL; (*Lag error for stop of the homing movement [Measurement units]*)
		BlockDetectionPositionError : LREAL; (*Lag error for block detection [Measurement units]*)
	END_STRUCT;
	McPVAHModType : STRUCT (*Homing mode*)
		Type : McPVAHModEnum; (*Mode selector setting*)
		Direct : McPVAHModDirType; (*Type mcPVAHM_DIR settings*)
		AbsoluteSwitch : McPVAHModAbsSwType; (*Type mcPVAHM_ABS_SW settings*)
		SwitchGate : McPVAHModSwGateType; (*Type mcPVAHM_SW_GATE settings*)
		LimitSwitch : McPVAHModLimSwType; (*Type mcPVAHM_LIM_SW settings*)
		Absolute : McPVAHModAbsType; (*Type mcPVAHM_ABS settings*)
		AbsoluteCorrection : McPVAHModAbsCorrType; (*Type mcPVAHM_ABS_CORR settings*)
		BlockLagError : McPVAHModBlkLagErrType; (*Type mcPVAHM_BLK_LAG_ERR settings*)
	END_STRUCT;
	McPVAHType : STRUCT (*Homing mode and parameters which can be used within the application program as preconfigured setting*)
		Mode : McPVAHModType; (*Homing mode*)
		RestorePositionVariable : STRING[250]; (*Remanent variable used for homing mode: Restore position*)
	END_STRUCT;
	McPVAJFEnum :
		( (*Jerk filter selector setting*)
		mcPVAJF_NOT_USE := 0, (*Not used - No jerk filter is applied*)
		mcPVAJF_USE := 1, (*Used - Jerk filter is applied*)
		mcPVAJF_JERK_LIM := 2 (*Jerk limited - Jerk is considered in the profile generator*)
		);
	McPVAJFUseType : STRUCT (*Type mcPVAJF_USE settings*)
		MaximumJerkTime : REAL; (*Maximum configurable jerk filter time [s]*)
		JerkTime : REAL; (*Used jerk filter time ('Jerk time' <= 'Maximum jerk time') [s]*)
	END_STRUCT;
	McPVAJFJerkLimType : STRUCT (*Type mcPVAJF_JERK_LIM settings*)
		JerkLimit : REAL; (*Jerk limit in any movement direction [Measurement units/s³]*)
	END_STRUCT;
	McPVAJFType : STRUCT (*Jerk filter*)
		Type : McPVAJFEnum; (*Jerk filter selector setting*)
		Used : McPVAJFUseType; (*Type mcPVAJF_USE settings*)
		JerkLimited : McPVAJFJerkLimType; (*Type mcPVAJF_JERK_LIM settings*)
	END_STRUCT;
	McPVAGPAIEnum :
		( (*General purpose axis interface selector setting*)
		mcPVAGPAI_NOT_USE := 0, (*Not used - No connection to a device used*)
		mcPVAGPAI_USE := 1 (*Used - Interface provides output data to control a device and receives status information of a device*)
		);
	McPVAMEType : STRUCT (*Parameter of hardware elements situated between motor encoder and load which influence the scaling*)
		Gearbox : McCfgGearBoxType; (*Specifies a gearbox by defining the ratio between a gearbox input and output*)
		RotaryToLinearTransformation : McCfgRotToLinTrfType; (*Specifies a transformation factor between the output of the gear and the actual load movement*)
	END_STRUCT;
	McPVAELEnum :
		( (*Encoder link selector setting*)
		mcPVAEL_NO_ENC := 0, (*No encoder - No position input*)
		mcPVAEL_ONE_ENC := 1 (*One encoder - One encoder is used*)
		);
	McPVAELOEPosEncEnum :
		( (*Position encoder selector setting*)
		mcPVAELOEPE_EXT := 0 (*External - External encoder is used*)
		);
	McPVAELOEExtPosTypEnum :
		( (*Position type selector setting*)
		mcPVAELOEEPT_ABS := 0, (*Absolute - Get position from an absolute encoder*)
		mcPVAELOEEPT_INCR := 1 (*Incremental - Get position from an incremental encoder*)
		);
	McPVAELOEExtPosTypAbsPosRngType : STRUCT (*Defines the range of the position value*)
		LowerLimit : DINT; (*Lower limit of encoder range*)
		UpperLimit : UDINT; (*Upper limit of encoder range*)
	END_STRUCT;
	McPVAELOEExtPosTypAbsType : STRUCT (*Type mcPVAELOEEPT_ABS settings*)
		PositionRange : McPVAELOEExtPosTypAbsPosRngType; (*Defines the range of the position value*)
	END_STRUCT;
	McPVAELOEExtPosTypType : STRUCT (*Type of the encoder*)
		Type : McPVAELOEExtPosTypEnum; (*Position type selector setting*)
		Absolute : McPVAELOEExtPosTypAbsType; (*Type mcPVAELOEEPT_ABS settings*)
	END_STRUCT;
	McPVAELOEExtPosSrcEnum :
		( (*Position source selector setting*)
		mcPVAELOEEPS_IO_CH_DINT := 0, (*I/O channel DINT - Get position from a signed 32 bit I/O channel*)
		mcPVAELOEEPS_IO_CH_UDINT := 1, (*I/O channel UDINT - Get position from an unsigned 32 bit I/O channel*)
		mcPVAELOEEPS_IO_CH_INT := 2, (*I/O channel INT - Get position from a signed 16 bit I/O channel*)
		mcPVAELOEEPS_IO_CH_UINT := 3, (*I/O channel UINT - Get position from an unsigned 16 bit I/O channel*)
		mcPVAELOEEPS_VAR_DINT := 4, (*Variable DINT - Get position from a signed 32 bit variable*)
		mcPVAELOEEPS_VAR_UDINT := 5, (*Variable UDINT - Get position from an unsigned 32 bit variable*)
		mcPVAELOEEPS_VAR_INT := 6, (*Variable INT - Get position from a signed 16 bit variable*)
		mcPVAELOEEPS_VAR_UINT := 7 (*Variable UINT - Get position from an unsigned 16 bit variable*)
		);
	McPVAELOEExtPosSrcIOChDINTType : STRUCT (*Type mcPVAELOEEPS_IO_CH_DINT settings*)
		ChannelMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcIOChUDINTType : STRUCT (*Type mcPVAELOEEPS_IO_CH_UDINT settings*)
		ChannelMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcIOChINTType : STRUCT (*Type mcPVAELOEEPS_IO_CH_INT settings*)
		ChannelMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcIOChUINTType : STRUCT (*Type mcPVAELOEEPS_IO_CH_UINT settings*)
		ChannelMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcVarDINTType : STRUCT (*Type mcPVAELOEEPS_VAR_DINT settings*)
		PVMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcVarUDINTType : STRUCT (*Type mcPVAELOEEPS_VAR_UDINT settings*)
		PVMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcVarINTType : STRUCT (*Type mcPVAELOEEPS_VAR_INT settings*)
		PVMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcVarUINTType : STRUCT (*Type mcPVAELOEEPS_VAR_UINT settings*)
		PVMapping : STRING[250]; (*Input source for the position*)
	END_STRUCT;
	McPVAELOEExtPosSrcType : STRUCT (*Position source*)
		Type : McPVAELOEExtPosSrcEnum; (*Position source selector setting*)
		IOChannelDINT : McPVAELOEExtPosSrcIOChDINTType; (*Type mcPVAELOEEPS_IO_CH_DINT settings*)
		IOChannelUDINT : McPVAELOEExtPosSrcIOChUDINTType; (*Type mcPVAELOEEPS_IO_CH_UDINT settings*)
		IOChannelINT : McPVAELOEExtPosSrcIOChINTType; (*Type mcPVAELOEEPS_IO_CH_INT settings*)
		IOChannelUINT : McPVAELOEExtPosSrcIOChUINTType; (*Type mcPVAELOEEPS_IO_CH_UINT settings*)
		VariableDINT : McPVAELOEExtPosSrcVarDINTType; (*Type mcPVAELOEEPS_VAR_DINT settings*)
		VariableUDINT : McPVAELOEExtPosSrcVarUDINTType; (*Type mcPVAELOEEPS_VAR_UDINT settings*)
		VariableINT : McPVAELOEExtPosSrcVarINTType; (*Type mcPVAELOEEPS_VAR_INT settings*)
		VariableUINT : McPVAELOEExtPosSrcVarUINTType; (*Type mcPVAELOEEPS_VAR_UINT settings*)
	END_STRUCT;
	McPVAELOEExtValCkModOkEnum :
		( (*Module ok selector setting*)
		mcPVAELOEEVCMO_POS_SRC_DEV := 0, (*Position source device - Get module ok from the same device as the position source*)
		mcPVAELOEEVCMO_IO_CH := 1, (*I/O channel - Get module ok from an I/O channel*)
		mcPVAELOEEVCMO_VAR := 2, (*Variable - Get module ok from a variable*)
		mcPVAELOEEVCMO_NOT_USE := 3 (*Not used - Module ok is not used*)
		);
	McPVAELOEExtValCkModOkIOChType : STRUCT (*Type mcPVAELOEEVCMO_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source for module ok*)
	END_STRUCT;
	McPVAELOEExtValCkModOkVarType : STRUCT (*Type mcPVAELOEEVCMO_VAR settings*)
		PVMapping : STRING[250]; (*Input source for module ok*)
	END_STRUCT;
	McPVAELOEExtValCkModOkType : STRUCT (*Use module ok for validity check*)
		Type : McPVAELOEExtValCkModOkEnum; (*Module ok selector setting*)
		IOChannel : McPVAELOEExtValCkModOkIOChType; (*Type mcPVAELOEEVCMO_IO_CH settings*)
		Variable : McPVAELOEExtValCkModOkVarType; (*Type mcPVAELOEEVCMO_VAR settings*)
	END_STRUCT;
	McPVAELOEExtValCkStDatEnum :
		( (*Stale data selector setting*)
		mcPVAELOEEVCSD_POS_SRC_DEV := 0, (*Position source device - Get stale data from the same device as the position source*)
		mcPVAELOEEVCSD_IO_CH := 1, (*I/O channel - Get stale data from an I/O channel*)
		mcPVAELOEEVCSD_VAR := 2, (*Variable - Get stale data from a variable*)
		mcPVAELOEEVCSD_NOT_USE := 3 (*Not used - Stale data is not used*)
		);
	McPVAELOEExtValCkStDatIOChType : STRUCT (*Type mcPVAELOEEVCSD_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source for stale data*)
	END_STRUCT;
	McPVAELOEExtValCkStDatVarType : STRUCT (*Type mcPVAELOEEVCSD_VAR settings*)
		PVMapping : STRING[250]; (*Input source for stale data*)
	END_STRUCT;
	McPVAELOEExtValCkStDatType : STRUCT (*Use stale data for validity check*)
		Type : McPVAELOEExtValCkStDatEnum; (*Stale data selector setting*)
		IOChannel : McPVAELOEExtValCkStDatIOChType; (*Type mcPVAELOEEVCSD_IO_CH settings*)
		Variable : McPVAELOEExtValCkStDatVarType; (*Type mcPVAELOEEVCSD_VAR settings*)
	END_STRUCT;
	McPVAELOEExtValCkNetTimeEnum :
		( (*Net time selector setting*)
		mcPVAELOEEVCNT_NOT_USE := 0, (*Not used - Net time is not used*)
		mcPVAELOEEVCNT_IO_CH := 1, (*I/O channel - Get net time from an I/O channel*)
		mcPVAELOEEVCNT_VAR := 2 (*Variable - Get net time from a variable*)
		);
	McPVAELOEExtValCkNetTimeIOChType : STRUCT (*Type mcPVAELOEEVCNT_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source for net time*)
	END_STRUCT;
	McPVAELOEExtValCkNetTimeVarType : STRUCT (*Type mcPVAELOEEVCNT_VAR settings*)
		PVMapping : STRING[250]; (*Input source for net time*)
	END_STRUCT;
	McPVAELOEExtValCkNetTimeType : STRUCT (*Use net time for validity check*)
		Type : McPVAELOEExtValCkNetTimeEnum; (*Net time selector setting*)
		IOChannel : McPVAELOEExtValCkNetTimeIOChType; (*Type mcPVAELOEEVCNT_IO_CH settings*)
		Variable : McPVAELOEExtValCkNetTimeVarType; (*Type mcPVAELOEEVCNT_VAR settings*)
	END_STRUCT;
	McPVAELOEExtValCkEncOkEnum :
		( (*Encoder ok selector setting*)
		mcPVAELOEEVCEO_NOT_USE := 0, (*Not used - Encoder ok is not used*)
		mcPVAELOEEVCEO_IO_CH := 1, (*I/O channel - Get encoder ok from an I/O channel*)
		mcPVAELOEEVCEO_VAR := 2 (*Variable - Get encoder ok from a variable*)
		);
	McPVAELOEExtValCkEncOkIOChType : STRUCT (*Type mcPVAELOEEVCEO_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source for encoder ok*)
	END_STRUCT;
	McPVAELOEExtValCkEncOkVarType : STRUCT (*Type mcPVAELOEEVCEO_VAR settings*)
		PVMapping : STRING[250]; (*Input source for encoder ok*)
	END_STRUCT;
	McPVAELOEExtValCkEncOkType : STRUCT (*Use encoder ok flag for validity check (True = position valid)*)
		Type : McPVAELOEExtValCkEncOkEnum; (*Encoder ok selector setting*)
		IOChannel : McPVAELOEExtValCkEncOkIOChType; (*Type mcPVAELOEEVCEO_IO_CH settings*)
		Variable : McPVAELOEExtValCkEncOkVarType; (*Type mcPVAELOEEVCEO_VAR settings*)
	END_STRUCT;
	McPVAELOEExtValCkType : STRUCT (*Check if given position is valid*)
		ModuleOk : McPVAELOEExtValCkModOkType; (*Use module ok for validity check*)
		StaleData : McPVAELOEExtValCkStDatType; (*Use stale data for validity check*)
		NetTime : McPVAELOEExtValCkNetTimeType; (*Use net time for validity check*)
		EncoderOk : McPVAELOEExtValCkEncOkType; (*Use encoder ok flag for validity check (True = position valid)*)
	END_STRUCT;
	McPVAELOEExtRefPEnum :
		( (*Reference pulse selector setting*)
		mcPVAELOEERP_NOT_USE := 0, (*Not used - Reference pulse is not used*)
		mcPVAELOEERP_IO_CH := 1, (*I/O channel - Reference pulse is used with I/O channel*)
		mcPVAELOEERP_VAR := 2 (*Variable - Reference pulse is used with variable*)
		);
	McPVAELOEExtRefPIOChPosType : STRUCT (*Position of the reference pulse*)
		ChannelMapping : STRING[250]; (*Input source for the reference pulse position*)
	END_STRUCT;
	McPVAELOEExtRefPIOChCntType : STRUCT (*Count of the reference pulse*)
		ChannelMapping : STRING[250]; (*Input source for the reference pulse count*)
	END_STRUCT;
	McPVAELOEExtRefPIOChType : STRUCT (*Type mcPVAELOEERP_IO_CH settings*)
		Position : McPVAELOEExtRefPIOChPosType; (*Position of the reference pulse*)
		Count : McPVAELOEExtRefPIOChCntType; (*Count of the reference pulse*)
	END_STRUCT;
	McPVAELOEExtRefPVarPosType : STRUCT (*Position of the reference pulse*)
		PVMapping : STRING[250]; (*Input source for the reference pulse position*)
	END_STRUCT;
	McPVAELOEExtRefPVarCntType : STRUCT (*Count of the reference pulse*)
		PVMapping : STRING[250]; (*Input source for the reference pulse count*)
	END_STRUCT;
	McPVAELOEExtRefPVarType : STRUCT (*Type mcPVAELOEERP_VAR settings*)
		Position : McPVAELOEExtRefPVarPosType; (*Position of the reference pulse*)
		Count : McPVAELOEExtRefPVarCntType; (*Count of the reference pulse*)
	END_STRUCT;
	McPVAELOEExtRefPType : STRUCT (*Check if given position is valid*)
		Type : McPVAELOEExtRefPEnum; (*Reference pulse selector setting*)
		IOChannel : McPVAELOEExtRefPIOChType; (*Type mcPVAELOEERP_IO_CH settings*)
		Variable : McPVAELOEExtRefPVarType; (*Type mcPVAELOEERP_VAR settings*)
	END_STRUCT;
	McPVAELOEEPosFltrEnum :
		( (*Position filter selector setting*)
		mcPVAELOEEPF_EXTPOL_AND_DIST := 0 (*Extrapolation and disturbance - An extrapolation and disturbance filter is used*)
		);
	McPVAELOEEPosFltrExtpolDistType : STRUCT (*Type mcPVAELOEEPF_EXTPOL_AND_DIST settings*)
		PositionFilterTimeConstant : REAL; (*Time constant for actual position filter*)
		ExtrapolationTime : REAL; (*Extrapolation time for actual position filter*)
	END_STRUCT;
	McPVAELOEEPosFltrType : STRUCT (*Filter for the encoder position*)
		Type : McPVAELOEEPosFltrEnum; (*Position filter selector setting*)
		ExtrapolationAndDisturbance : McPVAELOEEPosFltrExtpolDistType; (*Type mcPVAELOEEPF_EXTPOL_AND_DIST settings*)
	END_STRUCT;
	McPVAELOEPosEncExtType : STRUCT (*Type mcPVAELOEPE_EXT settings*)
		LinesPerEncoderRevolution : UDINT; (*Absolute number of lines of an encoder revolution [Lines/Rev]*)
		PositionType : McPVAELOEExtPosTypType; (*Type of the encoder*)
		PositionSource : McPVAELOEExtPosSrcType; (*Position source*)
		ValidityCheck : McPVAELOEExtValCkType; (*Check if given position is valid*)
		ReferencePulse : McPVAELOEExtRefPType; (*Check if given position is valid*)
		PositionFilter : McPVAELOEEPosFltrType; (*Filter for the encoder position*)
	END_STRUCT;
	McPVAELOEPosEncType : STRUCT (*Encoder which is used for this axis*)
		Type : McPVAELOEPosEncEnum; (*Position encoder selector setting*)
		External : McPVAELOEPosEncExtType; (*Type mcPVAELOEPE_EXT settings*)
	END_STRUCT;
	McPVAELOEType : STRUCT (*Type mcPVAEL_ONE_ENC settings*)
		PositionEncoder : McPVAELOEPosEncType; (*Encoder which is used for this axis*)
	END_STRUCT;
	McPVAELType : STRUCT (*Used position input*)
		Type : McPVAELEnum; (*Encoder link selector setting*)
		OneEncoder : McPVAELOEType; (*Type mcPVAEL_ONE_ENC settings*)
	END_STRUCT;
	McPVACModEnum :
		( (*Mode selector setting*)
		mcPVACM_NOT_USE := 0, (*Not used - Controller is not used*)
		mcPVACM_POS_CTRL := 1 (*Position controller - Position controller is used*)
		);
	McPVACModPosCtrlPosType : STRUCT (*Position controller parameters*)
		ProportionalGain : REAL; (*Proportional amplification [1/s]*)
		IntegrationTime : REAL; (*Integral action time [s]*)
		PredictionTime : REAL; (*Prediction time [s]*)
		TotalDelayTime : REAL; (*Total delay time [s]*)
		MaximumProportionalAction : REAL; (*Maximum proportional action [Measurement units/s]*)
		MaximumIntegralAction : REAL; (*Maximum integral action [Measurement units/s]*)
	END_STRUCT;
	McPVACModPosCtrlType : STRUCT (*Type mcPVACM_POS_CTRL settings*)
		Position : McPVACModPosCtrlPosType; (*Position controller parameters*)
	END_STRUCT;
	McPVACModType : STRUCT (*Mode of the axis controller*)
		Type : McPVACModEnum; (*Mode selector setting*)
		PositionController : McPVACModPosCtrlType; (*Type mcPVACM_POS_CTRL settings*)
	END_STRUCT;
	McPVACType : STRUCT (*Axis controller parameters*)
		Mode : McPVACModType; (*Mode of the axis controller*)
	END_STRUCT;
	McPVASRQstopEnum :
		( (*Quickstop selector setting*)
		mcPVASRQ_DEC_LIM := 0 (*Deceleration limit - Stop with deceleration limits*)
		);
	McPVASRQstopType : STRUCT (*Deceleration ramp / reaction in case of a quickstop which is caused by an active quickstop input*)
		Type : McPVASRQstopEnum; (*Quickstop selector setting*)
	END_STRUCT;
	McPVASRDrvErrEnum :
		( (*Drive error selector setting*)
		mcPVASRDE_DEC_LIM := 0, (*Deceleration limit - Stop with deceleration limits*)
		mcPVASRDE_COAST_TO_STANDSTILL := 1 (*Coast to standstill - Controller is deactivated*)
		);
	McPVASRDrvErrType : STRUCT (*Deceleration ramp / reaction in case of an error stop which is caused by a drive error*)
		Type : McPVASRDrvErrEnum; (*Drive error selector setting*)
	END_STRUCT;
	McPVASRType : STRUCT (*Reactions of the axis in case of certain stop conditions*)
		Quickstop : McPVASRQstopType; (*Deceleration ramp / reaction in case of a quickstop which is caused by an active quickstop input*)
		DriveError : McPVASRDrvErrType; (*Deceleration ramp / reaction in case of an error stop which is caused by a drive error*)
	END_STRUCT;
	McPVAMELType : STRUCT (*Limit values that result in a stop reaction when exceeded*)
		PositionError : LREAL; (*Lag error limit for stopping a movement [Measurement units]*)
	END_STRUCT;
	McPVADIAllSrcEnum :
		( (*Source selector setting*)
		mcPVADIAS_NOT_USE := 0, (*Not used -*)
		mcPVADIAS_VAR := 1, (*Variable - Get value from a PV*)
		mcPVADIAS_IO_CH := 2 (*I/O channel - Get value from an I/O channel*)
		);
	McPVADIAllSrcVarType : STRUCT (*Type mcPVADIAS_VAR settings*)
		PVMapping : STRING[250];
	END_STRUCT;
	McPVADIAllSrcIOChType : STRUCT (*Type mcPVADIAS_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Channel input source*)
	END_STRUCT;
	McPVADIAllSrcType : STRUCT (*Source of the digital input hardware which is used for this functionality*)
		Type : McPVADIAllSrcEnum; (*Source selector setting*)
		Variable : McPVADIAllSrcVarType; (*Type mcPVADIAS_VAR settings*)
		IOChannel : McPVADIAllSrcIOChType; (*Type mcPVADIAS_IO_CH settings*)
	END_STRUCT;
	McPVADILvlEnum :
		( (*Level of the digital input hardware which leads to an active level of the functionality*)
		mcPVADIL_LOW := 0, (*Low*)
		mcPVADIL_HIGH := 1 (*High*)
		);
	McPVADIHomeSwType : STRUCT (*Homing switch input functionality*)
		Source : McPVADIAllSrcType; (*Source of the digital input hardware which is used for this functionality*)
		Level : McPVADILvlEnum; (*Level of the digital input hardware which leads to an active level of the functionality*)
	END_STRUCT;
	McPVADIPosLimSwType : STRUCT (*Positive limit switch input functionality*)
		Source : McPVADIAllSrcType; (*Source of the digital input hardware which is used for this functionality*)
		Level : McPVADILvlEnum; (*Level of the digital input hardware which leads to an active level of the functionality*)
	END_STRUCT;
	McPVADINegLimSwType : STRUCT (*Negative limit switch input functionality*)
		Source : McPVADIAllSrcType; (*Source of the digital input hardware which is used for this functionality*)
		Level : McPVADILvlEnum; (*Level of the digital input hardware which leads to an active level of the functionality*)
	END_STRUCT;
	McPVADIAllTrgSrcEnum :
		( (*Source selector setting*)
		mcPVADIATS_NOT_USE := 0, (*Not used -*)
		mcPVADIATS_VAR := 1, (*Variable -*)
		mcPVADIATS_IO_CH := 2 (*I/O channel - Get value from an I/O channel*)
		);
	McPVADIAllTrgSrcVarTSEnum :
		( (*Time stamp selector setting*)
		mcPVADIATSVTS_NOT_USE := 0, (*Not used - Not used*)
		mcPVADIATSVTS_USE := 1, (*Used - Used*)
		mcPVADIATSVTS_RIS_AND_FALL_EDG := 2 (*Rising and falling edge - Detect the trigger by using a rising and a falling time stamp*)
		);
	McPVADIAllTrgSrcVarTSUseType : STRUCT (*Type mcPVADIATSVTS_USE settings*)
		PVMapping : STRING[250]; (*Name of the process variable (DINT) representing trigger time stamp*)
	END_STRUCT;
	McPVADIATSVTSRAFERECntType : STRUCT (*Count*)
		PVMapping : STRING[250]; (*Name of the process variable (SINT) representing the rising trigger edge count*)
	END_STRUCT;
	McPVADIATSVTSRAFERETimStmpType : STRUCT (*Time stamp*)
		PVMapping : STRING[250]; (*Name of the process variable (INT) representing the rising trigger edge time*)
	END_STRUCT;
	McPVADIATSVTSRAFERisEdgType : STRUCT (*Parameters for the rising trigger edge*)
		Count : McPVADIATSVTSRAFERECntType; (*Count*)
		TimeStamp : McPVADIATSVTSRAFERETimStmpType; (*Time stamp*)
	END_STRUCT;
	McPVADIATSVTSRAFEFECntType : STRUCT (*Count*)
		PVMapping : STRING[250]; (*Name of the process variable (SINT) representing the falling trigger edge count*)
	END_STRUCT;
	McPVADIATSVTSRAFEFETimStmpType : STRUCT (*Time stamp*)
		PVMapping : STRING[250]; (*Name of the process variable (INT) representing the falling trigger edge time*)
	END_STRUCT;
	McPVADIATSVTSRAFEFallEdgType : STRUCT (*Parameters for the falling trigger edge*)
		Count : McPVADIATSVTSRAFEFECntType; (*Count*)
		TimeStamp : McPVADIATSVTSRAFEFETimStmpType; (*Time stamp*)
	END_STRUCT;
	McPVADIATSVTSRisAndFallEdgType : STRUCT (*Type mcPVADIATSVTS_RIS_AND_FALL_EDG settings*)
		RisingEdge : McPVADIATSVTSRAFERisEdgType; (*Parameters for the rising trigger edge*)
		FallingEdge : McPVADIATSVTSRAFEFallEdgType; (*Parameters for the falling trigger edge*)
	END_STRUCT;
	McPVADIAllTrgSrcVarTSType : STRUCT (*Trigger time stamp*)
		Type : McPVADIAllTrgSrcVarTSEnum; (*Time stamp selector setting*)
		Used : McPVADIAllTrgSrcVarTSUseType; (*Type mcPVADIATSVTS_USE settings*)
		RisingAndFallingEdge : McPVADIATSVTSRisAndFallEdgType; (*Type mcPVADIATSVTS_RIS_AND_FALL_EDG settings*)
	END_STRUCT;
	McPVADIAllTrgSrcVarType : STRUCT (*Type mcPVADIATS_VAR settings*)
		PVMapping : STRING[250]; (*Name of the process variable (BOOL) representing trigger*)
		TimeStamp : McPVADIAllTrgSrcVarTSType; (*Trigger time stamp*)
	END_STRUCT;
	McPVADIAllTrgSrcIOChTSEnum :
		( (*Time stamp selector setting*)
		mcPVADIATSIOCTS_NOT_USE := 0, (*Not used - Not used*)
		mcPVADIATSIOCTS_USE := 1, (*Used - Used*)
		mcPVADIATSIOCTS_RIS_AND_FALL_EDG := 2 (*Rising and falling edge - Detect the trigger by using a rising and a falling time stamp*)
		);
	McPVADIAllTrgSrcIOChTSUseType : STRUCT (*Type mcPVADIATSIOCTS_USE settings*)
		ChannelMapping : STRING[250]; (*Input source (DINT) for representing the trigger time stamp*)
	END_STRUCT;
	McPVADIATSIOCTSRAFERECntType : STRUCT (*Count*)
		ChannelMapping : STRING[250]; (*Input source (SINT) for representing the rising trigger edge count*)
	END_STRUCT;
	McPVADIATSIOCTSRAFERETimStmpType : STRUCT (*Time stamp*)
		ChannelMapping : STRING[250]; (*Input source (INT) for representing the rising trigger edge time*)
	END_STRUCT;
	McPVADIATSIOCTSRAFERisEdgType : STRUCT (*Parameters for the rising trigger edge*)
		Count : McPVADIATSIOCTSRAFERECntType; (*Count*)
		TimeStamp : McPVADIATSIOCTSRAFERETimStmpType; (*Time stamp*)
	END_STRUCT;
	McPVADIATSIOCTSRAFEFECntType : STRUCT (*Count*)
		ChannelMapping : STRING[250]; (*Input source (SINT) for representing the falling trigger edge count*)
	END_STRUCT;
	McPVADIATSIOCTSRAFEFETimStmpType : STRUCT (*Time stamp*)
		ChannelMapping : STRING[250]; (*Input source (INT) for representing the falling trigger edge time*)
	END_STRUCT;
	McPVADIATSIOCTSRAFEFallEdgType : STRUCT (*Parameters for the falling trigger edge*)
		Count : McPVADIATSIOCTSRAFEFECntType; (*Count*)
		TimeStamp : McPVADIATSIOCTSRAFEFETimStmpType; (*Time stamp*)
	END_STRUCT;
	McPVADIATSIOCTSRisAndFallEdgType : STRUCT (*Type mcPVADIATSIOCTS_RIS_AND_FALL_EDG settings*)
		RisingEdge : McPVADIATSIOCTSRAFERisEdgType; (*Parameters for the rising trigger edge*)
		FallingEdge : McPVADIATSIOCTSRAFEFallEdgType; (*Parameters for the falling trigger edge*)
	END_STRUCT;
	McPVADIAllTrgSrcIOChTSType : STRUCT (*Trigger time stamp*)
		Type : McPVADIAllTrgSrcIOChTSEnum; (*Time stamp selector setting*)
		Used : McPVADIAllTrgSrcIOChTSUseType; (*Type mcPVADIATSIOCTS_USE settings*)
		RisingAndFallingEdge : McPVADIATSIOCTSRisAndFallEdgType; (*Type mcPVADIATSIOCTS_RIS_AND_FALL_EDG settings*)
	END_STRUCT;
	McPVADIAllTrgSrcIOChType : STRUCT (*Type mcPVADIATS_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source (BOOL) for representing the trigger signal*)
		TimeStamp : McPVADIAllTrgSrcIOChTSType; (*Trigger time stamp*)
	END_STRUCT;
	McPVADIAllTrgSrcType : STRUCT (*Source of the digital input hardware which is used for this functionality*)
		Type : McPVADIAllTrgSrcEnum; (*Source selector setting*)
		Variable : McPVADIAllTrgSrcVarType; (*Type mcPVADIATS_VAR settings*)
		IOChannel : McPVADIAllTrgSrcIOChType; (*Type mcPVADIATS_IO_CH settings*)
	END_STRUCT;
	McPVADITrg1Type : STRUCT (*Trigger 1 input functionality*)
		Source : McPVADIAllTrgSrcType; (*Source of the digital input hardware which is used for this functionality*)
		Level : McPVADILvlEnum; (*Level of the digital input hardware which leads to an active level of the functionality*)
	END_STRUCT;
	McPVADITrg2Type : STRUCT (*Trigger 2 input functionality*)
		Source : McPVADIAllTrgSrcType; (*Source of the digital input hardware which is used for this functionality*)
		Level : McPVADILvlEnum; (*Level of the digital input hardware which leads to an active level of the functionality*)
	END_STRUCT;
	McPVADIQstopInEnum :
		( (*Input selector setting*)
		mcPVADIQI_NOT_USE := 0, (*Not used -*)
		mcPVADIQI_TRG_1 := 1, (*Trigger 1 -*)
		mcPVADIQI_TRG_2 := 2, (*Trigger 2 -*)
		mcPVADIQI_POS_LIM_SW := 3, (*Positive limit switch -*)
		mcPVADIQI_NEG_LIM_SW := 4, (*Negative limit switch -*)
		mcPVADIQI_HOME_SW := 5, (*Homing switch -*)
		mcPVADIQI_VAR := 6, (*Variable -*)
		mcPVADIQI_IO_CH := 7 (*I/O channel - Get value from an I/O channel*)
		);
	McPVADIQstopInVarType : STRUCT (*Type mcPVADIQI_VAR settings*)
		PVMapping : STRING[250]; (*Name of the process variable*)
	END_STRUCT;
	McPVADIQstopInIOChType : STRUCT (*Type mcPVADIQI_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Channel input source*)
	END_STRUCT;
	McPVADIQstopInType : STRUCT (*Digital input functionality triggering an axis quickstop*)
		Type : McPVADIQstopInEnum; (*Input selector setting*)
		Variable : McPVADIQstopInVarType; (*Type mcPVADIQI_VAR settings*)
		IOChannel : McPVADIQstopInIOChType; (*Type mcPVADIQI_IO_CH settings*)
	END_STRUCT;
	McPVADIQstopType : STRUCT (*Quickstop functionality*)
		Input : McPVADIQstopInType; (*Digital input functionality triggering an axis quickstop*)
	END_STRUCT;
	McPVADIType : STRUCT (*Various digital input functionalities e.g. like homing switch or triggers*)
		HomingSwitch : McPVADIHomeSwType; (*Homing switch input functionality*)
		PositiveLimitSwitch : McPVADIPosLimSwType; (*Positive limit switch input functionality*)
		NegativeLimitSwitch : McPVADINegLimSwType; (*Negative limit switch input functionality*)
		Trigger1 : McPVADITrg1Type; (*Trigger 1 input functionality*)
		Trigger2 : McPVADITrg2Type; (*Trigger 2 input functionality*)
		Quickstop : McPVADIQstopType; (*Quickstop functionality*)
	END_STRUCT;
	McPVASIAllSrcEnum :
		( (*Source selector setting*)
		mcPVASIAS_NOT_USE := 0, (*Not used -*)
		mcPVASIAS_VAR := 1, (*Variable - Get value from a PV*)
		mcPVASIAS_IO_CH := 2 (*I/O channel - Get value from an I/O channel*)
		);
	McPVASIAllSrcVarType : STRUCT (*Type mcPVASIAS_VAR settings*)
		PVMapping : STRING[250];
	END_STRUCT;
	McPVASIAllSrcIOChType : STRUCT (*Type mcPVASIAS_IO_CH settings*)
		ChannelMapping : STRING[250]; (*Input source for status input*)
	END_STRUCT;
	McPVASIAllSrcType : STRUCT (*Source of the status information*)
		Type : McPVASIAllSrcEnum; (*Source selector setting*)
		Variable : McPVASIAllSrcVarType; (*Type mcPVASIAS_VAR settings*)
		IOChannel : McPVASIAllSrcIOChType; (*Type mcPVASIAS_IO_CH settings*)
	END_STRUCT;
	McPVASIPwrdOnType : STRUCT (*Powered on status signal*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASICommRdyType : STRUCT (*Communication ready status signal*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIRdyForPwrOnType : STRUCT (*Ready for power on status signal*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIErrReacActType : STRUCT (*Error reaction active status signal*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIErrType : STRUCT (*Error occurred*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIErrIDType : STRUCT (*Number specifying the occurred error*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIWarType : STRUCT (*Warning occurred*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIWarIDType : STRUCT (*Number specifying the occurred warning*)
		Source : McPVASIAllSrcType; (*Source of the status information*)
	END_STRUCT;
	McPVASIType : STRUCT (*Various input functionalities to be linked to PVs or Channels*)
		PoweredOn : McPVASIPwrdOnType; (*Powered on status signal*)
		CommunicationReady : McPVASICommRdyType; (*Communication ready status signal*)
		ReadyForPowerOn : McPVASIRdyForPwrOnType; (*Ready for power on status signal*)
		ErrorReactionActive : McPVASIErrReacActType; (*Error reaction active status signal*)
		Error : McPVASIErrType; (*Error occurred*)
		ErrorID : McPVASIErrIDType; (*Number specifying the occurred error*)
		Warning : McPVASIWarType; (*Warning occurred*)
		WarningID : McPVASIWarIDType; (*Number specifying the occurred warning*)
	END_STRUCT;
	McPVACOPwrOnEnum :
		( (*Power on selector setting*)
		mcPVACOPO_NOT_USE := 0, (*Not used -*)
		mcPVACOPO_USE := 1 (*Used -*)
		);
	McPVACOAllDestEnum :
		( (*Destination selector setting*)
		mcPVACOAD_VAR := 0 (*Variable -*)
		);
	McPVACOAllDestVarType : STRUCT (*Type mcPVACOAD_VAR settings*)
		PVMapping : STRING[250]; (*Process variable to provide the control information*)
	END_STRUCT;
	McPVACOAllDestType : STRUCT (*Destination for the control information*)
		Type : McPVACOAllDestEnum; (*Destination selector setting*)
		Variable : McPVACOAllDestVarType; (*Type mcPVACOAD_VAR settings*)
	END_STRUCT;
	McPVACOPwrOnUseType : STRUCT (*Type mcPVACOPO_USE settings*)
		Destination : McPVACOAllDestType; (*Destination for the control information*)
	END_STRUCT;
	McPVACOPwrOnType : STRUCT (*Power on signal*)
		Type : McPVACOPwrOnEnum; (*Power on selector setting*)
		Used : McPVACOPwrOnUseType; (*Type mcPVACOPO_USE settings*)
	END_STRUCT;
	McPVACOErrRstEnum :
		( (*Error reset selector setting*)
		mcPVACOER_NOT_USE := 0, (*Not used -*)
		mcPVACOER_USE := 1 (*Used -*)
		);
	McPVACOErrRstUseType : STRUCT (*Type mcPVACOER_USE settings*)
		Destination : McPVACOAllDestType; (*Destination for the control information*)
	END_STRUCT;
	McPVACOErrRstType : STRUCT (*Error reset signal*)
		Type : McPVACOErrRstEnum; (*Error reset selector setting*)
		Used : McPVACOErrRstUseType; (*Type mcPVACOER_USE settings*)
	END_STRUCT;
	McPVACOBrkCtrlEnum :
		( (*Brake control selector setting*)
		mcPVACOBC_NOT_USE := 0, (*Not used -*)
		mcPVACOBC_USE := 1 (*Used -*)
		);
	McPVACOBrkCtrlUseType : STRUCT (*Type mcPVACOBC_USE settings*)
		Destination : McPVACOAllDestType; (*Destination for the control information*)
		ActivationDelay : REAL; (*Holding torque build-up time after switching off the operating voltage. [s]*)
		ReleaseDelay : REAL; (*Holding torque decaying time after switching on the operating voltage. [s]*)
	END_STRUCT;
	McPVACOBrkCtrlType : STRUCT (*Parameter of the holding break*)
		Type : McPVACOBrkCtrlEnum; (*Brake control selector setting*)
		Used : McPVACOBrkCtrlUseType; (*Type mcPVACOBC_USE settings*)
	END_STRUCT;
	McPVACOSetSpdEnum :
		( (*Set speed selector setting*)
		mcPVACOSS_NOT_USE := 0, (*Not used -*)
		mcPVACOSS_USE := 1 (*Used -*)
		);
	McPVACOSetSpdUseType : STRUCT (*Type mcPVACOSS_USE settings*)
		Destination : McPVACOAllDestType; (*Destination for the set speed value*)
	END_STRUCT;
	McPVACOSetSpdType : STRUCT (*Set speed value*)
		Type : McPVACOSetSpdEnum; (*Set speed selector setting*)
		Used : McPVACOSetSpdUseType; (*Type mcPVACOSS_USE settings*)
	END_STRUCT;
	McPVACOType : STRUCT (*Various output functionalities to be linked to PVs*)
		PowerOn : McPVACOPwrOnType; (*Power on signal*)
		ErrorReset : McPVACOErrRstType; (*Error reset signal*)
		BrakeControl : McPVACOBrkCtrlType; (*Parameter of the holding break*)
		SetSpeed : McPVACOSetSpdType; (*Set speed value*)
	END_STRUCT;
	McPVAGPAIUseType : STRUCT (*Type mcPVAGPAI_USE settings*)
		MechanicalElements : McPVAMEType; (*Parameter of hardware elements situated between motor encoder and load which influence the scaling*)
		EncoderLink : McPVAELType; (*Used position input*)
		Controller : McPVACType; (*Axis controller parameters*)
		StopReaction : McPVASRType; (*Reactions of the axis in case of certain stop conditions*)
		MovementErrorLimits : McPVAMELType; (*Limit values that result in a stop reaction when exceeded*)
		DigitalInputs : McPVADIType; (*Various digital input functionalities e.g. like homing switch or triggers*)
		StatusInputs : McPVASIType; (*Various input functionalities to be linked to PVs or Channels*)
		ControlOutputs : McPVACOType; (*Various output functionalities to be linked to PVs*)
	END_STRUCT;
	McPVAGPAIType : STRUCT (*Connect a PureVAx to any kind of drive*)
		Type : McPVAGPAIEnum; (*General purpose axis interface selector setting*)
		Used : McPVAGPAIUseType; (*Type mcPVAGPAI_USE settings*)
	END_STRUCT;
	McPVAFType : STRUCT (*Features for an axis*)
		FeatureReference : McCfgUnboundedArrayType; (*Name of the axis feature reference*)
	END_STRUCT;
	McPVAType : STRUCT (*Parameters for the pure virtual axis*)
		AxisReference : McCfgReferenceType; (*Name of the referenced axis component*)
		Homing : McPVAHType; (*Homing mode and parameters which can be used within the application program as preconfigured setting*)
		JerkFilter : McPVAJFType; (*Jerk filter*)
		GeneralPurposeAxisInterface : McPVAGPAIType; (*Connect a PureVAx to any kind of drive*)
		AxisFeatures : McPVAFType; (*Features for an axis*)
	END_STRUCT;
	McCfgPureVAxType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX*)
		PureVirtualAxis : McPVAType; (*Parameters for the pure virtual axis*)
	END_STRUCT;
	McCfgPureVAxRefType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_REF*)
		AxisReference : McCfgReferenceType; (*Name of the referenced axis component*)
	END_STRUCT;
	McCfgPureVAxHomeType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_HOME*)
		Homing : McPVAHType; (*Homing mode and parameters which can be used within the application program as preconfigured setting*)
	END_STRUCT;
	McCfgPureVAxJerkFltrType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_JERK_FLTR*)
		JerkFilter : McPVAJFType; (*Jerk filter*)
	END_STRUCT;
	McCfgPureVAxFeatType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_FEAT*)
		AxisFeatures : McPVAFType; (*Features for an axis*)
	END_STRUCT;
	McCfgPureVAxMechElmType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_MECH_ELM*)
		MechanicalElements : McPVAMEType; (*Parameter of hardware elements situated between motor encoder and load which influence the scaling*)
	END_STRUCT;
	McCfgPureVAxEncLinkType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_ENC_LINK*)
		EncoderLink : McPVAELType; (*Used position input*)
	END_STRUCT;
	McCfgPureVAxCtrlType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_CTRL*)
		Controller : McPVACType; (*Axis controller parameters*)
	END_STRUCT;
	McCfgPureVAxStopReacType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_STOP_REAC*)
		StopReaction : McPVASRType; (*Reactions of the axis in case of certain stop conditions*)
	END_STRUCT;
	McCfgPureVAxMoveErrLimType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_MOVE_ERR_LIM*)
		MovementErrorLimits : McPVAMELType; (*Limit values that result in a stop reaction when exceeded*)
	END_STRUCT;
	McCfgPureVAxDigInType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_DIG_IN*)
		DigitalInputs : McPVADIType; (*Various digital input functionalities e.g. like homing switch or triggers*)
	END_STRUCT;
	McCfgPureVAxStatInType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_STAT_IN*)
		StatusInputs : McPVASIType; (*Various input functionalities to be linked to PVs or Channels*)
	END_STRUCT;
	McCfgPureVAxCtrlOutType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PURE_V_AX_CTRL_OUT*)
		ControlOutputs : McPVACOType; (*Various output functionalities to be linked to PVs*)
	END_STRUCT;
END_TYPE