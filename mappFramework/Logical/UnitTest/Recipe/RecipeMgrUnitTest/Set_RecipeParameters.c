#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

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
            strcpy((char*)&MpRecipeUIConnect.Recipe.Filter, "*.par");
            MpRecipeUIConnect.Recipe.Refresh = true;
            strcpy((char*)&HmiRecipe.Parameters.Category, PARAMETERS_CATEGORY);
            TEST_BUSY_CONDITION(!RecipeExists("Default.par"));
            TEST_BUSY_CONDITION(RecipeExists("Machine.mcfg"));
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT)
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE)
            MpRecipeUIConnect.Recipe.Refresh = false;
            TEST_ABORT_CONDITION(pParameters == NULL);
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
    memset(&HmiRecipe.Commands, 0, sizeof(HmiRecipe.Commands));
    MpRecipeUIConnect.Recipe.Load = false;
    TEST_BUSY_CONDITION(!SelectRecipe("Default.par"));

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
            memset(pParameters, 0, sizeof(*pParameters));
            TEST_BUSY_CONDITION(!SelectRecipe("Default.par"));
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
                    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
                    HmiRecipe.Commands.LoadRecipe = true;
                    TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == true);
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
                    HmiRecipe.Commands.LoadRecipe = false;
                    ActSubState = 2;
                    break;

                case 2:
                    TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT(Parameters.AddParametersHere1);
            TEST_ASSERT_EQUAL_STRING("two", Parameters.AddParametersHere2);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.3, Parameters.AddParametersHere3);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 4.4, Parameters.AddParametersHere4);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 5.5, Parameters.AddParametersHere5);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
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
            TEST_ASSERT(RecipeExists("test.par"));
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
            TEST_ASSERT(RecipeExists("test.par"));
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
            TEST_ASSERT(!RecipeExists("test2.par"));
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
            strcpy(&HmiRecipe.Parameters.FileName, strtok(HmiRecipe.Status.LastLoadedProductRecipe, "."));
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
            TEST_ASSERT(RecipeExists(HmiRecipe.Status.LastLoadedProductRecipe));
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST PreviewShouldNotAffectActive(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            ParametersEdit.AddParametersHere1 = false;
            strcpy(ParametersEdit.AddParametersHere2, "testing preview");
            ParametersEdit.AddParametersHere3 = 12.56;
            ParametersEdit.AddParametersHere4 = 134.876;
            ParametersEdit.AddParametersHere5 = 87.4567;
            strcpy(&HmiRecipe.Parameters.FileName, "preview");
            HmiRecipe.Commands.CreateRecipe = true;
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
            HmiRecipe.Commands.CreateRecipe = false;
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
                    TEST_BUSY_CONDITION(!SelectRecipe("preview.par"));
                    ActSubState = 4;
                    break;

                case 4:
                    TEST_BUSY_CONDITION(!SelectRecipe("preview.par"));
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
            // check if preview affects the active parameters
            TEST_ASSERT(Parameters.AddParametersHere1);
            TEST_ASSERT_EQUAL_STRING("two", Parameters.AddParametersHere2);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 3.3, Parameters.AddParametersHere3);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 4.4, Parameters.AddParametersHere4);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 5.5, Parameters.AddParametersHere5);
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
            TEST_BUSY_CONDITION(!SelectRecipe("Default.par"));
            LastSelectedIndex++;
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);

            ParametersEdit.AddParametersHere1 = false;
            strcpy(ParametersEdit.AddParametersHere2, "testing preview");
            ParametersEdit.AddParametersHere3 = 12.56;
            ParametersEdit.AddParametersHere4 = 134.876;
            ParametersEdit.AddParametersHere5 = 87.4567;
            strcpy(&HmiRecipe.Parameters.FileName, "preview");
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
                    TEST_BUSY_CONDITION(!SelectRecipe("preview.par"));
                    ActSubState = 4;
                    break;

                case 4:
                    TEST_BUSY_CONDITION(!SelectRecipe("preview.par"));
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
            TEST_ASSERT(!ParametersPreview.AddParametersHere1);
            TEST_ASSERT_EQUAL_STRING("testing preview", ParametersPreview.AddParametersHere2);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 12.56, ParametersPreview.AddParametersHere3);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 134.876, ParametersPreview.AddParametersHere4);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 87.4567, ParametersPreview.AddParametersHere5);

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
            TEST_BUSY_CONDITION(!SelectRecipe("test.par"));
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
            TEST_ASSERT(!RecipeExists("test.par"));
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
            TEST_BUSY_CONDITION(!SelectRecipe("Invalid.par"));
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

SKIP_TEST EditActive(void)
{
    TIMEOUT_TEST_CASE
    switch (TestState)
    {
        case TEST_ARRANGE:
            TEST_BUSY_CONDITION(!SelectRecipe("Default.par"));
            LastSelectedIndex++;
            TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
            TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);

            ParametersEdit.AddParametersHere1 = false;
            strcpy(ParametersEdit.AddParametersHere2, "testing editing active");
            ParametersEdit.AddParametersHere3 = 12.56;
            ParametersEdit.AddParametersHere4 = 134.876;
            ParametersEdit.AddParametersHere5 = 87.4567;
            strcpy(&HmiRecipe.Parameters.FileName, "editActive");
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
                    TEST_BUSY_CONDITION(HmiRecipe.Status.ProductRecipeLoaded == false);
                    TEST_BUSY_CONDITION(!SelectRecipe("editActive.par"));
                    ActSubState = 4;
                    break;

                case 4:
                    MpRecipeUIConnect.Recipe.Load = true;
                    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_LOAD);
                    MpRecipeUIConnect.Recipe.Load = false;
                    ActSubState = 5;
                    break;

                case 5:
                    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
                    ParametersEdit.AddParametersHere1 = true;
                    strcpy(ParametersEdit.AddParametersHere2, "edited active");
                    ParametersEdit.AddParametersHere3 = 52.56;
                    ParametersEdit.AddParametersHere4 = 184.876;
                    ParametersEdit.AddParametersHere5 = 587.4567;
                    ActSubState = 6;
                    break;

                case 6:
                    HmiRecipe.Commands.SaveSelectedRecipe = true;
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand == REC_HMI_WAIT);
                    HmiRecipe.Commands.SaveSelectedRecipe = false;
                    ActSubState = 7;
                    break;

                case 7:
                    TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT);
                    TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE);
                    TestState = TEST_ASSERT;
                    break;
            }
            break;

        case TEST_ASSERT:
            TEST_ASSERT(Parameters.AddParametersHere1);
            TEST_ASSERT_EQUAL_STRING("edited active", Parameters.AddParametersHere2);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 52.56, Parameters.AddParametersHere3);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 184.876, Parameters.AddParametersHere4);
            TEST_ASSERT_DOUBLE_WITHIN(0.0001, 587.4567, Parameters.AddParametersHere5);

            TEST_DONE;
            break;
    }
    TEST_BUSY;
}


/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2022-11-03 14:28:41Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("DefaultValues", DefaultValues),
	new_TestFixture("CreateNew", CreateNew),
	new_TestFixture("CreateExisting", CreateExisting),
	new_TestFixture("CreateNonExisting", CreateNonExisting),
	new_TestFixture("CreateActive", CreateActive),
	new_TestFixture("PreviewShouldNotAffectActive", PreviewShouldNotAffectActive),
	new_TestFixture("Preview", Preview),
	new_TestFixture("Delete", Delete),
	new_TestFixture("Invalid", Invalid),
	skipTestFixture("EditActive", EditActive),
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_RecipeParameters, "Set_RecipeParameters", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

