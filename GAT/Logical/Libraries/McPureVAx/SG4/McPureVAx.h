/* Automation Studio generated header file */
/* Do not edit ! */
/* McPureVAx 5.16.2 */

#ifndef _MCPUREVAX_
#define _MCPUREVAX_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _McPureVAx_VERSION
#define _McPureVAx_VERSION 5.16.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <McBase.h> 
#include <McAxis.h>
#endif
 
#ifdef _SG3
#include <McBase.h> 
#include <McAxis.h>
#endif
 
#ifdef _SGC
#include <McBase.h> 
#include <McAxis.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef enum McPVAHModEnum
{	mcPVAHM_DIR = 0,
	mcPVAHM_ABS_SW = 1,
	mcPVAHM_SW_GATE = 2,
	mcPVAHM_LIM_SW = 3,
	mcPVAHM_ABS = 4,
	mcPVAHM_ABS_CORR = 5,
	mcPVAHM_BLK_LAG_ERR = 9,
	mcPVAHM_RES_POS = 10,
	mcPVAHM_NOT_USE = 100
} McPVAHModEnum;

typedef enum McPVAHModDirRefPEnum
{	mcPVAHMDRP_NOT_USE = 0,
	mcPVAHMDRP_USE = 1
} McPVAHModDirRefPEnum;

typedef enum McPVAHModHomeDirEnum
{	mcPVAHMHD_POS = 0,
	mcPVAHMHD_NEG = 1
} McPVAHModHomeDirEnum;

typedef enum McPVAHModKeepDirEnum
{	mcPVAHMKD_NO = 0,
	mcPVAHMKD_YES = 1
} McPVAHModKeepDirEnum;

typedef enum McPVAHModSwEdgEnum
{	mcPVAHMSE_POS = 0,
	mcPVAHMSE_NEG = 1
} McPVAHModSwEdgEnum;

typedef enum McPVAHModRefPEnum
{	mcPVAHMRP_NOT_USE = 0,
	mcPVAHMRP_USE = 1
} McPVAHModRefPEnum;

typedef enum McPVAHModStartDirEnum
{	mcPVAHMSD_POS = 0,
	mcPVAHMSD_NEG = 1
} McPVAHModStartDirEnum;

typedef enum McPVAJFEnum
{	mcPVAJF_NOT_USE = 0,
	mcPVAJF_USE = 1,
	mcPVAJF_JERK_LIM = 2
} McPVAJFEnum;

typedef enum McPVAGPAIEnum
{	mcPVAGPAI_NOT_USE = 0,
	mcPVAGPAI_USE = 1
} McPVAGPAIEnum;

typedef enum McPVAELEnum
{	mcPVAEL_NO_ENC = 0,
	mcPVAEL_ONE_ENC = 1
} McPVAELEnum;

typedef enum McPVAELOEPosEncEnum
{	mcPVAELOEPE_EXT = 0
} McPVAELOEPosEncEnum;

typedef enum McPVAELOEExtPosTypEnum
{	mcPVAELOEEPT_ABS = 0,
	mcPVAELOEEPT_INCR = 1
} McPVAELOEExtPosTypEnum;

typedef enum McPVAELOEExtPosSrcEnum
{	mcPVAELOEEPS_IO_CH_DINT = 0,
	mcPVAELOEEPS_IO_CH_UDINT = 1,
	mcPVAELOEEPS_IO_CH_INT = 2,
	mcPVAELOEEPS_IO_CH_UINT = 3,
	mcPVAELOEEPS_VAR_DINT = 4,
	mcPVAELOEEPS_VAR_UDINT = 5,
	mcPVAELOEEPS_VAR_INT = 6,
	mcPVAELOEEPS_VAR_UINT = 7
} McPVAELOEExtPosSrcEnum;

typedef enum McPVAELOEExtValCkModOkEnum
{	mcPVAELOEEVCMO_POS_SRC_DEV = 0,
	mcPVAELOEEVCMO_IO_CH = 1,
	mcPVAELOEEVCMO_VAR = 2,
	mcPVAELOEEVCMO_NOT_USE = 3
} McPVAELOEExtValCkModOkEnum;

typedef enum McPVAELOEExtValCkStDatEnum
{	mcPVAELOEEVCSD_POS_SRC_DEV = 0,
	mcPVAELOEEVCSD_IO_CH = 1,
	mcPVAELOEEVCSD_VAR = 2,
	mcPVAELOEEVCSD_NOT_USE = 3
} McPVAELOEExtValCkStDatEnum;

typedef enum McPVAELOEExtValCkNetTimeEnum
{	mcPVAELOEEVCNT_NOT_USE = 0,
	mcPVAELOEEVCNT_IO_CH = 1,
	mcPVAELOEEVCNT_VAR = 2
} McPVAELOEExtValCkNetTimeEnum;

typedef enum McPVAELOEExtValCkEncOkEnum
{	mcPVAELOEEVCEO_NOT_USE = 0,
	mcPVAELOEEVCEO_IO_CH = 1,
	mcPVAELOEEVCEO_VAR = 2
} McPVAELOEExtValCkEncOkEnum;

typedef enum McPVAELOEExtRefPEnum
{	mcPVAELOEERP_NOT_USE = 0,
	mcPVAELOEERP_IO_CH = 1,
	mcPVAELOEERP_VAR = 2
} McPVAELOEExtRefPEnum;

typedef enum McPVAELOEEPosFltrEnum
{	mcPVAELOEEPF_EXTPOL_AND_DIST = 0
} McPVAELOEEPosFltrEnum;

typedef enum McPVACModEnum
{	mcPVACM_NOT_USE = 0,
	mcPVACM_POS_CTRL = 1
} McPVACModEnum;

typedef enum McPVASRQstopEnum
{	mcPVASRQ_DEC_LIM = 0
} McPVASRQstopEnum;

typedef enum McPVASRDrvErrEnum
{	mcPVASRDE_DEC_LIM = 0,
	mcPVASRDE_COAST_TO_STANDSTILL = 1
} McPVASRDrvErrEnum;

typedef enum McPVADIAllSrcEnum
{	mcPVADIAS_NOT_USE = 0,
	mcPVADIAS_VAR = 1,
	mcPVADIAS_IO_CH = 2
} McPVADIAllSrcEnum;

typedef enum McPVADILvlEnum
{	mcPVADIL_LOW = 0,
	mcPVADIL_HIGH = 1
} McPVADILvlEnum;

typedef enum McPVADIAllTrgSrcEnum
{	mcPVADIATS_NOT_USE = 0,
	mcPVADIATS_VAR = 1,
	mcPVADIATS_IO_CH = 2
} McPVADIAllTrgSrcEnum;

typedef enum McPVADIAllTrgSrcVarTSEnum
{	mcPVADIATSVTS_NOT_USE = 0,
	mcPVADIATSVTS_USE = 1,
	mcPVADIATSVTS_RIS_AND_FALL_EDG = 2
} McPVADIAllTrgSrcVarTSEnum;

typedef enum McPVADIAllTrgSrcIOChTSEnum
{	mcPVADIATSIOCTS_NOT_USE = 0,
	mcPVADIATSIOCTS_USE = 1,
	mcPVADIATSIOCTS_RIS_AND_FALL_EDG = 2
} McPVADIAllTrgSrcIOChTSEnum;

typedef enum McPVADIQstopInEnum
{	mcPVADIQI_NOT_USE = 0,
	mcPVADIQI_TRG_1 = 1,
	mcPVADIQI_TRG_2 = 2,
	mcPVADIQI_POS_LIM_SW = 3,
	mcPVADIQI_NEG_LIM_SW = 4,
	mcPVADIQI_HOME_SW = 5,
	mcPVADIQI_VAR = 6,
	mcPVADIQI_IO_CH = 7
} McPVADIQstopInEnum;

typedef enum McPVASIAllSrcEnum
{	mcPVASIAS_NOT_USE = 0,
	mcPVASIAS_VAR = 1,
	mcPVASIAS_IO_CH = 2
} McPVASIAllSrcEnum;

typedef enum McPVACOPwrOnEnum
{	mcPVACOPO_NOT_USE = 0,
	mcPVACOPO_USE = 1
} McPVACOPwrOnEnum;

typedef enum McPVACOAllDestEnum
{	mcPVACOAD_VAR = 0
} McPVACOAllDestEnum;

typedef enum McPVACOErrRstEnum
{	mcPVACOER_NOT_USE = 0,
	mcPVACOER_USE = 1
} McPVACOErrRstEnum;

typedef enum McPVACOBrkCtrlEnum
{	mcPVACOBC_NOT_USE = 0,
	mcPVACOBC_USE = 1
} McPVACOBrkCtrlEnum;

typedef enum McPVACOSetSpdEnum
{	mcPVACOSS_NOT_USE = 0,
	mcPVACOSS_USE = 1
} McPVACOSetSpdEnum;

typedef struct McPureVAxStatusInputsPvIfType
{	plcbit PoweredOn;
	plcbit CommunicationReady;
	plcbit ReadyForPowerOn;
	plcbit ErrorReactionActive;
	plcbit Error;
	signed long ErrorID;
	plcbit Warning;
	signed long WarningID;
} McPureVAxStatusInputsPvIfType;

typedef struct McPureVAxControlOutputsPvIfType
{	plcbit PowerOn;
	plcbit ErrorReset;
	plcbit BrakeControl;
	float SetSpeed;
} McPureVAxControlOutputsPvIfType;

typedef struct McPureVAxGeneralPvInterfaceType
{	struct McDigitalInputsPvIfType DigitalInputs;
	struct McPureVAxStatusInputsPvIfType StatusInputs;
	struct McPureVAxControlOutputsPvIfType ControlOutputs;
} McPureVAxGeneralPvInterfaceType;

typedef struct McPureVAxRestorePosType
{	signed long Data[18];
} McPureVAxRestorePosType;

typedef struct McPVAHModDirRefPUseType
{	float HomingVelocity;
	float Acceleration;
	enum McPVAHModHomeDirEnum HomingDirection;
	enum McPVAHModKeepDirEnum KeepDirection;
	double ReferencePulseBlockingDistance;
} McPVAHModDirRefPUseType;

typedef struct McPVAHModDirRefPType
{	enum McPVAHModDirRefPEnum Type;
	struct McPVAHModDirRefPUseType Used;
} McPVAHModDirRefPType;

typedef struct McPVAHModDirType
{	double Position;
	struct McPVAHModDirRefPType ReferencePulse;
} McPVAHModDirType;

typedef struct McPVAHModRefPUseType
{	double ReferencePulseBlockingDistance;
} McPVAHModRefPUseType;

typedef struct McPVAHModRefPType
{	enum McPVAHModRefPEnum Type;
	struct McPVAHModRefPUseType Used;
} McPVAHModRefPType;

typedef struct McPVAHModAbsSwType
{	double Position;
	float StartVelocity;
	float HomingVelocity;
	float Acceleration;
	enum McPVAHModSwEdgEnum SwitchEdge;
	enum McPVAHModHomeDirEnum HomingDirection;
	enum McPVAHModKeepDirEnum KeepDirection;
	struct McPVAHModRefPType ReferencePulse;
} McPVAHModAbsSwType;

typedef struct McPVAHModSwGateType
{	double Position;
	float StartVelocity;
	float HomingVelocity;
	float Acceleration;
	enum McPVAHModSwEdgEnum SwitchEdge;
	enum McPVAHModStartDirEnum StartDirection;
	enum McPVAHModHomeDirEnum HomingDirection;
	enum McPVAHModKeepDirEnum KeepDirection;
	struct McPVAHModRefPType ReferencePulse;
} McPVAHModSwGateType;

typedef struct McPVAHModLimSwType
{	double Position;
	float StartVelocity;
	float HomingVelocity;
	float Acceleration;
	enum McPVAHModSwEdgEnum SwitchEdge;
	enum McPVAHModHomeDirEnum HomingDirection;
	enum McPVAHModKeepDirEnum KeepDirection;
	struct McPVAHModRefPType ReferencePulse;
} McPVAHModLimSwType;

typedef struct McPVAHModAbsType
{	double Position;
} McPVAHModAbsType;

typedef struct McPVAHModAbsCorrType
{	double Position;
} McPVAHModAbsCorrType;

typedef struct McPVAHModBlkRefPNotUseType
{	double MinimumReturnDistance;
} McPVAHModBlkRefPNotUseType;

typedef struct McPVAHModBlkRefPUseType
{	double ReferencePulseBlockingDistance;
} McPVAHModBlkRefPUseType;

typedef struct McPVAHModBlkRefPType
{	enum McPVAHModRefPEnum Type;
	struct McPVAHModBlkRefPNotUseType NotUsed;
	struct McPVAHModBlkRefPUseType Used;
} McPVAHModBlkRefPType;

typedef struct McPVAHModBlkLagErrType
{	double Position;
	float StartVelocity;
	float HomingVelocity;
	float Acceleration;
	enum McPVAHModStartDirEnum StartDirection;
	enum McPVAHModHomeDirEnum HomingDirection;
	struct McPVAHModBlkRefPType ReferencePulse;
	double PositionErrorStopLimit;
	double BlockDetectionPositionError;
} McPVAHModBlkLagErrType;

typedef struct McPVAHModType
{	enum McPVAHModEnum Type;
	struct McPVAHModDirType Direct;
	struct McPVAHModAbsSwType AbsoluteSwitch;
	struct McPVAHModSwGateType SwitchGate;
	struct McPVAHModLimSwType LimitSwitch;
	struct McPVAHModAbsType Absolute;
	struct McPVAHModAbsCorrType AbsoluteCorrection;
	struct McPVAHModBlkLagErrType BlockLagError;
} McPVAHModType;

typedef struct McPVAHType
{	struct McPVAHModType Mode;
	plcstring RestorePositionVariable[251];
} McPVAHType;

typedef struct McPVAJFUseType
{	float MaximumJerkTime;
	float JerkTime;
} McPVAJFUseType;

typedef struct McPVAJFJerkLimType
{	float JerkLimit;
} McPVAJFJerkLimType;

typedef struct McPVAJFType
{	enum McPVAJFEnum Type;
	struct McPVAJFUseType Used;
	struct McPVAJFJerkLimType JerkLimited;
} McPVAJFType;

typedef struct McPVAMEType
{	struct McCfgGearBoxType Gearbox;
	struct McCfgRotToLinTrfType RotaryToLinearTransformation;
} McPVAMEType;

typedef struct McPVAELOEExtPosTypAbsPosRngType
{	signed long LowerLimit;
	unsigned long UpperLimit;
} McPVAELOEExtPosTypAbsPosRngType;

typedef struct McPVAELOEExtPosTypAbsType
{	struct McPVAELOEExtPosTypAbsPosRngType PositionRange;
} McPVAELOEExtPosTypAbsType;

typedef struct McPVAELOEExtPosTypType
{	enum McPVAELOEExtPosTypEnum Type;
	struct McPVAELOEExtPosTypAbsType Absolute;
} McPVAELOEExtPosTypType;

typedef struct McPVAELOEExtPosSrcIOChDINTType
{	plcstring ChannelMapping[251];
} McPVAELOEExtPosSrcIOChDINTType;

typedef struct McPVAELOEExtPosSrcIOChUDINTType
{	plcstring ChannelMapping[251];
} McPVAELOEExtPosSrcIOChUDINTType;

typedef struct McPVAELOEExtPosSrcIOChINTType
{	plcstring ChannelMapping[251];
} McPVAELOEExtPosSrcIOChINTType;

typedef struct McPVAELOEExtPosSrcIOChUINTType
{	plcstring ChannelMapping[251];
} McPVAELOEExtPosSrcIOChUINTType;

typedef struct McPVAELOEExtPosSrcVarDINTType
{	plcstring PVMapping[251];
} McPVAELOEExtPosSrcVarDINTType;

typedef struct McPVAELOEExtPosSrcVarUDINTType
{	plcstring PVMapping[251];
} McPVAELOEExtPosSrcVarUDINTType;

typedef struct McPVAELOEExtPosSrcVarINTType
{	plcstring PVMapping[251];
} McPVAELOEExtPosSrcVarINTType;

typedef struct McPVAELOEExtPosSrcVarUINTType
{	plcstring PVMapping[251];
} McPVAELOEExtPosSrcVarUINTType;

typedef struct McPVAELOEExtPosSrcType
{	enum McPVAELOEExtPosSrcEnum Type;
	struct McPVAELOEExtPosSrcIOChDINTType IOChannelDINT;
	struct McPVAELOEExtPosSrcIOChUDINTType IOChannelUDINT;
	struct McPVAELOEExtPosSrcIOChINTType IOChannelINT;
	struct McPVAELOEExtPosSrcIOChUINTType IOChannelUINT;
	struct McPVAELOEExtPosSrcVarDINTType VariableDINT;
	struct McPVAELOEExtPosSrcVarUDINTType VariableUDINT;
	struct McPVAELOEExtPosSrcVarINTType VariableINT;
	struct McPVAELOEExtPosSrcVarUINTType VariableUINT;
} McPVAELOEExtPosSrcType;

typedef struct McPVAELOEExtValCkModOkIOChType
{	plcstring ChannelMapping[251];
} McPVAELOEExtValCkModOkIOChType;

typedef struct McPVAELOEExtValCkModOkVarType
{	plcstring PVMapping[251];
} McPVAELOEExtValCkModOkVarType;

typedef struct McPVAELOEExtValCkModOkType
{	enum McPVAELOEExtValCkModOkEnum Type;
	struct McPVAELOEExtValCkModOkIOChType IOChannel;
	struct McPVAELOEExtValCkModOkVarType Variable;
} McPVAELOEExtValCkModOkType;

typedef struct McPVAELOEExtValCkStDatIOChType
{	plcstring ChannelMapping[251];
} McPVAELOEExtValCkStDatIOChType;

typedef struct McPVAELOEExtValCkStDatVarType
{	plcstring PVMapping[251];
} McPVAELOEExtValCkStDatVarType;

typedef struct McPVAELOEExtValCkStDatType
{	enum McPVAELOEExtValCkStDatEnum Type;
	struct McPVAELOEExtValCkStDatIOChType IOChannel;
	struct McPVAELOEExtValCkStDatVarType Variable;
} McPVAELOEExtValCkStDatType;

typedef struct McPVAELOEExtValCkNetTimeIOChType
{	plcstring ChannelMapping[251];
} McPVAELOEExtValCkNetTimeIOChType;

typedef struct McPVAELOEExtValCkNetTimeVarType
{	plcstring PVMapping[251];
} McPVAELOEExtValCkNetTimeVarType;

typedef struct McPVAELOEExtValCkNetTimeType
{	enum McPVAELOEExtValCkNetTimeEnum Type;
	struct McPVAELOEExtValCkNetTimeIOChType IOChannel;
	struct McPVAELOEExtValCkNetTimeVarType Variable;
} McPVAELOEExtValCkNetTimeType;

typedef struct McPVAELOEExtValCkEncOkIOChType
{	plcstring ChannelMapping[251];
} McPVAELOEExtValCkEncOkIOChType;

typedef struct McPVAELOEExtValCkEncOkVarType
{	plcstring PVMapping[251];
} McPVAELOEExtValCkEncOkVarType;

typedef struct McPVAELOEExtValCkEncOkType
{	enum McPVAELOEExtValCkEncOkEnum Type;
	struct McPVAELOEExtValCkEncOkIOChType IOChannel;
	struct McPVAELOEExtValCkEncOkVarType Variable;
} McPVAELOEExtValCkEncOkType;

typedef struct McPVAELOEExtValCkType
{	struct McPVAELOEExtValCkModOkType ModuleOk;
	struct McPVAELOEExtValCkStDatType StaleData;
	struct McPVAELOEExtValCkNetTimeType NetTime;
	struct McPVAELOEExtValCkEncOkType EncoderOk;
} McPVAELOEExtValCkType;

typedef struct McPVAELOEExtRefPIOChPosType
{	plcstring ChannelMapping[251];
} McPVAELOEExtRefPIOChPosType;

typedef struct McPVAELOEExtRefPIOChCntType
{	plcstring ChannelMapping[251];
} McPVAELOEExtRefPIOChCntType;

typedef struct McPVAELOEExtRefPIOChType
{	struct McPVAELOEExtRefPIOChPosType Position;
	struct McPVAELOEExtRefPIOChCntType Count;
} McPVAELOEExtRefPIOChType;

typedef struct McPVAELOEExtRefPVarPosType
{	plcstring PVMapping[251];
} McPVAELOEExtRefPVarPosType;

typedef struct McPVAELOEExtRefPVarCntType
{	plcstring PVMapping[251];
} McPVAELOEExtRefPVarCntType;

typedef struct McPVAELOEExtRefPVarType
{	struct McPVAELOEExtRefPVarPosType Position;
	struct McPVAELOEExtRefPVarCntType Count;
} McPVAELOEExtRefPVarType;

typedef struct McPVAELOEExtRefPType
{	enum McPVAELOEExtRefPEnum Type;
	struct McPVAELOEExtRefPIOChType IOChannel;
	struct McPVAELOEExtRefPVarType Variable;
} McPVAELOEExtRefPType;

typedef struct McPVAELOEEPosFltrExtpolDistType
{	float PositionFilterTimeConstant;
	float ExtrapolationTime;
} McPVAELOEEPosFltrExtpolDistType;

typedef struct McPVAELOEEPosFltrType
{	enum McPVAELOEEPosFltrEnum Type;
	struct McPVAELOEEPosFltrExtpolDistType ExtrapolationAndDisturbance;
} McPVAELOEEPosFltrType;

typedef struct McPVAELOEPosEncExtType
{	unsigned long LinesPerEncoderRevolution;
	struct McPVAELOEExtPosTypType PositionType;
	struct McPVAELOEExtPosSrcType PositionSource;
	struct McPVAELOEExtValCkType ValidityCheck;
	struct McPVAELOEExtRefPType ReferencePulse;
	struct McPVAELOEEPosFltrType PositionFilter;
} McPVAELOEPosEncExtType;

typedef struct McPVAELOEPosEncType
{	enum McPVAELOEPosEncEnum Type;
	struct McPVAELOEPosEncExtType External;
} McPVAELOEPosEncType;

typedef struct McPVAELOEType
{	struct McPVAELOEPosEncType PositionEncoder;
} McPVAELOEType;

typedef struct McPVAELType
{	enum McPVAELEnum Type;
	struct McPVAELOEType OneEncoder;
} McPVAELType;

typedef struct McPVACModPosCtrlPosType
{	float ProportionalGain;
	float IntegrationTime;
	float PredictionTime;
	float TotalDelayTime;
	float MaximumProportionalAction;
	float MaximumIntegralAction;
} McPVACModPosCtrlPosType;

typedef struct McPVACModPosCtrlType
{	struct McPVACModPosCtrlPosType Position;
} McPVACModPosCtrlType;

typedef struct McPVACModType
{	enum McPVACModEnum Type;
	struct McPVACModPosCtrlType PositionController;
} McPVACModType;

typedef struct McPVACType
{	struct McPVACModType Mode;
} McPVACType;

typedef struct McPVASRQstopType
{	enum McPVASRQstopEnum Type;
} McPVASRQstopType;

typedef struct McPVASRDrvErrType
{	enum McPVASRDrvErrEnum Type;
} McPVASRDrvErrType;

typedef struct McPVASRType
{	struct McPVASRQstopType Quickstop;
	struct McPVASRDrvErrType DriveError;
} McPVASRType;

typedef struct McPVAMELType
{	double PositionError;
} McPVAMELType;

typedef struct McPVADIAllSrcVarType
{	plcstring PVMapping[251];
} McPVADIAllSrcVarType;

typedef struct McPVADIAllSrcIOChType
{	plcstring ChannelMapping[251];
} McPVADIAllSrcIOChType;

typedef struct McPVADIAllSrcType
{	enum McPVADIAllSrcEnum Type;
	struct McPVADIAllSrcVarType Variable;
	struct McPVADIAllSrcIOChType IOChannel;
} McPVADIAllSrcType;

typedef struct McPVADIHomeSwType
{	struct McPVADIAllSrcType Source;
	enum McPVADILvlEnum Level;
} McPVADIHomeSwType;

typedef struct McPVADIPosLimSwType
{	struct McPVADIAllSrcType Source;
	enum McPVADILvlEnum Level;
} McPVADIPosLimSwType;

typedef struct McPVADINegLimSwType
{	struct McPVADIAllSrcType Source;
	enum McPVADILvlEnum Level;
} McPVADINegLimSwType;

typedef struct McPVADIAllTrgSrcVarTSUseType
{	plcstring PVMapping[251];
} McPVADIAllTrgSrcVarTSUseType;

typedef struct McPVADIATSVTSRAFERECntType
{	plcstring PVMapping[251];
} McPVADIATSVTSRAFERECntType;

typedef struct McPVADIATSVTSRAFERETimStmpType
{	plcstring PVMapping[251];
} McPVADIATSVTSRAFERETimStmpType;

typedef struct McPVADIATSVTSRAFERisEdgType
{	struct McPVADIATSVTSRAFERECntType Count;
	struct McPVADIATSVTSRAFERETimStmpType TimeStamp;
} McPVADIATSVTSRAFERisEdgType;

typedef struct McPVADIATSVTSRAFEFECntType
{	plcstring PVMapping[251];
} McPVADIATSVTSRAFEFECntType;

typedef struct McPVADIATSVTSRAFEFETimStmpType
{	plcstring PVMapping[251];
} McPVADIATSVTSRAFEFETimStmpType;

typedef struct McPVADIATSVTSRAFEFallEdgType
{	struct McPVADIATSVTSRAFEFECntType Count;
	struct McPVADIATSVTSRAFEFETimStmpType TimeStamp;
} McPVADIATSVTSRAFEFallEdgType;

typedef struct McPVADIATSVTSRisAndFallEdgType
{	struct McPVADIATSVTSRAFERisEdgType RisingEdge;
	struct McPVADIATSVTSRAFEFallEdgType FallingEdge;
} McPVADIATSVTSRisAndFallEdgType;

typedef struct McPVADIAllTrgSrcVarTSType
{	enum McPVADIAllTrgSrcVarTSEnum Type;
	struct McPVADIAllTrgSrcVarTSUseType Used;
	struct McPVADIATSVTSRisAndFallEdgType RisingAndFallingEdge;
} McPVADIAllTrgSrcVarTSType;

typedef struct McPVADIAllTrgSrcVarType
{	plcstring PVMapping[251];
	struct McPVADIAllTrgSrcVarTSType TimeStamp;
} McPVADIAllTrgSrcVarType;

typedef struct McPVADIAllTrgSrcIOChTSUseType
{	plcstring ChannelMapping[251];
} McPVADIAllTrgSrcIOChTSUseType;

typedef struct McPVADIATSIOCTSRAFERECntType
{	plcstring ChannelMapping[251];
} McPVADIATSIOCTSRAFERECntType;

typedef struct McPVADIATSIOCTSRAFERETimStmpType
{	plcstring ChannelMapping[251];
} McPVADIATSIOCTSRAFERETimStmpType;

typedef struct McPVADIATSIOCTSRAFERisEdgType
{	struct McPVADIATSIOCTSRAFERECntType Count;
	struct McPVADIATSIOCTSRAFERETimStmpType TimeStamp;
} McPVADIATSIOCTSRAFERisEdgType;

typedef struct McPVADIATSIOCTSRAFEFECntType
{	plcstring ChannelMapping[251];
} McPVADIATSIOCTSRAFEFECntType;

typedef struct McPVADIATSIOCTSRAFEFETimStmpType
{	plcstring ChannelMapping[251];
} McPVADIATSIOCTSRAFEFETimStmpType;

typedef struct McPVADIATSIOCTSRAFEFallEdgType
{	struct McPVADIATSIOCTSRAFEFECntType Count;
	struct McPVADIATSIOCTSRAFEFETimStmpType TimeStamp;
} McPVADIATSIOCTSRAFEFallEdgType;

typedef struct McPVADIATSIOCTSRisAndFallEdgType
{	struct McPVADIATSIOCTSRAFERisEdgType RisingEdge;
	struct McPVADIATSIOCTSRAFEFallEdgType FallingEdge;
} McPVADIATSIOCTSRisAndFallEdgType;

typedef struct McPVADIAllTrgSrcIOChTSType
{	enum McPVADIAllTrgSrcIOChTSEnum Type;
	struct McPVADIAllTrgSrcIOChTSUseType Used;
	struct McPVADIATSIOCTSRisAndFallEdgType RisingAndFallingEdge;
} McPVADIAllTrgSrcIOChTSType;

typedef struct McPVADIAllTrgSrcIOChType
{	plcstring ChannelMapping[251];
	struct McPVADIAllTrgSrcIOChTSType TimeStamp;
} McPVADIAllTrgSrcIOChType;

typedef struct McPVADIAllTrgSrcType
{	enum McPVADIAllTrgSrcEnum Type;
	struct McPVADIAllTrgSrcVarType Variable;
	struct McPVADIAllTrgSrcIOChType IOChannel;
} McPVADIAllTrgSrcType;

typedef struct McPVADITrg1Type
{	struct McPVADIAllTrgSrcType Source;
	enum McPVADILvlEnum Level;
} McPVADITrg1Type;

typedef struct McPVADITrg2Type
{	struct McPVADIAllTrgSrcType Source;
	enum McPVADILvlEnum Level;
} McPVADITrg2Type;

typedef struct McPVADIQstopInVarType
{	plcstring PVMapping[251];
} McPVADIQstopInVarType;

typedef struct McPVADIQstopInIOChType
{	plcstring ChannelMapping[251];
} McPVADIQstopInIOChType;

typedef struct McPVADIQstopInType
{	enum McPVADIQstopInEnum Type;
	struct McPVADIQstopInVarType Variable;
	struct McPVADIQstopInIOChType IOChannel;
} McPVADIQstopInType;

typedef struct McPVADIQstopType
{	struct McPVADIQstopInType Input;
} McPVADIQstopType;

typedef struct McPVADIType
{	struct McPVADIHomeSwType HomingSwitch;
	struct McPVADIPosLimSwType PositiveLimitSwitch;
	struct McPVADINegLimSwType NegativeLimitSwitch;
	struct McPVADITrg1Type Trigger1;
	struct McPVADITrg2Type Trigger2;
	struct McPVADIQstopType Quickstop;
} McPVADIType;

typedef struct McPVASIAllSrcVarType
{	plcstring PVMapping[251];
} McPVASIAllSrcVarType;

typedef struct McPVASIAllSrcIOChType
{	plcstring ChannelMapping[251];
} McPVASIAllSrcIOChType;

typedef struct McPVASIAllSrcType
{	enum McPVASIAllSrcEnum Type;
	struct McPVASIAllSrcVarType Variable;
	struct McPVASIAllSrcIOChType IOChannel;
} McPVASIAllSrcType;

typedef struct McPVASIPwrdOnType
{	struct McPVASIAllSrcType Source;
} McPVASIPwrdOnType;

typedef struct McPVASICommRdyType
{	struct McPVASIAllSrcType Source;
} McPVASICommRdyType;

typedef struct McPVASIRdyForPwrOnType
{	struct McPVASIAllSrcType Source;
} McPVASIRdyForPwrOnType;

typedef struct McPVASIErrReacActType
{	struct McPVASIAllSrcType Source;
} McPVASIErrReacActType;

typedef struct McPVASIErrType
{	struct McPVASIAllSrcType Source;
} McPVASIErrType;

typedef struct McPVASIErrIDType
{	struct McPVASIAllSrcType Source;
} McPVASIErrIDType;

typedef struct McPVASIWarType
{	struct McPVASIAllSrcType Source;
} McPVASIWarType;

typedef struct McPVASIWarIDType
{	struct McPVASIAllSrcType Source;
} McPVASIWarIDType;

typedef struct McPVASIType
{	struct McPVASIPwrdOnType PoweredOn;
	struct McPVASICommRdyType CommunicationReady;
	struct McPVASIRdyForPwrOnType ReadyForPowerOn;
	struct McPVASIErrReacActType ErrorReactionActive;
	struct McPVASIErrType Error;
	struct McPVASIErrIDType ErrorID;
	struct McPVASIWarType Warning;
	struct McPVASIWarIDType WarningID;
} McPVASIType;

typedef struct McPVACOAllDestVarType
{	plcstring PVMapping[251];
} McPVACOAllDestVarType;

typedef struct McPVACOAllDestType
{	enum McPVACOAllDestEnum Type;
	struct McPVACOAllDestVarType Variable;
} McPVACOAllDestType;

typedef struct McPVACOPwrOnUseType
{	struct McPVACOAllDestType Destination;
} McPVACOPwrOnUseType;

typedef struct McPVACOPwrOnType
{	enum McPVACOPwrOnEnum Type;
	struct McPVACOPwrOnUseType Used;
} McPVACOPwrOnType;

typedef struct McPVACOErrRstUseType
{	struct McPVACOAllDestType Destination;
} McPVACOErrRstUseType;

typedef struct McPVACOErrRstType
{	enum McPVACOErrRstEnum Type;
	struct McPVACOErrRstUseType Used;
} McPVACOErrRstType;

typedef struct McPVACOBrkCtrlUseType
{	struct McPVACOAllDestType Destination;
	float ActivationDelay;
	float ReleaseDelay;
} McPVACOBrkCtrlUseType;

typedef struct McPVACOBrkCtrlType
{	enum McPVACOBrkCtrlEnum Type;
	struct McPVACOBrkCtrlUseType Used;
} McPVACOBrkCtrlType;

typedef struct McPVACOSetSpdUseType
{	struct McPVACOAllDestType Destination;
} McPVACOSetSpdUseType;

typedef struct McPVACOSetSpdType
{	enum McPVACOSetSpdEnum Type;
	struct McPVACOSetSpdUseType Used;
} McPVACOSetSpdType;

typedef struct McPVACOType
{	struct McPVACOPwrOnType PowerOn;
	struct McPVACOErrRstType ErrorReset;
	struct McPVACOBrkCtrlType BrakeControl;
	struct McPVACOSetSpdType SetSpeed;
} McPVACOType;

typedef struct McPVAGPAIUseType
{	struct McPVAMEType MechanicalElements;
	struct McPVAELType EncoderLink;
	struct McPVACType Controller;
	struct McPVASRType StopReaction;
	struct McPVAMELType MovementErrorLimits;
	struct McPVADIType DigitalInputs;
	struct McPVASIType StatusInputs;
	struct McPVACOType ControlOutputs;
} McPVAGPAIUseType;

typedef struct McPVAGPAIType
{	enum McPVAGPAIEnum Type;
	struct McPVAGPAIUseType Used;
} McPVAGPAIType;

typedef struct McPVAFType
{	struct McCfgUnboundedArrayType FeatureReference;
} McPVAFType;

typedef struct McPVAType
{	struct McCfgReferenceType AxisReference;
	struct McPVAHType Homing;
	struct McPVAJFType JerkFilter;
	struct McPVAGPAIType GeneralPurposeAxisInterface;
	struct McPVAFType AxisFeatures;
} McPVAType;

typedef struct McCfgPureVAxType
{	struct McPVAType PureVirtualAxis;
} McCfgPureVAxType;

typedef struct McCfgPureVAxRefType
{	struct McCfgReferenceType AxisReference;
} McCfgPureVAxRefType;

typedef struct McCfgPureVAxHomeType
{	struct McPVAHType Homing;
} McCfgPureVAxHomeType;

typedef struct McCfgPureVAxJerkFltrType
{	struct McPVAJFType JerkFilter;
} McCfgPureVAxJerkFltrType;

typedef struct McCfgPureVAxFeatType
{	struct McPVAFType AxisFeatures;
} McCfgPureVAxFeatType;

typedef struct McCfgPureVAxMechElmType
{	struct McPVAMEType MechanicalElements;
} McCfgPureVAxMechElmType;

typedef struct McCfgPureVAxEncLinkType
{	struct McPVAELType EncoderLink;
} McCfgPureVAxEncLinkType;

typedef struct McCfgPureVAxCtrlType
{	struct McPVACType Controller;
} McCfgPureVAxCtrlType;

typedef struct McCfgPureVAxStopReacType
{	struct McPVASRType StopReaction;
} McCfgPureVAxStopReacType;

typedef struct McCfgPureVAxMoveErrLimType
{	struct McPVAMELType MovementErrorLimits;
} McCfgPureVAxMoveErrLimType;

typedef struct McCfgPureVAxDigInType
{	struct McPVADIType DigitalInputs;
} McCfgPureVAxDigInType;

typedef struct McCfgPureVAxStatInType
{	struct McPVASIType StatusInputs;
} McCfgPureVAxStatInType;

typedef struct McCfgPureVAxCtrlOutType
{	struct McPVACOType ControlOutputs;
} McCfgPureVAxCtrlOutType;






#ifdef __cplusplus
};
#endif
#endif /* _MCPUREVAX_ */

