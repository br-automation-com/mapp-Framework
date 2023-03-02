/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLogger.c
 * Author: buchananw
 * Created: August 19, 2009
 *******************************************************************/

#include <bur/plctypes.h>
#include <LoggingLib.h>
#include "AsLoggerInternal.h"
#include <string.h>
#include <stdbool.h>

static LogStore_typ LogStore;

LogStatus logDebug(char* name, char* message, UDINT pMsgData)
{
    return logMessage(name, LOG_LEVEL_DEBUG, message, pMsgData);
}

LogStatus logInfo(char* name, char* message, UDINT pMsgData)
{
    return logMessage(name, LOG_LEVEL_INFO, message, pMsgData);
}

LogStatus logWarn(char* name, char* message, UDINT pMsgData)
{        
    return logMessage(name, LOG_LEVEL_WARN, message, pMsgData);
}

LogStatus logError(char* name, char* message, UDINT pMsgData)
{
    return logMessage(name, LOG_LEVEL_ERROR, message, pMsgData);
}

LogStatus logFatal(char* name, char* message, UDINT pMsgData)
{
    return logMessage(name, LOG_LEVEL_FATAL, message, pMsgData);
}

UDINT AsLoggerGetLastMessage(void)
{
    UINT lastMessage = LogStore.inputIndex;
    
    return (UDINT)&LogStore.messages[decrementIndex(lastMessage)].message;
}

BOOL logLevelIsValid(LogLevel level)
{
    return ((level >= LOG_LEVEL_DEBUG) && (level <= LOG_LEVEL_FATAL));
}

BOOL isSameAsLastMessage(char* name, const char* message)
{
    unsigned int i = 0;
    for (i=0; i<sizeof(LogStore.lastMessages)/sizeof(LogStore.lastMessages[0]); i++)
    {
        if ((strcmp(LogStore.lastMessages[i].name, name) == 0) && (strcmp(LogStore.lastMessages[i].message, message) == 0))
            return true;
    }
    
    // message not found
    for (i=0; i<sizeof(LogStore.lastMessages)/sizeof(LogStore.lastMessages[0]); i++)
    {
        if (strcmp(LogStore.lastMessages[i].name, "") == 0)
        {
            strcpy(LogStore.lastMessages[i].name, name);
        }
        if (strcmp(LogStore.lastMessages[i].name, name) == 0)
        {
            strcpy(LogStore.lastMessages[i].message, message);
            break;
        }
    }
    
    return false;
}

LogStatus logMessage(char* name, LogLevel level, const char* message, UDINT pMsgData)
{
    UINT tempIndex;
    UtcDTGetTime_typ now;
    UtcDTStructureGetTime_typ UtcDTStructureGetTime_0;
    DTStructure nowMilliseconds;

    STRING formattedMessage[MAX_MESSAGE_LENGTH];
    char* currentChar;
    USINT currentArgIndex;
    UDINT** pData;
    char* arguments[LOGGING_MAX_ARGUMENTS];
    char argumentsTemp[LOGGING_MAX_ARGUMENTS][80];
    char tempMessage[256];
    
    if (logLevelIsValid(level) == false)
    {
        return LOG_ILLEGAL_LEVEL;
    }
   
    if (name == NULL)
    {
        return LOG_INVALID_ARGUMENTS;
    }
    if (message == NULL)
    {
        return LOG_INVALID_ARGUMENTS;
    }
    
    if (pMsgData == NULL)
    {
        strcpy(formattedMessage, message);
    }
    else
    {
        currentArgIndex = 0;
        pData = (void*)pMsgData;
        memset(&argumentsTemp, 0, sizeof(argumentsTemp));
        memset(&arguments, 0, sizeof(arguments));
        memset(&tempMessage, 0, sizeof(tempMessage));
        strcpy(tempMessage, message);
        currentChar = (char*)&tempMessage;
        
        while ((*currentChar != '\0') && (currentArgIndex < LOGGING_MAX_ARGUMENTS))
        {
            if (*currentChar == '%')
            {
                char nextChar;
                if (pData[currentArgIndex] == 0)
                    return LOG_INVALID_ARGUMENTS;
                
                switch (*(++currentChar))
                {
                    case 'b':
                        if (*(BOOL*)(pData[currentArgIndex]) == true)
                            strcpy(argumentsTemp[currentArgIndex], "TRUE");
                        else
                            strcpy(argumentsTemp[currentArgIndex], "FALSE");
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %b to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case 'l':
                        nextChar = *(currentChar + 1);
                        switch (nextChar)
                        {
                            case 'i':
                            case 'd':
                                strcpy(currentChar, (currentChar + 1));
                                *(currentChar + strlen(currentChar)) = 0;
                                snprintf2(argumentsTemp[currentArgIndex], (sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%li", *(DINT*)pData[currentArgIndex]);
                            break;
                            case 'u':
                                strcpy(currentChar, (currentChar + 1));
                                *(currentChar + strlen(currentChar)) = 0;
                                snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%lu", *(UDINT*)pData[currentArgIndex]);
                            break;
                            case 'f':
                                strcpy(currentChar, (currentChar + 1));
                                *(currentChar + strlen(currentChar)) = 0;
                                snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%lf", *(LREAL*)pData[currentArgIndex]);
                            break;
                        }
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %b to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case 's':
                        if ((currentChar + 1) != 0)
                        {
                            nextChar = *(currentChar + 1);
                            switch (nextChar)
                            {
                                case 'i':
                                case 'd':
                                    strcpy(currentChar, (currentChar + 1));
                                    *(currentChar + strlen(currentChar)) = 0;
                                    snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%i", *(SINT*)pData[currentArgIndex]);
                                    break;
                                case 'u':
                                    strcpy(currentChar, (currentChar + 1));
                                    *(currentChar + strlen(currentChar)) = 0;
                                    snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%i", *(USINT*)pData[currentArgIndex]);
                                    break;
                                default:
                                    snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%s", (char*)pData[currentArgIndex]);
                            }
                        }
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %b to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case 'd':
                    case 'i':
                        snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%i", *(INT*)pData[currentArgIndex]);
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %d to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case 'u':
                        snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%u", *(UINT*)pData[currentArgIndex]);
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %d to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case 'f':
                        snprintf2(argumentsTemp[currentArgIndex],(sizeof(argumentsTemp[0]) / sizeof(argumentsTemp[0][0])) - 1, "%f", *(REAL*)pData[currentArgIndex]);
                        arguments[currentArgIndex] = (char*)argumentsTemp[currentArgIndex];
                        // change %f to %s since we are creating the string.
                        *(currentChar) = 's';
                        break;
                    case '%':
                        // this isn't an argument index so make sure the index isn't incremented
                        currentArgIndex--;
                        break;
                }
                currentArgIndex++;
            }
            else
            {
                currentChar++;
            }
        }
        
        memset(&formattedMessage, 0, sizeof(formattedMessage));        
        snprintf2(formattedMessage,(sizeof(formattedMessage) / sizeof(formattedMessage[0])) - 1, tempMessage, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
    }
    
    
    if (isSameAsLastMessage(name, formattedMessage) == true) 
        return LOG_DUPLICATE;
    
    /* no need for a lock because we increment the input index before doing anything else */
    tempIndex = LogStore.inputIndex;
    incrementIndex(LogStore.inputIndex);
    
    /* if the log buffer is full than forget the old messages */
    updateOutputIndexes(LogStore.outputIndexes, LogStore.inputIndex);

    strncpy(LogStore.messages[tempIndex].name, name, (sizeof(LogStore.messages[tempIndex].name) / sizeof(LogStore.messages[tempIndex].name[0])) - 1);
    strncpy(LogStore.messages[tempIndex].message, formattedMessage, (sizeof(LogStore.messages[tempIndex].message) / sizeof(LogStore.messages[tempIndex].message[0])) - 1);
    
    LogStore.messages[tempIndex].level = level;

    now.enable = true;
    UtcDTGetTime(&now);
    LogStore.messages[tempIndex].timeStamp = now.DT1;
    UtcDTStructureGetTime_0.enable = true ;
    UtcDTStructureGetTime_0.pDTStructure = (UDINT)&nowMilliseconds;
    UtcDTStructureGetTime(&UtcDTStructureGetTime_0);
    LogStore.messages[tempIndex].timeStampMilliseconds = nowMilliseconds.millisec;
    LogStore.messages[tempIndex].used = true;
   
    return LOG_OK;
}

LogStore_typ* getLogStore(void)
{
    return &LogStore;
}

BOOL addNewOutputIndex(UINT* newOutputIndex)
{
    USINT i = 0;
    while ((LogStore.outputIndexes[i] != NULL) && (i < (sizeof(LogStore.outputIndexes)/sizeof(LogStore.outputIndexes[0]))))
    {
        i++;    
    }
    if (LogStore.outputIndexes[i] == NULL)
    {
        LogStore.outputIndexes[i] = newOutputIndex;
        return true;
    }
    return false;
}

void updateOutputIndexes(UINT** outputIndexes, UINT inputIndex)
{
    USINT i=0;
    if (outputIndexes == NULL)
        return;
        
    for (i=0;i < (sizeof(LogStore.outputIndexes)/sizeof(LogStore.outputIndexes[0]));i++)
    {
        if ((outputIndexes[i] != NULL) && (*outputIndexes[i] == inputIndex))
        {
            incrementIndex(*outputIndexes[i]);
        }
    }
}
