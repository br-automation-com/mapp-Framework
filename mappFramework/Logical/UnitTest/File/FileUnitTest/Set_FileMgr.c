#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include <stdbool.h>
#include <string.h>

_SETUP_SET(void)
{
	/* TODO:  add code running before test set here */
	TEST_DONE;
}

_TEARDOWN_SET(void)
{
	/* TODO:  add code running after test set here */
	TEST_DONE;
}


_SETUP_TEST(void)
{
    TestState = 0;
    FileNumber = 0;
    
    HmiFile_UT.Parameters.Fifo.Enable = false;
    HmiFile_UT.Parameters.Fifo.ScanInterval = 60;
    strcpy(HmiFile_UT.Parameters.Fifo.DeviceName, "mappUserXFiles");

    switch (SetupState)
    {
        case 0:
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
	TEST_DONE;
}

_TEST FIFO_20(void)
{
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            FileWrite_UT.pSrc = &testData;
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
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 5;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(5, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_60Files(void)
{
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
            FileWrite_UT.pSrc = &testData;
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
            HmiFile_UT.Parameters.Fifo.MaxFolderSize = 5;
            HmiFile_UT.Parameters.Fifo.ScanInterval = 0;
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
            HmiFile_UT.Parameters.Fifo.Enable = false;

            DirInfo_UT.enable = true;
            DirInfo_UT.pDevice = (UDINT)&"mappUserXFiles";
            DirInfo_UT.pPath = (UDINT)&"";
            DirInfo(&DirInfo_UT);
            TEST_BUSY_CONDITION(DirInfo_UT.status == 65535);
            TEST_ABORT_CONDITION(DirInfo_UT.status != 0);
            TEST_ASSERT_EQUAL_INT(5, DirInfo_UT.filenum);
            TEST_DONE;
            break;
        
    }
    TEST_BUSY;
}

_TEST FIFO_MaxFolderSize_Keep60Files(void)
{
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
            FileWrite_UT.pSrc = &testData;
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
            FileWrite_UT.pSrc = &testData;
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
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep == FILE_DELETE_WAIT);
            TestState = 100;
            break;
            
        // Assert
        case 100:
            TEST_BUSY_CONDITION(HmiFile_UT.Status.DeleteStep != FILE_DELETE_WAIT);
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
LastUpdated: 2022-09-22 11:55:24Z
By B+R UnitTest Helper Version: 2.0.1.59
*/
UNITTEST_FIXTURES(fixtures)
{
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

UNITTEST_CALLER_COMPLETE_EXPLICIT(Set_FileMgr, "Set_FileMgr", setupTest, teardownTest, fixtures, setupSet, teardownSet, 0);

