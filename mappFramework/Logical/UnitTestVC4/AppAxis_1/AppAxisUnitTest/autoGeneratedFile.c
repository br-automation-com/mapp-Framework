/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (List of TestSets).
LastUpdated: 2022-11-08 14:30:25Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
#include "UnitTest.h"



UNITTEST_TESTSET_DECLARATION  Set_Common;
UNITTEST_TESTSET_DECLARATION  Set_ManualTests;
UNITTEST_TESTSET_DECLARATION  Set_AutomaticTests;



UNITTEST_TESTSET_FIXTURES(utTestSets)
{
	new_TestSet(Set_Common),
	new_TestSet(Set_ManualTests),
	new_TestSet(Set_AutomaticTests),
};
UNTITTEST_TESTSET_HANDLER();

