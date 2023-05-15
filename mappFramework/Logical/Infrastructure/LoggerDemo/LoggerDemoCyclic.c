/********************************************************************
 * COPYRIGHT -- B&R
 ********************************************************************
 * Program: LoggerDemo
 * File: LoggerDemoCyclic.c
 * Author: buchananw
 * Created: August 20, 2009
 ********************************************************************
 * Implementation of program loadLogger
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include <stdbool.h>
#include <string.h> 

void _CYCLIC loadLoggerCyclic( void )
{
	AsLoggerServer(&AsLoggerServer_0);
//    AsLoggerFile(&AsLoggerFile_0);
//    AsLoggerLogBook(&AsLoggerLogBook_0);
}
