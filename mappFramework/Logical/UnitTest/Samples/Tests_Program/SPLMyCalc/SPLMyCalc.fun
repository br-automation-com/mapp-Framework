(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: SPLMyCalc
 * File: MyCalc.fun
 * Author: B+R
 ********************************************************************
 * Functions and function blocks of library SPLMyCalc
 ********************************************************************)

FUNCTION_BLOCK MyCalculator (*This functionblock provides several operations. If result is bigger / smaller than MIN or MAX, MIN or MAX are returned.*)
	VAR_INPUT
		CalcOperator : MyCalcOperator_enum; (*Calculation operation*)
		Param1 : INT; (*Paramerter 1*)
		Param2 : INT; (*Paramerter 2*)
	END_VAR
	VAR_OUTPUT
		Status : UINT; (*execution status: ERR_OK, ... *)
		Result : DINT; (*Result of the operation*)
	END_VAR
END_FUNCTION_BLOCK
