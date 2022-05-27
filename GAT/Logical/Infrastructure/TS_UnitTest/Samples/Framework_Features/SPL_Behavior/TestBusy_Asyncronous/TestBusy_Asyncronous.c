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

#include "AsArCfg.h"

#include "UnitTest.h"

/* _SETUP_TEST() is called before each test case of this test set */
_SETUP_TEST(void)
{
	/* Call */
	webserverStatus.enable = 0;
	CfgGetWebServerStatus(&webserverStatus);

	webserverSetMimeType.enable = 0;
	CfgSetWebMimeType(&webserverSetMimeType);

	webserverGetMimeType.enable = 0;
	CfgGetWebMimeType(&webserverGetMimeType);

	/* Done */
	TEST_DONE;
}

/* _TEARDOWN_SET() is called at end of this test set */
_TEARDOWN_SET(void)
{
	/* Call */
	webserverStatus.enable = 0;
	CfgGetWebServerStatus(&webserverStatus);

	webserverSetMimeType.enable = 0;
	CfgSetWebMimeType(&webserverSetMimeType);

	webserverGetMimeType.enable = 0;
	CfgGetWebMimeType(&webserverGetMimeType);

	/* Done */
	TEST_DONE;
}



/* Sample test case tests async. FB CfgGetWebServerStatus() */
_TEST test_AsyncFub(void)
{
	/* Call */
	webserverStatus.enable = 1;
	CfgGetWebServerStatus(&webserverStatus);

	/* Wait  */
	TEST_BUSY_CONDITION(ERR_FUB_BUSY == webserverStatus.status );

	/* Test */
	TEST_ASSERT_EQUAL_INT( ERR_OK, webserverStatus.status  );
	TEST_ASSERT_EQUAL_INT(cfgWEB_MODE_ENABLED,  webserverStatus.mode);


	/* Done */
	TEST_DONE;
}



/* Sample test case tests async. FB CfgGetWebMimeType() */
_TEST test_getMimeType(void)
{
	/* Call */
	webserverGetMimeType.enable = 1;
	webserverGetMimeType.pFileExtension =  (UDINT) "*.txt";
	webserverGetMimeType.pMimeType = (UDINT)GetMimeTypeResult;
	webserverGetMimeType.len = sizeof(GetMimeTypeResult) - 1;
	CfgGetWebMimeType(&webserverGetMimeType);

	/* Wait  */
	TEST_BUSY_CONDITION_MSG(ERR_FUB_BUSY == webserverGetMimeType.status,  "Fub is busy");

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

UNITTEST_CALLER_COMPLETE_EXPLICIT(TestBusy_Asyncronous, "TestBusy_Asyncronous", setupTest, 0, fixtures, 0, teardownSet, 0);

