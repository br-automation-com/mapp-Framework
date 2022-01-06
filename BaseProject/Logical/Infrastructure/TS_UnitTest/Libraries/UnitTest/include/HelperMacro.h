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
 * $Id: HelperMacro.h,v 1.3 2004/02/10 16:19:29 arms22 Exp $
 */


#ifndef	__HELPERMACRO_H__
#define	__HELPERMACRO_H__




/* Defines the order of test cases */
#define UNITTEST_FIXTURES(fixtures) \
	static const TestFixture	fixtures[] =

/* Standard UnitTest caller without any setup / teardown methods*/
#define UNITTEST_CALLER_TEST(caller,name,fixtures) \
	UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,0,0,fixtures,0,0, 0)

/* Standard UnitTest caller with macro setup / teardown for tests*/
#define UNITTEST_CALLER_BASIC(caller,name,fixtures) \
	UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,setupTest,teardownTest,fixtures,0,0, 0)

/* UnitTest caller with macro setup / teardown for tests and test set */
#define UNITTEST_CALLER_SET(caller,name,fixtures) \
	UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,setupTest,teardownTest,fixtures, setupSet, teardownSet, 0)


/* UnitTest caller with macro setup / teardown for tests and test set and cylic*/
#define UNITTEST_CALLER_COMPLETE(caller,name,fixtures) \
	UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,setupTest,teardownTest,fixtures, setupSet, teardownSet, cyclicSetCaller)


/* UnitTest caller with explicit setup / teardown for suite */
#define UNITTEST_CALLER_SET_EXPLICIT(caller,name,sup,tdw,fixtures, setupSuite, teardownSuite) \
	UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,sup,tdw,fixtures, setupSuite, teardownSuite, 0)



#ifdef  __cplusplus
/* UnitTest caller with explicit setup / teardown for suite and cylic */
#define UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,sup,tdw,fixtures, setupSuite, teardownSuite, cyclicCaller) \
	UNITTEST_TESTSET_DECLARATION caller = new_TestCaller(name,sup,tdw,sizeof(fixtures)/sizeof(fixtures[0]),(TestFixture*)fixtures, setupSuite, teardownSuite, cyclicCaller)

#else

/* UnitTest caller with explicit setup / teardown for suite and cylic */
#define UNITTEST_CALLER_COMPLETE_EXPLICIT(caller,name,sup,tdw,fixtures, setupSuite, teardownSuite, cyclicCaller) \
	 const TestCaller caller = new_TestCaller(name,sup,tdw,sizeof(fixtures)/sizeof(fixtures[0]),(TestFixture*)fixtures, setupSuite, teardownSuite, cyclicCaller)

#endif

#define UNITTEST_CALLER_SKIPPED(caller,name,sup,tdw,fixtures, setupSuite, teardownSuite, cyclicCaller) \
 const TestCaller caller = skipTestCaller(name,sup,tdw,sizeof(fixtures)/sizeof(fixtures[0]),(TestFixture*)fixtures, setupSuite, teardownSuite, cyclicCaller)

/* --------------------------------------*/



/* --------------------------------------*/


typedef struct TestSetActive
{
	BOOL			active;
	TestCallerRef 	set;
} TestSetActive;

typedef struct TestSetList
{
	UINT 			nrOfTestSets;
	UINT 			currentTestSet;
	TestSetActive 	*list;
} TestSetList;



/* Defines the order of test sets.
Should look like this
UNITTEST_TESTSET_FIXTURES(fixtures)
{
	new_TestSet(testSet_1),
	new_TestSet(testSet_2),
	new_TestSet(testSet_3)
}*/
#define UNITTEST_TESTSET_FIXTURES(fixtures) \
	static TestSetActive	fixtures[] =


/* Adds a test set with description to the fixture of test sets.
See UNITTEST_TESTSET_FIXTURES() */
#define new_TestSet(testcaller)\
	{\
		1,\
		(TestCallerRef)&testcaller,\
	}

/* Adds a test set with description to the fixture of test sets.
See UNITTEST_TESTSET_FIXTURES() */
#define skipTestSet(testcaller)\
	{\
		1,\
		(TestCallerRef)&testcaller,\
	}

/* Adds a test set with description to the fixture of test sets.
See UNITTEST_TESTSET_FIXTURES() */
#define disabledTestSet(testcaller)\
	{\
		0,\
		(TestCallerRef)&testcaller,\
	}


/* Defines the test set list handling structure*/
#define UNTITTEST_TESTSET_HANDLER() \
TestSetList setList = {\
	sizeof(utTestSets) / sizeof(TestSetActive), \
	0, \
	(TestSetActive*)&utTestSets\
	}




#endif/*__HELPERMACRO_H__*/
