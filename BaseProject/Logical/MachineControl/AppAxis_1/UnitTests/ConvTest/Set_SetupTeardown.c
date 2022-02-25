/********************************************************************
 * COPYRIGHT --
 ********************************************************************
 * Program: -
 * Author:
 * Created: 
 ********************************************************************
 * Tests for ... 
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include <stdbool.h>
#include "UnitTest.h"

_SETUP_SET(void)
{
    // wait until the axis is ready
    TEST_BUSY_CONDITION(AxisControl.Status.IsReady == false);
    
    TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}


_SETUP_TEST(void)
{
    testState = TEST_STATE_ARRANGE;
	TEST_DONE;
}

_TEARDOWN_TEST(void)
{
    AxisControl.Command.JogNegative = false;
    AxisControl.Command.JogPositive = false;
    AxisControl.Command.MoveToStart = false;
    AxisControl.Command.Start = false;
    TEST_BUSY_CONDITION(AxisControl.Status.Velocity > 0.001);
    TEST_BUSY_CONDITION(AxisControl.Status.Velocity < -0.001);
    
	TEST_DONE;
}

_TEST powerOnTest(void)
{
    switch (testState)
    {
        case TEST_STATE_ARRANGE:
            // Arrange
            AxisControl.Command.Power = true;
            TEST_BUSY_CONDITION(AxisControl.Status.Busy == false);
            testState = TEST_STATE_ACT;
            break;
        
        case TEST_STATE_ACT:
            // Act
            TEST_BUSY_CONDITION(AxisControl.Status.Busy);
            testState = TEST_STATE_ASSERT;
            break;
        
        case TEST_STATE_ASSERT:
            // Assert
            TEST_ASSERT(AxisControl.Status.IsPowered);
            testState = TEST_STATE_DONE;
            break;
        
        case TEST_STATE_DONE:
            /* test is done */
            TEST_DONE;
    }
    
    TEST_BUSY;
}

_TEST homeTest(void)
{
    switch (testState)
    {
        case TEST_STATE_ARRANGE:
            // Arrange
            AxisControl.Command.Home = true;
            TEST_BUSY_CONDITION(AxisControl.Status.Busy == false);
            testState = TEST_STATE_ACT;
            break;
        
        case TEST_STATE_ACT:
            // Act
            TEST_BUSY_CONDITION(AxisControl.Status.Busy);
            testState = TEST_STATE_ASSERT;
            break;
        
        case TEST_STATE_ASSERT:
            // Assert
            TEST_ASSERT(AxisControl.Status.IsHomed);
            testState = TEST_STATE_DONE;
            break;
        
        case TEST_STATE_DONE:
            /* test is done */
            TEST_DONE;
    }
    
    TEST_BUSY;
}



_TEST jogNegativeTest(void)
{
    switch (testState)
    {
        case TEST_STATE_ARRANGE:
            // Arrange
            AxisControl.Parameters.JogVelocity = 5.0;
            testState = TEST_STATE_ACT;
            break;
        
        case TEST_STATE_ACT:
            // Act
            AxisControl.Command.JogNegative = true;
            TEST_BUSY_CONDITION(AxisControl.Status.Velocity > -0.01);
            testState = TEST_STATE_ASSERT;
            break;
        
        case TEST_STATE_ASSERT:
            // Assert
            TEST_ASSERT_REAL_WITHIN(0.01, -5.0, AxisControl.Status.Velocity);
            AxisControl.Command.JogNegative = false;
            testState = TEST_STATE_DONE;
            break;
        
        case TEST_STATE_DONE:
            /* test is done */
            TEST_DONE;
    }
    
    TEST_BUSY;
}


_TEST jogPositiveTest(void)
{
    switch (testState)
    {
        case TEST_STATE_ARRANGE:
            // Arrange
            AxisControl.Parameters.JogVelocity = 6.0;
            testState = TEST_STATE_ACT;
            break;
        
        case TEST_STATE_ACT:
            // Act
            AxisControl.Command.JogPositive = true;
            TEST_BUSY_CONDITION(AxisControl.Status.Velocity < 0.01);
            testState = TEST_STATE_ASSERT;
            break;
        
        case TEST_STATE_ASSERT:
            // Assert
            TEST_ASSERT_REAL_WITHIN(0.01, 6.0, AxisControl.Status.Velocity);
            AxisControl.Command.JogPositive = false;
            testState = TEST_STATE_DONE;
            break;
        
        case TEST_STATE_DONE:
            /* test is done */
            TEST_DONE;
    }
    
    TEST_BUSY;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2021-09-29 12:12:33Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("powerOnTest", powerOnTest), 
	new_TestFixture("homeTest", homeTest), 
	new_TestFixture("jogNegativeTest", jogNegativeTest), 
	new_TestFixture("jogPositiveTest", jogPositiveTest), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_SetupTeardown, "Set_SetupTeardown", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

