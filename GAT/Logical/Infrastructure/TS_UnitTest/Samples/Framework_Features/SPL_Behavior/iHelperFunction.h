/********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SPL_Behavior
 * File: iHelperFunction.h
 * Author: B+R
 *******************************************************************/

#include <bur/plctypes.h>


#include "iPrototypes.h"

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_CYCLIC_SET  \
	brsstrcat((UDINT)OutputString, (UDINT)"Cyclic set - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); \
	CounterInSet++;

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEST_CASE_1   \
	brsstrcat((UDINT)OutputString,(UDINT) "Call test 1 - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); 
	

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEST_CASE_2 \
	brsstrcat((UDINT)OutputString,(UDINT) "Call test 2 - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); 

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEST_CASE_3   \
	brsstrcat((UDINT)OutputString,(UDINT) "Call test 3 - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); 
	


/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_SETUP_SET  \
	brsstrcat((UDINT)OutputString, (UDINT)"Setup set - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__);
	

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEARDOWN_SET  \
	brsstrcat((UDINT)OutputString, (UDINT)"Teardown set - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); 
	

 /* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_SETUP_TEST \
	brsstrcat((UDINT)OutputString, (UDINT)"Setup test - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__);
	

/* This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEARDOWN_TEST  \
	brsstrcat((UDINT)OutputString, (UDINT)"Teardown test - "); \
	checkAndWriteCounterIfChanged(__LINE__, __FILE__); 


/* ************************************************/

/* Add this line behind a LOG_FOR_EXEMPLIFICATION_TEST_CASE_x to simulate an asyncron test case
 This Macro is for tracing the calls in the sample 
(For exemplification)*/
#define LOG_FOR_EXEMPLIFICATION_TEST_BUSY  if(CountTestCaseRuns < DEF_BUSY_STEPS)\
	{\
	countTestCaseRuns++; \
	brsstrcat((UDINT)OutputString,(UDINT) "TEST_BUSY (recall in next cycle) - "); \
	TEST_BUSY; } \
	else { CountTestCaseRuns = 0;}




