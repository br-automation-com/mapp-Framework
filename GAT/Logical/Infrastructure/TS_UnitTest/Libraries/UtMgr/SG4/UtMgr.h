/* Automation Studio generated header file */
/* Do not edit ! */
/* UtMgr 2.01.0 */

#ifndef _UTMGR_
#define _UTMGR_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _UtMgr_VERSION
#define _UtMgr_VERSION 2.01.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "Runtime.h"
#endif



/* Constants */
#ifdef _REPLACE_CONST
 #define utERR_GENERAL (-1057750784)
 #define utMgrERR_INVALID_PARAM (-1057750783)
 #define utMgrERR_TOO_MANY_TESTS (-1057750782)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long utERR_GENERAL;
 _GLOBAL_CONST signed long utMgrERR_INVALID_PARAM;
 _GLOBAL_CONST signed long utMgrERR_TOO_MANY_TESTS;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum UtMgrTestTypeEnum
{	utMgrTEST_TYPE_NONE = 0,
	utMgrTEST_TYPE_C = 10,
	utMgrTEST_TYPE_OTHER = 20
} UtMgrTestTypeEnum;

typedef enum UtMgrTestPhaseBasicHelperEnum
{	utMgrTEST_PHASE_IDLE = 0,
	utMgrTEST_PHASE_RUNNING = 5,
	utMgrTEST_PHASE_DONE = 10
} UtMgrTestPhaseBasicHelperEnum;

typedef struct UtMgrLocationType
{	unsigned long TestSetName;
	unsigned long TestCaseName;
	unsigned long Line;
	unsigned long Location;
	unsigned long File;
} UtMgrLocationType;

typedef struct UtMgrInformationalType
{	unsigned long TestCasesSinceActiveCounter;
	unsigned long FailedAssertCounter;
	unsigned long PassedAssertCounter;
	unsigned long InformationalMessageCounter;
	struct UtMgrLocationType LastKnownPassedLocation;
} UtMgrInformationalType;

typedef struct UtMgrUnitTestRunnerHelperType
{	unsigned long TestSets;
	unsigned short TestSetCount;
	enum UtMgrTestPhaseBasicHelperEnum CurrentPhase;
	unsigned short CurrentTestSet;
} UtMgrUnitTestRunnerHelperType;

typedef struct UtMgrSuiteInternalType
{	signed long State;
	unsigned long Handle;
	unsigned long List[30];
	unsigned long LibInst;
	struct UtMgrUnitTestRunnerHelperType TestHelper;
} UtMgrSuiteInternalType;

typedef struct UtMgrTestSuite
{
	/* VAR_INPUT (analog) */
	plcstring Name[81];
	plcstring Description[201];
	enum UtMgrTestTypeEnum Type;
	plcstring MetaInformation[201];
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct UtMgrInformationalType Informational;
	/* VAR (analog) */
	struct UtMgrSuiteInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit TestAborted;
	plcbit TestFinished;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit TestActive;
	plcbit TestFinishedAck;
	plcbit TestFinishedDone;
} UtMgrTestSuite_typ;

typedef struct UtMgrMonitor
{
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct UtMgrInformationalType Informational;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit TestActive;
} UtMgrMonitor_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void UtMgrTestSuite(struct UtMgrTestSuite* inst);
_BUR_PUBLIC void UtMgrMonitor(struct UtMgrMonitor* inst);
_BUR_PUBLIC signed long UtMgrTestRunnerRunTest(unsigned long TestSet);




#ifdef __cplusplus
};
#endif
#endif /* _UTMGR_ */

