#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define TIMEOUT_TEST_CASE                                   \
    if (cycleCount >= 254)                                  \
    {                                                       \
        char abortMessage[80];                              \
        char substate[10];                                  \
        memset(abortMessage, 0, sizeof(abortMessage));      \
        memset(substate, 0, sizeof(substate));              \
        itoa(ActSubState, substate, 10);                    \
        strcpy(abortMessage, "Timeout in ActSubState = ");  \
        strcat(abortMessage, substate);                     \
        TEST_FAIL(abortMessage);                            \
        TEST_DONE;                                          \
    }

_SETUP_SET(void)
{
    switch (SetupState)
    {
        case 0:
            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappRecipeFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            NumberOfFiles = DirInfo_UT.filenum;
            CurrentFile = 0;
            SetupState = (NumberOfFiles == 0) ? 100 : 1;
            break;

        case 1:
            DirRead_UT.enable = true;
            DirRead_UT.pDevice = DirInfo_UT.pDevice;
            DirRead_UT.entry = CurrentFile;
            DirRead_UT.option = fiFILE;
            DirRead_UT.pData = (UDINT)&fileInfo;
            DirRead_UT.data_len = sizeof(fileInfo);
            DirRead(&DirRead_UT);
            TEST_BUSY_CONDITION(DirRead_UT.status == 65535);
            TEST_ABORT_CONDITION(DirRead_UT.status != 0);
            SetupState = 2;
            break;

        case 2:
            if ((strcmp("Default.par", &fileInfo.Filename) == 0) || (strcmp("Invalid.par", &fileInfo.Filename) == 0) ||
                (strcmp("Machine.mcfg", &fileInfo.Filename) == 0) || (strcmp("MachineInvalid.mcfg", &fileInfo.Filename) == 0))
            {
                CurrentFile++;
                SetupState = (CurrentFile >= NumberOfFiles) ? 10 : 1;
                break;
            }
            FileDelete_UT.enable = true;
            FileDelete_UT.pDevice = DirInfo_UT.pDevice;
            FileDelete_UT.pName = (UDINT)&fileInfo.Filename;
            FileDelete(&FileDelete_UT);
            TEST_BUSY_CONDITION(FileDelete_UT.status == 65535);
            TEST_ABORT_CONDITION(FileDelete_UT.status != 0);

            NumberOfFiles--;
            SetupState = (CurrentFile >= NumberOfFiles) ? 10 : 1;
            break;

        case 10:
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
            SetupState = 100;
            break;

        case 100:
            TEST_DONE;
    }
    TEST_BUSY;
}

_TEARDOWN_SET(void)
{
    SetupState = 0;
	TEST_DONE;
}

_SETUP_TEST(void)
{
    cycleCount = 0;
    TestState = TEST_ARRANGE;
    ArrangeSubState = 0;
    ActSubState = 0;
    AssertSubState = 0;
    TEST_DONE;
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
            strcpy(&HmiRecipe.Parameters.FileName, "test");
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
    TIMEOUT_TEST_CASE
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
    TIMEOUT_TEST_CASE
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
    TIMEOUT_TEST_CASE
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
            TEST_BUSY_CONDITION(!SelectRecipe("test.mcfg"));
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
            TEST_BUSY_CONDITION(!SelectRecipe("MachineInvalid.mcfg"));
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TestState = TEST_ACT;
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
LastUpdated: 2022-11-03 15:12:53Z
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

