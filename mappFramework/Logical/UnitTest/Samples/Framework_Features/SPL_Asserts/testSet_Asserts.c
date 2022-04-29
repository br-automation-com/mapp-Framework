/********************************************************************
* COPYRIGHT -- Bernecker + Rainer
********************************************************************
* Program: SPL_Asserts
* Author: B+R
********************************************************************
* This test set shows the available asserts of the UnitTest library
********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"


/* Executed before each test case */
_SETUP_TEST(void)
{
	MySecondVar = 2;

	TEST_DONE;
}

/* Executed after each test case */
_TEARDOWN_TEST(void)
{
	TEST_DONE;
}


_TEST test_int(void)
{
	TEST_ASSERT_EQUAL_INT(	Usi1, 	Usi2);
	TEST_ASSERT_EQUAL_INT( 	Si1,	Si2 );
	TEST_ASSERT_EQUAL_INT( 	Ui1, 	Ui2	);
	TEST_ASSERT_EQUAL_INT( 	I1, 	I2	);
	TEST_ASSERT_EQUAL_INT( 	Di1, 	Di2	);
	TEST_ASSERT_EQUAL_INT(	Udi1, 	Udi2);

	TEST_DONE;
}

_TEST test_string(void)
{
	TEST_ASSERT_EQUAL_STRING(String1, String2 );

	TEST_DONE;
}

_TEST test_wstring(void)
{
	TEST_ASSERT_EQUAL_WSTRING(WString1,	WString2);

	TEST_DONE;
}

_TEST test_float(void)
{
	TEST_ASSERT_EQUAL_FLOAT(Real1, Real2);
	TEST_ASSERT_FLOAT_WITHIN(RealDeltaForComparison, Real1, Real2);

	TEST_ASSERT_EQUAL_REAL(Real1, Real2);
	TEST_ASSERT_REAL_WITHIN(RealDeltaForComparison, Real1, Real2);

	TEST_DONE;
}

_TEST test_double(void)
{
	TEST_ASSERT_EQUAL_DOUBLE(LReal1, LReal2);
	TEST_ASSERT_DOUBLE_WITHIN(LRealDeltaForComparison, LReal1, LReal2);

	TEST_ASSERT_EQUAL_LREAL(LReal1, LReal2);
	TEST_ASSERT_LREAL_WITHIN(LRealDeltaForComparison, LReal1, LReal2);

	TEST_DONE;
}

_TEST test_memory(void)
{
	TEST_ASSERT_EQUAL_MEM(Buffer1, Buffer2, sizeof(Buffer1)  );

	TEST_DONE;
}

_TEST test_null_true_and_false(void)
{
	TEST_ASSERT_NOT_NULL(Pointer);
	TEST_ASSERT_NOT_NULL(0); 	/* Not Ok */

	TEST_ASSERT_NULL(0); 		/* Ok */
	TEST_ASSERT_NULL(Pointer);

	Pointer = &Udi1;
	TEST_ASSERT_NULL(Pointer); /* Not Ok */

	TEST_DONE;
}

_TEST test_message(void)
{
	TEST_ASSERT_MESSAGE(ConditionFlag, "This text, if condition evaluates to false.");
	ConditionFlag = 0;
	TEST_ASSERT_MESSAGE(ConditionFlag, "This text, because condition evaluates to false.");
	ConditionFlag = 4;
	TEST_ASSERT_MESSAGE(ConditionFlag, "Nothing, as condition evaluates to true (!= 0).");

	TEST_DONE;
}

_TEST test_info(void)
{
	TEST_INFO("Info Text - for some comment");
	TEST_INFO_POS("Info Text - for some comment with position");

	TEST_DONE;
}

_TEST test_fail(void)
{
	TEST_FAIL("Always fails");

	TEST_DONE;
}





/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2015-04-14 12:03:48Z
By B+R UnitTest Helper Version: 2.0.0.0
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("test_int", test_int), 
	new_TestFixture("test_string", test_string), 
	new_TestFixture("test_wstring", test_wstring), 
	new_TestFixture("test_float", test_float), 
	new_TestFixture("test_double", test_double), 
	new_TestFixture("test_memory", test_memory), 
	new_TestFixture("test_null_true_and_false", test_null_true_and_false), 
	new_TestFixture("test_message", test_message), 
	new_TestFixture("test_info", test_info), 
	new_TestFixture("test_fail", test_fail), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(testSet_Asserts, "testSet_Asserts", setupTest, teardownTest, fixtures, 0, 0, 0);

