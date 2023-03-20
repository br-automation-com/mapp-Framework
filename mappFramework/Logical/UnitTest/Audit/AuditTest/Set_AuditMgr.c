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
		itoa(TestState, substate, 10);						\
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
	ArrangeDelay = 0;
	ActDelay = 0;
	AssertDelay = 0;
	SampleTemperature = 1;
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
	
	switch (TestState)
	{
		case TEST_ARRANGE:
			// Force an audit to be generated
			switch (ArrangeSubState)
			{
				case 0:
					SampleTemperature++;
					TEST_BUSY_CONDITION(!HmiAudit.Status.ArchiveAvailable);
					ArrangeSubState = 1;
					break;
					
				case 1:
					ArrangeDelay += 1;												// This delay is compensating for the function block refreshing after finishing a command
					TEST_BUSY_CONDITION(ArrangeDelay <= 10);
					TestComparisonNumber = DirInfo_0.filenum;
					TestState = TEST_ACT;
					break;
			}
			break;
		
		case TEST_ACT:
			// Archive audit
			switch (ActSubState)
			{
				case 0:
					HmiAudit.Commands.ExportArchives = 1;
					TEST_ABORT_CONDITION(MpAuditTrailError);
					TEST_BUSY_CONDITION(!MpAuditTrailCmdDone);
					HmiAudit.Commands.ExportArchives = 0;
					ActSubState = 1;
					break;
				
				case 1:
					ActDelay += 1;													// This delay is compensating for the function block refreshing after finishing a command
					TEST_BUSY_CONDITION(ActDelay <= 10);
					TestState = TEST_ASSERT;
					break;
			}
			break;
		
		case TEST_ASSERT:
			TEST_ASSERT(TestComparisonNumber  < DirInfo_0.filenum);
			TEST_DONE;
			break;
	}
}

_TEST AutomaticArchive(void)
{
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case TEST_ARRANGE:
			// Set automatic archive parameters prepare audit for generation
			switch (ArrangeSubState)
			{
				case 0:
					HmiAudit.Parameters.ArchiveSettings.Enable = 1;
					HmiAudit.Parameters.ArchiveSettings.FileType = mpAUDIT_FILE_TYPE_XML;
					HmiAudit.Parameters.ArchiveSettings.MaxSize = MAX_FILE_SIZE;
					HmiAudit.Parameters.ArchiveSettings.Mode = mpAUDIT_ARCHIVE_DAILY;
					HmiAudit.Parameters.ArchiveSettings.Hour = HOUR;
					HmiAudit.Parameters.ArchiveSettings.Minute = MINUTE;
					ArrangeSubState = 1;
					break;
					
				case 1:
					TestComparisonNumber = HmiAudit.Status.NumberOfArchives;
					ArrangeSubState = 2;
					break;
						
				case 2:
					ArrangeDelay += 1;
					TEST_BUSY_CONDITION(ArrangeDelay <= 2);
					TestState = TEST_ACT;
					break;
			}
			break;
		
		case TEST_ACT:
			// Archive audit
			switch (ActSubState)
			{
				case 0:
					SampleTemperature = SAMPLE_TEMP_VALUE;
					DTSetTime_0.DT1 = SET_TIME;
					DTSetTime_0.enable = 1;
					DTSetTime(&DTSetTime_0);
					ActSubState = 1;
					break;
					
				case 1:
					TON_0.PT = TIMER_LENGTH;
					TON_0.IN = 1;
					TON(&TON_0);
					if(TON_0.Q)
					{
						ActSubState = 2;
					}
					break;
				
				case 2:
					TestState = TEST_ASSERT;
					TON_0.IN = 0;
					TON(&TON_0);
					break;
			}
			break;
		
		case TEST_ASSERT:
			// Check save location for archive
			TEST_ASSERT(TestComparisonNumber + 1 <= HmiAudit.Status.NumberOfArchives);
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

