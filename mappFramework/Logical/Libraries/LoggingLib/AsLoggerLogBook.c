/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: LoggingLib
 * File: AsLoggerLogBook.c
 * Author: buchananw
 * Created: April 19, 2010
 *******************************************************************/

#include <bur/plctypes.h>
#include <LoggingLib.h>
#include <string.h>
#include <stdbool.h>
#include "AsLoggerInternal.h"

#define LOGBOOK_ERROR_STATE 255

#ifdef __DEBUG_LOGGING_LIBRARY__
#define transit(x, y)                                        \
{                                                            \
    x->internal.state = y;                                   \
    logDebug("AsLoggerFile", "changing to state " #y, NULL); \
}
#else
#define transit(x, y)                                        \
{                                                            \
    x->internal.state = y;                                   \
}
#endif

#define incrementFileNumber(x) x = (x+1) % inst->internal.maxFiles
#define decrementFileNumber(x) x = (x > 0) ? x - 1 : inst->internal.maxFiles - 1

void AsLoggerLogBook(struct AsLoggerLogBook* inst)
{
    LogStore_typ* logStore;
#ifdef __DEBUG_LOGGING_LIBRARY__
    UDINT arguments[LOGGING_MAX_ARGUMENTS];
#endif
    
    if (inst == NULL)
    {
        logError("AsLoggerLogBook", "AsLoggerLogBook called with NULL instance", (UDINT)NULL);
        return;
    }
    logStore = getLogStore();    
    
    if (logStore == NULL)
    {
#ifdef __DEBUG_LOGGING_LIBRARY__
        logDebug("AsLoggerLogBook", "logStore is NULL", NULL);
#endif
        inst->status = ASLOGGER_INTERNAL_ERROR; 
        return;
    }
    
    if (inst->internal.outputIndexRegistered != true)
    {
        addNewOutputIndex(&inst->internal.outputIndex);
        inst->internal.outputIndexRegistered = true;
    }
    
    while ((inst->internal.outputIndex != logStore->inputIndex) && (logStore->messages[inst->internal.outputIndex].level < inst->level))
    {
        incrementIndex(inst->internal.outputIndex);
    }
    
    if (inst->internal.outputIndex != logStore->inputIndex)
    {
        if (inst->internal.ArEventLogWrite_0.Ident == 0)
        {
            inst->internal.ArEventLogGetIdent_0.Execute = true;
            strcpy(inst->internal.ArEventLogGetIdent_0.Name, "$arlogusr");
            ArEventLogGetIdent(&inst->internal.ArEventLogGetIdent_0);
            if (inst->internal.ArEventLogGetIdent_0.StatusID == 0)
                inst->internal.ArEventLogWrite_0.Ident = inst->internal.ArEventLogGetIdent_0.Ident;
        }
        else
        {
            USINT _logBuffer[MAX_MESSAGE_LENGTH + MAX_NAME_LENGTH + 10];
            char _tempString[MAX_MESSAGE_LENGTH + MAX_NAME_LENGTH + 2];
            
            memset(&_logBuffer, 0, sizeof(_logBuffer));
            inst->internal.ArEventLogWrite_0.Execute = true;
            inst->internal.ArEventLogWrite_0.EventID = ArEventLogMakeEventID(convertToArLogLevel(&(logStore->messages[inst->internal.outputIndex])), 0, 0);
            inst->internal.ArEventLogWrite_0.OriginRecordID = 0;
            snprintf2(_tempString, (sizeof(_tempString) / sizeof(_tempString)) - 1, "%s: %s", logStore->messages[inst->internal.outputIndex].name, logStore->messages[inst->internal.outputIndex].message);
            ArEventLogAddDataInit((UDINT)&_logBuffer, sizeof(_logBuffer), arEVENTLOG_ADDFORMAT_CODED);
            ArEventLogAddDataString((UDINT)&_logBuffer, sizeof(_logBuffer), (UDINT)&_tempString);
            inst->internal.ArEventLogWrite_0.AddData = (UDINT)&_logBuffer;
            inst->internal.ArEventLogWrite_0.AddDataFormat = arEVENTLOG_ADDFORMAT_CODED;
            inst->internal.ArEventLogWrite_0.AddDataSize = sizeof(_logBuffer);

            ArEventLogWrite(&inst->internal.ArEventLogWrite_0);
            if (inst->internal.ArEventLogWrite_0.StatusID == 0)
            {
                incrementIndex(inst->internal.outputIndex);

            }
#ifdef __DEBUG_LOGGING_LIBRARY__
            else
            {
                //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "AR log write error %d", inst->internal.AsArLogWrite_0.status);
                arguments[0] = (UDINT)&inst->internal.ArEventLogWrite_0.StatusID;
                logDebug("AsLoggerLogBook", "AR log write error %d", (UDINT)&arguments);
                inst->status = inst->internal.ArEventLogWrite_0.StatusID;
            }
#endif
            inst->internal.ArEventLogWrite_0.Execute = false;
            ArEventLogWrite(&inst->internal.ArEventLogWrite_0);

        }

    }
}

USINT convertToArLogLevel(LogMessage_typ* message)
{
    if (message == NULL)
        return arEVENTLOG_SEVERITY_INFO;

    switch(message->level)
    {
        case LOG_LEVEL_DEBUG:
        case LOG_LEVEL_INFO:
            return arEVENTLOG_SEVERITY_INFO;
        break;
        case LOG_LEVEL_WARN:
            return arEVENTLOG_SEVERITY_WARNING;
        break;
        case LOG_LEVEL_ERROR:
        case LOG_LEVEL_FATAL:
            return arEVENTLOG_SEVERITY_ERROR;
            return arEVENTLOG_SEVERITY_ERROR;
        break;
    }
    return arEVENTLOG_SEVERITY_ERROR;
}
