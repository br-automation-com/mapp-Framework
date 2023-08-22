#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define _RESET_ALARMS																\
	AlarmExamples.LevelMonitoring = 50;												\
	MpAlarmXAcknowledgeAll_0.Execute = true;										\
	MpAlarmXAcknowledgeAll(&MpAlarmXAcknowledgeAll_0);								\
	TEST_BUSY_CONDITION(MpAlarmXAcknowledgeAll_0.CommandDone == false);				\
	MpAlarmXAcknowledgeAll_0.Execute = false;										\
	TEST_BUSY_CONDITION(MpAlarmXAcknowledgeAll_0.Info.UnacknowledgedAlarms != 0);	\
	TEST_BUSY_CONDITION(cycleCount < 25);

_SETUP_SET(void)
{
	_RESET_ALARMS;
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	_RESET_ALARMS;
	TEST_DONE;
}

_SETUP_TEST(void)
{
	cycleCount = 0;
	TEST_DONE;
}
	
_CYCLIC_SET(void)
{
	MpAlarmXAcknowledgeAll_0.MpLink = &gMpLinkAlarmXCore;
	MpAlarmXAcknowledgeAll_0.Enable = true;
	MpAlarmXAcknowledgeAll(&MpAlarmXAcknowledgeAll_0);
	
	cycleCount++;
	
	TEST_ABORT_CONDITION(cycleCount == 254);
}

bool AlarmIsActive(char* alarmName)
{
	for (USINT i = 0; i < (sizeof(MpAlarmXListUIConnect.AlarmList.Name)/sizeof(MpAlarmXListUIConnect.AlarmList.Name[0])); i++)
	{
		if ((strcmp(alarmName, MpAlarmXListUIConnect.AlarmList.Name[i]) == 0) && (MpAlarmXListUIConnect.AlarmList.StateActive[i] == true))
			return true;
	}
	return false;	  
}

// These tests must run sequentially, Arrange->Act->Assert
// 3 "_TEST" function for each unit test
_TEST Arrange_LevelMonitoringLow(void)
{
	StartingActiveAlarms = MpAlarmXCoreMain.ActiveAlarms;
	StartingPendingAlarms = MpAlarmXCoreMain.PendingAlarms;
	_RESET_ALARMS;
	TEST_DONE;
}

_TEST Act_LevelMonitoringLow(void)
{
	AlarmExamples.LevelMonitoring = 19;
	TEST_BUSY_CONDITION(cycleCount < 10);
	TEST_DONE;
}

_TEST Assert_LevelMonitoringLow(void)
{
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.PendingAlarms > StartingPendingAlarms, "Pending Alarms did not increase");
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.ActiveAlarms > StartingActiveAlarms, "Active Alarms did not increase");
	TEST_ASSERT(AlarmIsActive("LevelMonitoringExample"));
	TEST_DONE;
}

_TEST Arrange_LevelMonitoringLowLow(void)
{
	StartingActiveAlarms = MpAlarmXCoreMain.ActiveAlarms;
	StartingPendingAlarms = MpAlarmXCoreMain.PendingAlarms;
	_RESET_ALARMS;
	TEST_DONE;
}

_TEST Act_LevelMonitoringLowLow(void)
{
	AlarmExamples.LevelMonitoring = 9;
	TEST_BUSY_CONDITION(cycleCount < 10);
	TEST_DONE;
}

_TEST Assert_LevelMonitoringLowLow(void)
{
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.PendingAlarms > StartingPendingAlarms, "Pending Alarms did not increase");
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.ActiveAlarms > StartingActiveAlarms, "Active Alarms did not increase");
	TEST_ASSERT(AlarmIsActive("LevelMonitoringExample"));
	TEST_DONE;
}

_TEST Arrange_LevelMonitoringHigh(void)
{
	StartingActiveAlarms = MpAlarmXCoreMain.ActiveAlarms;
	StartingPendingAlarms = MpAlarmXCoreMain.PendingAlarms;
	_RESET_ALARMS;
	TEST_DONE;
}

_TEST Act_LevelMonitoringHigh(void)
{
	AlarmExamples.LevelMonitoring = 81;
	TEST_BUSY_CONDITION(cycleCount < 10);
	TEST_DONE;
}

_TEST Assert_LevelMonitoringHigh(void)
{
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.PendingAlarms > StartingPendingAlarms, "Pending Alarms did not increase");
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.ActiveAlarms > StartingActiveAlarms, "Active Alarms did not increase");
	TEST_ASSERT(AlarmIsActive("LevelMonitoringExample"));
	TEST_DONE;
}

_TEST Arrange_LevelMonitoringHighHigh(void)
{
	StartingActiveAlarms = MpAlarmXCoreMain.ActiveAlarms;
	StartingPendingAlarms = MpAlarmXCoreMain.PendingAlarms;
	_RESET_ALARMS;
	TEST_DONE;
}

_TEST Act_LevelMonitoringHighHigh(void)
{
	AlarmExamples.LevelMonitoring = 91;
	TEST_BUSY_CONDITION(cycleCount < 10);
	TEST_DONE;
}

_TEST Assert_LevelMonitoringHighHigh(void)
{
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.PendingAlarms > StartingPendingAlarms, "Pending Alarms did not increase");
	TEST_ASSERT_MESSAGE(MpAlarmXCoreMain.ActiveAlarms > StartingActiveAlarms, "Active Alarms did not increase");
	TEST_ASSERT(AlarmIsActive("LevelMonitoringExample"));
	TEST_DONE;
}


/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-03 17:18:35Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("Arrange_LevelMonitoringLow", Arrange_LevelMonitoringLow), 
	new_TestFixture("Act_LevelMonitoringLow", Act_LevelMonitoringLow), 
	new_TestFixture("Assert_LevelMonitoringLow", Assert_LevelMonitoringLow), 
	new_TestFixture("Arrange_LevelMonitoringLowLow", Arrange_LevelMonitoringLowLow), 
	new_TestFixture("Act_LevelMonitoringLowLow", Act_LevelMonitoringLowLow), 
	new_TestFixture("Assert_LevelMonitoringLowLow", Assert_LevelMonitoringLowLow), 
	new_TestFixture("Arrange_LevelMonitoringHigh", Arrange_LevelMonitoringHigh), 
	new_TestFixture("Act_LevelMonitoringHigh", Act_LevelMonitoringHigh), 
	new_TestFixture("Assert_LevelMonitoringHigh", Assert_LevelMonitoringHigh), 
	new_TestFixture("Arrange_LevelMonitoringHighHigh", Arrange_LevelMonitoringHighHigh), 
	new_TestFixture("Act_LevelMonitoringHighHigh", Act_LevelMonitoringHighHigh), 
	new_TestFixture("Assert_LevelMonitoringHighHigh", Assert_LevelMonitoringHighHigh), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_AlarmExamples, "Set_AlarmExamples", setupTest, 0, fixtures, setupSet, teardownSet, cyclicSetCaller);

