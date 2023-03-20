/********************************************************************
 * COPYRIGHT -- B&R
 ********************************************************************
 * Program: LoggerDemo
 * File: lLoggerDemoInit.c
 * Author: buchananw
 * Created: August 20, 2009
 ********************************************************************
 * Implementation of program loadLogger
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

void _INIT loadLoggerInit( void )
{
    AsLoggerServer_0.port = 15622;
    AsLoggerServer_0.level = LOG_LEVEL_DEBUG;

    strcpy(AsLoggerFile_0.delimiter, ",");
    strcpy(AsLoggerFile_0.device,"C");
    strcpy(AsLoggerFile_0.fileExtension,"csv");
    strcpy(AsLoggerFile_0.fileName,"logTest");    
    AsLoggerFile_0.maxFiles = 10;
    AsLoggerFile_0.maxFileSize = 100000;
    AsLoggerFile_0.level = LOG_LEVEL_DEBUG;

    AsLoggerLogBook_0.level = LOG_LEVEL_DEBUG;
    
}
