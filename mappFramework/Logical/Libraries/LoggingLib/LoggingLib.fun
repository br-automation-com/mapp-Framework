(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsLogger
 * File: AsLogger.fun
 * Author: buchananw
 * Created: August 19, 2009
 ********************************************************************
 * Functions and function blocks of library AsLogger
 ********************************************************************)

FUNCTION logDebug : LogStatus
	VAR_INPUT
		name : STRING[80];
		message : STRING[256];
		pMsgData : UDINT;
	END_VAR
END_FUNCTION

FUNCTION logInfo : LogStatus
	VAR_INPUT
		name : STRING[80];
		message : STRING[256];
		pMsgData : UDINT;
	END_VAR
END_FUNCTION

FUNCTION logWarn : LogStatus
	VAR_INPUT
		name : STRING[80];
		message : STRING[256];
		pMsgData : UDINT;
	END_VAR
END_FUNCTION

FUNCTION logError : LogStatus
	VAR_INPUT
		name : STRING[80];
		message : STRING[256];
		pMsgData : UDINT;
	END_VAR
END_FUNCTION

FUNCTION logFatal : LogStatus
	VAR_INPUT
		name : STRING[80];
		message : STRING[256];
		pMsgData : UDINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK AsLoggerServer
	VAR_INPUT
		port : UINT;
		disconnect : BOOL;
		level : LogLevel;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		internal : AsLoggerServerInternal_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK AsLoggerFile
	VAR_INPUT
		enable : BOOL;
		device : STRING[80];
		fileName : STRING[80];
		maxFileSize : UDINT;
		maxFiles : USINT;
		delimiter : STRING[2];
		fileExtension : STRING[4];
		level : LogLevel;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		internal : AsLoggerFileInternal_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK AsLoggerLogBook
	VAR_INPUT
		level : LogLevel;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		internal : AsLoggerLogBookInternal_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION AsLoggerGetLastMessage : UDINT (*Function mainly used for testing purposes*)
END_FUNCTION
