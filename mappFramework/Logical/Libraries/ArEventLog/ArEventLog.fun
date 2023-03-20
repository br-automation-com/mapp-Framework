
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogCreate		(*creates an event log module; asynchronous execution *)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Name			: STRING[256];				(*name of the event log module*)
		Size			: UDINT;					(*size of the event log module*)
		Persistence		: USINT;					(*persistence type of the log module*)
		Info			: UDINT;					(*format of the additional data*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Busy			: BOOL;						(*execution running*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module*)
	END_VAR

	VAR
        Internal		: ArEventLogAsyncInternalType;(*internal variable*)
	END_VAR		
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogDelete		(*deletes an event log module; asynchronous execution *)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Busy			: BOOL;						(*execution running*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
	END_VAR

	VAR
        Internal		: ArEventLogAsyncInternalType;(*internal variable*)
	END_VAR		
END_FUNCTION_BLOCK
 
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogGetIdent		(*gets identifier of an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Name			: STRING[256];				(*name of the event log module*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		Ident			: ArEventLogIdentType;		(*identifier of the event log module*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR	
END_FUNCTION_BLOCK
 
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogWrite		(*writes a log entry to an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		EventID			: DINT;						(*event id of the log entry*)
		OriginRecordID	: ArEventLogRecordIDType;	(*record id of basic cause of error/warning, or 0*)
		ObjectID		: STRING[36];				(*object id - string of maximum 35 characters, string length of 0 object id is generated internally*)
		AddDataSize		: UDINT;					(*size of the additional data, or 0 (no additional data)*)
		AddDataFormat	: USINT;					(*format of the additional data*)
		AddData			: UDINT;					(*additional data of the entry given as pointer, or 0 (no additional data)*)
		TimeStamp		: UDINT;					(*external timestamp given as pointer to ArEventLogTimeStampType, or 0 (timestamp is taken internally)*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		RecordID		: ArEventLogRecordIDType;	(*id of current record*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR		
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogGetLatestRecordID		(*gets latest record id*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		RecordID		: ArEventLogRecordIDType;	(*latest record id to read*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR		
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogGetPreviousRecordID		(*gets previous record id*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*current record id*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		PrevRecordID	: ArEventLogRecordIDType;	(*previous record id to read*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR		
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogRead		(*reads a log entry from an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*record id to read*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		EventID			: DINT;						(*event id of the log entry*)
		OriginRecordID	: ArEventLogRecordIDType;	(*record id of basic cause of error/warning, or 0*)
		AddDataFormat	: USINT;					(*format of the additional data*)
		AddDataSize		: UDINT;					(*size of the additional data*)
		TimeStamp		: ArEventLogTimeStampType;	(*timestamp*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogReadDescription		(*reads a description of an event id*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*record id to read*)
		LanguageCode	: ArEventLogLanguageCodeType;(*language id of description*)
		Qualifier		: STRING[250];				(*additional qualifier - reserved for future use*)
		TextBuffer		: UDINT;					(*buffer for description*)
		TextBufferSize	: UDINT;					(*maximum description size*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Busy			: BOOL;						(*execution running*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		TextSize		: UDINT;					(*size of description (including 0-termination)*)
	END_VAR

	VAR
        Internal		: ArEventLogAsyncInternalType; (*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogReadErrorNumber		(*reads an error number log entry from an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*record id to read*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		ErrorNumber		: UDINT;					(*error number of the log entry*)
		Severity		: USINT;					(*severity of the log entry*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogReadAddData		(*reads the additional data from an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*record id to read*)
		AddData			: UDINT;					(*buffer for additional data given as pointer*)
		BytesToRead		: UDINT;					(*buffer size for additional data*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution status: see help*)
		AddDataSize		: UDINT;					(*size of the additional data*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR	
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArEventLogReadObjectID		(*reads the object id from an event log module*)
	VAR_INPUT
		Execute			: BOOL;						(*enables execution*)
		Ident			: ArEventLogIdentType;		(*ident for the event log module to be written*)
		RecordID		: ArEventLogRecordIDType;	(*record id to read*)
	END_VAR

	VAR_OUTPUT
		Done			: BOOL;						(*execution done*)
		Error			: BOOL;						(*execution failed*)
		StatusID		: DINT;  					(*execution error: see help*)
		ObjectID		: STRING[36];				(*object id - string of maximum 35 characters*)
	END_VAR

	VAR
        Internal		: ArEventLogInternalType;	(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION ArEventLogMakeEventID	: DINT		(*makes an event id*)
	VAR_INPUT
		Severity		: USINT;					(*severity code of event id*)
		Facility		: UINT;						(*facility of event id*)
		ErrorCode		: UINT;						(*error code of event id*)
	END_VAR
END_FUNCTION

{REDUND_OK} FUNCTION ArEventLogIsError	: BOOL		(*returns true if event id is an error entry*)
	VAR_INPUT
		EventID			: DINT;			(*event id*)
	END_VAR
END_FUNCTION

{REDUND_OK} FUNCTION ArEventLogIsWarning	: BOOL		(*returns true if event id is a warning entry*)
	VAR_INPUT
		EventID			: DINT;			(*event id*)
	END_VAR
END_FUNCTION

{REDUND_OK} FUNCTION ArEventLogIsInformation	: BOOL		(*returns true if event id is a information entry*)
	VAR_INPUT
		EventID			: DINT;			(*event id*)
	END_VAR
END_FUNCTION

{REDUND_OK} FUNCTION ArEventLogIsSuccess	: BOOL		(*returns true if event id is a success entry*)
	VAR_INPUT
		EventID			: DINT;			(*event id*)
	END_VAR
END_FUNCTION

{REDUND_OK} FUNCTION ArEventLogIsCustomerArea	: BOOL		(*returns true if the customer flag of the event id is set*)
	VAR_INPUT
		EventID			: DINT;			(*event id*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ArEventLogAddDataInit	: BOOL	(*returns true on success, false on failure*)
	VAR_INPUT
		Buffer			: UDINT;		(*buffer for additional event log data*)
		BufferSize		: UDINT;		(*buffer size*)
		Format			: USINT;		(*format of the additional data*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ArEventLogAddDataUdint	: BOOL	(*returns true on success, false on failure*)
	VAR_INPUT
		Buffer			: UDINT;		(*buffer for additional event data*)
		BufferSize		: UDINT;		(*buffer size*)
		Value			: UDINT;		(*UDINT value*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ArEventLogAddDataDint	: BOOL	(*returns true on success, false on failure*)
	VAR_INPUT
		Buffer			: UDINT;		(*buffer for additional event data*)
		BufferSize		: UDINT;		(*buffer size*)
		Value			: DINT;			(*DINT value*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ArEventLogAddDataString : BOOL	(*returns true on success, false on failure*)
	VAR_INPUT
		Buffer			: UDINT;		(*buffer for additional event log data*)
		BufferSize		: UDINT;		(*buffer size*)
		Value			: UDINT;		(*STRING value, given as pointer to null terminated string*)
	END_VAR
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION ArEventLogAddDataQuantity : BOOL	(*returns true on success, false on failure*)
	VAR_INPUT
		Buffer			: UDINT;		(*buffer for additional event log data*)
		BufferSize		: UDINT;		(*buffer size*)
		Value			: LREAL;		(*LREAL value*)
		UnitID			: DINT;			(*unit ID, -1 no unit*)
		NamespaceURI	: UDINT;		(*namespace URI given as pointer to null terminated string, null is default namespace (CEFACT)*)
	END_VAR
END_FUNCTION
