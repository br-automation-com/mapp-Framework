(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: UtWs
 * File: UtWs.fun
 * Author: B+R
 ********************************************************************
 * Functions and function blocks of library UtWs
 ********************************************************************)

FUNCTION_BLOCK UtWsStatistics (*Presents diagnostic data for monitoring*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*FB is active*)
		Error : BOOL; (*Indicates an error*)
		StatusID : DINT; (*Status information*)
		TestActive : BOOL; (*True if any test is currently running / requested*)
		TestsCalled : UDINT; (*Requested tests*)
		MaxResponseBytes : UDINT; (*Maximum report size*)
		MaxTestRunningSeconds : UDINT; (*Longest duration of any UtMgrTestSuite*)
		CurrentTest : STRING[80]; (*Name of current UtMgrTestSuite*)
		LastCalledTest : STRING[80]; (*Name of last requested UtMgrTestSuite*)
		LastTestRunningSeconds : UDINT; (*Time of execution of last executed UtMgrTestSuite*)
		LastTestTotalTestCases : UDINT; (*Number of executed test cases of last executed UtMgrTestSuite*)
		LastTestPassedTestCases : UDINT; (*Number of passed test cases of last executed UtMgrTestSuite*)
		LastTestTotalAsserts : UDINT; (*Number of executed asserts of last exectued UtMgrTestSuite*)
		LastTestPassedAsserts : UDINT; (*Number of passed asserts of last exectued UtMgrTestSuite*)
		LastTestFailedAsserts : UDINT; (*Number of failed asserts of last exectued UtMgrTestSuite*)
	END_VAR
END_FUNCTION_BLOCK
