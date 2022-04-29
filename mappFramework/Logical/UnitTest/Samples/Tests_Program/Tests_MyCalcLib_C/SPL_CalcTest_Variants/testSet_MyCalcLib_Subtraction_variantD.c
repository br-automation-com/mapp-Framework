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



/***************************************** 
* Begin Custom Assert 

* Note: Custom asserts may be seperated from Test Sets. 
* 		In this sample it's part of the Test Set file for symmetry reason
*
* Note: To learn more about Custom Asserts see help 
*		or sample in \Logical\TS_UnitTest\Samples\Samples_Advanced_CustomAsserts\
 */
BOOL spl_verify_subtract_impl(INT par1, INT par2 , DINT expectResult,  unsigned long line, const char *file)
{
	instMyCalc.CalcOperator = splMyCalcOPERATOR_SUBTRACT;
	instMyCalc.Param1   = par1;
	instMyCalc.Param2   = par2;
	
	/* call synchron functionblock */
	MyCalculator(&instMyCalc);
	
	/* check expectations and report outcome */
	if(expectResult != instMyCalc.Result) 
	{
		addFailure("Calculation Error", line, file); 
	}
	else if (ERR_OK != instMyCalc.Status)
	{
		addFailure("Unexpected Status", line, file); 
	}
	else
	{
		addPassed("",0,0);
		return 1;
	}
	return 0;
}

#ifdef SMARTEDIT_DUMMY
/* When the helper is formulated as macro, the correct location (line / file) inside the testcase is given. */
void SPL_ASSERT_VERIFY_SUBTRACT(INT par1, INT par2 , DINT expectResult);
#endif
#define  SPL_ASSERT_VERIFY_SUBTRACT( par1,  par2 , expectResult)  spl_verify_subtract_impl(par1, par2, expectResult, __LINE__, __FILE__);

/***************************************** 
* End Custom Assert 
*/

/*****************************************
	Begin Test Set 
*/
_TEST test_Subtract(void)
{
	SPL_ASSERT_VERIFY_SUBTRACT(4, 2, 2);
	
	/* test is done */
	TEST_DONE;
}


_TEST test_Subtract_negResult(void)
{
	SPL_ASSERT_VERIFY_SUBTRACT(6, 8, -2);
	/* test is done */
	TEST_DONE;
}

_TEST test_Subtract_zeroResult(void)
{
	SPL_ASSERT_VERIFY_SUBTRACT(6, 6, 0);
	
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

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_MyCalcLib_Subtraction_variantD, "testSet_MyCalcLib_Subtraction_variantD", 0, 0, fixtures, 0, 0, 0);

