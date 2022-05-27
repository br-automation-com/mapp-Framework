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



#ifdef SMARTEDIT_DUMMY
/* When the helper is formulated as macro, the correct location (line / file) inside the testcase is given.
Each time the macro is used, the code gets duplicated.

Best practise: Extract a helper function first, use / test it before converting it into a macro, as functions can be far farbetter debugged / analyzed than macros. */
void def_verify_subtract(INT par1, INT par2 , DINT expectResult);
#endif
#define  def_verify_subtract( par1,  par2 , expectResult)\
{\
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;\
	instMyCalc.Param1   = par1;\
	instMyCalc.Param2   = par2;\
	/* call synchron functionblock */\
	MyCalculator(&instMyCalc);\
	/* check result */\
	TEST_ASSERT_EQUAL_INT(expectResult, instMyCalc.Result);\
	TEST_ASSERT_EQUAL_INT(ERR_OK, instMyCalc.Status);\
}




_TEST test_Subtract(void)
{
	def_verify_subtract(4, 2, 2);
	
	/* test is done */
	TEST_DONE;
}


_TEST test_Subtract_negResult(void)
{
	def_verify_subtract(6, 8, -2);
	/* test is done */
	TEST_DONE;
}

_TEST test_Subtract_zeroResult(void)
{
	def_verify_subtract(6, 6, 0);
	
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

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_MyCalcLib_Subtraction_variantC, "testSet_MyCalcLib_Subtraction_variantC", 0, 0, fixtures, 0, 0, 0);

