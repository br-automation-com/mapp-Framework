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



/* a test case*/
_TEST testcase1(void)
{

	/* TODO: add assertions here */

	/* test is done */
	TEST_DONE;
}


/* a test case*/
_TEST testcase2(void)
{
	/* TODO: add assertions here */

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
UNITTEST_CALLER_TEST(testSet_testcases, "testSet_testcases",fixtures);

