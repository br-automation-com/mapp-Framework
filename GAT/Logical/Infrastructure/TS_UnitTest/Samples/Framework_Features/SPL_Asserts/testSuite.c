/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_Asserts
 * Author: B+R
 ********************************************************************
 * Test registration and handshake
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"




void _INIT initTestSuite(void)
{
	utInit(&Testsuite);
}


void _CYCLIC cyclicWithTest(void)
{
	/* Some code */
	utCyclic(&Testsuite);
}


void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}
