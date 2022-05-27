(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: UtMgr
 * File: UtMgr.typ
 * Author: B+R
 ********************************************************************
 * Data types of library UtMgr
 ********************************************************************)

TYPE
	UtMgrLocationType : 	STRUCT  (*Provides location information as passed by a assert*)
		TestSetName : UDINT; (*&STRING Name of current Test Set*)
		TestCaseName : UDINT; (*&STRING Name of current Test Case*)
		Line : UDINT; (*Line number (utMgrTEST_TYPE_C)*)
		Location : UDINT; (*&STRING Location information *)
		File : UDINT; (*&STRING File name*)
	END_STRUCT;
	UtMgrInformationalType : 	STRUCT  (*Informational Data, will be reset before test run is active*)
		TestCasesSinceActiveCounter : UDINT; (*Counts executed test cases (increments at the beginning of a test case)*)
		FailedAssertCounter : UDINT; (*Counts total failed asserts since start of testsuite execution *)
		PassedAssertCounter : UDINT; (*Counts total passed asserts since start of testsuite execution *)
		InformationalMessageCounter : UDINT; (*Counts total informational messages since start of testsuite execution *)
		LastKnownPassedLocation : UtMgrLocationType; (*Provides information about last known location (as reported in a test assert)*)
	END_STRUCT;
	UtMgrTestTypeEnum : 
		( (*Defines Implementation of  UtMgrTestSuite*)
		utMgrTEST_TYPE_NONE := 0, (*Invalid value*)
		utMgrTEST_TYPE_C := 10, (*Test Suite uses the static library UnitTest *)
		utMgrTEST_TYPE_OTHER := 20 (*Reserved*)
		);
	UtMgrTestPhaseBasicHelperEnum : 
		( (*Internal status of test execution*)
		utMgrTEST_PHASE_IDLE := 0, (*No tests running*)
		utMgrTEST_PHASE_RUNNING := 5, (*Executing Test Sets*)
		utMgrTEST_PHASE_DONE := 10 (*Done executing Test Sets*)
		);
	UtMgrUnitTestRunnerHelperType : 	STRUCT  (*Internal*)
		TestSets : UDINT; (*Pointer to the array of Test Sets*)
		TestSetCount : UINT; (*Number of entries in array*)
		CurrentPhase : UtMgrTestPhaseBasicHelperEnum; (*Status of internal test execution*)
		CurrentTestSet : UINT; (*Index of current active Test Set*)
	END_STRUCT;
	UtMgrSuiteInternalType : 	STRUCT  (*Internal*)
		State : DINT; (*Internal*)
		Handle : UDINT; (*Internal*)
		List : ARRAY[0..29]OF UDINT; (*Internal*)
		LibInst : UDINT; (*Internal*)
		TestHelper : UtMgrUnitTestRunnerHelperType; (*Internal*)
	END_STRUCT;
END_TYPE
