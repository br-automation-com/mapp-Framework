#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

_SETUP_SET(void)
{
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}


_SETUP_TEST(void)
{
	TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	TEST_DONE;
}

_TEST CreateAdvReport(void)
{
	switch (TestState)
	{
		case TEST_ARRANGE:
			HmiReport_UT.Parameters.UseAdvancedFormat = true;
			TEST_BUSY_CONDITION(CoreInfoActive == true);
			TEST_ABORT_CONDITION(HmiReport_UT.Status.Error == true);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			TEST_BUSY_CONDITION(CoreInfoActive == false);
			HmiReport_UT.Commands.Generate = true;
			TEST_BUSY_CONDITION(HmiReport_UT.Status.Busy == false);
			TestState = TEST_ASSERT;
			break;

		case TEST_ASSERT:
			HmiReport_UT.Commands.Generate = false;	
			TEST_BUSY_CONDITION(HmiReport_UT.Status.Busy == true);	
			TEST_ASSERT(HmiReport_UT.Status.Error == false);
			TEST_ASSERT_EQUAL_INT(1, CoreInfo_UT.NumberOfReports);			  
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST CreateSimpleReport(void)
{
	switch (TestState)
	{
		case TEST_ARRANGE:
			HmiReport_UT.Parameters.UseAdvancedFormat = false;
			TEST_BUSY_CONDITION(CoreInfoActive == true);
			TEST_ABORT_CONDITION(HmiReport_UT.Status.Error == true);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			TEST_BUSY_CONDITION(CoreInfoActive == false);
			HmiReport_UT.Commands.Generate = true;
			TEST_BUSY_CONDITION(HmiReport_UT.Status.Busy == false);
			TestState = TEST_ASSERT;
			break;

		case TEST_ASSERT:
			HmiReport_UT.Commands.Generate = false;	
			TEST_BUSY_CONDITION(HmiReport_UT.Status.Busy == true);	
			TEST_ASSERT(HmiReport_UT.Status.Error == false);
			TEST_ASSERT_EQUAL_INT(1, CoreInfo_UT.NumberOfReports);			  
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}


/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-15 21:58:19Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("CreateAdvReport", CreateAdvReport), 
	new_TestFixture("CreateSimpleReport", CreateSimpleReport), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_ReportMgr, "Set_ReportMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

