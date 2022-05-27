/********************************************************************
* COPYRIGHT -- Bernecker + Rainer
********************************************************************
* Program: SPL_Behavior
* Author: B+R
********************************************************************
* This test set shows the sequence of calls within a test set
* Add some busy conditions or test cases to see the changes.
********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"


#include "iHelperFunction.h"


void resetDataForTestSet_TestSetupTeardown()
{
	resetDataForTestSet();
}




_CYCLIC_SET(void)
{
	LOG_FOR_EXEMPLIFICATION_CYCLIC_SET;
	return;
}


_SETUP_TEST(void)
{
	LOG_FOR_EXEMPLIFICATION_SETUP_TEST;
	TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	LOG_FOR_EXEMPLIFICATION_TEARDOWN_TEST;
	TEST_DONE;
}



_TEST test_1(void)
{
	LOG_FOR_EXEMPLIFICATION_TEST_CASE_1;
	TEST_DONE;
}


_TEST test_2(void)
{
	LOG_FOR_EXEMPLIFICATION_TEST_CASE_2;
	TEST_DONE;
}

_TEST test_3(void)
{
	LOG_FOR_EXEMPLIFICATION_TEST_CASE_3;
	TEST_DONE;
}



/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2015-04-14 12:03:48Z
By B+R UnitTest Helper Version: 2.0.0.0
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("test_1", test_1), 
	new_TestFixture("test_2", test_2), 
	new_TestFixture("test_3", test_3), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(test_SetTestCases_TestSetup_TestTeardown, "test_SetTestCases_TestSetup_TestTeardown", setupTest, teardownTest, fixtures, 0, 0, cyclicSetCaller);

