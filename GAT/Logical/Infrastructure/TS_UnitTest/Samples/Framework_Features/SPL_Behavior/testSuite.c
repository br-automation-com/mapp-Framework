/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_Behavior
 * Author: B+R
 ********************************************************************
 * Test registration and handshake
 ********************************************************************/
 
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif



#include "UnitTest.h"

#include "iPrototypes.h"



void _INIT initTestSuite(void)
{
	utInit(&Testsuite);
}


void _CYCLIC cyclicWithTest(void)
{
	/* Some code */
	utCyclic(&Testsuite);

	if(Testsuite.TestFinishedDone)
	{
		resetDataForTestSet_Complete();
		resetDataForTestSet_TestCases();
		resetDataForTestSet_SetSetupTeardown();
		resetDataForTestSet_TestSetupTeardown();
	}
}


void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}
