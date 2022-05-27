/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: LibAssert1
 * File: LibAssert1_REAL_ArrayAsserts.h
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>
#include "UnitTest.h"

#ifdef __cplusplus
extern "C"
{
#endif


	/* Dummies for smart edit autocompletion.
	See below for the real macros used by the compiler  */
#ifdef _SMART_EDIT_DUMMY_

	/* This assert checks two arrays of floats for equality. TEST_FLOAT_PRECISION is used as default Delta.

	Note: An assert like this is generally more readable and meaningful than multiple TEST_ASSERT_EQUAL_FLOAT().
	It informs about how many entries failed in total and shows the first NR_OF_DETAILED_ENTRIES_TO_SHOW together with the array index the failure occured. */
	BOOL SPL_ASSERT_ARRAY_EQUAL_REAL(REAL *expected[], REAL *actual[], UDINT nrOfEntries);


	/* This assert checks two arrays of floats for equality with an accepted delta per entry

	Note: An assert like this is generally more readable and meaningful than multiple TEST_ASSERT_FLOAT_WITHIN().
	It informs about how many entries failed in total and shows the first NR_OF_DETAILED_ENTRIES_TO_SHOW together with the array index the failure occured.
	*/
	BOOL SPL_ASSERT_ARRAY_REAL_WITHIN(REAL *delta[], REAL *expected[], REAL *actual[], UDINT nrOfEntries);

#endif



	/*------------------------------------------------------------*/



	/* Prototyping of functions.
	These declaration of functions are used by the compiler to check number and type of arguments. */
	BOOL spl_assertImplRealArrayEqual(const REAL delta,
	                                  const REAL *expected,
	                                  const REAL *actual,
	                                  const unsigned long nrOfEntries,
	                                  unsigned long line, const char *file);


	BOOL spl_assertImplRealArrayWithin(const REAL *delta,
	                                   const REAL *expected,
	                                   const REAL *actual,
	                                   const unsigned long nrOfEntries,
	                                   unsigned long line, const char *file);



	/* Makros used in the test implementation.
	The macro passes the location information to the implemented assert. */

#define SPL_ASSERT_ARRAY_EQUAL_REAL(expected, actual, nrOfEntries)	\
	spl_assertImplRealArrayEqual((REAL)TEST_FLOAT_PRECISION, expected, actual, nrOfEntries, (unsigned long) __LINE__, __FILE__)


#define SPL_ASSERT_ARRAY_REAL_WITHIN(delta, expected, actual, nrOfEntries)	\
	spl_assertImplRealArrayWithin(delta, expected, actual, nrOfEntries,  (unsigned long) __LINE__, __FILE__)



#ifdef __cplusplus
};
#endif

