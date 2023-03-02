#include <bur/plctypes.h>
#include <fileio.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define TIMEOUT_TEST_CASE									\
	if (cycleCount >= 500)									\
	{														\
		char abortMessage[80];								\
		char substate[10];									\
		memset(abortMessage, 0, sizeof(abortMessage));		\
		memset(substate, 0, sizeof(substate));				\
		itoa(UnitTestState, substate, 10);					\
		strcpy(abortMessage, "Timeout in State = ");		\
		strcat(abortMessage, substate);						\
		TEST_FAIL(abortMessage);							\
		TEST_DONE;											\
	}

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
	TestDone = 0;
	TestFailed = 0;
	WriteNumFiles = 0;
	Delay = 0;
	ArrangeSubState = 0;
	ActSubState = 0;
	AssertSubState = 0;
	SampleTemperature = 1;
	NumberOfFiles = 0;
	UnitTestState = TEST_ARRANGE;
    TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	TEST_DONE;
}

_CYCLIC_SET(void)
{
	cycleCount++;
}

_TEST ExportArchive(void)
{
	TIMEOUT_TEST_CASE;
	
	DirInfo_0.enable = 1;
	DirInfo_0.pDevice = (UDINT) "mappAuditFiles";
	DirInfo_0.pPath = 0;
	DirInfo(&DirInfo_0);
	
	switch (UnitTestState)
	{
		case TEST_ARRANGE:
			// Force an audit to be generated
			SampleTemperature++;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailArchiveAvailable);
			WriteNumFiles = 1;
			NumberOfFiles = DirInfo_0.filenum;
			UnitTestState = TEST_ACT;
			break;
		
		case TEST_ACT:
			// Archive audit
			WriteNumFiles = 0;
			HMIAuditInterfaceCtrl.Commands.ExportArchives = 1;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailCmdDone);
			HMIAuditInterfaceCtrl.Commands.ExportArchives = 0;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailCmdDone);
			Delay += 1;
			TEST_BUSY_CONDITION(Delay != 2);
			UnitTestState = TEST_ASSERT;
			break;
		
		case TEST_ASSERT:
			// Check save location for archive
			TEST_ASSERT(NumberOfFiles + 1 == DirInfo_0.filenum);
			TestFailed = !(NumberOfFiles + 1 == DirInfo_0.filenum);
			TestDone = 1;
			TEST_DONE;
			break;
	}
	
	DirInfo(&DirInfo_0);
}

_TEST AutomaticArchive(void)
{
	TIMEOUT_TEST_CASE;
	
	DirInfo_0.enable = 1;
	DirInfo_0.pDevice = (UDINT) "mappAuditFiles";
	DirInfo_0.pPath = 0;
	DirInfo(&DirInfo_0);
	
	switch (UnitTestState)
	{
		case TEST_ARRANGE:
			// Set automatic archive parameters and force audit generation
			SampleTemperature++;
			HmiAudit.Parameters.ArchiveSettings.Enable = 1;
			HmiAudit.Parameters.ArchiveSettings.FileType = 1;
			HmiAudit.Parameters.ArchiveSettings.MaxSize = 1;
			HmiAudit.Parameters.ArchiveSettings.Mode = 0;
			HmiAudit.Parameters.ArchiveSettings.Hour = 1;
			HmiAudit.Parameters.ArchiveSettings.Minute = 1;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailArchiveAvailable);
			WriteNumFiles = 1;
			NumberOfFiles = DirInfo_0.filenum;
			UnitTestState = TEST_ACT;
			break;
		
		case TEST_ACT:
			// Archive audit
			WriteNumFiles = 0;
			HMIAuditInterfaceCtrl.Commands.ExportArchives = 1;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailCmdDone);
			HMIAuditInterfaceCtrl.Commands.ExportArchives = 0;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailCmdDone);
			Delay += 1;
			TEST_BUSY_CONDITION(Delay != 2);
			UnitTestState = TEST_ASSERT;
			break;
		
		case TEST_ASSERT:
			// Check save location for archive
			TEST_ASSERT(NumberOfFiles + 1 == DirInfo_0.filenum);
			TestFailed = !(NumberOfFiles + 1 == DirInfo_0.filenum);
			TestDone = 1;
			TEST_DONE;
			break;
	}
	
	DirInfo(&DirInfo_0);
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2023-02-06 16:23:26Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("ExportArchive", ExportArchive), 
	new_TestFixture("AutomaticArchive", AutomaticArchive), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_AuditMgr, "Set_AuditMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

