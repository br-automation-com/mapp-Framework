/* Automation Studio generated header file */
/* Do not edit ! */
/* UtWs 2.01.0 */

#ifndef _UTWS_
#define _UTWS_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _UtWs_VERSION
#define _UtWs_VERSION 2.01.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "astime.h"
		#include "UtMgr.h"
#endif
#ifdef _SG3
		#include "astime.h"
		#include "UtMgr.h"
#endif
#ifdef _SGC
		#include "astime.h"
		#include "UtMgr.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef struct UtWsStatistics
{
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TestsCalled;
	unsigned long MaxResponseBytes;
	unsigned long MaxTestRunningSeconds;
	plcstring CurrentTest[81];
	plcstring LastCalledTest[81];
	unsigned long LastTestRunningSeconds;
	unsigned long LastTestTotalTestCases;
	unsigned long LastTestPassedTestCases;
	unsigned long LastTestTotalAsserts;
	unsigned long LastTestPassedAsserts;
	unsigned long LastTestFailedAsserts;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit TestActive;
} UtWsStatistics_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void UtWsStatistics(struct UtWsStatistics* inst);


#ifdef __cplusplus
};
#endif
#endif /* _UTWS_ */

