(* Check divisor for SINT division *)
FUNCTION CheckDivSint
	IF divisor=0 THEN
		CheckDivSint := 1;
		MakeEntry(55555, divisor, 'CheckDivSint');
	ELSE
		CheckDivSint := divisor;
	END_IF
END_FUNCTION

(* Check divisor for USINT division *)
FUNCTION CheckDivUsint
	IF divisor = 0 THEN
		CheckDivUsint := 1;
		MakeEntry(55555, divisor, 'CheckDivUsint');
	ELSE
		CheckDivUsint := divisor;
	END_IF
END_FUNCTION

(* Check divisor for INT division *)
FUNCTION CheckDivInt
	IF divisor = 0 THEN
		CheckDivInt := 1;
		MakeEntry(55555, divisor, 'CheckDivInt');
	ELSE
		CheckDivInt := divisor;
	END_IF
END_FUNCTION

(* Check divisor for UINT division *)
FUNCTION CheckDivUint
	IF divisor = 0 THEN
		CheckDivUint := 1;
		MakeEntry(55555, divisor, 'CheckDivUint');
	ELSE
		CheckDivUint := divisor;
	END_IF
END_FUNCTION

(* Check divisor for DINT division *)
FUNCTION CheckDivDint
	IF divisor = 0 THEN
		CheckDivDint := 1;
		MakeEntry(55555, divisor, 'CheckDivDint');
	ELSE
		CheckDivDint := divisor;
	END_IF
END_FUNCTION

(* Check divisor for UDINT division *)
FUNCTION CheckDivUdint
	IF divisor = 0 THEN
		CheckDivUdint := 1;
		MakeEntry(55555, divisor, 'CheckDivUdint');
	ELSE
		CheckDivUdint := divisor;
	END_IF
END_FUNCTION

(* Check divisor for REAL division *)
FUNCTION CheckDivReal
	IF divisor = 0 THEN
		CheckDivReal := 1;
		MakeEntry(55555, 0, 'CheckDivReal');
	ELSE
		CheckDivReal := divisor;
	END_IF
END_FUNCTION

(* Check divisor for LREAL division *)
FUNCTION CheckDivLReal
	IF divisor = 0 THEN
		CheckDivLReal := 1;
		MakeEntry(55555, 0, 'CheckDivLReal');
	ELSE
		CheckDivLReal := divisor;
	END_IF
END_FUNCTION

(* Check range for array access *)
FUNCTION CheckBounds
	IF index < lower THEN
		CheckBounds := lower;
		MakeEntry(55555, index, 'CheckBounds');
	ELSIF index > upper THEN
		CheckBounds := upper;
		MakeEntry(55555, index, 'CheckBounds');
	ELSE
		CheckBounds := index;
	END_IF
END_FUNCTION

(* Check range for enumeration *)
FUNCTION CheckRange
	IF value < lower THEN
		CheckRange := lower;
		MakeEntry(55555, value, 'CheckRange');
	ELSIF value > upper THEN
		CheckRange := upper;
		MakeEntry(55555, value, 'CheckRange');
	ELSE
		CheckRange := value;
	END_IF
END_FUNCTION

(* Check range for subrange of signed data types *)
FUNCTION CheckSignedSubrange
	IF value < lower THEN
		CheckSignedSubrange := lower;
		MakeEntry(55555, value, 'CheckSignedSubrange');
	ELSIF value > upper THEN
		CheckSignedSubrange := upper;
		MakeEntry(55555, value, 'CheckSignedSubrange');
	ELSE
		CheckSignedSubrange := value;
	END_IF
END_FUNCTION

(* Check range for subrange of unsigned data types *)
FUNCTION CheckUnsignedSubrange
	IF value < lower THEN
		CheckUnsignedSubrange := lower;
		MakeEntry(55555, value, 'CheckUnsignedSubrange');
	ELSIF value > upper THEN
		CheckUnsignedSubrange := upper;
		MakeEntry(55555, value, 'CheckUnsignedSubrange');
	ELSE
		CheckUnsignedSubrange := value;
	END_IF
END_FUNCTION

(* Check address when reading dynamic variables *)
FUNCTION CheckReadAccess
	IF address = 0 THEN
		(* TODO: Insert an appropriate code, see AutomationStudio help for further information *)
		MakeEntry(55555, address, 'Read from NULL');
	END_IF

	CheckReadAccess := 0;
END_FUNCTION

(* Check address when writing dynamic variables *)
FUNCTION CheckWriteAccess
	IF address = 0 THEN
		(* TODO: Insert an appropriate code, see AutomationStudio help for further information *)
		MakeEntry(55555, address, 'Write to NULL');
	END_IF

	CheckWriteAccess := 0;
END_FUNCTION

(* Makes an entry (log book entry) in the error log book *)
FUNCTION MakeEntry
    status_name := ST_name(0, ADR(taskname), ADR(group));
    brsstrcpy(ADR(out_text), ADR(text));
    brsstrcat(ADR(out_text), ADR(' > in task > '));
    brsstrcat(ADR(out_text), ADR(taskname));
    MakeEntry := ADR(out_text);
    ERRxwarning(number, index, ADR(out_text));
    // force page fault to get back trace
    brsmemcpy(0, 0, 1);
END_FUNCTION
