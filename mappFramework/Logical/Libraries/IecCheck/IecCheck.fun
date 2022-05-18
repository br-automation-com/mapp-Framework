FUNCTION CheckDivSint : SINT (* Check divisor for SINT division *)
	VAR_INPUT
		divisor : SINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivUsint : USINT (* Check divisor for USINT division *)
	VAR_INPUT
		divisor : USINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivInt : INT (* Check divisor for INT division *)
	VAR_INPUT
		divisor : INT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivUint : UINT (* Check divisor for UINT division *)
	VAR_INPUT
		divisor : UINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivDint : DINT (* Check divisor for DINT division *)
	VAR_INPUT
		divisor : DINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivUdint : UDINT (* Check divisor for UDINT division *)
	VAR_INPUT
		divisor : UDINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivReal : REAL (* Check divisor for REAL division *)
	VAR_INPUT
		divisor : REAL;
	END_VAR
END_FUNCTION

FUNCTION CheckDivLReal : LREAL (* Check divisor for LREAL division, not available for SG3 and SGC *)
	VAR_INPUT
		divisor : LREAL;
	END_VAR
END_FUNCTION

FUNCTION CheckBounds : DINT (* Check range for array access *)
	VAR_INPUT
		index : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
END_FUNCTION

FUNCTION CheckRange : DINT (* Check range for enumeration *)
	VAR_INPUT
		value : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
END_FUNCTION

FUNCTION CheckSignedSubrange : DINT (* Check range for subrange of signed data types *)
	VAR_INPUT
		value : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
END_FUNCTION

FUNCTION CheckUnsignedSubrange : UDINT (* Check range for subrange of unsigned data types *)
	VAR_INPUT
		value : UDINT;
		lower : UDINT;
		upper : UDINT;
	END_VAR
END_FUNCTION

FUNCTION CheckReadAccess : UDINT (* Check address when reading dynamic variables *)
	VAR_INPUT
		address : UDINT;
	END_VAR
END_FUNCTION

FUNCTION CheckWriteAccess : UDINT (* Check address when writing dynamic variables *)
	VAR_INPUT
		address : UDINT;
	END_VAR
END_FUNCTION

FUNCTION MakeEntry : UDINT (* Makes an entry (log book entry) in the error log book *)
	VAR
		taskname : STRING[30];
		group : USINT;
		status_name : UINT;
		out_text : STRING[80];
	END_VAR
	VAR_INPUT
		number : UINT;
		index : DINT;
		text : STRING[50];
	END_VAR
END_FUNCTION
