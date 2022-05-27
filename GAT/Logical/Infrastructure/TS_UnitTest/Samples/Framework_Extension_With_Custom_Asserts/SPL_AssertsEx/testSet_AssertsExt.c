/********************************************************************
* COPYRIGHT -- Bernecker + Rainer
********************************************************************
* Program: SPL_AssertsEx
* Author: B+R
********************************************************************
* This test set shows the use of self created asserts.
* Asserts are implemented in the library LibAssert1.
********************************************************************/


#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include "LibAssert1.h"



_TEST test_splAssert_ArrayOfRealValues(void)
{
	/* manual generated differences for demonstration of the SPL_ASSERT */
	FloatArray1[0] = 2;
	FloatArray2[0] = 2;

	FloatArray1[1] = 3;
	FloatArray2[1] = 1;

	FloatArray1[30] = 3.33;
	FloatArray2[30] = 1.11;

	FloatArrayDeltaForComparison[31] = 1; /* Within -> pass, equal -> failed */
	FloatArray1[31] = 3.33;
	FloatArray2[31] = 3.31;


	SPL_ASSERT_ARRAY_EQUAL_REAL(FloatArray1, FloatArray2, sizeof(FloatArray1) / sizeof(FloatArray1[0]) );
	SPL_ASSERT_ARRAY_REAL_WITHIN(FloatArrayDeltaForComparison, FloatArray1, FloatArray2, sizeof(FloatArray1) / sizeof(FloatArray1[0]) );
	TEST_DONE;
}



_TEST test_splAssert_Boundary()
{
	/* should fail */
	SPL_ASSERT_UPPER_BOUNDARY(2,4);

	/* should pass */
	SPL_ASSERT_UPPER_BOUNDARY(4,2);
	
	TEST_DONE;
}






/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2015-04-14 12:04:07Z
By B+R UnitTest Helper Version: 2.0.0.0
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("test_splAssert_ArrayOfRealValues", test_splAssert_ArrayOfRealValues), 
	new_TestFixture("test_splAssert_Boundary", test_splAssert_Boundary), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_AssertsExt, "testSet_AssertsExt", 0, 0, fixtures, 0, 0, 0);

