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


_TEST CheckCommissioningModeActive(void)
{
	CommissioningModeActive = true;
	TEST_ASSERT(Alarms[0] == false);
	TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2023-01-30 14:31:38Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("CheckCommissioningModeActive", CheckCommissioningModeActive), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_AlarmMgr, "Set_AlarmMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

