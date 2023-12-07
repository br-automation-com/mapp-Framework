#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include "testSuite.h"

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
	return RemoveNonDefaultFiles(MACH_CONFIG_CATEGORY_INDEX, "Machine.mcfg", MACHINE_CONFIGURATION_CATEGORY);
}

_TEARDOWN_SET(void)
{
	SetupState = 0;
	TEST_DONE;
}

_SETUP_TEST(void)
{
	ArrangeSubState = 0;
	ActSubState = 0;
	AssertSubState = 0;
	return RemoveNonDefaultFiles(MACH_CONFIG_CATEGORY_INDEX, "Machine.mcfg", MACHINE_CONFIGURATION_CATEGORY);
}

_TEARDOWN_TEST(void)
{
	memset(&HmiRecipe.Commands, 0, sizeof(HmiRecipe.Commands));
	MpRecipeUIConnect.Recipe.Load = false;
	TEST_BUSY_CONDITION(!SelectRecipe("Machine.mcfg"));

	if (MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR)
	{
		MpRecipeUIConnect.Recipe.Refresh = true;
	}
	TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE)
	MpRecipeUIConnect.Recipe.Refresh = false;

	TEST_DONE;
}

_CYCLIC_SET(void)
{
	cycleCount++;
}

_TEST DefaultValues(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			// set MachineSettings through the pointer
			memset(pMachineSettings, 0, sizeof(*pMachineSettings));
			TEST_BUSY_CONDITION(!SelectRecipe("Machine.mcfg"));
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			if (MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR)
			{
				TEST_FAIL("MpRecipeUIConnect in error state");
				TEST_DONE;
			}
			switch (ActSubState)
			{
				case 0:
					MpRecipeUIConnect.Recipe.Load = true;
					HmiRecipe.Commands.LoadRecipe = true;
					TEST_BUSY_CONDITION(HmiRecipe.Status.ConfigRecipeLoaded == true);
					TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
					HmiRecipe.Commands.LoadRecipe = false;
					MpRecipeUIConnect.Recipe.Load = false;
					ActSubState = 1;
					break;
				case 1:
					TEST_BUSY_CONDITION(HmiRecipe.Status.ConfigRecipeLoaded == false);
					TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_LOAD);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT_EQUAL_INT(11, MachineSettings.AddMachineSettingsHere1);
			TEST_ASSERT_EQUAL_INT(22, MachineSettings.AddMachineSettingsHere2);
			TEST_ASSERT_EQUAL_INT(true, MachineSettings.AddMachineSettingsHere3);
			TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.2999999, MachineSettings.AddMachineSettingsHere4);
			TEST_ASSERT_EQUAL_INT(44, MachineSettings.AddMachineSettingsHere5);
			TEST_DONE;
			break;
	}
	TEST_BUSY;


	TEST_DONE;
}
_TEST CreateNew(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			strcpy(HmiRecipe.Parameters.FileName, "test");
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			if (MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR)
			{
				TEST_FAIL("MpRecipeUIConnect in error state");
				TEST_DONE;
			}
			switch (ActSubState)
			{
				case 0:
					HmiRecipe.Commands.CreateRecipe = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_CREATE);
					HmiRecipe.Commands.CreateRecipe = false;
					ActSubState = 1;
					break;

				case 1:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
					ActSubState = 2;
					break;

				case 2:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_REFRESH);
					ActSubState = 3;
					break;

				case 3:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT(RecipeExists("test.mcfg"));
			TEST_DONE;
			break;
	}
	TEST_BUSY;

}

_TEST CreateExisting(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			strcpy(HmiRecipe.Parameters.FileName, "Machine");
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			TestState = TEST_ASSERT;
			break;

		case TEST_ASSERT:
			HmiRecipe.Commands.CreateRecipe = false;
			TEST_ASSERT(HmiRecipe.Status.FileDuplicate);
			TEST_ASSERT(RecipeExists("Machine.mcfg"));
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST CreateNonExisting(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			strcpy(HmiRecipe.Parameters.FileName, "test2");
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			TestState = TEST_ASSERT;
			break;

		case TEST_ASSERT:
			HmiRecipe.Commands.CreateRecipe = false;
			TEST_ASSERT(!HmiRecipe.Status.FileDuplicate);
			TEST_ASSERT(!RecipeExists("test2.mcfg"));
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST CreateActive(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			strcpy(HmiRecipe.Parameters.FileName, strtok(HmiRecipe.Status.LastLoadedConfigRecipe, "."));
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			TestState = TEST_ASSERT;
			break;

		case TEST_ASSERT:
			HmiRecipe.Commands.CreateRecipe = false;
			TEST_ASSERT(HmiRecipe.Status.FileDuplicate);
			TEST_ASSERT(RecipeExists(HmiRecipe.Status.LastLoadedConfigRecipe));
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST Preview(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			MachineSettings.AddMachineSettingsHere1 = 157;
			MachineSettings.AddMachineSettingsHere2 = 43956;
			MachineSettings.AddMachineSettingsHere3 = true;
			MachineSettings.AddMachineSettingsHere4 = 134.876;
			MachineSettings.AddMachineSettingsHere5 = 4373;
			strcpy(HmiRecipe.Parameters.FileName, "preview");
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
			TestState = TEST_ACT;
			break;

		case TEST_ACT:
			if (MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR)
			{
				TEST_FAIL("MpRecipeUIConnect in error state");
				TEST_DONE;
			}
			switch (ActSubState)
			{
				case 0:
					HmiRecipe.Commands.CreateRecipe = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_CREATE);
					HmiRecipe.Commands.CreateRecipe = false;
					ActSubState = 1;
				break;

				case 1:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
					ActSubState = 2;
				break;

				case 2:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_REFRESH);
					ActSubState = 3;
				break;

				case 3:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(!SelectRecipe("preview.mcfg"));
					ActSubState = 4;
				break;

				case 4:
					TEST_BUSY_CONDITION(!SelectRecipe("preview.mcfg"));
					MpRecipeUIConnect.Recipe.Load = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_LOAD);
					MpRecipeUIConnect.Recipe.Load = false;
					ActSubState = 5;
				break;

				case 5:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TestState = TEST_ASSERT;
				break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT_EQUAL_INT(11, MachineSettings.AddMachineSettingsHere1);
			TEST_ASSERT_EQUAL_INT(22, MachineSettings.AddMachineSettingsHere2);
			TEST_ASSERT_EQUAL_INT(true, MachineSettings.AddMachineSettingsHere3);
			TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.2999999, MachineSettings.AddMachineSettingsHere4);
			TEST_ASSERT_EQUAL_INT(44, MachineSettings.AddMachineSettingsHere5);
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST Delete(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			switch (ArrangeSubState)
			{
				case 0:
					strcpy(HmiRecipe.Parameters.FileName, "test");
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
					ArrangeSubState = 1;
					break;

				case 1:
					HmiRecipe.Commands.CreateRecipe = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_CREATE);
					HmiRecipe.Commands.CreateRecipe = false;
					ArrangeSubState = 2;
					break;

				case 2:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
					ArrangeSubState = 3;
					break;

				case 3:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_REFRESH);
					ArrangeSubState = 4;
					break;

				case 4:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					ArrangeSubState = 5;
					break;

				case 5:
					TEST_BUSY_CONDITION(!SelectRecipe("test.mcfg"));
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
					TestState = TEST_ACT;
					break;
			}
			break;

		case TEST_ACT:
			if (MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR)
			{
				TEST_FAIL("MpRecipeUIConnect in error state");
				TEST_DONE;
			}
			switch (ActSubState)
			{
				case 0:
					MpRecipeUIConnect.Recipe.Delete = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.MessageBox.LayerStatus != 0);
					MpRecipeUIConnect.Recipe.Delete = false;
					MpRecipeUIConnect.MessageBox.Confirm = true;
					ActSubState = 1;
					break;

				case 1:
					MpRecipeUIConnect.MessageBox.Confirm = false;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.MessageBox.LayerStatus == 0)
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_IDLE);
					ActSubState = 2;
					break;

				case 2:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					ActSubState = 3;
					break;

				case 3:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_REFRESH);
					ActSubState = 4;
					break;

				case 4:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT(!RecipeExists("test.mcfg"));
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

_TEST Invalid(void)
{
	TIMEOUT_TEST_CASE
	switch (TestState)
	{
		case TEST_ARRANGE:
			switch (ArrangeSubState) {
				case 0:
					FileCopy_UT.enable = true;
					FileCopy_UT.pSrcDev = (UDINT)&"mappRecipeFiles";
					FileCopy_UT.pSrc = (UDINT)&"CSVformat\\Machine.mcfg";
					FileCopy_UT.pDestDev = (UDINT)&"mappRecipeFiles";
					FileCopy_UT.pDest = (UDINT)&"MachineInvalid.mcfg";
					FileCopy_UT.option= fiOVERWRITE;
					FileCopy(&FileCopy_UT);
					TEST_BUSY_CONDITION(FileCopy_UT.status == 65535);
					FileCopy_UT.enable = false;
					FileCopy(&FileCopy_UT);
					ArrangeSubState = 1;
					break;

				case 1:
					MpRecipeUIConnect.Recipe.Refresh = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_IDLE);
					MpRecipeUIConnect.Recipe.Refresh = false;
					ArrangeSubState = 2;
					break;

				case 2:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_REFRESH);
					ArrangeSubState = 3;
					break;

				case 3:
					TEST_BUSY_CONDITION(!SelectRecipe("MachineInvalid.mcfg"));
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
					TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
					TestState = TEST_ACT;
					break;
			}
			break;

		case TEST_ACT:
			switch (ActSubState)
			{
				case 0:
					MpRecipeUIConnect.Recipe.Load = true;
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_LOAD);
					MpRecipeUIConnect.Recipe.Load = false;
					ActSubState = 1;
					break;

				case 1:
					TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_LOAD);
					TestState = TEST_ASSERT;
					break;
			}
			break;

		case TEST_ASSERT:
			TEST_ASSERT_EQUAL_INT(mpRECIPE_UI_STATUS_ERROR, MpRecipeUIConnect.Status);
			TEST_DONE;
			break;
	}
	TEST_BUSY;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2023-08-25 18:59:10Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("DefaultValues", DefaultValues), 
	new_TestFixture("CreateNew", CreateNew), 
	new_TestFixture("CreateExisting", CreateExisting), 
	new_TestFixture("CreateNonExisting", CreateNonExisting), 
	new_TestFixture("CreateActive", CreateActive), 
	new_TestFixture("Preview", Preview), 
	new_TestFixture("Delete", Delete), 
	new_TestFixture("Invalid", Invalid), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_RecipeMachineSettings, "Set_RecipeMachineSettings", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

