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
 * $Id: TestCaller.h,v 1.7 2004/02/10 16:19:29 arms22 Exp $
 */
#ifndef	__TESTCALLER_H__
#define	__TESTCALLER_H__

typedef struct __TestFixture	TestFixture;
typedef struct __TestFixture	*TestFixtureRef;/*downward compatible*/


struct __TestFixture
{
	const char *name;
	unsigned long mode;
	testStatusEnum (*test)(void);
};

#define new_TestFixture(name,test)\
	{\
		name,\
		1,\
		test\
	}

#define skipTestFixture(name,test)\
	{\
		name,\
		0,\
		test\
	}

typedef struct __TestCaller		TestCaller;
typedef struct __TestCaller	*TestCallerRef;/*downward compatible*/


struct __TestCaller
{
	TestImplement *isa;
	const  char					*name;
	testStateEnum 				state;
	char 						abort;
	testStatusEnum				(*setUp)(void);
	testStatusEnum				(*tearDown)(void);
	unsigned int 				numberOfFixtuers;
	TestFixture					*fixtuers;
	testStatusEnum				(*setUpSuite)(void);
	testStatusEnum				(*tearDownSuite)(void);
	/* per Set, called in each cycle */
	void 						(*cyclicSetCaller)(void);
	unsigned long				mode;
};

extern const TestImplement TestCallerImplement;

#define new_TestCaller(name,sup,tdw,numberOfFixtuers,fixtuers,setupSuite,teardownSuite, cyclicSuite )\
	{\
		(TestImplement*)&TestCallerImplement,\
		name,\
		stateStart,\
		0,\
		sup,\
		tdw,\
		numberOfFixtuers,\
		fixtuers,\
		setupSuite,\
		teardownSuite,\
		cyclicSuite,\
		1\
	}

#define skipTestCaller(name,sup,tdw,numberOfFixtuers,fixtuers,setupSuite,teardownSuite, cyclicSuite )\
	{\
		(TestImplement*)&TestCallerImplement,\
		name,\
		stateStart,\
		0,\
		sup,\
		tdw,\
		numberOfFixtuers,\
		fixtuers,\
		setupSuite,\
		teardownSuite,\
		cyclicSuite,\
		0\
	}


#endif/*__TESTCALLER_H__*/
