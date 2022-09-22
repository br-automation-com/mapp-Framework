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



void _INIT initTestSuite(void)
{
    Testsuite.Enable = 1;
	utInit(&Testsuite);
    
    CommonTestsuite.Enable = 1;
    utInit(&CommonTestsuite);
    
    strcpy((UDINT)&FileDeviceName, "mappUserXFiles");
}


void _CYCLIC cyclicWithTest(void)
{
	utCyclic(&Testsuite);
}


void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}


