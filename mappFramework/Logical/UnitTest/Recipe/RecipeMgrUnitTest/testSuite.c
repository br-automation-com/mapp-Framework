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

}


void _CYCLIC cyclicWithTest(void)
{
	utCyclic(&Testsuite);

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
    if (MpRecipeUIConnect.Recipe.List.SelectedIndex != LastSelectedIndex)
    {
        LastSelectedIndex = MpRecipeUIConnect.Recipe.List.SelectedIndex;

        if (strcmp(wantedRecipe, MpRecipeUIConnect.Recipe.List.Names[MpRecipeUIConnect.Recipe.List.SelectedIndex]) == 0) return true;

        if (MpRecipeUIConnect.Recipe.List.SelectedIndex == MpRecipeUIConnect.Recipe.List.MaxSelection)
        {
            MpRecipeUIConnect.Recipe.List.PageUp = true;
            MpRecipeUIConnect.Recipe.List.StepDown = false;
        }
        else
        {
            MpRecipeUIConnect.Recipe.List.PageUp = false;
            MpRecipeUIConnect.Recipe.List.StepDown = true;
        }
        return false;
    }

    MpRecipeUIConnect.Recipe.List.PageUp = false;
    MpRecipeUIConnect.Recipe.List.StepDown = false;
    return false;
}
