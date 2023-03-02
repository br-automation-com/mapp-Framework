/********************************************************************
 * COPYRIGHT -- B&R
 ********************************************************************
 * Program: LoggerDemo
 * File: LoggerDemoExit.c
 * Author: buchananw
 * Created: August 20, 2009
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

#include <stdbool.h>

void _EXIT logServerExit( void )
{
    AsLoggerServer_0.disconnect = true;
    do
    {
        AsLoggerServer(&AsLoggerServer_0);
    }while (AsLoggerServer_0.status == 65535);
}
