/********************************************************************
* COPYRIGHT -- Bernecker + Rainer
********************************************************************
* Program: SPL_Behavior
* Author: B+R
********************************************************************
* This test set shows the option to call a function 
*       (test case, setup or teardown) until "done".
* This is usable for example for testing asynchronous FUBs.
********************************************************************/


#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"


#include "iHelperFunction.h"



/*_CYCLIC_SET() is called in each cycle as long this Test Set is the active test set*/
_CYCLIC_SET(void)
{
	LOG_FOR_EXEMPLIFICATION_CYCLIC_SET;
	CfgGetWebServerStatus(&webserverStatus);
	CfgSetWebMimeType(&webserverSetMimeType);
	CfgGetWebMimeType(&webserverGetMimeType);

}

/* _SETUP_SET() is called at the beginning of this test set */
_SETUP_SET(void)
{
	resetDataForTestSet();

	LOG_FOR_EXEMPLIFICATION_SETUP_SET;

	/*Disable FB at beginning of this test set*/
	webserverStatus.enable = 0;
	webserverSetMimeType.enable = 0;
	webserverGetMimeType.enable = 0;

	TEST_DONE;
}

/* _SETUP_TEST() is called before each test case of this test set */
_SETUP_TEST(void)
{
	LOG_FOR_EXEMPLIFICATION_SETUP_TEST;

	/*Disable FB at beginning of this test set*/
	webserverStatus.enable = 0;
	webserverSetMimeType.enable = 0;
	webserverGetMimeType.enable = 0;

	TEST_DONE;
}



/* _TEARDOWN_SET() is called at end of this test set */
_TEARDOWN_SET(void)
{
	LOG_FOR_EXEMPLIFICATION_TEARDOWN_SET;
	/*Disable FB after each test case*/
	webserverStatus.enable = 0;
	webserverSetMimeType.enable = 0;
	webserverGetMimeType.enable = 0;

	/* Done */
	TEST_DONE;
}




/* Sample test case tests async. FB CfgGetWebServerStatus() */
_TEST test_AsyncFub(void)
{
	LOG_FOR_EXEMPLIFICATION_TEST_CASE_1;

	/*Silent  wait  as FB is still busy*/
	TEST_BUSY_CONDITION(ERR_FUB_BUSY == webserverStatus.status  );

	webserverStatus.enable = 1;

	/*Silent  wait  as FB is not yet enabled*/
	TEST_BUSY_CONDITION( ERR_FUB_ENABLE_FALSE == webserverStatus.status );

	/* Test */
	TEST_ASSERT_EQUAL_INT( ERR_OK, webserverStatus.status  );
	TEST_ASSERT_EQUAL_INT(cfgWEB_MODE_ENABLED,  webserverStatus.mode);


	/* Done */
	TEST_DONE;
}



/* Sample test case tests async. FB CfgGetWebMimeType() */
_TEST test_getMimeType(void)
{
	LOG_FOR_EXEMPLIFICATION_TEST_CASE_3;

	TEST_BUSY_CONDITION_MSG(ERR_FUB_BUSY == webserverGetMimeType.status,  "Fub is busy");

	webserverGetMimeType.enable = 1;
	webserverGetMimeType.pFileExtension =  (UDINT) "*.txt";
	webserverGetMimeType.pMimeType = (UDINT)GetMimeTypeResult;
	webserverGetMimeType.len = sizeof(GetMimeTypeResult) - 1;

	/* Wait  */
	TEST_BUSY_CONDITION_MSG(ERR_FUB_ENABLE_FALSE == webserverGetMimeType.status,  "Fub is not enabled");

	/* Test */
	TEST_ASSERT_EQUAL_INT( ERR_OK, webserverGetMimeType.status  );
	TEST_ASSERT_EQUAL_STRING("text/plain", GetMimeTypeResult   );

	/* Done */
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
	new_TestFixture("test_AsyncFub", test_AsyncFub), 
	new_TestFixture("test_getMimeType", test_getMimeType), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(TestBusy_Asyncronous_with_CyclicSet, "TestBusy_Asyncronous_with_CyclicSet", setupTest, 0, fixtures, setupSet, teardownSet, cyclicSetCaller);

