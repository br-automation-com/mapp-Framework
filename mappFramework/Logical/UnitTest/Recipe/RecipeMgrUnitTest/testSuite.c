/********************************************************************
 * COPYRIGHT --
 ********************************************************************
 * Program: -
 * Author:
 * Created:
 ********************************************************************
 * Test registration and handshake
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <string.h>
#include <stdbool.h>

void _INIT initTestSuite(void)
{
    Testsuite.Enable = 1;
	utInit(&Testsuite);
    
    CommonTestsuite.Enable = 1;
    utInit(&CommonTestsuite);
    
    strcpy((char*)&FileDeviceName, "mappRecipeFiles");
    strcpy((char*)&TextNameSpace, "mappFramework/Recipe/Alarms");
    strcpy((char*)&TextID, "SaveFailed");
    strcpy((char*)&HmiRecipe.Parameters.DeviceName, "mappRecipeFiles");

    PV_xgetadr("RecipeMgr:MachineSettings", &pMachineSettings, &MachineSettingsSize);
    PV_xgetadr("RecipeMgr:Parameters", &pParameters, &ParameterSize);

    LastSelectedIndex++;
}

void _CYCLIC cyclicWithTest(void)
{
	utCyclic(&Testsuite);
    if (Testsuite.Informational.LastKnownPassedLocation.TestCaseName != 0)
        strcpy((char*)&LastTestCase, (char*)Testsuite.Informational.LastKnownPassedLocation.TestCaseName);
    if (Testsuite.Informational.LastKnownPassedLocation.TestSetName != 0)
        strcpy((char*)&LastTestSet, (char*)Testsuite.Informational.LastKnownPassedLocation.TestSetName);
    if (Testsuite.Informational.LastKnownPassedLocation.File != 0)
        strcpy((char*)&LastTestFile, (char*)Testsuite.Informational.LastKnownPassedLocation.File);
}

void _EXIT exitTestSuite(void)
{
	utExit(&Testsuite);
}

bool RecipeExists(char* recipeName)
{
    for (USINT i = 0; i<(sizeof(MpRecipeUIConnect.Recipe.List.Names)/sizeof(MpRecipeUIConnect.Recipe.List.Names[0])); i++)
    {
        if (strcmp(recipeName, MpRecipeUIConnect.Recipe.List.Names[i]) == 0)
        {
            return true;
        }
    }
    return false;
}

bool SelectRecipe(char* wantedRecipe)
{
    if ((MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE) && (MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_ERROR)) return false;

    for (USINT i=0; i <= MpRecipeUIConnect.Recipe.List.MaxSelection; i++)
    {
        if (strcmp(wantedRecipe, MpRecipeUIConnect.Recipe.List.Names[i]) == 0)
            MpRecipeUIConnect.Recipe.List.SelectedIndex = i;
    }

    return (strcmp(wantedRecipe, HmiRecipe.Status.SelectedRecipe) == 0);
}
