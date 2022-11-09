#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

_SETUP_SET(void)
{
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}


_SETUP_TEST(void)
{
	switch (TestStep)
	{
		case 0:
			TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
			MpUserXLogin_0.Enable = 1;
			MpUserXLogin_0.UserName = (UDINT)&UT_Username;
			MpUserXLogin_0.Password = (UDINT)&UT_Password;
			MpUserXLogin_0.Login = 1;
			MpUserXLogin(&MpUserXLogin_0);
			UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
			TEST_BUSY_CONDITION(UT_Compare != 0);
			if (UT_Compare == 0){
				TEST_ABORT_CONDITION(UserXLoginUIConnect.Status == mpUSERX_UI_STATUS_ERROR);
				MpUserXLogin_0.Login = 0;
				TestStep = 1;
			}	
			break;
		case 1:
			UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
			TEST_ABORT_CONDITION(UT_Compare != 0);
			TestStep = 0;
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST USERX_ROLES_CHECK(void)
{
	switch (TestStep){
		case 0:
			UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
			TEST_ABORT_CONDITION(UT_Compare != 0); // Check to make sure role is admin so all users / roles can be seen
			for (UT_i = 0; UT_i < (sizeof(UT_UserList) / sizeof(UT_UserList[0]) - 1); UT_i++)
			{
				for (UT_j = 0; UT_j < (sizeof(UserXMgrUIConnect.User.List.UserNames) / sizeof(UserXMgrUIConnect.User.List.UserNames[0]) - 1); UT_j++)
				{
					UT_Compare = brwcscmp((UDINT)&UserXMgrUIConnect.User.List.UserNames[UT_j], (UDINT)&UT_UserList[UT_i]);
					if (UT_Compare == 0) 
					{
						
						break;
					}
				}
				if (UT_UserList[UT_i] != "")
				{
					TEST_ASSERT(UT_Compare == 0);
				}				
			}
			TestStep = 1;
			break;
		case 1:
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}
_TEARDOWN_TEST(void)
{
	TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-08 20:27:26Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("USERX_ROLES_CHECK", USERX_ROLES_CHECK), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_UserXMgr, "Set_UserXMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

