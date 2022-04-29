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

#include "UnitTest.h"

/* called before first test case of test set*/
_SETUP_SET(void)
{
	/* TODO:  add code running before test set here */
	TEST_DONE;
}

/* called after last test case of test set */
_TEARDOWN_SET(void)
{
	/* TODO:  add code running after test set here */
	TEST_DONE;
}

/* called before a test case first called */
_SETUP_TEST(void)
{
	/* TODO:  add code running before test case here */
	TEST_DONE;
}

/* called after a test case is done*/
_TEARDOWN_TEST(void)
{
	/* TODO:  add code running after test case here */
	TEST_DONE;
}

/* ---------------------------*/

/* a test case*/
_TEST testcase1(void)
{

	/* TODO:  add assertions here */

	/* test is done */
	TEST_DONE;
}

/* a test case*/
_TEST testcase2(void)
{
	/* TODO:  add assertions here */

	/* test is done */
	TEST_DONE;
}


#warning TODO: Add your test cases here 
/*TODO: Add your test cases here */
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("testcase1",testcase1),
	                new_TestFixture("testcase2",testcase2),
};


#warning TODO: rename testset (Param 1 and 2)
UNITTEST_CALLER_SET(testSetupTeardown, "testSetupTeardown",fixtures);
