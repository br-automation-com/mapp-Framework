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

_TEST createNotAllowedInSim(void)
{
	TEST_ABORT_CONDITION(!HmiBackup.Status.SimulationActive);
	TEST_ASSERT(!HmiBackup.Status.CreateAllowed);
	TEST_DONE;
}

_TEST restoreNotAllowedInSim(void)
{
	TEST_ABORT_CONDITION(!HmiBackup.Status.SimulationActive);
	TEST_ASSERT(!HmiBackup.Status.RestoreAllowed);
	TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2023-09-05 18:15:00Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("createNotAllowedInSim", createNotAllowedInSim), 
	new_TestFixture("restoreNotAllowedInSim", restoreNotAllowedInSim), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_BackupMgr, "Set_BackupMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

