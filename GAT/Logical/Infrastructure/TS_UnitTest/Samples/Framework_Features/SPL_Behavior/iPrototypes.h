/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_Behavior
 * File: iPrototypes.h
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>


/* Prototyping of functions  */
void 	resetDataForTestSet();
void 	checkAndWriteCounterIfChanged( unsigned long line, const char *file);

void	resetDataForTestSet_Complete();	
void	resetDataForTestSet_TestCases();
void	resetDataForTestSet_SetSetupTeardown();
void	resetDataForTestSet_TestSetupTeardown();


