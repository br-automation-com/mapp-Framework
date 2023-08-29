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
#include <stdbool.h>

void _INIT initTestSuite(void)
{
	Testsuite.Enable = 1;
	utInit(&Testsuite);

	CommonTestsuite.Enable = 1;
	utInit(&CommonTestsuite);

	strcpy((char*)&FileDeviceName, "");
	strcpy((char*)&TextNameSpace, "Axis/Alarms");
	strcpy((char*)&TextID, "ReferenceRequired");
}

void _CYCLIC cyclicWithTest(void)
{
	utCyclic(&Testsuite);

	if (Testsuite.Informational.LastKnownPassedLocation.TestCaseName != 0)
		strcpy((char*)&LastTestCase, (char*)Testsuite.Informational.LastKnownPassedLocation.TestCaseName);
	if (Testsuite.Informational.LastKnownPassedLocation.TestSetName != 0)
		strcpy((char*)&LastTestSet, (char*)Testsuite.Informational.LastKnownPassedLocation.TestSetName);
	if (Testsuite.Informational.LastKnownPassedLocation.File != 0)
		strcpy((char*)&LastTestFile, (char*)Testsuite.Informational.LastKnownPassedLocation.File);
}

void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}


