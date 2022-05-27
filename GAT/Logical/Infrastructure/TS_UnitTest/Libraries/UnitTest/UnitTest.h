/*****************************************************************************
 * COPYRIGHT (C) BERNECKER + RAINER
 *****************************************************************************
 * Library:  UnitTest
 * File:     UnitTest.h
 * Author:   B+R
 *****************************************************************************
 * Description: Static library for UnitTest programs written in ANSI C /C++
 *
 * Add the path "\Logical\TS_UnitTest\Libraries\UnitTest\" to the 
 * "Additional include directories" in the tab "Build" (PLC Properties)
 ******************************************************************************/


#ifndef	__UNITTEST_H__
#define	__UNITTEST_H__
#ifdef __cplusplus
extern "C"
{
#endif
#include <bur/plctypes.h>

#ifndef NULL
#define	NULL	0
#endif
#include "include/Test.h"

#include "include/TestCase.h"
#include "include/TestListener.h"
#include "include/TestResult.h"
#include "include/TestCaller.h"

#include "include/AssertImpl.h"
#include "include/HelperMacro.h"
#include "include/utRunner.h"

/* function is a test case */
#define _TEST 			static testStatusEnum

/* function is a setup */
#define _SETUP_TEST 	static testStatusEnum 	setupTest

/* function is a teardown */
#define _TEARDOWN_TEST 	static testStatusEnum 	teardownTest

/* function is a setup for whole test set */
#define _SETUP_SET		static testStatusEnum	setupSet

/* function is a teardown for whole test set */
#define _TEARDOWN_SET 	static testStatusEnum	teardownSet

/* function is a cyclic handler for test set */
#define _CYCLIC_SET		static void 			cyclicSetCaller


/* Skipped test case */
#define SKIP_TEST  		_TEST
/* Skip all test cases of set */
#define SKIP_TEST_SET


/* Dummies for smart edit autocompletion.
See AssertImpl.h for real macros used by the compiler  */
#ifdef _SMART_EDIT_DUMMY_

/* String comparison. 
Returns true if the strings are equal. */
BOOL TEST_ASSERT_EQUAL_STRING(char *expected,char  *actual);
/* Wstring comparison. 
Returns true if the WSTRINGS are equal. */
BOOL TEST_ASSERT_EQUAL_WSTRING(unsigned short *expected,unsigned short *actual);
 /* Compares two memory blocks. 
Returns true if [size] bytes are equal. */
BOOL TEST_ASSERT_EQUAL_MEM(void *expected, void *actual,UDINT size);
/* Compares integer values. Usable for all integer types.
Avoid comparison of unsigned with signed types.
Returns true if they are equal.
Note: If different, values are reported as DINT values in the test report */
BOOL TEST_ASSERT_EQUAL_INT(expected, actual);



/* Compares REAL values with delta = (expected * TEST_FLOAT_PRECISION). 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_EQUAL_REAL(REAL expected,REAL actual);
/* Compares REAL values with explicit delta. 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_REAL_WITHIN(REAL delta, REAL expected, REAL actual);
/* Compares LREAL values with delta = (expected * TEST_DOUBLE_PRECISION). 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_EQUAL_LREAL(LREAL expected,LREAL  actual);
/* Compares LREAL values with explicit delta. 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_LREAL_WITHIN(LREAL delta, LREAL expected, LREAL actual);

/* Compares float values with delta = (expected * TEST_FLOAT_PRECISION). 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_EQUAL_FLOAT(float expected, float actual);
/* Compares float values with explicit delta. 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_FLOAT_WITHIN(float delta, float expected, float actual);
/* Compares double values with delta = (expected * TEST_DOUBLE_PRECISION). 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_EQUAL_DOUBLE(double expected, double actual);
/* Compares double values with explicit delta. 
Returns true if (difference <= delta) */
BOOL TEST_ASSERT_DOUBLE_WITHIN(double delta, double expected, double actual);


/* Returns true if pointer is null */
BOOL TEST_ASSERT_NULL(void *pointer);
/* Returns true if pointer is not null */
BOOL TEST_ASSERT_NOT_NULL(void *pointer);
/* Returns true, if condition evals to  true */
BOOL TEST_ASSERT_MESSAGE(condition, char *message);
/* Returns true, if condition evals to  true */
BOOL TEST_ASSERT(condition);

/* Returns always false */
BOOL TEST_FAIL(char *message);

/* Add a note to the test report */
void TEST_INFO(char *message);
/* Add a note with location information to the test report */
void TEST_INFO_POS(char *message);


#ifdef __cplusplus
/* Test if expression throws given exception.
Catches all other exceptions as failure.
Note: Available for C++ only */
void TEST_ASSERT_THROW(expression, type);

/* Fails if expression throws any exceptions.
Note: Available for C++ only*/
void TEST_ASSERT_NO_THROW(expression);
#endif


/* Adds a test function with description to the Testfixture.
See UNITTEST_FIXTURES() */
void new_TestFixture(char *name, _TEST function);

/* Adds a test function with description to the Testfixture.
This test will be skipped
See UNITTEST_FIXTURES() */
void skipTestFixture(char *name, _TEST function);


/* Defines the order of test cases.
Should look like this
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("test_1",test_1),
	new_TestFixture("test_2",test_2),
	new_TestFixture("test_3",test_3)
}
*/
void UNITTEST_FIXTURES(fixtures)

/* Standard UnitTest caller without any setup / teardown methods*/
void UNITTEST_CALLER_TEST(caller, char *name, fixtures);

/* Standard UnitTest caller with macro setup / teardown for tests*/
void UNITTEST_CALLER_BASIC(caller, char *name, fixtures);

/* UnitTest caller with macro setup / teardown for tests and test set */
void UNITTEST_CALLER_SET(caller, char *name, fixtures);

/* UnitTest caller with macro setup / teardown for tests and test set and cylic*/
void UNITTEST_CALLER_COMPLETE(caller, char *name, fixtures);

/* UnitTest caller with explicit setup / teardown for suite */
void UNITTEST_CALLER_SET_EXPLICIT(caller,name,setupTest,teardownTest,fixtures, setupSuite, teardownSuite);

/* UnitTest caller with explicit setup / teardown for suite and cylic */
void UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,setupTest,teardownTest,fixtures, setupSuite, teardownSuite, cyclicCaller);

/* Adds a test set with description to the fixture of test sets.
See UNITTEST_TESTSET_FIXTURES() */
void new_TestSet(testcaller);

/* Defines the order of test sets.
Should look like this
UNITTEST_TESTSET_FIXTURES(fixtures)
{
	new_TestSet(testSet_1),
	new_TestSet(testSet_2),
	new_TestSet(testSet_3)
}*/
void UNITTEST_TESTSET_FIXTURES(fixtures);

/* Defines the test set list handling structure*/
void UNTITTEST_TESTSET_HANDLER();

#endif /*_SMART_EDIT_DUMMY_*/



/*
 Use to declare Test set for use in list of test sets of test programm
 See usage in autogeneratedFile.c / FixtureOfTestSets.c
*/
#define UNITTEST_TESTSET_DECLARATION 	extern const TestCaller


/* Default factor for precision used to test if REAL / float values  are equal. 
(0.00001f) */
#define TEST_FLOAT_PRECISION 	(0.00001f)
/* Default factor for precision used to test if LREAL / double values  are equal. 
(1e - 12f) */
#define TEST_DOUBLE_PRECISION 	(1e-12f)





#if (__GNUC__ != 6) || (__GNUC_MINOR__ != 3) || (__GNUC_PATCHLEVEL__ != 0)
#error UnitTest is compiled with GCC version 6.3.0. To use UnitTest switch GCC version to 6.3.0 or import a different solution package 
#endif


#define UNIT_TEST_LIBRARY_VERSION  			"2.01.0"


#ifdef __cplusplus
};
#endif

#include "include/asserts.hpp"

#endif/*__UNITTEST_H__*/
