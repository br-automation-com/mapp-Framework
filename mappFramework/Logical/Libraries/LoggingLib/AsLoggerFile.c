/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLoggerFile.c
 * Author: buchananw
 * Created: August 21, 2009
 *******************************************************************/

#include <bur/plctypes.h>
#include <LoggingLib.h>
#include <string.h>
#include <stdbool.h>
#include "AsLoggerInternal.h"

#ifdef __DEBUG_LOGGING_LIBRARY__
#define transit(x, _state)                                          \
{                                                                   \
    x = _state;                                                     \
    logDebug("AsLoggerFile", "changing to state " #_state, NULL);   \
}
#else

#define transit(x, _state)                                          \
{                                                                   \
    x = _state;                                                     \
}

#endif


#define disableAllFunctionBlocks                \
inst->internal.FileOpen_0.enable    = false;    \
inst->internal.FileCreate_0.enable  = false;    \
inst->internal.FileWrite_0.enable   = false;    \
inst->internal.FileCopy_0.enable    = false;    \
inst->internal.FileClose_0.enable   = false;    \
inst->internal.FileDelete_0.enable  = false;      

#define incrementFileNumber(x) x = (x+1) % inst->maxFiles
#define decrementFileNumber(x) x = (x > 0) ? x - 1 : inst->maxFiles - 1

void AsLoggerFile(struct AsLoggerFile* inst)
{
    LogStore_typ* logStore;
    UDINT arguments[LOGGING_MAX_ARGUMENTS];
    USINT i, numberOfLinesWritten;

    if (inst == NULL)
    {
        logError("AsLoggerFile", "AsLoggerFile called with NULL instance", NULL);
        return;
    }
    logStore = getLogStore();
    
    if (logStore == NULL)
    {
        transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
#ifdef __DEBUG_LOGGING_LIBRARY__
        logDebug("AsLoggerFile", "logStore is NULL", NULL);
        logDebug("AsLoggerFile", "changing to ERROR state", NULL);
#endif
        inst->status = ASLOGGER_INTERNAL_ERROR; 
        return;
    }

    switch(inst->internal.state)
    {
        case AS_FILE_LOGGER_STATE_W_ENABLE:
            if (inst->enable != true)
            {
                inst->status = ERR_FUB_ENABLE_FALSE;
                return;
            }
        
            if (strcmp(inst->device, "") == true)
            {
                logError("AsLoggerFile", "device name empty", NULL);
                inst->status = ASLOGGER_ILLEGAL_DEVICENAME;
                return;
            }
            if (strcmp(inst->fileName, "") == true)
            {
                logError("AsLoggerFile", "file name empty", NULL);
                inst->status = ASLOGGER_ILLEGAL_FILENAME;
                return;
            }

            inst->internal.fileNumber = (inst->maxFiles > 1) ? inst->maxFiles - 1 : 0;
            if (inst->internal.fileNumber <= 1)
            {
                snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0])) - 1, "%s.%s", inst->fileName, inst->fileExtension);
                inst->internal.FileDelete_0.pDevice = (UDINT)&inst->device;
                inst->internal.FileDelete_0.pName = (UDINT)&inst->internal.tempFileName;
                inst->internal.FileDelete_0.enable = true;
                transit(inst->internal.state, AS_FILE_LOGGER_STATE_DELETE_OLD);
            }
            else
            {
                snprintf2(inst->internal.newFileName, (sizeof(inst->internal.newFileName) / sizeof(inst->internal.newFileName[0])) - 1, "%s%d.%s", inst->fileName, inst->internal.fileNumber, inst->fileExtension);
                snprintf2(inst->internal.oldFileName, (sizeof(inst->internal.oldFileName) / sizeof(inst->internal.oldFileName[0])) - 1, "%s%d.%s", inst->fileName, --inst->internal.fileNumber, inst->fileExtension);
                
                inst->internal.FileCopy_0.enable = true;
                inst->internal.FileCopy_0.option = fiOVERWRITE;
                inst->internal.FileCopy_0.pSrc = (UDINT)&inst->internal.oldFileName;
                inst->internal.FileCopy_0.pSrcDev = (UDINT)&inst->device;
                inst->internal.FileCopy_0.pDest = (UDINT)&inst->internal.newFileName;
                inst->internal.FileCopy_0.pDestDev = (UDINT)&inst->device;
                transit(inst->internal.state, AS_FILE_LOGGER_STATE_MOVE_FILES);
            }
        break;

        case AS_FILE_LOGGER_STATE_MOVE_FILES:
            switch (inst->internal.FileCopy_0.status)
            {
                case 0:
                case fiERR_FILE_NOT_FOUND:
                    inst->internal.FileCopy_0.enable = false;
                    if (inst->internal.fileNumber == 0)
                    {
                        snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0])) - 1, "%s.%s", inst->fileName, inst->fileExtension);
                        inst->internal.FileDelete_0.pDevice = (UDINT)&inst->device;
                        inst->internal.FileDelete_0.pName = (UDINT)&inst->internal.tempFileName;
                        inst->internal.FileDelete_0.enable = true;
                        transit(inst->internal.state, AS_FILE_LOGGER_STATE_DELETE_OLD);
                    }
                    else
                    {
                        strcpy((char*)&inst->internal.newFileName, (char*)&inst->internal.oldFileName);

                        if (inst->internal.fileNumber <= 1)
                        {
                            snprintf2(inst->internal.oldFileName, (sizeof(inst->internal.oldFileName) / sizeof(inst->internal.oldFileName[0])) - 1, "%s.%s", inst->fileName, inst->fileExtension);
                            inst->internal.fileNumber--;
                        }
                        else
                        {
                            snprintf2(inst->internal.oldFileName, (sizeof(inst->internal.oldFileName) / sizeof(inst->internal.oldFileName[0])) - 1, "%s%d.%s", inst->fileName, --inst->internal.fileNumber, inst->fileExtension);
                        }
                        inst->internal.FileCopy_0.option = fiOVERWRITE;
                        inst->internal.FileCopy_0.pSrc = (UDINT)&inst->internal.oldFileName;
                        inst->internal.FileCopy_0.pSrcDev = (UDINT)&inst->device;
                        inst->internal.FileCopy_0.pDest = (UDINT)&inst->internal.newFileName;
                        inst->internal.FileCopy_0.pDestDev = (UDINT)&inst->device;
                        /* no state transition here. */
                    }
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileCopy_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
#ifdef __DEBUG_LOGGING_LIBRARY__
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "old file name %s", inst->internal.oldFileName);
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "new file name %s", inst->internal.newFileName);
                    //logDebug("AsLoggerFile", logString);
                    arguments[0] = (UDINT)inst->internal.oldFileName;
                    arguments[1] = (UDINT)inst->internal.newFileName;
                    logDebug("AsLoggerFile", "old file name is %s, new file name is %s", (UDINT)&arguments);
                    
#endif
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file copy error %d", inst->internal.FileCopy_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileCopy_0.status;
                    logDebug("AsLoggerFile", "file copy error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);

                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                break;
            }
        break;

        case AS_FILE_LOGGER_STATE_DELETE_OLD:

            switch (inst->internal.FileDelete_0.status)
            {
                case 0:
                case fiERR_FILE_NOT_FOUND:
                    inst->internal.FileDelete_0.enable = false;
                    inst->internal.FileCreate_0.pDevice = (UDINT)&inst->device;
                    snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0]))- 1, "%s.%s", inst->fileName, inst->fileExtension);
                    inst->internal.FileCreate_0.pFile = (UDINT)&inst->internal.tempFileName;
                    inst->internal.FileCreate_0.enable = true;
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_CREATE_FILE);
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileDelete_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file delete error %d", inst->internal.FileDelete_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileDelete_0.status;
                    logDebug("AsLoggerFile", "file delete error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                break;
            }
        break;        
        
        case AS_FILE_LOGGER_STATE_CREATE_FILE:
            switch (inst->internal.FileCreate_0.status)
            {
                case 0:
                    inst->internal.FileCreate_0.enable = false;
                    inst->internal.FileClose_0.ident = inst->internal.FileCreate_0.ident;
                    inst->internal.FileClose_0.enable = true;
                    inst->internal.fileOffset = 0;
                    inst->internal.writeBufferUsed = 0;
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_CLOSE);
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileCreate_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file create error %d", inst->internal.FileCreate_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileCreate_0.status;
                    logDebug("AsLoggerFile", "file create error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);
                    logDebug("AsLoggerFile", inst->internal.tempFileName, NULL);
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                    inst->status = inst->internal.FileCreate_0.status;
            }
        break;
        
        case AS_FILE_LOGGER_STATE_MARSHALL:
            memset(&inst->internal.writeBuffer, 0, sizeof(inst->internal.writeBuffer));
            inst->internal.writeBufferUsed = 0;
            
            numberOfLinesWritten = 0;
            for (i=inst->internal.outputIndex; i != logStore->inputIndex; incrementIndex(i))
            {
                if (logStore->messages[i].level >= inst->level)
                {
                    memset(inst->internal.tempString, 0, sizeof(inst->internal.tempString));
                    marchallLogMessageForFile(&logStore->messages[i], inst->delimiter, inst->internal.tempString, sizeof(inst->internal.tempString) / sizeof(inst->internal.tempString[0]));
                    if ((strlen(inst->internal.tempString) + inst->internal.writeBufferUsed) >= sizeof(inst->internal.writeBuffer))
                    {
                        snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0])) - 1, "%s.%s", inst->fileName, inst->fileExtension);
                        inst->internal.FileOpen_0.enable = true;
                        inst->internal.FileOpen_0.mode = fiREAD_WRITE;
                        inst->internal.FileOpen_0.pDevice = (UDINT)&inst->device;
                        inst->internal.FileOpen_0.pFile = (UDINT)&inst->internal.tempFileName;
                        transit(inst->internal.state, AS_FILE_LOGGER_STATE_OPEN);
                        return;
                    }
                    addStringToBuffer((char*)&inst->internal.writeBuffer, &inst->internal.writeBufferUsed, inst->internal.tempString);
                }
                incrementIndex(inst->internal.outputIndex);
            }
            if (inst->internal.writeBufferUsed > 0)
            {
                snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0]))- 1, "%s.%s", inst->fileName, inst->fileExtension);
                inst->internal.FileOpen_0.enable = true;
                inst->internal.FileOpen_0.mode = fiREAD_WRITE;
                inst->internal.FileOpen_0.pDevice = (UDINT)&inst->device;
                inst->internal.FileOpen_0.pFile = (UDINT)&inst->internal.tempFileName;
                transit(inst->internal.state, AS_FILE_LOGGER_STATE_OPEN);
            }
        break;
        
        case AS_FILE_LOGGER_STATE_OPEN:
            switch (inst->internal.FileOpen_0.status)
            {
                case 0:
                    inst->internal.FileOpen_0.enable = false;
                    
                    inst->internal.FileWrite_0.enable = true;
                    inst->internal.FileWrite_0.ident = inst->internal.FileOpen_0.ident;
                    inst->internal.FileWrite_0.len = inst->internal.writeBufferUsed;
                    inst->internal.FileWrite_0.offset = inst->internal.fileOffset;
                    inst->internal.FileWrite_0.pSrc = (UDINT)inst->internal.writeBuffer;
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_WRITE);
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileOpen_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file open error %d", inst->internal.FileOpen_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileOpen_0.status;
                    logDebug("AsLoggerFile", "file open error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);
                    logDebug("AsLoggerFile", inst->internal.tempFileName, NULL);
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                    inst->status = inst->internal.FileOpen_0.status;
            }
        break;
        
        case AS_FILE_LOGGER_STATE_WRITE:
            switch (inst->internal.FileWrite_0.status)
            {
                case 0:
                    inst->internal.FileWrite_0.enable = false;
                    inst->internal.fileOffset += inst->internal.writeBufferUsed;
                    inst->internal.FileClose_0.enable = true;
                    inst->internal.FileClose_0.ident = inst->internal.FileWrite_0.ident;
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_CLOSE);
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileWrite_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file write error %d", inst->internal.FileWrite_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileWrite_0.status;
                    logDebug("AsLoggerFile", "file write error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);
                    logDebug("AsLoggerFile", inst->internal.tempFileName, NULL);
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                    inst->status = inst->internal.FileWrite_0.status;
            }
        break;
        
        case AS_FILE_LOGGER_STATE_CLOSE:
            switch (inst->internal.FileClose_0.status)
            {
                case 0:
                    inst->internal.FileClose_0.enable = false;
                    if (inst->internal.fileOffset >= inst->maxFileSize)
                    {
                        inst->internal.fileNumber = (inst->maxFiles > 1) ? inst->maxFiles - 1 : 0;
                        if (inst->internal.fileNumber <= 1)
                        {
                            snprintf2(inst->internal.tempFileName, (sizeof(inst->internal.tempFileName) / sizeof(inst->internal.tempFileName[0])) - 1, "%s.%s", inst->fileName, inst->fileExtension);
                            inst->internal.FileDelete_0.pDevice = (UDINT)&inst->device;
                            inst->internal.FileDelete_0.pName = (UDINT)&inst->internal.tempFileName;
                            inst->internal.FileDelete_0.enable = true;
                            transit(inst->internal.state, AS_FILE_LOGGER_STATE_DELETE_OLD);
                        }
                        else
                        {
                            snprintf2(inst->internal.newFileName, (sizeof(inst->internal.newFileName) / sizeof(inst->internal.newFileName[0])) - 1, "%s%d.%s", inst->fileName, inst->internal.fileNumber, inst->fileExtension);
                            snprintf2(inst->internal.oldFileName, (sizeof(inst->internal.oldFileName) / sizeof(inst->internal.oldFileName[0])) - 1, "%s%d.%s", inst->fileName, --inst->internal.fileNumber, inst->fileExtension);
                
                            inst->internal.FileCopy_0.enable = true;
                            inst->internal.FileCopy_0.option = fiOVERWRITE;
                            inst->internal.FileCopy_0.pSrc = (UDINT)&inst->internal.oldFileName;
                            inst->internal.FileCopy_0.pSrcDev = (UDINT)&inst->device;
                            inst->internal.FileCopy_0.pDest = (UDINT)&inst->internal.newFileName;
                            inst->internal.FileCopy_0.pDestDev = (UDINT)&inst->device;
                            transit(inst->internal.state, AS_FILE_LOGGER_STATE_MOVE_FILES);
                        }
                    }
                    else
                    {
                        inst->internal.writeBufferUsed = 0;
                        transit(inst->internal.state, AS_FILE_LOGGER_STATE_MARSHALL);
                    }
                break;
                
                case ERR_FUB_ENABLE_FALSE:
                    inst->internal.FileClose_0.enable = true;
                break;
                
                case ERR_FUB_BUSY:
                break;
                
                default:
                    disableAllFunctionBlocks;
                    //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "file close error %d", inst->internal.FileClose_0.status);
                    arguments[0] = (UDINT)&inst->internal.FileClose_0.status;
                    logDebug("AsLoggerFile", "file close error %d", (UDINT)&arguments);
                    logDebug("AsLoggerFile", "changing to ERROR state", NULL);
                    logDebug("AsLoggerFile", inst->internal.tempFileName, NULL);
                    transit(inst->internal.state, AS_FILE_LOGGER_STATE_ERROR);
                    inst->status = inst->internal.FileClose_0.status;
            }
        break;
        
        case AS_FILE_LOGGER_STATE_ERROR:
            if (inst->enable != true)
            {
                transit(inst->internal.state, 0);
            }
        break;
        
        default:
        break;
    }
    
    if (inst->internal.state != AS_FILE_LOGGER_STATE_ERROR)
        inst->status = ERR_FUB_BUSY;

    FileOpen(&inst->internal.FileOpen_0);
    FileWrite(&inst->internal.FileWrite_0);
    FileClose(&inst->internal.FileClose_0);
    FileCreate(&inst->internal.FileCreate_0);
    FileCopy(&inst->internal.FileCopy_0);
    FileDelete(&inst->internal.FileDelete_0);
}

void marchallLogMessageForFile(LogMessage_typ* message, char* delimiter, char* tempString, UDINT sizeOfTempString)
{
    DTStructure timeStamp;
    char level[6];
    
    if ((message == NULL) || (delimiter == NULL) || (tempString == NULL)) 
        return;
    
    DT_TO_DTStructure(message->timeStamp, (UDINT)&timeStamp);
    timeStamp.millisec = message->timeStampMilliseconds;
    
    memset(&level, 0, sizeof(level));
    switch(message->level)
    {
        case LOG_LEVEL_DEBUG:
            strcpy(level, "DEBUG");
        break;
        case LOG_LEVEL_INFO:
            strcpy(level, "INFO");
        break;
        case LOG_LEVEL_WARN:
            strcpy(level, "WARN");
        break;
        case LOG_LEVEL_ERROR:
            strcpy(level, "ERROR");
        break;
        case LOG_LEVEL_FATAL:
            strcpy(level, "FATAL");
        break;
    }

    snprintf2(tempString, sizeOfTempString - 1, "%04d/%02d/%02d %02d:%02d:%02d.%03d%s %s%s %s%s %s\r\n", timeStamp.year, timeStamp.month, timeStamp.day, \
                    timeStamp.hour, timeStamp.minute, timeStamp.second, timeStamp.millisec, delimiter, \
                    level, delimiter, \
                    message->name, delimiter, \
                    message->message);
}

void addStringToBuffer(char* buffer, UINT* bufferPos, char* newMessage)
{
    if ((buffer == NULL) || (bufferPos == NULL) || (newMessage == NULL))
        return;
        
    memcpy(buffer + *bufferPos, newMessage, strlen(newMessage));
    *bufferPos = *bufferPos + strlen(newMessage);    
}

