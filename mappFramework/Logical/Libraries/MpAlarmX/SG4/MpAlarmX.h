/* Automation Studio generated header file */
/* Do not edit ! */
/* MpAlarmX 5.18.0 */

#ifndef _MPALARMX_
#define _MPALARMX_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpAlarmX_VERSION
#define _MpAlarmX_VERSION 5.18.0
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
typedef enum MpAlarmXListUIStatusEnum
{	mpALARMX_LIST_UI_STATUS_IDLE = 0,
	mpALARMX_LIST_UI_STATUS_ERROR = 99
} MpAlarmXListUIStatusEnum;

typedef enum MpAlarmXStateEnum
{	mpALARMX_STATE_NONE = 0,
	mpALARMX_STATE_ACTIVE = 1,
	mpALARMX_STATE_INACTIVE = 2,
	mpALARMX_STATE_ACKNOWLEDGED = 3,
	mpALARMX_STATE_UNACKNOWLEDGED = 4
} MpAlarmXStateEnum;

typedef enum MpAlarmXAcknowledgeConfigEnum
{	mpALARMX_ACK_DISABLED = 0,
	mpALARMX_ACK_REQ = 1,
	mpALARMX_ACK_REQ_AFTER_ACTIVE = 2,
	mpALARMX_ACK_REQ_RESETTABLE = 3
} MpAlarmXAcknowledgeConfigEnum;

typedef enum MpAlarmXHistoryUIStatusEnum
{	mpALARMX_HISTORY_UI_STATUS_IDLE = 0,
	mpALARMX_HISTORY_UI_STATUS_ERROR = 99
} MpAlarmXHistoryUIStatusEnum;

typedef enum MpAlarmXQueryModeEnum
{	mpALARMX_QUERY_MODE_ALL = 0,
	mpALARMX_QUERY_MODE_NEW = 1
} MpAlarmXQueryModeEnum;

typedef enum MpAlarmXMappingTypeEnum
{	mpALARMX_MAPPING_TYPE_ALARM_NAME = 0,
	mpALARMX_MAPPING_TYPE_SEVERITY = 1,
	mpALARMX_MAPPING_TYPE_DEFAULT = 2
} MpAlarmXMappingTypeEnum;

typedef enum MpAlarmXActionEnum
{	mpALARMX_ACT_NONE = 0,
	mpALARMX_ACT_REACTION = 1,
	mpALARMX_ACT_ESCALATE_ALARM = 2,
	mpALARMX_ACT_ESCALATE_REACTION = 3,
	mpALARMX_ACT_REPLACE_ALARM = 4,
	mpALARMX_ACT_SEND_MESSAGE = 5,
	mpALARMX_ACT_REMAIN = 6,
	mpALARMX_ACT_AGGREGATE = 7,
	mpALARMX_ACT_AGGREGATE_LOCAL = 8
} MpAlarmXActionEnum;

typedef enum MpAlarmXErrorEnum
{	mpALARMX_NO_ERROR = 0,
	mpALARMX_ERR_ACTIVATION = -1064239103,
	mpALARMX_ERR_MPLINK_NULL = -1064239102,
	mpALARMX_ERR_MPLINK_INVALID = -1064239101,
	mpALARMX_ERR_MPLINK_CHANGED = -1064239100,
	mpALARMX_ERR_MPLINK_CORRUPT = -1064239099,
	mpALARMX_ERR_MPLINK_IN_USE = -1064239098,
	mpALARMX_ERR_CONFIG_NULL = -1064239096,
	mpALARMX_ERR_CONFIG_NO_PV = -1064239095,
	mpALARMX_ERR_CONFIG_INVALID = -1064239091,
	mpALARMX_ERR_NAME_NULL = -1064116224,
	mpALARMX_ERR_NAME_EMPTY = -1064116223,
	mpALARMX_WRN_MISSING_UICONNECT = -2137858045,
	mpALARMX_ERR_ALARM_NOT_ACTIVE = -1064116220,
	mpALARMX_ERR_ALARM_NOT_SELECTED = -1064116219,
	mpALARMX_ERR_ACK_NOT_ALLOWED = -1064116218,
	mpALARMX_ERR_INVALID_FILE_DEV = -1064116217,
	mpALARMX_INF_WAIT_CORE_FB = 1083367432,
	mpALARMX_ERR_CORE_INST_EXISTS = -1064116215,
	mpALARMX_ERR_MEMORY_INIT = -1064116214,
	mpALARMX_ERR_WRITE_EXPORT_FILE = -1064116213,
	mpALARMX_ERR_NAME_NOT_FOUND = -1064116212,
	mpALARMX_ERR_QUERY_NOT_FOUND = -1064116211,
	mpALARMX_INF_QUERY_NO_DATA = 1083367438,
	mpALARMX_WRN_QUERY_INCONSISTENT = -2137858033
} MpAlarmXErrorEnum;

typedef struct MpAlarmXStatusIDType
{	enum MpAlarmXErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpAlarmXStatusIDType;

typedef struct MpAlarmXDiagType
{	struct MpAlarmXStatusIDType StatusID;
} MpAlarmXDiagType;

typedef struct MpAlarmXInfoType
{	struct MpAlarmXDiagType Diag;
} MpAlarmXInfoType;

typedef struct MpAlarmXQueryInfoType
{	unsigned long AvailableSpace;
	unsigned long RowsRead;
	plcbit HasMoreRows;
	struct MpAlarmXDiagType Diag;
} MpAlarmXQueryInfoType;

typedef struct MpAlarmXAcknowledgeAllInfoType
{	unsigned long UnacknowledgedAlarms;
	struct MpAlarmXDiagType Diag;
} MpAlarmXAcknowledgeAllInfoType;

typedef struct MpAlarmXControlInfoType
{	struct MpAlarmXDiagType Diag;
} MpAlarmXControlInfoType;

typedef struct MpAlarmXListUIBacktraceType
{	unsigned long RecordID[5];
	plcstring LogbookName[5][101];
	signed long EventID[5];
	plcstring Description[5][256];
} MpAlarmXListUIBacktraceType;

typedef struct MpAlarmXListUIAlarmListType
{	unsigned long Severity[50];
	unsigned long Code[50];
	plcwstring Message[50][256];
	plcwstring AdditionalInformation1[50][256];
	plcwstring AdditionalInformation2[50][256];
	unsigned long InstanceID[50];
	plcstring Scope[50][256];
	plcstring Name[50][256];
	plcbit StateActive[50];
	plcbit StateAcknowledged[50];
	plcstring Timestamp[50][51];
	unsigned short SelectedIndex;
	unsigned short MaxSelection;
	plcbit PageUp;
	plcbit PageDown;
	plcbit StepUp;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpAlarmXListUIAlarmListType;

typedef struct MpAlarmXListUIDetailsType
{	unsigned long Severity;
	unsigned long Code;
	plcwstring Message[256];
	plcwstring AdditionalInformation1[256];
	plcwstring AdditionalInformation2[256];
	unsigned long InstanceID;
	plcstring Scope[256];
	plcstring Name[256];
	plcbit StateActive;
	plcbit StateAcknowledged;
	plcstring Timestamp[51];
	struct MpAlarmXListUIBacktraceType Backtrace;
} MpAlarmXListUIDetailsType;

typedef struct MpAlarmXListUIConnectType
{	enum MpAlarmXListUIStatusEnum Status;
	struct MpAlarmXListUIAlarmListType AlarmList;
	plcbit Acknowledge;
	plcbit AcknowledgeAll;
	struct MpAlarmXListUIDetailsType Details;
	plcstring Language[21];
	unsigned long AcknowledgeID;
} MpAlarmXListUIConnectType;

typedef struct MpAlarmXListUISetupType
{	unsigned short AlarmListSize;
	unsigned char AlarmListScrollWindow;
	plcstring TimeStampPattern[51];
} MpAlarmXListUISetupType;

typedef struct MpAlarmXHistoryUIAlarmListType
{	unsigned long Severity[50];
	unsigned long Code[50];
	plcwstring Message[50][256];
	plcwstring AdditionalInformation1[50][256];
	plcwstring AdditionalInformation2[50][256];
	plcstring Scope[50][256];
	plcstring Name[50][256];
	enum MpAlarmXStateEnum OldState[50];
	enum MpAlarmXStateEnum NewState[50];
	plcstring Timestamp[50][51];
	unsigned short SelectedIndex;
	unsigned short MaxSelection;
	plcbit PageUp;
	plcbit PageDown;
	plcbit StepUp;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpAlarmXHistoryUIAlarmListType;

typedef struct MpAlarmXHistoryUIDetailsType
{	unsigned long Severity;
	unsigned long Code;
	plcwstring Message[256];
	plcwstring AdditionalInformation1[256];
	plcwstring AdditionalInformation2[256];
	plcstring Scope[256];
	plcstring Name[256];
	enum MpAlarmXStateEnum OldState;
	enum MpAlarmXStateEnum NewState;
	plcstring Timestamp[51];
	plcstring DataDescriptions[10][51];
	plcstring DataValues[10][256];
} MpAlarmXHistoryUIDetailsType;

typedef struct MpAlarmXHistoryUIConnectType
{	enum MpAlarmXHistoryUIStatusEnum Status;
	struct MpAlarmXHistoryUIAlarmListType AlarmList;
	struct MpAlarmXHistoryUIDetailsType Details;
	plcstring Language[21];
} MpAlarmXHistoryUIConnectType;

typedef struct MpAlarmXHistoryUISetupType
{	unsigned short AlarmListSize;
	unsigned char AlarmListScrollWindow;
	plcstring TimeStampPattern[51];
} MpAlarmXHistoryUISetupType;

typedef struct MpAlarmXActionConfigType
{	enum MpAlarmXActionEnum Type;
	plcstring Name[256];
} MpAlarmXActionConfigType;

typedef struct MpAlarmXMappingConfigType
{	struct MpAlarmXActionConfigType Action[20];
} MpAlarmXMappingConfigType;

typedef struct MpAlarmXHistoryReportType
{	plcbit InactiveToActive;
	plcbit ActiveToInactive;
	plcbit UnacknowledgedToAcknowledged;
	plcbit AcknowledgedToUnacknowledged;
	plcbit Reactivation;
} MpAlarmXHistoryReportType;

typedef struct MpAlarmXActivationUpdateType
{	plcbit Timestamp;
	plcbit Snippet;
} MpAlarmXActivationUpdateType;

typedef struct MpAlarmXUpdateBehaviorType
{	struct MpAlarmXActivationUpdateType Activation;
} MpAlarmXUpdateBehaviorType;

typedef struct MpAlarmXBehaviorType
{	plcbit AutoReset;
	enum MpAlarmXAcknowledgeConfigEnum Acknowledge;
	plcbit MultipleInstances;
	plcbit ReactionUntilAcknowledged;
	plcbit Retain;
	plcbit Async;
	struct MpAlarmXHistoryReportType HistoryReport;
	struct MpAlarmXUpdateBehaviorType DataUpdate;
} MpAlarmXBehaviorType;

typedef struct MpAlarmXAlarmConfigType
{	plcstring Message[256];
	unsigned long Code;
	unsigned long Severity;
	struct MpAlarmXBehaviorType Behavior;
	plcbit Disable;
	plcstring AdditionalInformation1[256];
	plcstring AdditionalInformation2[256];
} MpAlarmXAlarmConfigType;

typedef struct MpAlarmXCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long ActiveAlarms;
	unsigned long PendingAlarms;
	struct MpAlarmXInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpAlarmXCore_typ;

typedef struct MpAlarmXListUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpAlarmXListUISetupType UISetup;
	struct MpAlarmXListUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpAlarmXListUI_typ;

typedef struct MpAlarmXHistoryUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpAlarmXHistoryUISetupType UISetup;
	struct MpAlarmXHistoryUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpAlarmXHistoryUI_typ;

typedef struct MpAlarmXHistory
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*DeviceName);
	plcstring (*Language);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Export;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpAlarmXHistory_typ;

typedef struct MpAlarmXConfigAlarm
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*Name);
	struct MpAlarmXAlarmConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXInfoType Info;
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
} MpAlarmXConfigAlarm_typ;

typedef struct MpAlarmXConfigMapping
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	enum MpAlarmXMappingTypeEnum Type;
	plcstring (*Name);
	struct MpAlarmXMappingConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXInfoType Info;
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
} MpAlarmXConfigMapping_typ;

typedef struct MpAlarmXQuery
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*Language);
	enum MpAlarmXQueryModeEnum Mode;
	plcstring (*Name);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXQueryInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Execute;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpAlarmXQuery_typ;

typedef struct MpAlarmXAcknowledgeAll
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpAlarmXAcknowledgeAllInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpAlarmXAcknowledgeAll_typ;

typedef struct MpAlarmXAlarmControl
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*Name);
	unsigned long ID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long InstanceID;
	struct MpAlarmXControlInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Set;
	plcbit Reset;
	plcbit Acknowledge;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpAlarmXAlarmControl_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpAlarmXCore(struct MpAlarmXCore* inst);
_BUR_PUBLIC void MpAlarmXListUI(struct MpAlarmXListUI* inst);
_BUR_PUBLIC void MpAlarmXHistoryUI(struct MpAlarmXHistoryUI* inst);
_BUR_PUBLIC void MpAlarmXHistory(struct MpAlarmXHistory* inst);
_BUR_PUBLIC void MpAlarmXConfigAlarm(struct MpAlarmXConfigAlarm* inst);
_BUR_PUBLIC void MpAlarmXConfigMapping(struct MpAlarmXConfigMapping* inst);
_BUR_PUBLIC void MpAlarmXQuery(struct MpAlarmXQuery* inst);
_BUR_PUBLIC void MpAlarmXAcknowledgeAll(struct MpAlarmXAcknowledgeAll* inst);
_BUR_PUBLIC void MpAlarmXAlarmControl(struct MpAlarmXAlarmControl* inst);
_BUR_PUBLIC plcbit MpAlarmXCheckState(struct MpComIdentType* MpLink, plcstring* Name, enum MpAlarmXStateEnum State);
_BUR_PUBLIC plcbit MpAlarmXCheckStateID(struct MpComIdentType* MpLink, unsigned long InstanceID, enum MpAlarmXStateEnum State);
_BUR_PUBLIC plcbit MpAlarmXCheckReaction(struct MpComIdentType* MpLink, plcstring* Name);
_BUR_PUBLIC unsigned long MpAlarmXSet(struct MpComIdentType* MpLink, plcstring* Name);
_BUR_PUBLIC signed long MpAlarmXAcknowledge(struct MpComIdentType* MpLink, plcstring* Name);
_BUR_PUBLIC signed long MpAlarmXAcknowledgeID(struct MpComIdentType* MpLink, unsigned long InstanceID);
_BUR_PUBLIC signed long MpAlarmXReset(struct MpComIdentType* MpLink, plcstring* Name);
_BUR_PUBLIC signed long MpAlarmXResetID(struct MpComIdentType* MpLink, unsigned long InstanceID);
_BUR_PUBLIC signed long MpAlarmXClearHistory(struct MpComIdentType* MpLink);


#ifdef __cplusplus
};
#endif
#endif /* _MPALARMX_ */

