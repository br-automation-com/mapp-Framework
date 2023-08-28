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
	TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	
	TEST_DONE;
}

_TEST FileDeviceExists(void)
{
	if (strcmp((char*)&FileDeviceName, "") == 0)
	{
		TEST_INFO_POS("FileDeviceName is empty");
		TEST_DONE;
	}
	DirInfoCommon_UT.enable = true;
	DirInfoCommon_UT.pDevice = (UDINT)&FileDeviceName;
	DirInfoCommon_UT.pPath = (UDINT)&"";
	DirInfo(&DirInfoCommon_UT);
	TEST_BUSY_CONDITION(DirInfoCommon_UT.status == 65535);
	TEST_ASSERT_EQUAL_INT(0, DirInfoCommon_UT.status);
	TEST_DONE;
}

_TEST NoFunctionBlockErrors(void)
{
	
	for (USINT i=0; i<(sizeof(MpBlockStatus)/sizeof(MpBlockStatus[0]));i++)
	{
		TEST_ASSERT_EQUAL_INT(0, MpBlockStatus[i]);
	}
	TEST_DONE;
}

_TEST TextFileConfirmation(void)
{
	// Arrange 
	TEST_ABORT_CONDITION(strcmp(TextNameSpace, "") == 0);
	TEST_ABORT_CONDITION(strcmp(TextID, "") == 0);

	ArTextSysGetTextComon_UT.Execute = true;
	ArTextSysGetTextComon_UT.Namespace = (UDINT)&TextNameSpace;
	ArTextSysGetTextComon_UT.TextID = (UDINT)&TextID;
	strcpy((char*)&ArTextSysGetTextComon_UT.LanguageCode, "en");
	ArTextSysGetTextComon_UT.TextBuffer = (UDINT)&Text;
	ArTextSysGetTextComon_UT.TextBufferSize = sizeof(Text)/sizeof(Text[0]);

	// Act
	ArTextSysGetText(&ArTextSysGetTextComon_UT);
	TEST_BUSY_CONDITION(ArTextSysGetTextComon_UT.Busy);

	// Assert
	TEST_ASSERT(ArTextSysGetTextComon_UT.Error == false);
	TEST_ASSERT_EQUAL_INT(0, ArTextSysGetTextComon_UT.StatusID);
	TEST_ASSERT_MESSAGE(strcmp(Text, "") != 0, "Text is empty");
	TEST_DONE;
}


/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-09-22 14:29:52Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("FileDeviceExists", FileDeviceExists), 
	new_TestFixture("NoFunctionBlockErrors", NoFunctionBlockErrors), 
	new_TestFixture("TextFileConfirmation", TextFileConfirmation), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_Common, "Set_Common", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

