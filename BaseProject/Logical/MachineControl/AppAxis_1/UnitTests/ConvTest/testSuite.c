/********************************************************************
 * COPYRIGHT --
 ********************************************************************
 * Program: -
 * Author:
 * Created:
 ********************************************************************
 * Test registration and handshake
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <string.h>

void _INIT initTestSuite(void)
{
	utInit(&Testsuite);
}


void _CYCLIC cyclicWithTest(void)
{
	utCyclic(&Testsuite);

    if (Testsuite.Informational.LastKnownPassedLocation.TestCaseName != 0)
        strcpy((char*)&lastTestCase, (char*)Testsuite.Informational.LastKnownPassedLocation.TestCaseName);
    if (Testsuite.Informational.LastKnownPassedLocation.TestSetName != 0)
        strcpy((char*)&lastTestSet, (char*)Testsuite.Informational.LastKnownPassedLocation.TestSetName);
}


void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}


