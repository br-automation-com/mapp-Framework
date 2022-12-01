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

#define TIMEOUT_TEST_CASE                                   \
    if (cycleCount >= 254)                                  \
    {                                                       \
        char abortMessage[80];                              \
        char substate[10];                                  \
        memset(abortMessage, 0, sizeof(abortMessage));      \
        memset(substate, 0, sizeof(substate));              \
        itoa(ActSubState, substate, 10);                    \
        strcpy(abortMessage, "Timeout in ActSubState = ");  \
        strcat(abortMessage, substate);                     \
        TEST_FAIL(abortMessage);                            \
        TEST_DONE;                                          \
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

    if ((AxisControl.Status.ErrorActive == true) || (MpAlarmXCore_0.PendingAlarms > 0))
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

    MpAlarmXListUI_0.Enable = true;
    MpAlarmXListUI_0.UIConnect = &MpAlarmXListUIConnect;
    MpAlarmXListUI_0.MpLink = &gMpLinkAlarmXCoreAppAxis_1;
    MpAlarmXListUI_0.UISetup.AlarmListScrollWindow = 10;
    MpAlarmXListUI_0.UISetup.AlarmListSize = 50;
    strcpy(MpAlarmXListUI_0.UISetup.TimeStampPattern, "%Y %m %d %H:%M:%S");
    MpAlarmXListUI(&MpAlarmXListUI_0);

    MpAlarmXAcknowledgeAll_0.MpLink = &gMpLinkAlarmXCoreAppAxis_1;
    MpAlarmXAcknowledgeAll_0.Enable = true;
    MpAlarmXAcknowledgeAll(&MpAlarmXAcknowledgeAll_0);
    TEST_BUSY_CONDITION(MpAlarmXAcknowledgeAll_0.CommandBusy);
    MpAlarmXAcknowledgeAll_0.Execute = false;

}

_TEST PowerOn(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.Power = true;
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy == true);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT(AxisControl.Status.IsPowered);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST Homing(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.Reference = true;
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.IsHomed == false);
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 2;
                    break;

                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT(AxisControl.Status.IsHomed);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 0.0, AxisControl.Status.Position);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST JogPositive(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.JogPositive = true;
                    AxisControl.Parameters.JogVelocity = 50;
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.Velocity <= 49.0);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 50.0, AxisControl.Status.Velocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST JogNegative(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.JogNegative = true;
                    AxisControl.Parameters.JogVelocity = 50;
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.Velocity >= -49.0);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, -50.0, AxisControl.Status.Velocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveAbsolute(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Position = 10;
            AxisControl.Parameters.Velocity = 40;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveAbsolute = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    AxisControl.Command.MoveAbsolute = false;
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 40.0, maxVelocity);
            TEST_ASSERT_FLOAT_WITHIN(0.01, 10.0, AxisControl.Status.Position);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveAdditive(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Distance = 5;
            AxisControl.Parameters.Velocity = 30;
            StartPosition = AxisControl.Status.Position;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveAdditive = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    AxisControl.Command.MoveAbsolute = false;
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 30.0, maxVelocity);
            TEST_ASSERT_FLOAT_WITHIN(0.01, StartPosition + 5.0, AxisControl.Status.Position);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveVelocity(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Velocity = 25;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveVelocity = true;
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
            TEST_ASSERT_FLOAT_WITHIN(0.1, 25.0, maxVelocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveJogPositiveStop(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.JogVelocity = 25;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.JogPositive = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 30);
                    AxisControl.Command.JogPositive = false;
                    ActSubState = 2;
                    break;
                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveJogNegativeStop(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.JogVelocity = 25;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.JogNegative = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 30);
                    AxisControl.Command.JogNegative = false;
                    ActSubState = 2;
                    break;
                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveAbsoluteStop(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Position = 1;
            AxisControl.Parameters.Velocity = 25;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveAbsolute = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 30);
                    AxisControl.Command.MoveAbsolute = false;
                    AxisControl.Command.Stop = true;
                    ActSubState = 2;
                    break;
                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            // check that we are not at the target position
            TEST_ASSERT(fabs(1.0 - AxisControl.Status.Position) > 0.01);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveAdditiveStop(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Distance = 10;
            AxisControl.Parameters.Velocity = 25;
            StartPosition = AxisControl.Status.Position;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveAdditive = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 30);
                    AxisControl.Command.MoveAdditive = false;
                    AxisControl.Command.Stop = true;
                    ActSubState = 2;
                    break;
                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            // check that we are not at the target position
            TEST_ASSERT(fabs((StartPosition + 10.0) - AxisControl.Status.Position) > 0.01);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST MoveVelocityStop(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Velocity = 25;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveVelocity = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 30);
                    AxisControl.Command.MoveVelocity = false;
                    AxisControl.Command.Stop = true;
                    ActSubState = 2;
                    break;
                case 2:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST TriggerAlarm(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Velocity = 10001;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveVelocity = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(cycleCount < 20);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, AxisControl.Status.Velocity);
            TEST_ASSERT_FLOAT_WITHIN(0.1, 0.0, maxVelocity);
            TEST_ASSERT(AxisControl.Status.ErrorActive);
            TEST_ASSERT_EQUAL_INT(1, MpAlarmXCore_0.PendingAlarms);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST ResetAlarm(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            AxisControl.Parameters.Velocity = 10001;
            StartingPendingAlarms = MpAlarmXCore_0.PendingAlarms;
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            maxVelocity = MAX(AxisControl.Status.Velocity, maxVelocity);
            switch (ActSubState)
            {
                case 0:
                    AxisControl.Command.MoveVelocity = true;
                    TEST_BUSY_CONDITION(!AxisControl.Status.Busy);
                    ActSubState = 1;
                    break;
                case 1:
                    TEST_BUSY_CONDITION(!AxisControl.Status.ErrorActive);
                    TEST_BUSY_CONDITION(MpAlarmXCore_0.PendingAlarms == StartingPendingAlarms);
                    AxisControl.Command.MoveVelocity = false;
                    ActSubState = 2;
                    break;
                case 2:
                    // wait until the command is received by the axis task
                    TEST_BUSY_CONDITION(State != STATE_RESETTING);
                    AxisControl.Command.Reset = true;
                    MpAlarmXAcknowledgeAll_0.Execute = true;
                    ActSubState = 3;
                    break;
                case 3:
                    TEST_BUSY_CONDITION(AxisControl.Status.Busy);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT(!AxisControl.Status.ErrorActive);
            TEST_ASSERT_EQUAL_INT(0, MpAlarmXCore_0.PendingAlarms);
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
                    AxisControl.Command.MoveVelocity = true;
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
            // update velocity should not affect manual moves
            TEST_ASSERT_FLOAT_WITHIN(0.1, 40.0, maxVelocity);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-15 16:02:39Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("PowerOn", PowerOn),
	new_TestFixture("Homing", Homing),
	new_TestFixture("JogPositive", JogPositive),
	new_TestFixture("JogNegative", JogNegative),
	new_TestFixture("MoveAbsolute", MoveAbsolute),
	new_TestFixture("MoveAdditive", MoveAdditive),
	new_TestFixture("MoveVelocity", MoveVelocity),
	new_TestFixture("MoveJogPositiveStop", MoveJogPositiveStop),
	new_TestFixture("MoveJogNegativeStop", MoveJogNegativeStop),
	new_TestFixture("MoveAbsoluteStop", MoveAbsoluteStop),
    new_TestFixture("MoveAdditiveStop", MoveAdditiveStop),
	new_TestFixture("MoveVelocityStop", MoveVelocityStop),
	new_TestFixture("TriggerAlarm", TriggerAlarm),
	new_TestFixture("ResetAlarm", ResetAlarm),
	new_TestFixture("UpdateVelocity", UpdateVelocity),
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_ManualTests, "Set_ManualTests", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

