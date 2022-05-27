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

/* 	Create a helper returning a BOOL and pass the result of the helper to e.g. TEST_ASSERT()
Note: if the validation itself is not trivial, this function should be tested as well.

If the assert would be used in the helper as well, each of the checks count's twice.
Option would be, to use the TEST_INFO_LOC if returned false. */
BOOL verify_subtract_retBool(INT par1, INT par2 , DINT expectResult)
{
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = par1;
	instMyCalc.Param2   = par2;
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);
	/* check result */
	return (expectResult == instMyCalc.Result);
}




_TEST test_Subtract(void)
{
	TEST_ASSERT(verify_subtract_retBool(4, 2, 2));
	
	/* test is done */
	TEST_DONE;
}


_TEST test_Subtract_negResult(void)
{
	TEST_ASSERT(verify_subtract_retBool(6, 8, -2));

	/* test is done */
	TEST_DONE;
}

_TEST test_Subtract_zeroResult(void)
{
	TEST_ASSERT(verify_subtract_retBool(6, 6, 0));

	/* test is done */
	TEST_DONE;
}




/* This test isn't reduced as there is (currently) no argument for  instMyCalc.Status  */
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

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_MyCalcLib_Subtraction_variantB, "testSet_MyCalcLib_Subtraction_variantB", 0, 0, fixtures, 0, 0, 0);

