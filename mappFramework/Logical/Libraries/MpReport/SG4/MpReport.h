/* Automation Studio generated header file */
/* Do not edit ! */
/* MpReport 5.18.0 */

#ifndef _MPREPORT_
#define _MPREPORT_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpReport_VERSION
#define _MpReport_VERSION 5.18.0
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
typedef enum MpReportErrorEnum
{	mpREPORT_NO_ERROR = 0,
	mpREPORT_ERR_ACTIVATION = -1064239103,
	mpREPORT_ERR_MPLINK_NULL = -1064239102,
	mpREPORT_ERR_MPLINK_INVALID = -1064239101,
	mpREPORT_ERR_MPLINK_CHANGED = -1064239100,
	mpREPORT_ERR_MPLINK_CORRUPT = -1064239099,
	mpREPORT_ERR_MPLINK_IN_USE = -1064239098,
	mpREPORT_ERR_CONFIG_INVALID = -1064239091,
	mpREPORT_ERR_TEXT_IDENT = -1064112128,
	mpREPORT_ERR_LANGUAGE = -1064112127,
	mpREPORT_ERR_INVALID_FILE_DEV = -1064112126,
	mpREPORT_ERR_INVALID_REPORT = -1064112125,
	mpREPORT_ERR_GENERATE_REPORT = -1064112124
} MpReportErrorEnum;

typedef enum MpReportCoreAlarmEnum
{	mpREPORT_ALM_GENERATE_FAILED = 0
} MpReportCoreAlarmEnum;

typedef struct MpReportStatusIDType
{	enum MpReportErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpReportStatusIDType;

typedef struct MpReportDiagType
{	struct MpReportStatusIDType StatusID;
} MpReportDiagType;

typedef struct MpReportCoreInfoType
{	unsigned long NumberOfReports;
	plcstring GeneratedFileName[51];
	struct MpReportDiagType Diag;
} MpReportCoreInfoType;

typedef struct MpReportCore
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*Name);
	plcstring (*Language);
	plcstring (*DeviceName);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpReportCoreInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Generate;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpReportCore_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpReportCore(struct MpReportCore* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPREPORT_ */

