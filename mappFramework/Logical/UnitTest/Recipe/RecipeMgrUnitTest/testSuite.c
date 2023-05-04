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

	PV_xgetadr("RecipeMgr:MachineSettings", (void*)&pMachineSettings, &MachineSettingsSize);
	PV_xgetadr("RecipeMgr:Parameters", (void*)&pParameters, &ParameterSize);

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
	if (((MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE) && (MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_ERROR)) &&
		(strcmp(wantedRecipe, HmiRecipe.Status.SelectedRecipe) != 0)) return false;

	for (USINT i=0; i <= MpRecipeUIConnect.Recipe.List.MaxSelection; i++)
	{
		if (strcmp(wantedRecipe, MpRecipeUIConnect.Recipe.List.Names[i]) == 0)
			MpRecipeUIConnect.Recipe.List.SelectedIndex = i;
	}

	return (strcmp(wantedRecipe, HmiRecipe.Status.SelectedRecipe) == 0);
}

testStatusEnum RemoveNonDefaultFiles(char* filter, char* selectFile, const char* category)
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
			if ((strcmp("Default.par", (char*)fileInfo.Filename) == 0) ||
				(strcmp("Machine.mcfg", (char*)fileInfo.Filename) == 0))
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
			strcpy((char*)&MpRecipeUIConnect.Recipe.Filter, filter);
			MpRecipeUIConnect.Recipe.Refresh = true;
			strcpy((char*)&HmiRecipe.Parameters.Category, category);
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_REFRESH)
			MpRecipeUIConnect.Recipe.Refresh = false;
			SetupState = 11;
			break;

		case 11:
			TEST_BUSY_CONDITION(MpRecipeUIConnect.Status != mpRECIPE_UI_STATUS_IDLE)
			TEST_BUSY_CONDITION(!RecipeExists(selectFile));
			TEST_BUSY_CONDITION(HmiRecipe.Status.HMIcommand != REC_HMI_WAIT)
			TEST_ABORT_CONDITION(pParameters == NULL);
			SetupState = 100;
			break;

		case 100:
			cycleCount = 0;
			TestState = TEST_ARRANGE;
			SetupState = 0;
			TEST_DONE;
	}
	TEST_BUSY;
}