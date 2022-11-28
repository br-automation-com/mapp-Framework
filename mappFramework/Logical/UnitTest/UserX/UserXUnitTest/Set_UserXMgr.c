#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define TIMEOUT_TEST_CASE									\
	if (cycleCount >= 254)									\
	{														\
		char abortMessage[80];								\
		char substate[10];									\
		memset(abortMessage, 0, sizeof(abortMessage));		\
		memset(substate, 0, sizeof(substate));				\
		itoa(ActSubState, substate, 10);					\
		strcpy(abortMessage, "Timeout in ActSubState = ");	\
		strcat(abortMessage, substate);						\
		TEST_FAIL(abortMessage);							\
		TEST_DONE;											\
	}

_SETUP_SET(void)
{
	TestStep = 0;
	cycleCount = 0;
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}


_SETUP_TEST(void)
{
//		TODO: Fix issue with variable mapping or removal of UserX MpUserXLogin_0 from framework as it is not used.
//	  switch (TestStep)
//	  {
//		  case 0:
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  MpUserXLogin_0.Enable = 1;
//			  brwcscpy((UDINT)&UT_Username, (UDINT)&UT_UserList[0]); 
//			  MpUserXLogin_0.UserName = (UDINT)&UT_Username;
//			  MpUserXLogin_0.Password = (UDINT)&UT_Password;
//			  MpUserXLogin_0.Login = 1;
//			  MpUserXLogin(&MpUserXLogin_0);
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_BUSY_CONDITION(UT_Compare != 0);
//			  if (UT_Compare == 0){
//				  TEST_ABORT_CONDITION(UserXLoginUIConnect.Status == mpUSERX_UI_STATUS_ERROR);
//				  MpUserXLogin_0.Login = 0;
//				  TestStep = 1;
//			  }	
//			  break;
//		  case 1:
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ABORT_CONDITION(UT_Compare != 0);
//			  TestStep = 0;
//			  TEST_DONE;
//			  break;
//	  }
//	  TEST_BUSY;
	TEST_DONE; // Temporary
}

_TEST USERX_ROLES_CHECK(void)
{
//		See Note in setup	
//	  switch (TestStep){
//		  case 0:
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ABORT_CONDITION(UT_Compare != 0); // Check to make sure role is admin so all users / roles can be seen
//			  for (UT_i = 0; UT_i < (sizeof(UT_RoleList) / sizeof(UT_RoleList[0]) - 1); UT_i++)
//			  {
//				  for (UT_j = 0; UT_j < (sizeof(UserXMgrUIConnect.Role.List.Names) / sizeof(UserXMgrUIConnect.Role.List.Names[0]) - 1); UT_j++)
//				  {
//					  UT_Compare = brwcscmp((UDINT)&UserXMgrUIConnect.Role.List.Names[UT_j], (UDINT)&UT_RoleList[UT_i]);
//					  if (UT_Compare == 0) 
//					  {
//						  
//						  break;
//					  }
//				  }
//				  if (UT_RoleList[UT_i] != "")
//				  {
//					  TEST_ASSERT(UT_Compare == 0);
//				  }				
//			  }
//			  TestStep = 1;
//			  break;
//		  case 1:
//			  TestStep = 0;
//			  TEST_DONE;
//			  break;
//	  }
//	  TEST_BUSY;
	TEST_DONE; // Temporary
}

_TEST USERX_USER_CHECK(void)
{
//		See Note in setup
//	  
//	  switch (TestStep){
//		  case 0: // Ensure Admin has Admin Role
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ABORT_CONDITION(UT_Compare != 0);
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  TestStep = 1;
//			  break;
//		  case 1:
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  brwcscpy((UDINT)&UT_Username, (UDINT)&UT_UserList[1]);
//			  MpUserXLogin_0.Enable = 1;
//			  MpUserXLogin_0.UserName = (UDINT)&UT_Username;
//			  MpUserXLogin_0.Password = (UDINT)&UT_Password;
//			  MpUserXLogin_0.Login = 1;
//			  MpUserXLogin(&MpUserXLogin_0);
//			  while (MpUserXLogin_0.CommandBusy == 1){
//				  MpUserXLogin(&MpUserXLogin_0);
//			  }
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ASSERT(UT_Compare == 0);
//			  if (UT_Compare == 0){
//				  MpUserXLogin_0.Login = 0;
//				  //	TODO: UIConnect does not update on user change this may require that the password be reset as required by the configuration	
//				  //UT_Compare = brwcscmp((UDINT)&UT_RoleList[1], (UDINT)&UserXMgrUIConnect.Role.Info.Name);
//				  //TEST_ASSERT(UT_Compare == 0);
//				  TestStep = 2;
//			  }	
//			  break;
//		  
//		  case 2:	
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  brwcscpy((UDINT)&UT_Username, (UDINT)&UT_UserList[2]);
//			  MpUserXLogin_0.Enable = 1;
//			  MpUserXLogin_0.UserName = (UDINT)&UT_Username;
//			  MpUserXLogin_0.Password = (UDINT)&UT_Password;
//			  MpUserXLogin_0.Login = 1;
//			  MpUserXLogin(&MpUserXLogin_0);
//			  while (MpUserXLogin_0.CommandBusy == 1){
//				  MpUserXLogin(&MpUserXLogin_0);
//			  }
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ASSERT(UT_Compare == 0);
//			  if (UT_Compare == 0){
//				  MpUserXLogin_0.Login = 0;
////				TODO: UIConnect does not update on user change this may require that the password be reset as required by the configuration			
////				UT_Compare = brwcscmp((UDINT)&UT_RoleList[2], (UDINT)&UserXMgrUIConnect.Role.Info.Name);
////				TEST_ASSERT(UT_Compare == 0);
//				  TestStep = 3;
//			  }	
//			  break;
//		  case 3:
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  brwcscpy((UDINT)&UT_Username, (UDINT)&UT_UserList[0]);
//			  MpUserXLogin_0.Enable = 1;
//			  MpUserXLogin_0.UserName = (UDINT)&UT_Username;
//			  MpUserXLogin_0.Password = (UDINT)&UT_Password;
//			  MpUserXLogin_0.Login = 1;
//			  MpUserXLogin(&MpUserXLogin_0);
//			  while (MpUserXLogin_0.CommandBusy == 1){
//				  MpUserXLogin(&MpUserXLogin_0);
//			  }
//			  UT_Compare = brwcscmp((UDINT)&MpUserXLogin_0.CurrentUser, (UDINT)&UT_Username);
//			  TEST_ASSERT(UT_Compare == 0);
//			  if (UT_Compare == 0){
//				  MpUserXLogin_0.Login = 0;
//				  TestStep = 4;
//			  }	
//			  break;
//		  case 4:
//			  TestStep = 0;
//			  TEST_DONE;
//			  break;
//	  }
//	  TEST_BUSY;
	TEST_DONE; // Temporary
}

_TEST USERX_LOGOUT(void){
	//		See Note in setup
//	  switch (TestStep){
//		  case 0:
//			  TEST_ABORT_CONDITION(MpUserXLogin_0.MpLink == 0);
//			  MpUserXLogin_0.Enable = 1;
//			  MpUserXLogin_0.Logout = 1;
//			  MpUserXLogin(&MpUserXLogin_0);
//			  while (MpUserXLogin_0.CommandBusy == 1){
//				  MpUserXLogin(&MpUserXLogin_0);
//			  }
//			  TestStep = 1;
//			  break;
//		  case 1:
//			  TEST_ASSERT(MpUserXLogin_0.CurrentLevel != 0);
//			  TestStep = 2;
//			  break;
//		  case 2:
//			  TestStep = 0;
//			  TEST_DONE;
//			  break;
//	  }
	TEST_DONE; // Temporary
}
_TEARDOWN_TEST(void)
{
	TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-23 14:37:57Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("USERX_ROLES_CHECK", USERX_ROLES_CHECK), 
	new_TestFixture("USERX_USER_CHECK", USERX_USER_CHECK), 
	new_TestFixture("USERX_LOGOUT", USERX_LOGOUT), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_UserXMgr, "Set_UserXMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

