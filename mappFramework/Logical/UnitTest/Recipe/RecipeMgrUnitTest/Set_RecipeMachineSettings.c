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
    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT)
    TEST_BUSY_CONDITION(RecipeExists("Default.par"));
    TEST_BUSY_CONDITION(!RecipeExists("Machine.mcfg"));
    MpRecipeUIConnect.Recipe.Refresh = false;
    TEST_ABORT_CONDITION(pMachineSettings == NULL);
    TEST_DONE;
}

_TEARDOWN_SET(void)
{
	TEST_DONE;
}

_SETUP_TEST(void)
{
    LastSelectedIndex++;
    cycleCount = 0;
    TestState = TEST_ARRANGE;
    ArrangeSubState = 0;
    ActSubState = 0;
    AssertSubState = 0;
    TEST_DONE;
}

_TEARDOWN_TEST(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    memset(&HmiRecipe.Commands, 0, sizeof(HmiRecipe.Commands));
    MpRecipeUIConnect.Recipe.Load = false;
    LastSelectedIndex++;
    MpRecipeUIConnect.Recipe.List.PageUp = false;
    MpRecipeUIConnect.Recipe.List.StepDown = false;
    TEST_BUSY_CONDITION(!SelectRecipe("Machine.mcfg"));
    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
    TEST_DONE;
}

_CYCLIC_SET(void)
{
    cycleCount++;
}
//    TEST_ABORT_CONDITION(cycleCount == 254);
//    switch (TestState)
//    {
//        case TEST_ARRANGE:
//            TestState = TEST_ACT;
//            break;
//
//        case TEST_ACT:
//            TestState = TEST_ASSERT;
//            break;
//
//        case TEST_ASSERT:
//            TEST_DONE;
//            break;
//    }
//    TEST_BUSY;

_TEST DefaultValues(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
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
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            strcpy(&HmiRecipe.Parameters.FileName, "test");
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState)
            {
                case 0:
                    HmiRecipe.Commands.CreateRecipe = true;
                    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_IDLE);
                    HmiRecipe.Commands.CreateRecipe = false;
                    ActSubState = 1;
                    break;

                case 1:
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
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            strcpy(&HmiRecipe.Parameters.FileName, "test");
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
            TEST_ASSERT(RecipeExists("test.mcfg"));
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST CreateNonExisting(void)
{
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            strcpy(&HmiRecipe.Parameters.FileName, "test2");
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
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            strcpy(&HmiRecipe.Parameters.FileName, strtok(HmiRecipe.Status.LastLoadedConfigRecipe, "."));
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
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            MachineSettings.AddMachineSettingsHere1 = 157;
            MachineSettings.AddMachineSettingsHere2 = 43956;
            MachineSettings.AddMachineSettingsHere3 = true;
            MachineSettings.AddMachineSettingsHere4 = 134.876;
            MachineSettings.AddMachineSettingsHere5 = 4373;
            strcpy(&HmiRecipe.Parameters.FileName, "preview");
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState) {
                case 0:
                    HmiRecipe.Commands.CreateRecipe = true;
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
                    HmiRecipe.Commands.CreateRecipe = false;
                    ActSubState = 1;
                    break;

                case 1:
                    MpRecipeUIConnect.Recipe.List.StepDown = (MpRecipeUIConnect.Recipe.List.SelectedIndex != 0);
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
                    ActSubState = 2;
                    break;

                case 2:
                    TEST_ABORT_CONDITION(MpRecipeUIConnect.Status == mpRECIPE_UI_STATUS_ERROR);
                    TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
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
    TEST_ABORT_CONDITION(cycleCount == 254);
    switch (TestState)
    {
        case TEST_ARRANGE:
            TEST_BUSY_CONDITION(!SelectRecipe("test.mcfg"));
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TestState = TEST_ACT;
            break;

        case TEST_ACT:
            switch (ActSubState) {
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

/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-02 15:42:14Z
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
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_RecipeMachineSettings, "Set_RecipeMachineSettings", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

