/* Automation Studio generated header file */
/* Do not edit ! */
/* MpBackup 5.16.1 */

#ifndef _MPBACKUP_
#define _MPBACKUP_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpBackup_VERSION
#define _MpBackup_VERSION 5.16.1
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
typedef enum MpBackupGenerationTypeEnum
{	mpBACKUP_GENERATION_AUTO = 1,
	mpBACKUP_GENERATION_MANUAL = 0
} MpBackupGenerationTypeEnum;

typedef enum MpBackupIntervalEnum
{	mpBACKUP_INTERVAL_DAILY = 0,
	mpBACKUP_INTERVAL_WEEKLY = 1
} MpBackupIntervalEnum;

typedef enum MpBackupDayEnum
{	mpBACKUP_DAY_MONDAY = 0,
	mpBACKUP_DAY_TUESDAY = 1,
	mpBACKUP_DAY_WEDNESDAY = 2,
	mpBACKUP_DAY_THURSDAY = 3,
	mpBACKUP_DAY_FRIDAY = 4,
	mpBACKUP_DAY_SATURDAY = 5,
	mpBACKUP_DAY_SUNDAY = 6
} MpBackupDayEnum;

typedef enum MpBackupUpdateCheckEnum
{	mpBACKUP_UPDATE_CHECK_DAILY = 0,
	mpBACKUP_UPDATE_CHECK_WEEKLY = 1,
	mpBACKUP_UPDATE_CHECK_ON_ENABLE = 2
} MpBackupUpdateCheckEnum;

typedef enum MpBackupAutoUpdateModeEnum
{	mpBACKUP_AUTO_UPDATE_DISABLED = 0,
	mpBACKUP_AUTO_UPDATE_NOTIFY = 1
} MpBackupAutoUpdateModeEnum;

typedef enum MpBackupErrorEnum
{	mpBACKUP_NO_ERROR = 0,
	mpBACKUP_ERR_ACTIVATION = -1064239103,
	mpBACKUP_ERR_MPLINK_NULL = -1064239102,
	mpBACKUP_ERR_MPLINK_INVALID = -1064239101,
	mpBACKUP_ERR_MPLINK_CHANGED = -1064239100,
	mpBACKUP_ERR_MPLINK_CORRUPT = -1064239099,
	mpBACKUP_ERR_MPLINK_IN_USE = -1064239098,
	mpBACKUP_ERR_CONFIG_NULL = -1064239096,
	mpBACKUP_ERR_CONFIG_NO_PV = -1064239095,
	mpBACKUP_ERR_CONFIG_LOAD = -1064239094,
	mpBACKUP_WRN_CONFIG_LOAD = -2137980917,
	mpBACKUP_ERR_CONFIG_SAVE = -1064239092,
	mpBACKUP_ERR_CONFIG_INVALID = -1064239091,
	mpBACKUP_ERR_INSTALL_FAILED = -1064159488,
	mpBACKUP_ERR_CREATE_FAILED = -1064159487,
	mpBACKUP_ERR_REQUEST_INFO_FAILED = -1064159486,
	mpBACKUP_WRN_UPDATE_CHECK_FAILED = -2137901309
} MpBackupErrorEnum;

typedef enum MpBackupAlarmEnum
{	mpBACKUP_ALM_CREATE_FAILED = 0,
	mpBACKUP_ALM_INSTALL_FAILED = 1,
	mpBACKUP_ALM_UPDATE_CHECK_FAILED = 2
} MpBackupAlarmEnum;

typedef struct MpBackupLastBackupType
{	plcstring Name[256];
	plcdt DateTime;
	enum MpBackupGenerationTypeEnum GenerationType;
} MpBackupLastBackupType;

typedef struct MpBackupProjectInfoCurrentType
{	plcstring ConfigurationID[256];
	plcstring ConfigurationVersion[65];
} MpBackupProjectInfoCurrentType;

typedef struct MpBackupProjectInfoRequestType
{	plcstring Name[256];
	plcstring ConfigurationID[256];
	plcstring ConfigurationVersion[65];
} MpBackupProjectInfoRequestType;

typedef struct MpBackupProjectInfoType
{	struct MpBackupProjectInfoCurrentType Current;
	struct MpBackupProjectInfoRequestType Requested;
} MpBackupProjectInfoType;

typedef struct MpBackupStatusIDType
{	enum MpBackupErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpBackupStatusIDType;

typedef struct MpBackupDiagType
{	struct MpBackupStatusIDType StatusID;
} MpBackupDiagType;

typedef struct MpBackupAutoBackupInfoType
{	plcbit InProgress;
} MpBackupAutoBackupInfoType;

typedef struct MpBackupAutoUpdateInfoType
{	plcbit IsAvailable;
	plcstring Name[256];
	plcstring ConfigurationID[256];
	plcstring ConfigurationVersion[65];
} MpBackupAutoUpdateInfoType;

typedef struct MpBackupAutoInfoType
{	struct MpBackupAutoBackupInfoType Backup;
	struct MpBackupAutoUpdateInfoType Update;
} MpBackupAutoInfoType;

typedef struct MpBackupCoreInfoType
{	struct MpBackupLastBackupType LastBackup;
	struct MpBackupProjectInfoType Project;
	struct MpBackupDiagType Diag;
	struct MpBackupAutoInfoType Automatic;
} MpBackupCoreInfoType;

typedef struct MpBackupInfoType
{	struct MpBackupDiagType Diag;
} MpBackupInfoType;

typedef struct MpBackupIntervalType
{	enum MpBackupIntervalEnum Interval;
	enum MpBackupDayEnum Day;
	plctod Time;
} MpBackupIntervalType;

typedef struct MpBackupOverwriteOldestType
{	plcbit Enabled;
	unsigned short MaximumNumberOfBackups;
} MpBackupOverwriteOldestType;

typedef struct MpBackupAutoBackupType
{	plcbit Enabled;
	plcstring NamePrefix[51];
	plcstring DeviceName[256];
	struct MpBackupIntervalType Mode;
	struct MpBackupOverwriteOldestType OverwriteOldest;
} MpBackupAutoBackupType;

typedef struct MpBackupUpdateCheckType
{	enum MpBackupUpdateCheckEnum Type;
	enum MpBackupDayEnum Day;
	plctod Time;
} MpBackupUpdateCheckType;

typedef struct MpBackupAutoUpdateType
{	enum MpBackupAutoUpdateModeEnum Mode;
	plcstring DeviceName[256];
	struct MpBackupUpdateCheckType Check;
} MpBackupAutoUpdateType;

typedef struct MpBackupCoreConfigType
{	struct MpBackupAutoBackupType AutomaticBackup;
	struct MpBackupAutoUpdateType AutomaticUpdate;
} MpBackupCoreConfigType;

typedef struct MpBackupCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*DeviceName);
	plcstring (*Name);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpBackupCoreInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Create;
	plcbit Install;
	plcbit RequestInfo;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpBackupCore_typ;

typedef struct MpBackupCoreConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpBackupCoreConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpBackupInfoType Info;
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
} MpBackupCoreConfig_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpBackupCore(struct MpBackupCore* inst);
_BUR_PUBLIC void MpBackupCoreConfig(struct MpBackupCoreConfig* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPBACKUP_ */

