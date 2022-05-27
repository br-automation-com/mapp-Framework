/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: LibAssert1
 * File: LibAssert1_REAL_ArrayAsserts.c
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>

#include "asbrstr.h"
#include "LibAssert1_REAL_ArrayAsserts.h"

#define TRUE 1
#define FALSE 0

#define NR_OF_DETAILED_ENTRIES_TO_SHOW 10


/* Tests each REAL in the array for equality in range
Returns true if passed, false otherwise
delta: allowed tolerance (floats are not exact values)
expected: array of expected REAL values
acutal: array of REAL values under test
nrOfEntries: number of entries in array
line: location information
file: location information
*/
BOOL spl_assertImplRealArrayWithin(const REAL *delta,
                                   const REAL *expected, 	const REAL *actual, const unsigned long nrOfEntries,
                                   unsigned long line, const char *file)
{
	unsigned long i = 0;
	unsigned long countFail = 0;
	STRING buffer[100];
	STRING numbuf[30];


	/*------------------------------------------------------------*/
	for(i = 0; i < nrOfEntries; i++)
	{
		REAL diff = actual[i] - expected[i];
		REAL pos_delta = delta[i];

		if (diff < 0)
		{
			/* use absolute (positive) value */
			diff = 0.0f - diff;
		}
		if (pos_delta < 0)
		{
			/* use absolute (positive) value */
			pos_delta = 0.0f - pos_delta;
		}

		/* Check */
		if (pos_delta < diff)
		{
			/* count the failures */
			countFail++;

			/* for the first NR_OF_DETAILED_ENTRIES_TO_SHOW failures generate an informational message) */
			if(countFail < NR_OF_DETAILED_ENTRIES_TO_SHOW)
			{
				brsstrcpy((unsigned long) buffer, (unsigned long) "At array index ");
				brsitoa((int)i, (unsigned long)numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				brsstrcat((unsigned long) buffer, (unsigned long) ": exp ");
				brsftoa((REAL)expected[i], (unsigned long)numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				brsstrcat((unsigned long) buffer, (unsigned long)" was ");
				brsftoa((REAL)actual[i], (unsigned long)numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				addInfo(buffer, line, file);
			}
		}
	}/* end for */
	/*------------------------------------------------------------*/
	/* All entries checked, generate notification for test report */
	if(0 == countFail)
	{
		addPassed("", line, file);
		return TRUE;
	}
	else
	{
		brsitoa(countFail, (unsigned long)numbuf);
		brsstrcpy((unsigned long)buffer, (unsigned long)numbuf);
		brsstrcat((unsigned long)buffer, (unsigned long)" failures occured in array ");
		addFailure(buffer, line, file);
		return FALSE;
	}
}

/* Tests each REAL in the array for equality
Returns true if passed, false otherwise
delta: allowed tolerance (floats are not exact values)
expected: array of expected REAL values
acutal: array of REAL values under test
nrOfEntries: number of entries in array
line: location information
file: location information
*/
BOOL spl_assertImplRealArrayEqual(const REAL delta,
                                  const REAL *expected, 	const REAL *actual, const unsigned long nrOfEntries,
                                  unsigned long line, const char *file)
{
	unsigned long i = 0;
	char countFail = 0;
	STRING buffer[100];
	STRING numbuf[30];

	/*------------------------------------------------------------*/
	for(i = 0; i < nrOfEntries; i++)
	{
		REAL diff = actual[i] - expected[i];
		REAL pos_delta = delta * (REAL)(expected[i]);


		if (diff < 0)
		{
			/* use absolute (positive) value */
			diff = 0.0f - diff;
		}
		if (pos_delta < 0)
		{
			/* use absolute (positive) value */
			pos_delta = 0.0f - pos_delta;
		}

		/* Check */
		if (pos_delta < diff)
		{
			/* count the failures */
			countFail++;

			/* for the first NR_OF_DETAILED_ENTRIES_TO_SHOW failures generate an informational message) */
			if(countFail < NR_OF_DETAILED_ENTRIES_TO_SHOW)
			{
				brsstrcpy((unsigned long) buffer, (unsigned long) "At array index ");
				brsitoa((int)i, (unsigned long) numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				brsstrcat((unsigned long) buffer, (unsigned long) ": exp ");
				brsftoa((REAL)expected[i], (unsigned long)numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				brsstrcat((unsigned long) buffer, (unsigned long) " was ");
				brsftoa((REAL)actual[i], (unsigned long)numbuf);
				brsstrcat((unsigned long) buffer, (unsigned long) numbuf);

				addInfo(buffer, 0, 0);
			}
		}
	}/* end for */

	/*------------------------------------------------------------*/
	/* All entries checked, generate notification for test report */
	if(0 == countFail)
	{
		addPassed("", line, file);
		return TRUE;
	}
	else
	{
		brsitoa(countFail, (unsigned long)numbuf);
		brsstrcpy((unsigned long)buffer, (unsigned long)numbuf);
		brsstrcat((unsigned long)buffer,(unsigned long) " failures occured in array ");
		addFailure(buffer, line, file);
		return FALSE;
	}
}
