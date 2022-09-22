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

_TEST FileDeviceExists(void)
{
    if (strcmp((UDINT)&FileDeviceName, "") == 0)
    {
        TEST_INFO_POS("FileDeviceName is empty");
        TEST_DONE;
    }
    DirInfoCommon_UT.enable = true;
    DirInfoCommon_UT.pDevice = (UDINT)&FileDeviceName;
    DirInfoCommon_UT.pPath = (UDINT)&"";
    DirInfo(&DirInfoCommon_UT);
    TEST_BUSY_CONDITION(DirInfoCommon_UT.status == 65535);
    TEST_ASSERT_EQUAL_INT(0, DirInfoCommon_UT.status);
    TEST_DONE;
}

_TEST NoFunctionBlockErrors(void)
{
    
    for (USINT i=0; i<(sizeof(MpBlockStatus)/sizeof(MpBlockStatus[0]));i++)
    {
        TEST_ASSERT_EQUAL_INT(0, (MpBlockStatus[i]));
    }
    TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-09-22 12:08:04Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("FileDeviceExists", FileDeviceExists), 
	new_TestFixture("NoFunctionBlockErrors", NoFunctionBlockErrors), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_Common, "Set_Common", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

