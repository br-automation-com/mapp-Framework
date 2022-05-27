/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (List of TestSets).
LastUpdated: 2015-04-14 12:03:48Z
By B+R UnitTest Helper Version: 2.0.0.0
*/
#include "UnitTest.h"



UNITTEST_TESTSET_DECLARATION  test_SetTestCases;
UNITTEST_TESTSET_DECLARATION  test_SetTestCases_SetSetup_SetTeardown;
UNITTEST_TESTSET_DECLARATION  test_SetTestCases_TestSetup_TestTeardown;
UNITTEST_TESTSET_DECLARATION  test_SetComplete;
UNITTEST_TESTSET_DECLARATION  TestBusy_Asyncronous;
UNITTEST_TESTSET_DECLARATION  TestBusy_Asyncronous_with_CyclicSet;



UNITTEST_TESTSET_FIXTURES(utTestSets)
{
	new_TestSet(test_SetTestCases),
	new_TestSet(test_SetTestCases_SetSetup_SetTeardown),
	new_TestSet(test_SetTestCases_TestSetup_TestTeardown),
	new_TestSet(test_SetComplete),
	new_TestSet(TestBusy_Asyncronous),
	new_TestSet(TestBusy_Asyncronous_with_CyclicSet),
};
UNTITTEST_TESTSET_HANDLER();

