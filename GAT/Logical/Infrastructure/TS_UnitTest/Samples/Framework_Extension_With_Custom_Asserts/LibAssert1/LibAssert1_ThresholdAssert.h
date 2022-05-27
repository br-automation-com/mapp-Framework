/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: LibAssert1
 * File: LibAssert1_ThresholdAssert.h
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>


#include <bur/plctypes.h>
#include "UnitTest.h"

#ifdef __cplusplus
extern "C"
{
#endif



/* Dummies for smart edit autocompletion.
See below for the real macros used by the compiler  */
#ifdef _SMART_EDIT_DUMMY_
	/* This asserts checks (actual < threshold) */
	BOOL SPL_ASSERT_UPPER_BOUNDARY(DINT threshold, DINT actual);
#endif

/*------------------------------------------------------------*/


/* Prototyping of functions.
These declaration of functions are used by the compiler to check number and type of arguments. */
BOOL spl_assertUpperBoundary_DINT(const DINT threshold, const DINT actual, unsigned long line, const char *file);


/* Macros used in the test implementation.
The macro passes the location information to the implemented assert. */
#define SPL_ASSERT_UPPER_BOUNDARY(threshold, actual) 	\
	spl_assertUpperBoundary_DINT(threshold, actual, (unsigned long) __LINE__, __FILE__)


#ifdef __cplusplus
};
#endif

