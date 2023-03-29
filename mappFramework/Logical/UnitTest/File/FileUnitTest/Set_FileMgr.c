#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

#define TIMEOUT_TEST_CASE								\
	if (cycleCount >= 1000)								\
	{													\
	char abortMessage[80];								\
	char substate[10];									\
	memset(abortMessage, 0, sizeof(abortMessage));		\
	memset(substate, 0, sizeof(substate));				\
	itoa(TestState, substate, 10);						\
	strcpy(abortMessage, "Timeout in State = ");		\
	strcat(abortMessage, substate);						\
	TEST_FAIL(abortMessage);							\
	TEST_DONE;											\
	}

_SETUP_SET(void)
{
    TestState = 0;
    FileNumber = 0;

    HmiFile_UT.Parameters.Fifo.Enable = false;
    HmiFile_UT.Parameters.Fifo.ScanInterval = 60;
    strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");

    switch (SetupState)
    {
        case 0:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DISABLED);
            for (USINT i=0; i<sizeof(HmiFile_UT.Status.FifoSelect)/sizeof(HmiFile_UT.Status.FifoSelect[0]); i++)
            {
                TEST_BUSY_CONDITION(HmiFile_UT.Status.FifoSelect[i] != 0);
            }

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
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
            DirRead_UT.entry = 0;
            DirRead_UT.option = fiFILE;
            DirRead_UT.pData = (UDINT)&fileInfo;
            DirRead_UT.data_len = sizeof(fileInfo);
            DirRead(&DirRead_UT);
            TEST_BUSY_CONDITION(DirRead_UT.status == 65535);
            TEST_ABORT_CONDITION(DirRead_UT.status != 0);
            SetupState = 2;
            break;

        case 2:
            FileDelete_UT.enable = true;
            FileDelete_UT.pDevice = DirInfo_UT.pDevice;
            FileDelete_UT.pName = (UDINT)&fileInfo.Filename;
            FileDelete(&FileDelete_UT);
            TEST_BUSY_CONDITION(FileDelete_UT.status == 65535);
            TEST_ABORT_CONDITION(FileDelete_UT.status != 0);

            CurrentFile++;
            SetupState = (CurrentFile >= NumberOfFiles) ? 100 : 1;
            break;

        case 10:
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status == mpFILE_UI_STATUS_IDLE);
            MpFileManagerUIConnect_FIFO.File.Refresh = true;
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status == mpFILE_UI_STATUS_IDLE);
            MpFileManagerUIConnect_FIFO.File.Refresh = false;
            SetupState = 11;
            break;

        case 11:
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status != mpFILE_UI_STATUS_IDLE);
            SetupState = 100;
            break;

        case 100:
            TEST_DONE;
    }
    TEST_BUSY;
}

_TEARDOWN_SET(void)
{
    /* TODO:  add code running after test set here */
    TEST_DONE;
}

bool FileIdleOrDisabled(void) {
    return ((HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT) || (HmiFile_UT.Status.DeleteStep == FILE_DISABLED));
}

_SETUP_TEST(void) {
    TestState = 0;
	ArrangeSubState = 0;
	ActSubState = 0;
	AssertSubState = 0;
    FileNumber = 0;
	cycleCount = 0;
	NameMatch = 0;
	InNewLocation = 0;
	InOldLocation = 0;
	HmiFile.Status.SelectedIndex = 0;
	MpFileManagerUIConnect.File.Copy = 0;
	MpFileManagerUIConnect.File.CreateFolder = 0;
	MpFileManagerUIConnect.File.Cut = 0;
	MpFileManagerUIConnect.File.Delete = 0;
	MpFileManagerUIConnect.File.EnterFolder = 0;
	MpFileManagerUIConnect.File.FolderUp = 0;
	MpFileManagerUIConnect.File.MultiSelect = 0;
	MpFileManagerUIConnect.File.Paste = 0;
	MpFileManagerUIConnect.File.Refresh = 0;
	MpFileManagerUIConnect.File.Rename = 0;
    
	HmiFile_UT.Parameters.Fifo.Enable = false;
    HmiFile_UT.Parameters.Fifo.ScanInterval = 60;
    strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");

    switch (SetupState)
    {
        case 0:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DISABLED);
            for (USINT i=0; i<sizeof(HmiFile_UT.Status.FifoSelect)/sizeof(HmiFile_UT.Status.FifoSelect[0]); i++)
            {
                TEST_BUSY_CONDITION(HmiFile_UT.Status.FifoSelect[i] != 0);
            }

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
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
            DirRead_UT.entry = 0;
            DirRead_UT.option = fiFILE;
            DirRead_UT.pData = (UDINT)&fileInfo;
            DirRead_UT.data_len = sizeof(fileInfo);
            DirRead(&DirRead_UT);
            TEST_BUSY_CONDITION(DirRead_UT.status == 65535);
            TEST_ABORT_CONDITION(DirRead_UT.status != 0);
            SetupState = 2;
            break;

        case 2:
            FileDelete_UT.enable = true;
            FileDelete_UT.pDevice = DirInfo_UT.pDevice;
            FileDelete_UT.pName = (UDINT)&fileInfo.Filename;
            FileDelete(&FileDelete_UT);
            TEST_BUSY_CONDITION(FileDelete_UT.status == 65535);
            TEST_ABORT_CONDITION(FileDelete_UT.status != 0);
            
            CurrentFile++;
            SetupState = (CurrentFile >= NumberOfFiles) ? 100 : 1;
            break;
        
        case 10:
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status == mpFILE_UI_STATUS_IDLE);
            MpFileManagerUIConnect_FIFO.File.Refresh = true;
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status == mpFILE_UI_STATUS_IDLE);
            MpFileManagerUIConnect_FIFO.File.Refresh = false;
            SetupState = 11;
            break;

        case 11:
            TEST_BUSY_CONDITION(MpFileManagerUIConnect_FIFO.Status != mpFILE_UI_STATUS_IDLE);
            SetupState = 100;
            break;

        case 100:
            TEST_DONE;
    }
    TEST_BUSY;
}

_TEARDOWN_TEST(void)
{
    HmiFile_UT.Parameters.Fifo.Enable = false;
    HmiFile_UT.Parameters.Fifo.ScanInterval = 60;
    TestState = 0;
    SetupState = 0;
	
	FileCreate_0.enable = 0;
	FileClose_0.enable = 0;
	FileCreate(&FileCreate_0);
	FileClose(&FileClose_0);
	
    TEST_DONE;
}

_CYCLIC_SET(void)
{
	cycleCount++;
}

_TEST Create_Directory(void)
{
//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input directory name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					brsmemcpy(&MpFileManagerUIConnect.File.NewName, &DirName, sizeof(MpFileManagerUIConnect.File.NewName));
					ArrangeSubState = 1;
					break;
			
				case 1:
					MpFileManagerUIConnect.File.Refresh = 1;
					ArrangeSubState = 2;
					break;
			
				case 2:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					MpFileManagerUIConnect.File.Refresh = 0;
					ArrangeSubState = 3;
					break;
				
				case 3:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						TEST_ABORT_CONDITION(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0);
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Create directory
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.CreateFolder = 1;
					ActSubState = 1;
					break;
					
				case 1:
					MpFileManagerUIConnect.File.CreateFolder = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					ActSubState = 2;
					MpFileManagerUIConnect.File.Refresh = 1;
					break;
				
				case 2:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					MpFileManagerUIConnect.File.Refresh = 0;
					ActSubState = 3;
					break;
				
				case 3:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check save location for directory
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Add_File(void)
{
//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	FileCreate(&FileCreate_0);
	FileClose(&FileClose_0);
	
	switch (TestState)
	{
		case 0:	// Arrange
			// Select Recipe file device and input file name
			switch (ArrangeSubState)
			{
				case 0:
					FileCreate_0.pDevice = (UDINT)&"mappRecipeFiles";
					FileCreate_0.pFile = (UDINT)&CreateFileName;
					ArrangeSubState = 1;
					break;
			
				case 1:
					MpFileManagerUIConnect.File.Refresh = 1;
					ArrangeSubState = 2;
					break;
			
				case 2:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					MpFileManagerUIConnect.File.Refresh = 0;
					ArrangeSubState = 3;
					break;
				
				case 3: // Check to make sure there isn't already a file by the specified name in the directory
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						TEST_ABORT_CONDITION(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CreateFileName) == 0);
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:	// Act
			// Create file
			switch (ActSubState)
			{
				case 0:
					FileCreate_0.enable = 1;
					ActSubState = 1;
					break;
					
				case 1:
					TEST_ABORT_CONDITION((FileCreate_0.status != 0) && (FileCreate_0.status != 65535));
					TEST_BUSY_CONDITION(FileCreate_0.status != 0);
					ActSubState = 2;
					FileClose_0.ident = FileCreate_0.ident;
					FileClose_0.enable = 1;
					FileCreate_0.enable = 0;
					break;
				
				case 2:
					TEST_ABORT_CONDITION((FileClose_0.status != 0) && (FileClose_0.status != 65535));
					TEST_BUSY_CONDITION(FileClose_0.status != 0);
					FileClose_0.enable = 0;
					MpFileManagerUIConnect.File.Refresh = 1;
					ActSubState = 3;
					break;
			
				case 3:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_REFRESH);
					MpFileManagerUIConnect.File.Refresh = 0;
					ActSubState = 4;
					break;
			
				case 4:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != 0);
					ActSubState = 5;
					break;
				
				case 5:
					MpFileManagerUIConnect.File.Refresh = 0;
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CreateFileName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:	// Assert
			// Check save location for file
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Copy_File(void)
{
//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input file name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CreateFileName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Copy/paste file
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Copy = 1;
					ActSubState = 1;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.Copy = 0;
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 2;
					break;
			
				case 2:
					MpFileManagerUIConnect.File.Paste = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_PASTE);
					ActSubState = 3;
					break;
				
				case 3:
					// Check file list for copied file
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedFileName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if copied file was found
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Copy_Directory(void)
{
	//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input directory name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Copy/paste directory
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Copy = 1;
					ActSubState = 1;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.Copy = 0;
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 2;
					break;
			
				case 2:
					MpFileManagerUIConnect.File.Paste = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_PASTE);
					ActSubState = 3;
					break;
				
				case 3:
					// Check file list for copied directory
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedDirName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if copied directory was found
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Rename_File(void)
{
	//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input name of file to be renamed and new name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					brsmemcpy(&MpFileManagerUIConnect.File.NewName, &NewFileName, sizeof(MpFileManagerUIConnect.File.NewName));
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedFileName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Rename file
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Rename = 1;
					ActSubState = 1;
					break;
			
				case 1:
					MpFileManagerUIConnect.File.Rename = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					ActSubState = 2;
					break;
				
				case 2:
					// Check file list for renamed file
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewFileName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if renamed file was found
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Rename_Directory(void)
{
//		TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input name of directory to be renamed and new name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					brsmemcpy(&MpFileManagerUIConnect.File.NewName, &NewDirName, sizeof(MpFileManagerUIConnect.File.NewName));
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedDirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Rename directory
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Rename = 1;
					ActSubState = 2;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.Rename = 0;
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 2;
					break;
			
				case 2:
					MpFileManagerUIConnect.File.Rename = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					ActSubState = 3;
					break;
				
				case 3:
					// Check file list for renamed directory
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewDirName) == 0)
						{
							NameMatch = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if renamed directory was found
			TEST_ASSERT(NameMatch);
			TEST_DONE;
			break;
	}
}

_TEST Cut_Paste_File(void)
{
	//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input file name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewFileName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Cut/paste file
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Cut = 1;
					ActSubState = 1;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.Cut = 0;
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					ActSubState = 2;
					break;
			
				case 2:
					HmiFile.Commands.EnterFolder = 1;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_CHANGE_DIR);
					HmiFile.Commands.EnterFolder = 0;
					ActSubState = 3;
					break;
				
				case 3:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 4;
					break;
			
				case 4:
					MpFileManagerUIConnect.File.Paste = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_PASTE);
					ActSubState = 5;
					break;
			
				case 5:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewFileName) == 0)
						{
							InNewLocation = 1;
						}
					}
					HmiFile.Commands.FolderUp = 1;
					ActSubState = 6;
					break;
				
				case 6:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_CHANGE_DIR);
					HmiFile.Commands.FolderUp = 0;
					ActSubState = 7;
					break;
				
				case 7:
					// Check file list for copied file
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewFileName) == 0)
						{
							InOldLocation = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if copied file was found
			TEST_ASSERT(InNewLocation);
			TEST_ASSERT(!InOldLocation);
			TEST_DONE;
			break;
	}
}

_TEST Cut_Paste_Directory(void)
{
//	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and input directory name
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewDirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Cut/paste directory
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.Cut = 1;
					ActSubState = 1;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.Cut = 0;
					MpFileManagerUIConnect.File.Refresh = 1;
					ActSubState = 2;
					break;
				
				case 2:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_REFRESH);
					MpFileManagerUIConnect.File.Refresh = 0;
					ActSubState = 3;
					break;
				
				case 3:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					ActSubState = 4;
					break;
				
				case 4:
					MpFileManagerUIConnect.File.Refresh = 1;
					ActSubState = 5;
					break;
				
				case 5:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_REFRESH);
					MpFileManagerUIConnect.File.Refresh = 0;
					ActSubState = 6;
					break;
			
				case 6:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					HmiFile.Commands.EnterFolder = 1;
					ActSubState = 7;
					break;
				
			case 7:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_CHANGE_DIR);
					HmiFile.Commands.EnterFolder = 0;
					ActSubState = 8;
					break;
				
				case 8:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 9;
					break;
			
				case 9:
					MpFileManagerUIConnect.File.Paste = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_PASTE);
					ActSubState = 10;
					break;
			
				case 10:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewDirName) == 0)
						{
							InNewLocation = 1;
						}
					}
					HmiFile.Commands.FolderUp = 1;
					ActSubState = 11;
					break;
				
				case 11:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_CHANGE_DIR);
					HmiFile.Commands.FolderUp = 0;
					ActSubState = 12;
					break;
				
				case 12:
					// Check file list for copied directory
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &NewDirName) == 0)
						{
							InOldLocation = 1;
						}
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if copied directory was found
			TEST_ASSERT(InNewLocation);
			TEST_ASSERT(!InOldLocation);
			TEST_DONE;
			break;
	}
}

_TEST Multiselect(void)
{
	TEST_DONE;
	TIMEOUT_TEST_CASE;
	
	switch (TestState)
	{
		case 0:
			// Select Recipe file device and navigate into directory with test files
			switch (ArrangeSubState)
			{
				case 0:
					MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
					ArrangeSubState = 1;
					break;
				
				case 1:
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &DirName) == 0)
							HmiFile.Status.SelectedIndex = i;
					}
					ArrangeSubState = 2;
					break;
				
				case 2:
					HmiFile.Commands.EnterFolder = 1;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_CHANGE_DIR);
					HmiFile.Commands.EnterFolder = 0;
					ArrangeSubState = 3;
					break;
				
				case 3:
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					TestState = 1;
					break;
			}
			break;
		
		case 1:
			// Select multiple files/directories and copy/paste
			switch (ActSubState)
			{
				case 0:
					MpFileManagerUIConnect.File.MultiSelect = 1;
					ActSubState = 1;
					break;
				
				case 1:
					MpFileManagerUIConnect.File.List.Items[0].IsSelected = 1;
					MpFileManagerUIConnect.File.List.Items[1].IsSelected = 1;
					ActSubState = 2;
					break;
			
				case 2:
					MpFileManagerUIConnect.File.Copy = 1;
					ActSubState = 3;
					break;
				
				case 3:
					MpFileManagerUIConnect.File.Copy = 0;
					MpFileManagerUIConnect.File.Paste = 1;
					ActSubState = 4;
					break;
			
				case 4:
					MpFileManagerUIConnect.File.Paste = 0;
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_PASTE);
					ActSubState = 5;
					break;
			
				case 5:
					// Check for copied file
					TEST_BUSY_CONDITION(MpFileManagerUIConnect.Status != mpFILE_UI_STATUS_IDLE);
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedNewFileName) == 0)
							MultiSelectFileCopy = 1;
					}
					ActSubState = 6;
					break;
				
				case 6:
					// Check for copied directory
					for(int i = 0; i < sizeof(MpFileManagerUIConnect.File.List.Items)/sizeof(MpFileManagerUIConnect.File.List.Items[0]); i++)
					{
						if(brsstrcmp(&MpFileManagerUIConnect.File.List.Items[i].Name, &CopiedNewDirName) == 0)
							MultiSelectDirCopy = 1;
					}
					TestState = 2;
					break;
			}
			break;
		
		case 2:
			// Check if copied file was found
			TEST_ASSERT(MultiSelectFileCopy);
			TEST_ASSERT(MultiSelectDirCopy);
			TEST_DONE;
			break;
	}
}

_TEST FIFO_20(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 20) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES;
            HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles = 10;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles, DirInfo_UT.filenum);
            TEST_DONE;
            break;
    }
    TEST_BUSY;
}

_TEST FIFO_60(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 60) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES;
            HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles = 15;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_140(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 140) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES;
            HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles = 15;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFiles60(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 100) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES;
            HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles = 60;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFiles120(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 200) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES;
            HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles = 120;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(HmiFile_UT.Parameters.Fifo.MaxNumberOfFiles, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_30Files(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileWrite_UT.enable = true;
            FileWrite_UT.ident = FileCreate_UT.ident;
            FileWrite_UT.offset = 0;
            FileWrite_UT.pSrc = (UDINT)&testData;
            FileWrite_UT.len = sizeof(testData);
            FileWrite(&FileWrite_UT);
            TEST_BUSY_CONDITION(FileWrite_UT.status == 65535);
            TEST_ABORT_CONDITION(FileWrite_UT.status != 0);
            TestState = 2;
            break;
            
        case 2:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 30) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER;
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 20;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(20, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_60Files(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileWrite_UT.enable = true;
            FileWrite_UT.ident = FileCreate_UT.ident;
            FileWrite_UT.offset = 0;
            FileWrite_UT.pSrc = (UDINT)&testData;
            FileWrite_UT.len = sizeof(testData);
            FileWrite(&FileWrite_UT);
            TEST_BUSY_CONDITION(FileWrite_UT.status == 65535);
            TEST_ABORT_CONDITION(FileWrite_UT.status != 0);
            TestState = 2;
            break;
            
        case 2:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 60) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER;
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 40;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(40, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_Keep60Files(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileWrite_UT.enable = true;
            FileWrite_UT.ident = FileCreate_UT.ident;
            FileWrite_UT.offset = 0;
            FileWrite_UT.pSrc = (UDINT)&testData;
            FileWrite_UT.len = sizeof(testData);
            FileWrite(&FileWrite_UT);
            TEST_BUSY_CONDITION(FileWrite_UT.status == 65535);
            TEST_ABORT_CONDITION(FileWrite_UT.status != 0);
            TestState = 2;
            break;
            
        case 2:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 90) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER;
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 60;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(60, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_Keep120Files(void)
{
	TEST_DONE;
    switch (TestState)
    {
        // Arrange
        case 0:
            FileCreate_UT.enable = true;
            FileCreate_UT.pDevice = (UDINT)&"mappUserXFiles";
            snprintf2(FileName, sizeof(FileName), "TestFile%d.txt", FileNumber);
            FileCreate_UT.pFile = (UDINT)&FileName;
            FileCreate(&FileCreate_UT);
            
            TEST_BUSY_CONDITION(FileCreate_UT.status == 65535);
            TEST_ABORT_CONDITION(FileCreate_UT.status != 0);
            TestState = 1;
            break;
        
        case 1:
            FileWrite_UT.enable = true;
            FileWrite_UT.ident = FileCreate_UT.ident;
            FileWrite_UT.offset = 0;
            FileWrite_UT.pSrc = (UDINT)&testData;
            FileWrite_UT.len = sizeof(testData);
            FileWrite(&FileWrite_UT);
            TEST_BUSY_CONDITION(FileWrite_UT.status == 65535);
            TEST_ABORT_CONDITION(FileWrite_UT.status != 0);
            TestState = 2;
            break;
            
        case 2:
            FileClose_UT.enable = true;
            FileClose_UT.ident = FileCreate_UT.ident;
            FileClose(&FileClose_UT);
            
            TEST_BUSY_CONDITION(FileClose_UT.status == 65535);
            TEST_ABORT_CONDITION(FileClose_UT.status != 0);
            
            FileNumber++;
            TestState = (FileNumber >= 140) ? 10 : 0;
            break;
        
        // Act
        case 10:
            HmiFile_UT.Parameters.Fifo.Enable = true;
            strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");
            HmiFile_UT.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER;
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 120;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(FileIdleOrDisabled());
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(!FileIdleOrDisabled());
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(120, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}
/*
B+R UnitTest: This is generated code.
Do not edit! Do not move!
Description: UnitTest Testprogramm infrastructure (TestSet).
LastUpdated: 2023-03-29 16:13:21Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
	new_TestFixture("Create_Directory", Create_Directory), 
	new_TestFixture("Add_File", Add_File), 
	new_TestFixture("Copy_File", Copy_File), 
	new_TestFixture("Copy_Directory", Copy_Directory), 
	new_TestFixture("Rename_File", Rename_File), 
	new_TestFixture("Rename_Directory", Rename_Directory), 
	new_TestFixture("Cut_Paste_File", Cut_Paste_File), 
	new_TestFixture("Cut_Paste_Directory", Cut_Paste_Directory), 
	new_TestFixture("Multiselect", Multiselect), 
	new_TestFixture("FIFO_20", FIFO_20), 
	new_TestFixture("FIFO_60", FIFO_60), 
	new_TestFixture("FIFO_140", FIFO_140), 
	new_TestFixture("FIFO_MaxFiles60", FIFO_MaxFiles60), 
	new_TestFixture("FIFO_MaxFiles120", FIFO_MaxFiles120), 
	new_TestFixture("FIFO_MaxFolderSize_30Files", FIFO_MaxFolderSize_30Files), 
	new_TestFixture("FIFO_MaxFolderSize_60Files", FIFO_MaxFolderSize_60Files), 
	new_TestFixture("FIFO_MaxFolderSize_Keep60Files", FIFO_MaxFolderSize_Keep60Files), 
	new_TestFixture("FIFO_MaxFolderSize_Keep120Files", FIFO_MaxFolderSize_Keep120Files), 
};

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_FileMgr, "Set_FileMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, cyclicSetCaller);

