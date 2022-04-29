(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: UtMgr
 * File: UtMgr.fun
 * Author: B+R
 ********************************************************************
 * Functions and function blocks of library UtMgr
 ********************************************************************)

FUNCTION_BLOCK UtMgrTestSuite (*Represents a test suite*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
		Name : STRING[80]; (*Distinct name of test suite*)
		Description : STRING[200]; (*Description of the test suite*)
		Type : UtMgrTestTypeEnum; (*Type of test suite*)
		MetaInformation : STRING[200]; (*Meta information. Data will be copied to the report at the end of the test suite execution*)
		TestAborted : BOOL; (*Rising edge = Test aborted*)
		TestFinished : BOOL; (*Rising edge = Test finished*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*FB is busy*)
		Active : BOOL; (*FB is active*)
		Error : BOOL; (*Indicates an error*)
		StatusID : DINT; (*Status information*)
		TestActive : BOOL; (*Test suite  is active*)
		Informational : UtMgrInformationalType; (*Monitoring information*)
		TestFinishedAck : BOOL; (*Acknowledge of flag "TestFinished"*)
		TestFinishedDone : BOOL; (*Test suite finished, report is done*)
	END_VAR
	VAR
		Internal : UtMgrSuiteInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK UtMgrMonitor (*Provides diagnostic data for monitoring*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*FB is active*)
		Error : BOOL; (*Indicates an error*)
		StatusID : DINT; (*Status information*)
		TestActive : BOOL; (*A test suite is active*)
		Informational : UtMgrInformationalType; (*Informational data provided while FB is active*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION UtMgrTestRunnerRunTest : DINT (*Internal: Used by the static library UnitTest. Handles Test Set execution*)
	VAR_INPUT
		TestSet : UDINT; (*&TestSet*)
	END_VAR
END_FUNCTION
