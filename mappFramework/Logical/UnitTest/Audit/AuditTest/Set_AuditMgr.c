#include <bur/plctypes.h>
#include <fileio.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define TIMEOUT_TEST_CASE									\
	if (cycleCount >= 1000)									\
	{														\
		char abortMessage[80];								\
		char substate[10];									\
		memset(abortMessage, 0, sizeof(abortMessage));		\
		memset(substate, 0, sizeof(substate));				\
		itoa(TestState, substate, 10);					\
		strcpy(abortMessage, "Timeout in State = ");		\
		strcat(abortMessage, substate);						\
		TEST_FAIL(abortMessage);							\
		TEST_DONE;											\
	}

_SETUP_SET(void)
{
	cycleCount = 0;
	
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}


_SETUP_TEST(void)
{
	Export = 0;
	Auto = 0;
	
	TestDone = 0;
	TestFailed = 0;
	WriteNumFiles = 0;
	ArrangeDelay = 0;
	ActDelay = 0;
	AssertDelay = 0;
	ArrangeSubState = 0;
	ActSubState = 0;
	AssertSubState = 0;
	SampleTemperature = 1;
	TestComparisonNumber = 0;
	TestState = TEST_ARRANGE;
	cycleCount = 0;
	
    TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	Export = 0;
	Auto=0;
	
	TestDone = 0;
	TestFailed = 0;
	WriteNumFiles = 0;
	ArrangeDelay = 0;
	ActDelay = 0;
	AssertDelay = 0;
	SampleTemperature = 1;
//	TestComparisonNumber = 0;
	TEST_DONE;
}

_CYCLIC_SET(void)
{
	cycleCount++;
	LogArray[0] = &TestComparisonNumber;
}

_TEST ExportArchive(void)
{
	Export=1;
//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	DirInfo_0.enable = 1;
	DirInfo_0.pDevice = (UDINT) "mappAuditFiles";
	DirInfo_0.pPath = 0;
	DirInfo(&DirInfo_0);
	
	switch (TestState)
	{
		case TEST_ARRANGE:
			// Force an audit to be generated
			SampleTemperature++;
			TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailArchiveAvailable);
			ArrangeDelay += 1;																	// This delay is compensating for the function block refreshing after finishing a command
			TEST_BUSY_CONDITION(ArrangeDelay != 10);
			//			WriteNumFiles = 1;
			TestComparisonNumber = DirInfo_0.filenum;
			TestState = TEST_ACT;
			break;
		
		case TEST_ACT:
			// Archive audit
			//			WriteNumFiles = 0;
			switch (ActSubState)
			{
				case 0:
					HMIAuditInterfaceCtrl.Commands.ExportArchives = 1;
					TEST_BUSY_CONDITION(!HMIAuditInterfaceCtrl.Status.AuditTrailCmdDone);
					HMIAuditInterfaceCtrl.Commands.ExportArchives = 0;
					ActSubState = 1;
					break;
				
				case 1:
					ActDelay += 1;																		// This delay is compensating for the function block refreshing after finishing a command
					TEST_BUSY_CONDITION(ActDelay != 10);
					TestState = TEST_ASSERT;
					break;
			}
			break;
		
		case TEST_ASSERT:
			// Check save location for archive
//			AssertDelay += 1;																		// This delay is compensating for the function block refreshing after finishing a command
//			TEST_BUSY_CONDITION(AssertDelay != 10);
			TEST_ASSERT(TestComparisonNumber  < DirInfo_0.filenum);
//			TestFailed = (TestComparisonNumber + 1 != DirInfo_0.filenum);
			TEST_DONE;
			break;
	}
	
	DirInfo(&DirInfo_0);
}

_TEST AutomaticArchive(void)
{
	Auto=1;
	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case TEST_ARRANGE:
			// Set automatic archive parameters prepare audit for generation
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.Enable = 1;
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.FileType = mpAUDIT_FILE_TYPE_XML;
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.MaxSize = MAX_FILE_SIZE;
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.Mode = mpAUDIT_ARCHIVE_DAILY;
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.Hour = HOUR;
			HMIAuditInterfaceCtrl.Parameters.ArchiveSettings.Minute = MINUTE;
//			TEST_BUSY_CONDITION(HMIAuditInterfaceCtrl.Status.NumberOfArchives == 0);
//			ArrangeDelay += 1;
//			TEST_BUSY_CONDITION(ArrangeDelay == 2);
			WriteNumFiles = 1;
			TestComparisonNumber = HMIAuditInterfaceCtrl.Status.NumberOfArchives;
			logDebug("AuditTest","CompNum = %si",LogArray);
			TestState = TEST_ACT;
			break;
		
		case TEST_ACT:
			// Archive audit
			ActDelay += 1;
			TEST_BUSY_CONDITION(ActDelay != 10);
//			if(SampleTemperature == SAMPLE_TEMP_VALUE)
//				SampleTemperature = DEFAULT_TEMP_VALUE;
//			else
				SampleTemperature = SAMPLE_TEMP_VALUE;
			DTSetTime_0.DT1 = SET_TIME;
			DTSetTime_0.enable = 1;
			DTSetTime(&DTSetTime_0);
//			DTGetTime_0.enable = 1;
//			DTGetTime(&DTGetTime_0);
			WriteNumFiles = 0;
			TON_0.PT = TIMER_LENGTH;
			TON_0.IN = 1;
			TON(&TON_0);
			TEST_BUSY_CONDITION(!TON_0.Q);
			TestState = TEST_ASSERT;
			TON_0.IN = 0;
			TON(&TON_0);
			break;
		
		case TEST_ASSERT:
			// Check save location for archive
			TEST_ASSERT(TestComparisonNumber + 1 == HMIAuditInterfaceCtrl.Status.NumberOfArchives);
			TestFailed = !(TestComparisonNumber + 1 == HMIAuditInterfaceCtrl.Status.NumberOfArchives);
			TestDone = 1;
			TEST_DONE;
			break;
	}
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

