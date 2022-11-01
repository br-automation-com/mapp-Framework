#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

_SETUP_SET(void)
{
    strcpy((char*)&HmiRecipe.Parameters.DeviceName, "mappRecipeFiles");
    strcpy((char*)&MpRecipeUIConnect.Recipe.Filter, "*.mcfg");
    MpRecipeUIConnect.Recipe.Refresh = true;
    strcpy(&HmiRecipe.Parameters.Category, MACHINE_CONFIGURATION_CATEGORY);
    TEST_BUSY_CONDITION(HmiRecipe.Status.LastStatus != mpRECIPE_UI_STATUS_IDLE);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT)
    TEST_BUSY_CONDITION(RecipeExists("Default.par"));
    TEST_BUSY_CONDITION(!RecipeExists("Machine.mcfg"));
    MpRecipeUIConnect.Recipe.Refresh = false;
    TEST_ABORT_CONDITION(pMachineSettings == NULL);
    TEST_DONE;
}

_TEARDOWN_SET(void)
{
    memset(&HmiRecipe.Commands, 0, sizeof(HmiRecipe.Commands));
    MpRecipeUIConnect.Recipe.Load = false;
	TEST_DONE;
}


_SETUP_TEST(void)
{
    LastSelectedIndex++;
    cycleCount = 0;
    TEST_DONE;
}

_TEARDOWN_TEST(void)
{
	TEST_DONE;
}


_CYCLIC_SET(void)
{
    cycleCount++;
}

// These tests must run sequentially, Arrange->Act->Assert
// 3 "_TEST" function for each unit test
_TEST Arrange_DefaultValues(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    // set MachineSettings through the pointer
    memset(pMachineSettings, 0, sizeof(*pMachineSettings));
    TEST_BUSY_CONDITION(!SelectRecipe("Machine.mcfg"));
    TEST_DONE;
}

_TEST Act_DefaultValues(void)
{
    MpRecipeUIConnect.Recipe.Load = true;
    HmiRecipe.Commands.LoadRecipe = true;
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_BUSY_CONDITION(HmiRecipe.Status.ConfigRecipeLoaded == true);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
    HmiRecipe.Commands.LoadRecipe = false;
    TEST_DONE;
}

_TEST Assert_DefaultValues(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_BUSY_CONDITION(HmiRecipe.Status.ConfigRecipeLoaded == false);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
    TEST_ASSERT_EQUAL_INT(11, MachineSettings.AddMachineSettingsHere1);
    TEST_ASSERT_EQUAL_INT(22, MachineSettings.AddMachineSettingsHere2);
    TEST_ASSERT_EQUAL_INT(true, MachineSettings.AddMachineSettingsHere3);
    TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.2999999, MachineSettings.AddMachineSettingsHere4);
    TEST_ASSERT_EQUAL_INT(44, MachineSettings.AddMachineSettingsHere5);

    TEST_DONE;
}

_TEST Arrange_CreateNew(void)
{
    strcpy(&HmiRecipe.Parameters.FileName, "test");
    TEST_DONE;
}

_TEST Act_CreateNew(void)
{
    HmiRecipe.Commands.CreateRecipe = true;
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
    HmiRecipe.Commands.CreateRecipe = false;
    TEST_DONE;
}

_TEST Assert_CreateNew(void)
{
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
    TEST_BUSY_CONDITION(HmiRecipe.Status.LastStatus != mpRECIPE_UI_STATUS_IDLE);
    TEST_ASSERT(RecipeExists("test.mcfg"));
    TEST_DONE;
}

_TEST Arrange_CreateExisting(void)
{
    strcpy(&HmiRecipe.Parameters.FileName, "test");
    TEST_DONE;
}

_TEST Act_CreateExisting(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_DONE;
}

_TEST Assert_CreateExisting(void)
{
    HmiRecipe.Commands.CreateRecipe = false;
    TEST_ASSERT(HmiRecipe.Status.FileDuplicate);
    TEST_ASSERT(RecipeExists("test.mcfg"));
    TEST_DONE;
}

_TEST Arrange_CreateNonExisting(void)
{
    strcpy(&HmiRecipe.Parameters.FileName, "test2");
    TEST_DONE;
}

_TEST Act_CreateNonExisting(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_DONE;
}

_TEST Assert_CreateNonExisting(void)
{
    HmiRecipe.Commands.CreateRecipe = false;
    TEST_ASSERT(!HmiRecipe.Status.FileDuplicate);
    TEST_ASSERT(!RecipeExists("test2.mcfg"));
    TEST_DONE;
}

_TEST Arrange_CreateActive(void)
{
    strcpy(&HmiRecipe.Parameters.FileName, strtok(HmiRecipe.Status.LastLoadedConfigRecipe, "."));
    TEST_DONE;
}

_TEST Act_CreateActive(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_DONE;
}

_TEST Assert_CreateActive(void)
{
    HmiRecipe.Commands.CreateRecipe = false;
    TEST_ASSERT(HmiRecipe.Status.FileDuplicate);
    TEST_ASSERT(RecipeExists(HmiRecipe.Status.LastLoadedConfigRecipe));
    TEST_DONE;
}

_TEST Arrange_Preview(void)
{
    MachineSettings.AddMachineSettingsHere1 = 157;
    MachineSettings.AddMachineSettingsHere2 = 43956;
    MachineSettings.AddMachineSettingsHere3 = true;
    MachineSettings.AddMachineSettingsHere4 = 134.876;
    MachineSettings.AddMachineSettingsHere5 = 4373;
    strcpy(&HmiRecipe.Parameters.FileName, "preview");
    HmiRecipe.Commands.CreateRecipe = true;
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
    HmiRecipe.Commands.CreateRecipe = false;
    TEST_DONE;
}

_TEST Act_Preview(void)
{
    MpRecipeUIConnect.Recipe.List.StepDown = (MpRecipeUIConnect.Recipe.List.SelectedIndex != 0);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
    TEST_ABORT_CONDITION(cycleCount == 254);
    TEST_DONE;
}

_TEST Assert_Preview(void)
{
    TEST_ABORT_CONDITION(HmiRecipe.Status.LastStatus == mpRECIPE_UI_STATUS_ERROR);
    TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
    TEST_ASSERT_EQUAL_INT(11, MachineSettings.AddMachineSettingsHere1);
    TEST_ASSERT_EQUAL_INT(22, MachineSettings.AddMachineSettingsHere2);
    TEST_ASSERT_EQUAL_INT(true, MachineSettings.AddMachineSettingsHere3);
    TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.2999999, MachineSettings.AddMachineSettingsHere4);
    TEST_ASSERT_EQUAL_INT(44, MachineSettings.AddMachineSettingsHere5);
    TEST_DONE;
}

_TEST Arrange_Delete(void)
{
    TEST_BUSY_CONDITION(!SelectRecipe("test.mcfg"));
    TEST_DONE;
}

_TEST Act_Delete(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    MpRecipeUIConnect.Recipe.Delete = true;
    TEST_BUSY_CONDITION(MpRecipeUIConnect.MessageBox.LayerStatus != 0);
    MpRecipeUIConnect.Recipe.Delete = false;
    MpRecipeUIConnect.MessageBox.Confirm = true;
    TEST_DONE;
}

_TEST Assert_Delete(void)
{
    MpRecipeUIConnect.MessageBox.Confirm = false;
    TEST_BUSY_CONDITION(MpRecipeUIConnect.MessageBox.LayerStatus == 0)
    TEST_ABORT_CONDITION(HmiRecipe.Status.LastStatus == mpRECIPE_UI_STATUS_ERROR);
    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
    TEST_ASSERT(!RecipeExists("test.mcfg"));
    TEST_DONE;
}

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-01 20:10:38Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("Arrange_DefaultValues", Arrange_DefaultValues),
	new_TestFixture("Act_DefaultValues", Act_DefaultValues),
	new_TestFixture("Assert_DefaultValues", Assert_DefaultValues),
	new_TestFixture("Arrange_CreateNew", Arrange_CreateNew),
	new_TestFixture("Act_CreateNew", Act_CreateNew),
	new_TestFixture("Assert_CreateNew", Assert_CreateNew),
	new_TestFixture("Arrange_CreateExisting", Arrange_CreateExisting),
	new_TestFixture("Act_CreateExisting", Act_CreateExisting),
	new_TestFixture("Assert_CreateExisting", Assert_CreateExisting),
	new_TestFixture("Arrange_CreateNonExisting", Arrange_CreateNonExisting),
	new_TestFixture("Act_CreateNonExisting", Act_CreateNonExisting),
	new_TestFixture("Assert_CreateNonExisting", Assert_CreateNonExisting),
	new_TestFixture("Arrange_CreateActive", Arrange_CreateActive),
	new_TestFixture("Act_CreateActive", Act_CreateActive),
	new_TestFixture("Assert_CreateActive", Assert_CreateActive),
	new_TestFixture("Arrange_Preview", Arrange_Preview),
	new_TestFixture("Act_Preview", Act_Preview),
	new_TestFixture("Assert_Preview", Assert_Preview),
	new_TestFixture("Arrange_Delete", Arrange_Delete),
	new_TestFixture("Act_Delete", Act_Delete),
	new_TestFixture("Assert_Delete", Assert_Delete),
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_RecipeMachineSettings, "Set_RecipeMachineSettings", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);
