/* Automation Studio generated header file */
/* Do not edit ! */
/* MpRegMark 5.16.0 */

#ifndef _MPREGMARK_
#define _MPREGMARK_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpRegMark_VERSION
#define _MpRegMark_VERSION 5.16.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpRegMarkDetectionEdgeEnum
{	mpREGMARK_MARK_EDGE_RISING = 0,
	mpREGMARK_MARK_EDGE_FALLING = 1,
	mpREGMARK_MARK_EDGE_MIDDLE = 2
} MpRegMarkDetectionEdgeEnum;

typedef enum MpRegMarkDetectionStateEnum
{	mpREGMARK_STATE_DTN_WAIT = 0,
	mpREGMARK_STATE_DTN_INIT = 1,
	mpREGMARK_STATE_DTN_ACTIVE = 2,
	mpREGMARK_STATE_DTN_STOP = 3,
	mpREGMARK_STATE_DTN_ERROR = 4
} MpRegMarkDetectionStateEnum;

typedef enum MpRegMarkExpWindowShiftEnum
{	mpREGMARK_EW_SHIFT_BY_PRODUCT = 0,
	mpREGMARK_EW_SHIFT_BY_USER = 1
} MpRegMarkExpWindowShiftEnum;

typedef enum MpRegMarkExpWindowShiftModeEnum
{	mpREGMARK_EW_SHIFT_FROM_MARK = 0,
	mpREGMARK_EW_SHIFT_FROM_WINDOW = 1
} MpRegMarkExpWindowShiftModeEnum;

typedef enum MpRegMarkIntervalDelayEnum
{	mpREGMARK_INTERVAL_DELAY_USER = 0
} MpRegMarkIntervalDelayEnum;

typedef enum MpRegMarkIntervalLengthTypeEnum
{	mpREGMARK_INTERVAL_LENGTH_USER = 0,
	mpREGMARK_INTERVAL_LENGTH_AXIS = 1
} MpRegMarkIntervalLengthTypeEnum;

typedef enum MpRegMarkIntervalPositionEnum
{	mpREGMARK_INT_POSITION_FROM_AXIS = 0
} MpRegMarkIntervalPositionEnum;

typedef enum MpRegMarkIntervalTypeEnum
{	mpREGMARK_INTERVAL_POS_BASED = 0
} MpRegMarkIntervalTypeEnum;

typedef enum MpRegMarkMeasurementTypeEnum
{	mpREGMARK_MARK_TO_INTERVAL = 0,
	mpREGMARK_MARK_TO_CYLINDER = 1
} MpRegMarkMeasurementTypeEnum;

typedef enum MpRegMarkMissedMarkPositionEnum
{	mpREGMARK_MISSED_MARK_SET = 0,
	mpREGMARK_MISSED_MARK_LAST = 1
} MpRegMarkMissedMarkPositionEnum;

typedef enum MpRegMarkIntervalPositionSrcEnum
{	mpREGMARK_INTERVAL_POS_SRC_SET = 0,
	mpREGMARK_INTERVAL_POS_SRC_PARID = 1
} MpRegMarkIntervalPositionSrcEnum;

typedef enum MpRegMarkProductPositionSrcEnum
{	mpREGMARK_PRODUCT_POS_SRC_ACT = 0,
	mpREGMARK_PRODUCT_POS_SRC_SET = 1,
	mpREGMARK_PRODUCT_POS_SRC_PARID = 2
} MpRegMarkProductPositionSrcEnum;

typedef enum MpRegMarkProductLengthTypeEnum
{	mpREGMARK_PRODUCT_LENGTH_USER = 0,
	mpREGMARK_PRODUCT_LENGTH_AXIS = 1
} MpRegMarkProductLengthTypeEnum;

typedef enum MpRegMarkProductPositionEnum
{	mpREGMARK_PRO_POSITION_FROM_AXIS = 0
} MpRegMarkProductPositionEnum;

typedef enum MpRegMarkSensorDelayEnum
{	mpREGMARK_SENSOR_DELAY_USER = 0
} MpRegMarkSensorDelayEnum;

typedef enum MpRegMarkSensorSignalEnum
{	mpREGMARK_SIGNAL_FROM_DRIVE = 0,
	mpREGMARK_SIGNAL_FROM_IO_CHANNEL = 1
} MpRegMarkSensorSignalEnum;

typedef enum MpRegMarkSensorSignalSourceEnum
{	mpREGMARK_SIGNAL_SRC_TRIGGER1 = 0,
	mpREGMARK_SIGNAL_SRC_TRIGGER2 = 1,
	mpREGMARK_SIGNAL_SRC_USER = 2
} MpRegMarkSensorSignalSourceEnum;

typedef enum MpRegMarkErrorEnum
{	mpREGMARK_NO_ERROR = 0,
	mpREGMARK_ERR_ACTIVATION = -1064239103,
	mpREGMARK_ERR_MPLINK_NULL = -1064239102,
	mpREGMARK_ERR_MPLINK_INVALID = -1064239101,
	mpREGMARK_ERR_MPLINK_CHANGED = -1064239100,
	mpREGMARK_ERR_MPLINK_CORRUPT = -1064239099,
	mpREGMARK_ERR_MPLINK_IN_USE = -1064239098,
	mpREGMARK_ERR_CONFIG_NULL = -1064239096,
	mpREGMARK_ERR_CONFIG_NO_PV = -1064239095,
	mpREGMARK_ERR_CONFIG_LOAD = -1064239094,
	mpREGMARK_WRN_CONFIG_LOAD = -2137980917,
	mpREGMARK_ERR_CONFIG_SAVE = -1064239092,
	mpREGMARK_ERR_CONFIG_INVALID = -1064239091,
	mpREGMARK_ERR_CONFIG_PAR = -1064018944,
	mpREGMARK_WRN_CONFIG_NOT_SAVED = -2137760767,
	mpREGMARK_ERR_LIBRARY_MISSING = -1064018942,
	mpREGMARK_ERR_AXIS_ERROR = -1064018941,
	mpREGMARK_ERR_COMMAND_INVALID = -1064018940,
	mpREGMARK_WRN_MISSED_MARK = -2137760763,
	mpREGMARK_ERR_AR_NOT_SUPPORTED = -1064018938
} MpRegMarkErrorEnum;

typedef enum MpRegMarkAlarmEnum
{	mpREGMARK_ALM_PAR_INVALID = 0,
	mpREGMARK_ALM_CONFIG_NOT_SAVED = 1,
	mpREGMARK_ALM_COMMAND_INVALID = 2,
	mpREGMARK_ALM_MISSED_MARK = 3
} MpRegMarkAlarmEnum;

typedef struct MpRegMarkDtnDetectionInfoType
{	unsigned long ConsecutiveValidMarks;
	unsigned long TotalValidMarks;
	unsigned long ConsecutiveMissedMarks;
	unsigned long TotalMissedMarks;
	plcbit AutomaticSearchActive;
} MpRegMarkDtnDetectionInfoType;

typedef struct MpRegMarkStatusIDType
{	enum MpRegMarkErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpRegMarkStatusIDType;

typedef struct MpRegMarkDiagType
{	struct MpRegMarkStatusIDType StatusID;
} MpRegMarkDiagType;

typedef struct MpRegMarkDetectionInfoType
{	enum MpRegMarkDetectionStateEnum State;
	struct MpRegMarkDtnDetectionInfoType Detection;
	struct MpRegMarkDiagType Diag;
} MpRegMarkDetectionInfoType;

typedef struct MpRegMarkInfoType
{	struct MpRegMarkDiagType Diag;
} MpRegMarkInfoType;

typedef struct MpRegMarkSensorSignalSourceType
{	enum MpRegMarkSensorSignalSourceEnum Type;
	unsigned short ParID;
} MpRegMarkSensorSignalSourceType;

typedef struct MpRegMarkSensorDelayType
{	enum MpRegMarkSensorDelayEnum Type;
	float ResponseTime;
	float AdditionalDelayTime;
} MpRegMarkSensorDelayType;

typedef struct MpRegMarkNettimeTimeStampType
{	plcstring ChannelMapping[256];
} MpRegMarkNettimeTimeStampType;

typedef struct MpRegMarkSensorEdgeNettimeType
{	struct MpRegMarkNettimeTimeStampType TimeStamp;
} MpRegMarkSensorEdgeNettimeType;

typedef struct MpRegMarkSensorSignalType
{	enum MpRegMarkSensorSignalEnum Type;
	plcstring AxisReference[256];
	struct MpRegMarkSensorSignalSourceType Source;
	struct MpRegMarkSensorDelayType DelayCompensation;
	struct MpRegMarkSensorEdgeNettimeType RisingEdge;
	struct MpRegMarkSensorEdgeNettimeType FallingEdge;
} MpRegMarkSensorSignalType;

typedef struct MpRegMarkProductPositionSrcType
{	enum MpRegMarkProductPositionSrcEnum Type;
	unsigned short ParID;
} MpRegMarkProductPositionSrcType;

typedef struct MpRegMarkProductPositionType
{	enum MpRegMarkProductPositionEnum Type;
	plcstring AxisReference[256];
	struct MpRegMarkProductPositionSrcType Source;
} MpRegMarkProductPositionType;

typedef struct MpRegMarkProductLengthType
{	enum MpRegMarkProductLengthTypeEnum Type;
	double Value;
} MpRegMarkProductLengthType;

typedef struct MpRegMarkProductType
{	struct MpRegMarkProductPositionType Position;
	struct MpRegMarkProductLengthType Length;
} MpRegMarkProductType;

typedef struct MpRegMarkIntervalPositionSrcType
{	enum MpRegMarkIntervalPositionSrcEnum Type;
	unsigned short ParID;
} MpRegMarkIntervalPositionSrcType;

typedef struct MpRegMarkIntervalPositionType
{	enum MpRegMarkIntervalPositionEnum Type;
	plcstring AxisReference[256];
	struct MpRegMarkIntervalPositionSrcType Source;
} MpRegMarkIntervalPositionType;

typedef struct MpRegMarkIntervalLengthType
{	enum MpRegMarkIntervalLengthTypeEnum Type;
	double Value;
} MpRegMarkIntervalLengthType;

typedef struct MpRegMarkIntervalDelayType
{	enum MpRegMarkIntervalDelayEnum Type;
	float DelayTime;
} MpRegMarkIntervalDelayType;

typedef struct MpRegMarkIntervalType
{	enum MpRegMarkIntervalTypeEnum Type;
	struct MpRegMarkIntervalPositionType Position;
	struct MpRegMarkIntervalLengthType Length;
	struct MpRegMarkIntervalDelayType DelayCompensation;
} MpRegMarkIntervalType;

typedef struct MpRegMarkMeasurementType
{	enum MpRegMarkMeasurementTypeEnum Type;
	struct MpRegMarkProductType Product;
	struct MpRegMarkIntervalType Interval;
} MpRegMarkMeasurementType;

typedef struct MpRegMarkExpWindowShiftType
{	enum MpRegMarkExpWindowShiftEnum Type;
	double Length;
	enum MpRegMarkExpWindowShiftModeEnum Mode;
} MpRegMarkExpWindowShiftType;

typedef struct MpRegMarkExpectationWindowType
{	plcbit Enable;
	struct MpRegMarkExpWindowShiftType Shift;
	double Width;
} MpRegMarkExpectationWindowType;

typedef struct MpRegMarkWidthMonitoringType
{	plcbit Enable;
	double MinimumWidth;
	double MaximumWidth;
} MpRegMarkWidthMonitoringType;

typedef struct MpRegMarkMissedMarkPositionTyp
{	enum MpRegMarkMissedMarkPositionEnum Type;
} MpRegMarkMissedMarkPositionTyp;

typedef struct MpRegMarkMissedMarkSearchTyp
{	plcbit Enable;
	unsigned short MissedTriggerCount;
	double AdditionalExpectationWindowShift;
} MpRegMarkMissedMarkSearchTyp;

typedef struct MpRegMarkMissedMarkReactionType
{	struct MpRegMarkMissedMarkPositionTyp MarkPosition;
	struct MpRegMarkMissedMarkSearchTyp AutomaticSearch;
} MpRegMarkMissedMarkReactionType;

typedef struct MpRegMarkDetectionType
{	enum MpRegMarkDetectionEdgeEnum Type;
	double SetMarkPosition;
	struct MpRegMarkExpectationWindowType ExpectationWindow;
	struct MpRegMarkWidthMonitoringType MarkWidthMonitoring;
	struct MpRegMarkMissedMarkReactionType MissedMarkReaction;
} MpRegMarkDetectionType;

typedef struct MpRegMarkDtnOutSignalType
{	plcstring ActualMarkPosition[256];
	plcstring MarkPositionError[256];
	plcstring ActualProductLength[256];
	plcstring ActualIntervalLength[256];
} MpRegMarkDtnOutSignalType;

typedef struct MpRegMarkDetectionConfigType
{	struct MpRegMarkSensorSignalType SensorSignal;
	struct MpRegMarkMeasurementType Measurement;
	struct MpRegMarkDetectionType Detection;
	struct MpRegMarkDtnOutSignalType OutputSignals;
} MpRegMarkDetectionConfigType;

typedef struct MpRegMarkDetection
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRegMarkDetectionInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Detect;
	plcbit Search;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit DetectionBusy;
	plcbit DetectionActive;
	plcbit DetectionTrigger;
	plcbit SearchBusy;
	plcbit SearchActive;
	plcbit SearchDone;
} MpRegMarkDetection_typ;

typedef struct MpRegMarkDetectionConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpRegMarkDetectionConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRegMarkInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpRegMarkDetectionConfig_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpRegMarkDetection(struct MpRegMarkDetection* inst);
_BUR_PUBLIC void MpRegMarkDetectionConfig(struct MpRegMarkDetectionConfig* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPREGMARK_ */

