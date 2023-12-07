#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#define MAX(x, y) (((x) > (y)) ? (x) : (y))

#define TIMEOUT_TEST_CASE									\
	if (cycleCount >= 254)									\
	{														\
		char abortMessage[80];								\
		char substate[10];									\
		memset(abortMessage, 0, sizeof(abortMessage));		\
		memset(substate, 0, sizeof(substate));				\
		itoa(ActSubState, substate, 10);					\
		strcpy(abortMessage, "Timeout in ActSubState = ");	\
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
	cycleCount = 0;
	ArrangeSubState = 0;
	ActSubState = 0;
	AssertSubState = 0;
	TestState = TEST_ARRANGE;

	maxVelocity = 0.0;
	TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	AxisControl.Command.JogNegative = false;
	AxisControl.Command.JogPositive = false;
	AxisControl.Command.Abort = false;
	AxisControl.Command.LoadRecipeParameters = false;
	AxisControl.Command.MoveAbsolute = false;
	AxisControl.Command.MoveAdditive = false;
	AxisControl.Command.MoveToStart = false;
	AxisControl.Command.MoveVelocity = false;
	AxisControl.Command.Reference = false;
	AxisControl.Command.Reset = false;
	AxisControl.Command.SaveRecipeParameters = false;
	AxisControl.Command.Start = false;
	AxisControl.Command.Stop = false;
	AxisControl.Command.UpdatePreviewParameters = false;
	AxisControl.Command.UpdateVelocity = false;

	if ((AxisControl.Status.ErrorActive == true) || (MpAlarmXCoreAxis.PendingAlarms > 0))
	{
		AxisControl.Command.Reset = true;
		MpAlarmXAcknowledgeAll_0.Execute = true;
	}
	TEST_BUSY_CONDITION(AxisControl.Status.ErrorActive);
	AxisControl.Command.Reset = false;
	if (abs(AxisControl.Status.Velocity) > 0.01)
		AxisControl.Command.Stop = true;
	TEST_BUSY_CONDITION(abs(AxisControl.Status.Velocity > 0.01));
	TEST_BUSY_CONDITION(AxisControl.Status.Busy);
	AxisControl.Command.Stop = false;

	TEST_DONE;
}

_CYCLIC_SET(void)
{
	cycleCount++;
	MpAlarmXAcknowledgeAll_0.MpLink = &gMpLinkAlarmXCoreAppAxis_1;
	MpAlarmXAcknowledgeAll_0.Enable = true;
	MpAlarmXAcknowledgeAll(&MpAlarmXAcknowledgeAll_0);
	MpAlarmXAcknowledgeAll_0.Execute = false;
}

_TEST Start(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			AxisControl.Parameters.Velocity = 40;
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
			switch (ActSubState)
			{
				case 0:
					AxisControl.Command.Start = true;
					TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
					ActSubState = 1;
					break;

				case 1:
					TEST_BUSY_CONDITION(cycleCount < 30);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT_FLOAT_WITHIN(0.1, 40.0, maxVelocity);
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST UpdateVelocity(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			AxisControl.Parameters.Velocity = 40;
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
			switch (ActSubState)
			{
				case 0:
					AxisControl.Command.Start = true;
					TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
					ActSubState = 1;
					break;

				case 1:
					TEST_BUSY_CONDITION(cycleCount < 30);
					TEST_ASSERT_FLOAT_WITHIN(0.1, 40.0, maxVelocity);
					AxisControl.Command.UpdateVelocity = true;
					AxisControl.Parameters.Velocity = 60;
					ActSubState = 2;
					break;

				case 2:
					TEST_BUSY_CONDITION(cycleCount < 60);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT_FLOAT_WITHIN(0.1, 60.0, maxVelocity);
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST ZeroVelocity(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			AxisControl.Parameters.Velocity = 0;
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
			switch (ActSubState)
			{
				case 0:
					AxisControl.Command.Start = true;
					TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
					ActSubState = 1;
					break;

				case 1:
					TEST_BUSY_CONDITION(cycleCount < 10);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT(AxisControl.Status.ErrorActive);
			TEST_ASSERT_EQUAL_INT(1, MpAlarmXCoreAxis.PendingAlarms);
			TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, maxVelocity);
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-08 14:33:54Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("Start", Start),
	new_TestFixture("UpdateVelocity", UpdateVelocity),
	new_TestFixture("ZeroVelocity", ZeroVelocity),
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_AutomaticTests, "Set_AutomaticTests", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

