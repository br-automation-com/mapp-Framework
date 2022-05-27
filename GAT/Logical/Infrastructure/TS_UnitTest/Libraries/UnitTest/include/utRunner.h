/********************************************************************
 * COPYRIGHT B+R
 ********************************************************************
 * Library: utRunner
 * File: utRunner.h
 * Author: B+R
 *******************************************************************/

#ifndef	__UT_RUNNER_H__
#define	__UT_RUNNER_H__

#include <bur/plctypes.h>

#include "UnitTest.h"
#include "UtMgr.h"
#include "include/TestCaller.h"

#ifdef __cplusplus
extern "C"
{
#endif

void utInit(UtMgrTestSuite_typ *TestSuiteRef);
void utCyclic(UtMgrTestSuite_typ *TestSuiteRef);
void utExit(UtMgrTestSuite_typ *TestSuiteRef);

#ifdef __cplusplus
};
#endif

#endif/*__UT_RUNNER_H__*/
