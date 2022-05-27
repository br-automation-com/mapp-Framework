/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: LibAssert1
 * File: LibAssert1_ThresholdAssert.c
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>

#include "asbrstr.h"
#include "LibAssert1_ThresholdAssert.h"


#define TRUE 1
#define FALSE 0


/* Returns TRUE: Assert passed, FALSE otherwise
threshold: limit
actual: value under test
line: location information
file: location information
*/
BOOL spl_assertUpperBoundary_DINT(const DINT threshold, const DINT actual,
                                  unsigned long line, const char *file)
{
	STRING buffer[100];
	STRING numbuf[15];

	/* Check */
	if(threshold > actual) /* Good case: actual value is below the allowed (expected) maximum. */
	{
		/* Inform the test framework about a passed assert*/
		addPassed("", line, file);
		return TRUE;
	}
	else /* Bad case: acutal value exceeded acceptable threshold  */
	{
		/* Generate message for failure */
		brsstrcpy((unsigned long) buffer, (unsigned long) "Limit ");
		brsitoa((int)threshold, (unsigned long)numbuf);
		brsstrcat((unsigned long) buffer, (unsigned long) numbuf);
		brsstrcat((unsigned long) buffer, (unsigned long) " exceeded (was ");

		brsitoa((int)actual, (unsigned long)numbuf);
		brsstrcat((unsigned long) buffer, (unsigned long) numbuf);
		brsstrcat((unsigned long) buffer, (unsigned long) " ) ");

		/* Add failure to test report */
		addFailure(buffer, line, file);
		return FALSE;
	}
};
