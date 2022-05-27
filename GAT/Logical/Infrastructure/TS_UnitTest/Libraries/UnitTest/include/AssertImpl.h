/*
* Author: 		B+R
* Contents of this file are modified and extended
*/

/*
 * COPYRIGHT AND PERMISSION NOTICE
 *
 * Copyright (c) 2003 Embedded Unit Project
 *
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, provided that the above
 * copyright notice(s) and this permission notice appear in all copies
 * of the Software and that both the above copyright notice(s) and this
 * permission notice appear in supporting documentation.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT
 * OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY
 * SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER
 * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF
 * CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * Except as contained in this notice, the name of a copyright holder
 * shall not be used in advertising or otherwise to promote the sale,
 * use or other dealings in this Software without prior written
 * authorization of the copyright holder.
 *
 * $Id: AssertImpl.h,v 1.6 2003/09/16 11:09:53 arms22 Exp $
 */

#ifndef	__ASSERTIMPL_H__
#define	__ASSERTIMPL_H__

#ifdef	__cplusplus
extern "C" {
#endif

#include <bur/plctypes.h>


/* Increments failure counter and outputs failure text*/
void addFailure(const char *msg, unsigned long line, const char *file);
/* Increments passed counter*/
void addPassed(const char *msg, unsigned long line, const char *file);
/* Outputs informational text*/
void addInfo(const char *msg, unsigned long line, const char *file);
/* Increments abort counter, aborts current test set, outputs abort text.
    Existing teardown methods will be called before leaving the test set */
void addAbort(const char *msg, unsigned long line, const char *file);

BOOL assertImplementationInt(int expected,int actual, unsigned long line, const char *file);
BOOL assertImplementationCStr(const char *expected,const char *actual, unsigned long line, const char *file);
BOOL assertImplementationDoublesWithin(const double delta,	const double expected,	const double actual,	unsigned long line, const char *file);
BOOL assertImplementationFloatsWithin(const float delta,	const float expected,	const float actual,	unsigned long line, const char *file);
BOOL assertImplementationWStr(const unsigned short *expected,const unsigned short *actual, unsigned long line, const char *file);
BOOL assertCondition(BOOL condition, const char *message,  unsigned long line, const char *file);
BOOL assertImplementationMem(void *expected ,void  *actual, unsigned long  size, unsigned long line, const char *file);

#define TEST_ASSERT_EQUAL_STRING(expected,actual)\
	assertImplementationCStr(expected,actual,__LINE__,__FILE__)

#define TEST_ASSERT_EQUAL_WSTRING(expected,actual)\
	assertImplementationWStr(expected,actual,__LINE__,__FILE__)

#define TEST_ASSERT_EQUAL_MEM(expected,actual,size)\
	assertImplementationMem(expected,actual,size,__LINE__,__FILE__)

#define TEST_ASSERT_EQUAL_INT(expected,actual)\
	assertImplementationInt(expected, actual,__LINE__,__FILE__)

#define TEST_ASSERT_NULL(pointer)\
	TEST_ASSERT_MESSAGE(pointer == NULL,#pointer " was not null.")

#define TEST_ASSERT_NOT_NULL(pointer)\
	TEST_ASSERT_MESSAGE(pointer != NULL,#pointer " was null.")

#define TEST_ASSERT_MESSAGE(condition, message)\
	assertCondition(condition,message,__LINE__,__FILE__)

#define TEST_ASSERT(condition) \
	assertCondition(condition, #condition,__LINE__,__FILE__)

#define TEST_FAIL(message)\
	assertCondition(0, message,__LINE__,__FILE__)


#define TEST_ASSERT_EQUAL_FLOAT(expected, actual)   		\
	assertImplementationFloatsWithin(\
									 (float)(expected) * (float)TEST_FLOAT_PRECISION, \
									 (float)(expected), (float)(actual), \
									 (unsigned long) __LINE__, __FILE__)


#define TEST_ASSERT_FLOAT_WITHIN(delta, expected, actual)	 \
	assertImplementationFloatsWithin(\
									 (float)(delta), \
									 (float)(expected), (float)(actual), \
									 (unsigned long) __LINE__, __FILE__)

#define TEST_ASSERT_EQUAL_DOUBLE(expected, actual)           \
	assertImplementationDoublesWithin(\
									  (double)(expected) * (double)TEST_DOUBLE_PRECISION,\
									  (double)(expected), (double)(actual), \
									  (unsigned long) __LINE__, __FILE__)


#define TEST_ASSERT_DOUBLE_WITHIN(delta, expected, actual)    \
	assertImplementationDoublesWithin(\
									  (double)(delta),\
									  (double)(expected), (double)(actual), \
									  (unsigned long) __LINE__, __FILE__)

	/* IEC data types*/
#define TEST_ASSERT_EQUAL_REAL(expected, actual)     		TEST_ASSERT_EQUAL_FLOAT(expected, actual)
#define TEST_ASSERT_REAL_WITHIN(delta, expected, actual)    TEST_ASSERT_FLOAT_WITHIN(delta, expected, actual)

#define TEST_ASSERT_EQUAL_LREAL(expected, actual)  			TEST_ASSERT_EQUAL_DOUBLE(expected, actual)
#define TEST_ASSERT_LREAL_WITHIN(delta, expected, actual)	TEST_ASSERT_DOUBLE_WITHIN(delta, expected, actual)


#define TEST_INFO(message)		addInfo(message,0,0);
#define TEST_INFO_POS(message)	addInfo(message,__LINE__,__FILE__)

	/* Returns and signals completion.
	Note: This is a return statement*/
#define TEST_DONE 				return ut_DONE


	/* Returns and signals that this call is not yet completed. Will be called again in next cycle.
	Note: This is a conditional return statement*/
#define TEST_BUSY 				return ut_BUSY

	/* If condition is true: Returns and signals that this call is not yet completed. Will be called again in next cycle.
	Note: This is a conditional return statement */
#define TEST_BUSY_CONDITION(condition) 				if(condition) { 	TEST_BUSY; }
	/* If condition is true: Returns and signals that this call is not yet completed. Will be called again in next cycle.
	A message is reported. 
	Note: This is a conditional return statement*/
#define TEST_BUSY_CONDITION_MSG(condition, msg) 	if(condition) {	TEST_INFO( msg );  TEST_BUSY; }

	/* Returns and signals abortion of current test set.
	No further test case of this set will be executed.
	If available teardown methods will be called before test set is left. 
	Note: This is a return statement*/
#define TEST_ABORT								{addAbort("Test set aborted.",__LINE__,__FILE__);} return ut_ABORT

	/* Returns and signals that this test case is aborted.
	No further test case of this set will be executed.
	If available teardown methods will be called before test set is left.
	A message is reported.
	Note: This is a return statement*/
#define TEST_ABORT_MSG(message)					{addAbort(message,__LINE__,__FILE__);} return ut_ABORT

	/* If condition is true: Returns and signals that this test case is aborted.
	No further test case of this set will be executed.
	If available teardown methods will be called before test set is left. 
	Note: This is a conditional return statement*/
#define TEST_ABORT_CONDITION(condition) 				if(condition) { 	TEST_ABORT; }

	/* If condition is true: Returns and signals that this test case is aborted.
	No further test case of this set will be executed.
	If available teardown methods will be called before test set is left.
	A message is reported 
	Note: This is a conditional return statement*/
#define TEST_ABORT_CONDITION_MSG(condition, msg) 		if(condition) { TEST_ABORT_MSG(msg); }


#ifdef	__cplusplus
}
#endif

#endif/*__ASSERTIMPL_H__*/
