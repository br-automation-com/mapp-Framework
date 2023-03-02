/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLoggerServer.c
 * Author: buchananw
 * Created: August 20, 2009
 *******************************************************************/

#include <bur/plctypes.h>
#include <LoggingLib.h>
#include <string.h>
#include <stdbool.h>
#include "AsLoggerInternal.h"

#define XMLHEADER "<?xml version=\"1.0\" encoding=\"utf-8\"?> <logReport version=\"1.0\">"
#define XMLFOOTER "</logReport>\r\n"
#define MAX_LOGS_AT_ONCE 5

void AsLoggerServer(struct AsLoggerServer* inst)
{
    LoggerClient_typ* newClient;
    LogStore_typ* logStore;
    BOOL clientStillActive = false;
    USINT i;
    UDINT arguments[LOGGING_MAX_ARGUMENTS];

    inst->status = LOG_BUSY;
    
    if (inst == NULL)
    {
        logError("AsLoggerServer", "AsLoggerServer called with NULL instance", NULL);
        return;
    }
    switch (inst->internal.state)
    {
        case  0 :
            inst->internal.open.enable = true;
            inst->internal.open.pIfAddr = NULL;
            inst->internal.open.port = inst->port;
            TcpOpen(&inst->internal.open);
            inst->status = inst->internal.open.status;
            if (inst->internal.open.status == 0)
            {
                addNewOutputIndex(&inst->internal.outputIndex);
                inst->internal.ident = inst->internal.open.ident;
                inst->internal.open.enable = false;
                inst->internal.state = 10;
            }
            break;
        
        case 10: /* accept clients in this state */
            if (inst->disconnect == true)
            {
                inst->internal.state = 20;
                return;
            }
        
            if (inst->internal.clientsActive > 0)
            {
                logStore = getLogStore();
                if (logStore == NULL)
                {
                    inst->status = 1;
                    return;
                }
                handleAllActiveClients(&inst->internal.clients[0], sizeof(inst->internal.clients)/sizeof(inst->internal.clients[0]), &inst->internal.clientsActive, (char*)&inst->internal.sendBuffer, &inst->internal.sendBufferUsed, &logStore->messages[0], inst->level, &inst->internal.outputIndex);
            }

            newClient = getNextFreeClient(inst);

            if (newClient == NULL)
            {
                return;
            }
            
            inst->internal.server.enable = true;
            inst->internal.server.ident = inst->internal.ident;
            inst->internal.server.pIpAddr = (UDINT)newClient->ipAddress;

            TcpServer(&inst->internal.server);
            inst->status = inst->internal.server.status;
            if (inst->internal.server.status == 0)
            {
                for (i=0;i<(sizeof(inst->internal.clients)/sizeof(inst->internal.clients[0]));i++)
                {
                    if ((&inst->internal.clients[i] != newClient) && (strcmp(inst->internal.clients[i].ipAddress, newClient->ipAddress) == 0) && (inst->internal.clients[i].status != CLIENT_NOT_USED))
                    {
                        freeClient(newClient);
                        return;
                    }
                }
                //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "accepting new client %s", newClient->ipAddress);
                arguments[0] = (UDINT)newClient->ipAddress;
                logDebug("AsLoggerServer",  "accepting new client %s", (UDINT)&arguments);
                /* accept client */
                if (acceptClient(newClient, inst->internal.server.identclnt, inst->internal.server.portclnt) == true)
                    inst->internal.clientsActive++;
            }
            break;
        
        case 20: /* disconnect all clients */
            inst->status = LOG_BUSY;
            clientStillActive = false;
            for (i=0;i<(sizeof(inst->internal.clients)/sizeof(inst->internal.clients[0]));i++)
            {
                if (inst->internal.clients[i].status != CLIENT_NOT_USED)
                {
                    clientStillActive |= dropClient(&inst->internal.clients[i]);
                }
            }
            if (clientStillActive == false)
            {
                inst->internal.state = 22;
            }
            break;
         
        case 22:
            inst->internal.close.enable = true;
            inst->internal.close.how = 0;
            inst->internal.close.ident = inst->internal.ident;
            TcpClose(&inst->internal.close);
            inst->status = inst->internal.close.status;
            if (inst->internal.close.status != 65535)
            {
                inst->status = 0;
                inst->internal.state = 0;
            }
            break;
        
        default :
            /* do nothing */
            break;
    }
}

LoggerClient_typ* getNextFreeClient(struct AsLoggerServer* inst)
{
    USINT i;
    for (i = 0; i < (sizeof(inst->internal.clients)/sizeof(inst->internal.clients[0])); i++) {
        if (inst->internal.clients[i].status == CLIENT_NOT_USED)
        {
            return &inst->internal.clients[i];
        }
    }
    return NULL;
}

BOOL acceptClient(LoggerClient_typ* newClient, UDINT clientIdent, UINT clientPort)
{
    if (newClient == NULL)
        return false;
    
    newClient->status = CLIENT_PENDING;
    newClient->ident = clientIdent;
    newClient->port = clientPort;
    memset(&newClient->send, 0, sizeof(newClient->send));
    memset(&newClient->close, 0, sizeof(newClient->close));
    return true;
}

void sendToClient(LoggerClient_typ* client, char* buffer, UINT bufferLength)
{
    UDINT arguments[LOGGING_MAX_ARGUMENTS];
    
    if ((client == NULL) || (client->status == CLIENT_NOT_USED))
        return;
    
    client->send.enable = true;
    client->send.ident = client->ident;
    client->send.datalen = bufferLength;
    client->send.pData = (UDINT)buffer;
    client->send.flags = 0;
    
    client->status = CLIENT_SENDING;
    
    TcpSend(&client->send);
    
    if (client->send.status == 0)
    {
        client->wouldBlockCount = 0;
        client->status = CLIENT_DONE;
    }
    else if ((client->send.status == tcpERR_WOULDBLOCK) && (client->wouldBlockCount < MAX_WOULD_BLOCK))
    {
        client->wouldBlockCount++;
    }
    else if (client->send.status == tcpERR_SENTLEN)
    {
        /* try to send data again */
    }
    else if (client->send.status != 65535)
    {
        client->wouldBlockCount = 0;
        /* an error occured so drop the client */
        //snprintf2(errorString, (sizeof(errorString) / sizeof(errorString[0])) - 1, "error received while sending %d", client->send.status);
        arguments[0] = (UDINT)&client->send.status;
        logDebug("AsLoggerServer", "error received while sending %d", (UDINT)&arguments);
        client->status = CLIENT_DROPPING;
    }
}

BOOL dropClient(LoggerClient_typ* client)
{
    UDINT arguments[LOGGING_MAX_ARGUMENTS];
    if (client == NULL)
        return false;
        
    client->close.enable = true;
    client->close.ident = client->ident;
    client->close.how = 0;
    client->status = CLIENT_DROPPING;
    
    TcpClose(&client->close);
    if (client->close.status == 0)
    {
        //snprintf2(logString, (sizeof(logString) / sizeof(logString[0])) - 1, "dropped client %s", client->ipAddress);
        arguments[0] = (UDINT)&client->ipAddress;
        logDebug("AsLoggerServer", "dropped client %s", (UDINT)&arguments);
        return freeClient(client);
    }
    return false;
}

BOOL freeClient(LoggerClient_typ* client)
{
    if (client == NULL)
        return false;
        
    memset(client, 0, sizeof(*client));
    client->status = CLIENT_NOT_USED;
    return true;
}

BOOL handleClient(LoggerClient_typ* client, char* sendBuffer, UINT sendBufferUsed)
{
    if (client == NULL)
        return false;
        
    switch (client->status)
    {
        case CLIENT_NOT_USED:
        break;
        
        case CLIENT_PENDING:
        case CLIENT_SENDING:
            sendToClient(client, sendBuffer, sendBufferUsed);
        break;
        
        case CLIENT_DROPPING:
            return dropClient(client);
        break;
        
        case CLIENT_DONE:
            /* wait until all clients are finished sending before transitting out of the done state */
            /* handled by handleAllActiveClients */
        break;
    }
    return false;
}

void handleAllActiveClients(LoggerClient_typ* clients, USINT numberOfClients, USINT* activeClients, char* sendBuffer, UINT* sendBufferUsed, LogMessage_typ* messages, LogLevel level, UINT* outputIndex)
{
    USINT i;
    BOOL allClientsFinishedSending = true;
    
    for (i=0;i<numberOfClients;i++)
    {
        if ((clients[i].status == CLIENT_PENDING) || (clients[i].status == CLIENT_SENDING))
            allClientsFinishedSending = false;
    }
    
    if (allClientsFinishedSending == true)
    {
        for (i=0;i<numberOfClients;i++)
        {
            if (clients[i].status == CLIENT_DONE)
            {
                clients[i].status = CLIENT_PENDING;
            }
        }
        marshallBuffer(sendBuffer, sendBufferUsed, messages, level, outputIndex);
    }

    for (i=0;i<numberOfClients;i++)
    {
        if (clients[i].status != CLIENT_NOT_USED)
        {
            if (handleClient(&clients[i], sendBuffer, *sendBufferUsed) == true)
            {
                *activeClients = *activeClients - 1;
            }
        }
    }
}

void marshallBuffer(char* buffer, UINT* bufferPos, LogMessage_typ* messages, LogLevel level, UINT* outputIndex)
{
    USINT i;
    USINT numberOfLogs = 0;
    LogStore_typ* logStore = getLogStore();
    
    if ((buffer == NULL) || (bufferPos == NULL) || (messages == NULL) || (logStore == NULL))
        return;
    
    *bufferPos = 0;
    writeHeader(buffer, bufferPos);
    
    for (i=*outputIndex; (i != logStore->inputIndex) && (numberOfLogs < MAX_LOGS_AT_ONCE); incrementIndex(i))
    {
        if (messages[i].level >= level)
        {
            marchallLogMessageAsXML(buffer, bufferPos, &messages[i]);
        }
        incrementIndex(*outputIndex);
        numberOfLogs++;
    }
    writeFooter(buffer, bufferPos);

}

BOOL writeHeader(char* buffer, UINT* bufferPos)
{
    if ((buffer == NULL) || (bufferPos == NULL))
        return 0;
    
    strcpy((char*)buffer, XMLHEADER);
    *bufferPos = *bufferPos + strlen(XMLHEADER);
    return true;
}

BOOL writeFooter(char* buffer, UINT* bufferPos)
{
    strcpy((char*)(buffer + *bufferPos), XMLFOOTER);
    *bufferPos = *bufferPos + strlen(XMLFOOTER);
    return true;
}

BOOL marchallLogMessageAsXML(char* buffer, UINT* bufferPos, LogMessage_typ* message)
{
    STRING level[6];
    STRING tempString[900];
    
    if ((buffer == NULL) || (bufferPos == NULL) || (message == NULL)) 
        return false;
        
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

    snprintf2(tempString, (sizeof(tempString) / sizeof(tempString[0])) - 1, \
            "<logItem><log><![CDATA[AsLoggerServer]]></log><level>%s</level><date>%u</date><millis>%u</millis><taskName>%s</taskName><message><![CDATA[%s]]></message></logItem>", \
            level, message->timeStamp, message->timeStampMilliseconds, message->name, message->message); 
    memcpy(buffer + *bufferPos, tempString, strlen(tempString));
    *bufferPos = *bufferPos + strlen(tempString);
    return true;
}

