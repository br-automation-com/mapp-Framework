/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_CalcTest
 * Author: B+R
 ********************************************************************
 * Test set implementation
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"


_TEST test_Add(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_ADD;
	instMyCalc.Param1   = 1;
	instMyCalc.Param2   = 2;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(3, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}

_TEST testResetOutputParam(void)
{

	/* Do any calculation with a result != 0  */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_ADD;
	instMyCalc.Param1   = 1;
	instMyCalc.Param2   = 2;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);
	/* Please note: the result of the calculation isn't checked as this is not subject of this test case.	 */


	instMyCalc.CalcOperator = splMyCalcOPERATOR_RESET_OUTPUTS;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(0, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;

}

/* This test case shows an example of a test case that can be "false positive".
	As long as MyCalculator() is not implemented, this test passes.
	As long as instMyCalc.Result already is 0 when this test case will be called, it doesn't check wether the FB was called at all.
	--> There are several methods, to verify the FB was called and changed the variables that are used to prove functionality:
	Choose other parameter for an addition with negative values
	Before calling the FB set the output to any other value than the expected result. (e.g. By using _SETUP_TEST() and / or _TEARDOWN_TEST() )
	...

*/
_TEST test_Addition_negValue_badExampleParameter(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_ADD;
	instMyCalc.Param1   = -1;
	instMyCalc.Param2   = 1;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(0, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}


_TEST test_Addition_negValue(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_ADD;
	instMyCalc.Param1   = -1;
	instMyCalc.Param2   = 3;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(2, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}


/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2015-04-14 12:04:18Z
By B+R UnitTest Helper Version: 2.0.0.0
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("test_Add", test_Add), 
	new_TestFixture("testResetOutputParam", testResetOutputParam), 
	new_TestFixture("test_Addition_negValue_badExampleParameter", test_Addition_negValue_badExampleParameter), 
	new_TestFixture("test_Addition_negValue", test_Addition_negValue), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_MyCalcLib_Addition, "testSet_MyCalcLib_Addition", 0, 0, fixtures, 0, 0, 0);

