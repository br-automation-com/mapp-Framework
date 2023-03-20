/* Automation Studio generated header file */
/* Do not edit ! */
/* MpPackML 5.18.0 */

#ifndef _MPPACKML_
#define _MPPACKML_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpPackML_VERSION
#define _MpPackML_VERSION 5.18.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
		#include "astime.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
		#include "astime.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
		#include "astime.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpPackMLStateEnum
{	mpPACKML_STATE_UNDEFINED = 0,
	mpPACKML_STATE_CLEARING = 1,
	mpPACKML_STATE_STOPPED = 2,
	mpPACKML_STATE_STARTING = 3,
	mpPACKML_STATE_IDLE = 4,
	mpPACKML_STATE_SUSPENDED = 5,
	mpPACKML_STATE_EXECUTE = 6,
	mpPACKML_STATE_STOPPING = 7,
	mpPACKML_STATE_ABORTING = 8,
	mpPACKML_STATE_ABORTED = 9,
	mpPACKML_STATE_HOLDING = 10,
	mpPACKML_STATE_HELD = 11,
	mpPACKML_STATE_UNHOLDING = 12,
	mpPACKML_STATE_SUSPENDING = 13,
	mpPACKML_STATE_UNSUSPENDING = 14,
	mpPACKML_STATE_RESETTING = 15,
	mpPACKML_STATE_COMPLETING = 16,
	mpPACKML_STATE_COMPLETE = 17,
	mpPACKML_STATE_DEACTIVATING = 30,
	mpPACKML_STATE_DEACTIVATED = 31,
	mpPACKML_STATE_ACTIVATING = 32
} MpPackMLStateEnum;

typedef enum MpPackMLPackTagsStatusEnum
{	mpPACKML_PACKTAGS_DISABLED = 0,
	mpPACKML_PACKTAGS_INIT = 1,
	mpPACKML_PACKTAGS_OK = 2,
	mpPACKML_PACKTAGS_ERROR_TAG = 6,
	mpPACKML_PACKTAGS_ERROR_TYPE = 10,
	mpPACKML_PACKTAGS_ERROR_STRUCT = 14
} MpPackMLPackTagsStatusEnum;

typedef enum MpPackMLErrorEnum
{	mpPACKML_NO_ERROR = 0,
	mpPACKML_ERR_ACTIVATION = -1064239103,
	mpPACKML_ERR_MPLINK_NULL = -1064239102,
	mpPACKML_ERR_MPLINK_INVALID = -1064239101,
	mpPACKML_ERR_MPLINK_CHANGED = -1064239100,
	mpPACKML_ERR_MPLINK_CORRUPT = -1064239099,
	mpPACKML_ERR_MPLINK_IN_USE = -1064239098,
	mpPACKML_ERR_CONFIG_LOAD = -1064239094,
	mpPACKML_ERR_CONFIG_SAVE = -1064239092,
	mpPACKML_ERR_CONFIG_INVALID = -1064239091,
	mpPACKML_INF_CORE_NOT_READY = 1083474944,
	mpPACKML_ERR_DEACTIVATION_FAIL = -1064008703,
	mpPACKML_ERR_MODE_ID_INVALID = -1064008702,
	mpPACKML_ERR_PV_ADR_NULL = -1064008701,
	mpPACKML_ERR_INVALID_PV_ADR = -1064008700,
	mpPACKML_WRN_CMD_NOT_ALLOWED = -2137750523,
	mpPACKML_WRN_ACTIV_NOT_ALLOWED = -2137750522,
	mpPACKML_ERR_MODE_ID_USED = -1064008697,
	mpPACKML_ERR_MISSING_UI_CONNECT = -1064008696,
	mpPACKML_WRN_TAGS_STR_NOT_FOUND = -2137750519,
	mpPACKML_WRN_TAGS_NOT_FOUND = -2137750518,
	mpPACKML_WRN_WRONG_TAGS_TYPE = -2137750517,
	mpPACKML_ERR_READ_MPPACKML_CFG = -1064008692,
	mpPACKML_ERR_WRITE_MPPACKML_CFG = -1064008691,
	mpPACKML_ERR_INVALID_MODULE = -1064008690,
	mpPACKML_ERR_INVALID_STATE = -1064008689,
	mpPACKML_INF_PARENT_NOT_ACTIVE = 1083474960,
	mpPACKML_WRN_AMBIQUOUS_MODE_INF = -2137750511,
	mpPACKML_ERR_INVALID_STATE_MODE = -1064008686,
	mpPACKML_ERR_INVALID_STATE_CHLD = -1064008685,
	mpPACKML_INF_MODE_CHG_FORBIDDEN = 1083474964
} MpPackMLErrorEnum;

typedef enum MpPackMLAlarmEnum
{	mpPACKML_ALM_STATE_TRANSITION = 0,
	mpPACKML_ALM_MODE_TRANSITION = 1,
	mpPACKML_ALM_WRONG_CONFIG = 2
} MpPackMLAlarmEnum;

typedef struct MpPackMLStatusIDType
{	enum MpPackMLErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpPackMLStatusIDType;

typedef struct MpPackMLDiagType
{	struct MpPackMLStatusIDType StatusID;
} MpPackMLDiagType;

typedef struct MpPackMLCoreInfoType
{	plcstring ModeCurrent[51];
	plcstring StateCurrent[21];
	struct MpPackMLDiagType Diag;
	enum MpPackMLPackTagsStatusEnum PackTagsStatus;
} MpPackMLCoreInfoType;

typedef struct MpPackMLModeInfoType
{	plcstring ModeCurrent[51];
	plcstring StateCurrent[21];
	plcbit ActivationAborted;
	struct MpPackMLDiagType Diag;
} MpPackMLModeInfoType;

typedef struct MpPackMLUIInfoType
{	plcstring ModeCurrent[51];
	plcstring StateCurrent[21];
	struct MpPackMLDiagType Diag;
} MpPackMLUIInfoType;

typedef struct MpPackMLColorIndexStatesType
{	unsigned char Clearing;
	unsigned char Stopped;
	unsigned char Starting;
	unsigned char Idle;
	unsigned char Suspended;
	unsigned char Execute;
	unsigned char Stopping;
	unsigned char Aborting;
	unsigned char Aborted;
	unsigned char Holding;
	unsigned char Held;
	unsigned char Unholding;
	unsigned char Suspending;
	unsigned char Unsuspending;
	unsigned char Resetting;
	unsigned char Completing;
	unsigned char Complete;
} MpPackMLColorIndexStatesType;

typedef struct MpPackMLBasicUIStateControlType
{	plcbit Start;
	plcbit Stop;
	plcbit Reset;
	plcbit Hold;
	plcbit Unhold;
	plcbit Suspend;
	plcbit Unsuspend;
	plcbit Abort;
	plcbit Clear;
	plcbit StateComplete;
	struct MpPackMLColorIndexStatesType ColorIndex;
} MpPackMLBasicUIStateControlType;

typedef struct MpPackMLBasicUIModeControlType
{	unsigned short SelectedIndex;
	unsigned long MaxSelection;
	plcbit LockActivation;
	plcbit Activate;
} MpPackMLBasicUIModeControlType;

typedef struct MpPackMLBasicUIConnectType
{	struct MpPackMLBasicUIStateControlType StateControl;
	struct MpPackMLBasicUIModeControlType ModeControl;
	signed long ModeCurrent;
	enum MpPackMLStateEnum StateCurrent;
} MpPackMLBasicUIConnectType;

typedef struct MpPackMLStatisticsUITimeType
{	unsigned long Hours;
	unsigned char Minutes;
	unsigned char Seconds;
} MpPackMLStatisticsUITimeType;

typedef struct MpPackMLStatisticsUIStateType
{	struct MpPackMLStatisticsUITimeType CumulativeTime;
	float CumulativePercent;
	struct MpPackMLStatisticsUITimeType CurrentTime;
} MpPackMLStatisticsUIStateType;

typedef struct MpPackMLStatisticsUIStatesType
{	struct MpPackMLStatisticsUIStateType Clearing;
	struct MpPackMLStatisticsUIStateType Stopped;
	struct MpPackMLStatisticsUIStateType Starting;
	struct MpPackMLStatisticsUIStateType Idle;
	struct MpPackMLStatisticsUIStateType Suspended;
	struct MpPackMLStatisticsUIStateType Execute;
	struct MpPackMLStatisticsUIStateType Stopping;
	struct MpPackMLStatisticsUIStateType Aborting;
	struct MpPackMLStatisticsUIStateType Aborted;
	struct MpPackMLStatisticsUIStateType Holding;
	struct MpPackMLStatisticsUIStateType Held;
	struct MpPackMLStatisticsUIStateType Unholding;
	struct MpPackMLStatisticsUIStateType Suspending;
	struct MpPackMLStatisticsUIStateType Unsuspending;
	struct MpPackMLStatisticsUIStateType Resetting;
	struct MpPackMLStatisticsUIStateType Completing;
	struct MpPackMLStatisticsUIStateType Complete;
	plcbit ResetTimers;
} MpPackMLStatisticsUIStatesType;

typedef struct MpPackMLStatisticsUIModeType
{	signed long ModeID;
	struct MpPackMLStatisticsUITimeType CumulativeTime;
	float CumulativePercent;
} MpPackMLStatisticsUIModeType;

typedef struct MpPackMLStatisticsUIConnectType
{	struct MpPackMLStatisticsUIStatesType States;
	struct MpPackMLStatisticsUIModeType Mode;
	signed long ModeCurrent;
	enum MpPackMLStateEnum StateCurrent;
} MpPackMLStatisticsUIConnectType;

typedef struct MpPackMLModuleCommandType
{	plcbit Abort;
	plcbit Clear;
	plcbit Stop;
	plcbit Reset;
	plcbit Start;
	plcbit Hold;
	plcbit Unhold;
	plcbit Suspend;
	plcbit Unsuspend;
	plcbit StateComplete;
} MpPackMLModuleCommandType;

typedef struct MpPackMLModuleOverwriteType
{	plcbit Abort;
	plcbit Stop;
	plcbit AllOtherCommands;
} MpPackMLModuleOverwriteType;

typedef struct MpPackMLModuleEscalateType
{	plcbit Abort;
} MpPackMLModuleEscalateType;

typedef struct MpPackMLModuleParType
{	struct MpPackMLModuleOverwriteType Overwrite;
	struct MpPackMLModuleEscalateType Escalate;
} MpPackMLModuleParType;

typedef struct MpPackMLParentType
{	plcstring Name[256];
	enum MpPackMLStateEnum StateCurrent;
	signed long SubStateCurrent;
} MpPackMLParentType;

typedef struct MpPackMLModuleInfoType
{	plcstring ModeCurrent[51];
	plcstring StateCurrent[21];
	unsigned long ChildCount;
	struct MpPackMLParentType Parent;
	unsigned long Level;
	plcbit ReadyForCommand;
	struct MpPackMLDiagType Diag;
} MpPackMLModuleInfoType;

typedef struct MpPackMLModulePVType
{	plcstring Name[256];
	enum MpPackMLStateEnum StateCurrent;
	signed long SubStateCurrent;
	plcstring StateInfo[256];
} MpPackMLModulePVType;

typedef struct MpPackMLCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	signed long ModeCurrent;
	enum MpPackMLStateEnum StateCurrent;
	struct MpPackMLCoreInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpPackMLCore_typ;

typedef struct MpPackMLMode
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	signed long ModeID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	enum MpPackMLStateEnum StateCurrent;
	struct MpPackMLModeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Activate;
	plcbit Start;
	plcbit Stop;
	plcbit Reset;
	plcbit Hold;
	plcbit Unhold;
	plcbit Suspend;
	plcbit Unsuspend;
	plcbit Abort;
	plcbit Clear;
	plcbit StateComplete;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit ChangeModeAllowed;
	plcbit ModeActive;
} MpPackMLMode_typ;

typedef struct MpPackMLBasicUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpPackMLBasicUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpPackMLUIInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpPackMLBasicUI_typ;

typedef struct MpPackMLStatisticsUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpPackMLStatisticsUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpPackMLUIInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpPackMLStatisticsUI_typ;

typedef struct MpPackMLModule
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpPackMLModuleParType* Parameters;
	struct MpPackMLModuleCommandType Command;
	signed long SubState;
	plcstring StateInfo[256];
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	enum MpPackMLStateEnum StateCurrent;
	signed long SubStateCurrent;
	signed long ModeID;
	struct MpPackMLModuleInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Blocked;
	plcbit Starved;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MpPackMLModule_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpPackMLCore(struct MpPackMLCore* inst);
_BUR_PUBLIC void MpPackMLMode(struct MpPackMLMode* inst);
_BUR_PUBLIC void MpPackMLBasicUI(struct MpPackMLBasicUI* inst);
_BUR_PUBLIC void MpPackMLStatisticsUI(struct MpPackMLStatisticsUI* inst);
_BUR_PUBLIC void MpPackMLModule(struct MpPackMLModule* inst);
_BUR_PUBLIC signed long MpPackMLModeChangeIsAllowed(struct MpComIdentType* MpLink, signed long ModeID);
_BUR_PUBLIC signed long MpPackMLChangeMode(struct MpComIdentType* MpLink, signed long ModeID);
_BUR_PUBLIC signed long MpPackMLModeCurrent(struct MpComIdentType* MpLink);
_BUR_PUBLIC MpPackMLStateEnum MpPackMLStateCurrent(struct MpComIdentType* MpLink);
_BUR_PUBLIC plcbit MpPackMLStateIsActive(struct MpComIdentType* MpLink, enum MpPackMLStateEnum State, signed long Mode);
_BUR_PUBLIC plcbit MpPackMLModeIsActive(struct MpComIdentType* MpLink, signed long Mode);
_BUR_PUBLIC plcbit MpPackMLStateComplete(struct MpComIdentType* MpLink, signed long Mode);
_BUR_PUBLIC plcbit MpPackMLAbort(struct MpComIdentType* MpLink, signed long Mode);


#ifdef __cplusplus
};
#endif
#endif /* _MPPACKML_ */

