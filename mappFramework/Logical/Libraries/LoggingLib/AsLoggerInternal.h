/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLoggerStructures.h
 * Author: buchananw
 * Created: August 19, 2009
 *******************************************************************/
#ifndef __AS_LOGGER_INTERNALS_H__
#define __AS_LOGGER_INTERNALS_H__

#include <bur/plctypes.h>
#include <LoggingLib.h>

//#define __DEBUG_LOGGING_LIBRARY__

#define MAX_LOG_ITEMS 255
#define MAX_MESSAGE_LENGTH 512
#define MAX_NAME_LENGTH 80
#define MAX_INDEXES 8

#define LOG_SEND_BUF_SIZE (sizeof(sendBuffer)/sizeof(sendBuffer[0]))
#define MAX_WOULD_BLOCK 25

#define incrementIndex(x) x = (x+1)%MAX_LOG_ITEMS
#define decrementIndex(x) x = (x > 0) ? x - 1 : MAX_LOG_ITEMS - 1

typedef struct LogMessage_typ
{
    BOOL used;
    STRING name[MAX_NAME_LENGTH];
    LogLevel level;
    DATE_AND_TIME timeStamp;
    USINT timeStampMilliseconds;
    STRING message[MAX_MESSAGE_LENGTH];
}LogMessage_typ;

typedef struct LastMessage_typ
{
    STRING name[MAX_NAME_LENGTH];
    STRING message[MAX_MESSAGE_LENGTH];
}LastMessage_typ;

typedef struct LogStore_typ
{
    UINT inputIndex;
    UINT* outputIndexes[MAX_INDEXES];
    LogLevel level;
    LogMessage_typ messages[MAX_LOG_ITEMS];
    LastMessage_typ lastMessages[30];
}LogStore_typ;

BOOL addNewOutputIndex(UINT* newOutputIndex);
void updateOutputIndexes(UINT** outputIndexes, UINT inputIndex);
LogStatus logMessage(char* name, LogLevel level, const char* message, UDINT pMsgData);
LoggerClient_typ* getNextFreeClient(struct AsLoggerServer* inst);
BOOL acceptClient(LoggerClient_typ* newClient, UDINT clientIdent, UINT clientPort);
BOOL freeClient(LoggerClient_typ* client);
BOOL dropClient(LoggerClient_typ* client);
void handleAllActiveClients(LoggerClient_typ* clients, USINT numberOfClients, USINT* activeClients, char* sendBuffer, UINT* sendBufferUsed, LogMessage_typ* messages, LogLevel level, UINT* outputIndex);
BOOL handleClient(LoggerClient_typ* client, char* sendBuffer, UINT sendBufferUsed);
void sendToClient(LoggerClient_typ* client, char* buffer, UINT bufferLength);
BOOL writeHeader(char* buffer, UINT* bufferPos);
BOOL writeFooter(char* buffer, UINT* bufferPos);
BOOL marchallLogMessageAsXML(char* buffer, UINT* bufferPos, LogMessage_typ* message);
void marshallBuffer(char* buffer, UINT* bufferPos, LogMessage_typ* messages, LogLevel level, UINT* outputIndex);
void marchallLogMessageForFile(LogMessage_typ* message, char* delimiter, char* tempString, UDINT sizeOfTempString);
void addStringToBuffer(char* buffer, UINT* bufferPos, char* newMessage);
USINT convertToArLogLevel(LogMessage_typ* message);

LogStore_typ* getLogStore(void);

#endif
