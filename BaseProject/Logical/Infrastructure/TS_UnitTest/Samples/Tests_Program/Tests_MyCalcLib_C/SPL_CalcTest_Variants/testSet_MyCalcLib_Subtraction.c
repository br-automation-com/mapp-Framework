/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_CalcTest_Variants
 * Author: B+R
 ********************************************************************
 * Test set implementation
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"


_TEST test_Subtract(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = 4;
	instMyCalc.Param2   = 2;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(2, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}


_TEST test_Subtract_negResult(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = 6;
	instMyCalc.Param2   = 8;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(-2, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}

_TEST test_Subtract_zeroResult(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = 6;
	instMyCalc.Param2   = 6;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(0, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);

	/* test is done */
	TEST_DONE;
}




_TEST test_Subtract_boundaryArea_expect_MIN(void)
{
	/* initialize functionblock parameters */
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = -1;
	instMyCalc.Param2   = 32768;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);

	/* check result */
	TEST_ASSERT_EQUAL_INT(-32768, instMyCalc.Result);
	TEST_ASSERT_EQUAL_INT(splMyCalcERR_OUT_OF_RANGE, instMyCalc.Status);

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
	new_TestFixture("test_Subtract", test_Subtract), 
	new_TestFixture("test_Subtract_negResult", test_Subtract_negResult), 
	new_TestFixture("test_Subtract_zeroResult", test_Subtract_zeroResult), 
	new_TestFixture("test_Subtract_boundaryArea_expect_MIN", test_Subtract_boundaryArea_expect_MIN), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_MyCalcLib_Subtraction, "testSet_MyCalcLib_Subtraction", 0, 0, fixtures, 0, 0, 0);

