(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: SPLMyCalc
 * File: SPLMyCalc.st
 * Author: B+R
 ********************************************************************
 * Implementation of library SPLMyCalc
 ********************************************************************) 

(* This can be used as a sample for  Test Driven Development (TDD)/ Test First Development
Steps (in a nutshell): 
    o Define your API (FB, functions, ...) 
		 this is already done for the FB MyCalc
	o Create a new test program (by using the template)
	o Write a test case (e.g. Addition) for this FB. 
		The tests should describe the expected behavior.
	o Transfer the test program to the target and run the test in the test view
		The test case will fail
	o Implement this FB (Addition), build and transfer, then run the test again
		The test case will pass
	o Write next test (e.g. Subtraction).
	..
	o Write test for MIN / MAX (underflow/overflow)
   	o Run the tests to verify your implementation. 

Note: 
	The sample test program in SPL_MyCalcLib_C provides some test cases using this FB. 


 *)
FUNCTION_BLOCK MyCalculator

	Status := ERR_NOTIMPLEMENTED;
		
END_FUNCTION_BLOCK






