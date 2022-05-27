/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_Behavior
 * File: iHelperFunction.c
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include "UnitTest.h"
#include "AsBrStr.h"
#include "iPrototypes.h"


void resetDataForTestSet()
{
	brsstrcpy((UDINT)OutputString, (UDINT)"");
	CounterInSet = 0;
	CounterInSet_LastChecked = -1;
	CounterToStringBuffer[0] = 0;
}

void checkAndWriteCounterIfChanged( unsigned long line, const char *file)
{	
	if(CounterInSet_LastChecked != CounterInSet)
	{
		addFailure((char*)OutputString, line, file);
		
		CounterInSet_LastChecked = CounterInSet;
		brsitoa(CounterInSet + 1, (UDINT) CounterToStringBuffer);

		brsstrcpy((UDINT)OutputString, (UDINT)"( ");
		brsstrcat((UDINT)OutputString, (UDINT)CounterToStringBuffer);		
		/*		brsstrcat((UDINT)OutputString, (UDINT)". task cylce in TestSet) "); */
		brsstrcat((UDINT)OutputString, (UDINT)". cylce) "); 
		
		addFailure((char*)OutputString, line, file);
		
	}
	else if(OutputString[0]) 
	{
		/*		TEST_FAIL(OutputString);*/
		addFailure((char*)OutputString, line, file);
	}

}
