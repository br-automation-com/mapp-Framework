(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: SPLMyCalc
 * File: SPLMyCalc.typ
 * Author: B+R
 ********************************************************************
 * Data types of library SPLMyCalc
 ********************************************************************)

TYPE
	MyCalcOperator_enum : 
		( (*Enumerator of maths operations*)
		splMyCalcOPERATOR_RESET_OUTPUTS := 0, (*Resets the outputs. No calculation*)
		splMyCalcOPERATOR_ADD := 1, (*Add *)
		splMyCalcOPERATOR_SUBTRACT := 2, (*Subtract*)
		splMyCalcOPERATOR_MULTIPLICATION := 3, (*Multiplication*)
		splMyCalcOPERATOR_DIVISION := 4, (*Division*)
		splMyCalcOPERATOR_SQUARE := 5, (*Square of Param 1*)
		splMyCalcOPERATOR_EXP := 6 (*Param1 ^ Param2*)
		);
END_TYPE
