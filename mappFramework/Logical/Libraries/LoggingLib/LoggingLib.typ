(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLogger.typ
 * Author: buchananw
 * Created: August 19, 2009
 ********************************************************************
 * Data types of library AsLogger
 ********************************************************************)

TYPE
	LogStatus : 
		(
		LOG_OK,
		LOG_NOT_VALID,
		LOG_ILLEGAL_LEVEL,
		LOG_INVALID_ARGUMENTS,
		LOG_DUPLICATE,
		LOG_BUSY := 65535
		);
	LogLevel : 
		(
		LOG_LEVEL_DEBUG,
		LOG_LEVEL_INFO,
		LOG_LEVEL_WARN,
		LOG_LEVEL_ERROR,
		LOG_LEVEL_FATAL
		);
	ClientStatus_typ : 
		(
		CLIENT_NOT_USED,
		CLIENT_PENDING,
		CLIENT_SENDING,
		CLIENT_DONE,
		CLIENT_DROPPING
		);
	LoggerClient_typ : 	STRUCT 
		ident : UDINT;
		ipAddress : STRING[15];
		port : UINT;
		status : ClientStatus_typ;
		wouldBlockCount : USINT;
		close : TcpClose;
		send : TcpSend;
	END_STRUCT;
	AS_LOGGER_ERRORS : 
		(
		ASLOGGER_INTERNAL_ERROR := 30000,
		ASLOGGER_ILLEGAL_FILENAME := 33000,
		ASLOGGER_ILLEGAL_DEVICENAME
		);
	AsLoggerServerInternal_typ : 	STRUCT 
		state : USINT;
		ident : UDINT;
		open : TcpOpen;
		close : TcpClose;
		server : TcpServer;
		clientsActive : USINT;
		clients : ARRAY[0..7]OF LoggerClient_typ;
		outputIndex : UINT;
		sendBuffer : STRING[5000];
		sendBufferUsed : UINT;
	END_STRUCT;
	AsLoggerFileInternal_typ : 	STRUCT 
		state : AS_FILE_LOGGER_STATE;
		fileNumber : USINT;
		fileOffset : UDINT;
		tempFileName : STRING[80];
		oldFileName : STRING[80];
		newFileName : STRING[80];
		tempString : STRING[500];
		outputIndex : UINT;
		FileCreate_0 : FileCreate;
		FileOpen_0 : FileOpen;
		FileClose_0 : FileClose;
		FileWrite_0 : FileWrite;
		FileCopy_0 : FileCopy;
		FileDelete_0 : FileDelete;
		writeBuffer : STRING[10000];
		writeBufferUsed : UINT;
	END_STRUCT;
	AsLoggerLogBookInternal_typ : 	STRUCT 
		outputIndex : UINT;
		ArEventLogWrite_0 : ArEventLogWrite;
		ArEventLogGetIdent_0 : ArEventLogGetIdent;
		outputIndexRegistered : BOOL;
	END_STRUCT;
	AS_FILE_LOGGER_STATE : 
		(
		AS_FILE_LOGGER_STATE_W_ENABLE,
		AS_FILE_LOGGER_STATE_MOVE_FILES,
		AS_FILE_LOGGER_STATE_DELETE_OLD,
		AS_FILE_LOGGER_STATE_CREATE_FILE,
		AS_FILE_LOGGER_STATE_MARSHALL,
		AS_FILE_LOGGER_STATE_OPEN,
		AS_FILE_LOGGER_STATE_WRITE,
		AS_FILE_LOGGER_STATE_CLOSE,
		AS_FILE_LOGGER_STATE_ERROR := 255
		);
END_TYPE
