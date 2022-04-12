
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserAuthenticatePassword	(*Check if the password for this user is correct; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		Password		: STRING[128];			(*The password.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		IsAuthentic		: BOOL;					(*Returns TRUE when the password is correct, otherwise FALSE.*)
	END_VAR
	
	VAR
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserAuthenticateToken	(*Check if a (Crypto)Token is assigned to a user and get that username; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		Token		: STRING[128];				(*The Token.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		IsAuthentic		: BOOL;					(*Returns TRUE when the password is correct, otherwise FALSE.*)
		UserName		: STRING[128];			(*The username the RFID-token belongs to.*)
	END_VAR
	
	VAR
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserHasRole	(*Check if the user is assigned the given role; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		RoleName		: STRING[128];			(*The role name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		HasRole			: BOOL;					(*Returns TRUE when the user is assigned the given role, otherwise FALSE.*)
	END_VAR
	
	VAR
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserInitList (*Initialize  the list of user/roles/role assignments; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		ListType		: BYTE;					(*ArUserUSER or ArUserROLE or ArUserUSERROLES.*)
		ElementName		: STRING[128];			(*The username - just necessary for ArUserUSERROLES.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		List			: ArUserIdentType;		(*The identifier for the list.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserGetNext (*Get the next item from the user/roles/role assignments list.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		List			: ArUserIdentType;		(*The identifier for the list.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		ElementName		: STRING[128];			(*The next element in the list.*)
	END_VAR
	
	VAR	
        Internal		: ArUserInternalType;		(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserGetFirst (*Get first item from the user/roles/role assignments list.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		List			: ArUserIdentType;		(*The identifier for the list.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		ElementName		: STRING[128];			(*The first element in the list.*)
	END_VAR
	
	VAR	
        Internal		: ArUserInternalType;		(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserDestroyList (*Frees up the list; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
	END_VAR

	VAR_IN_OUT
		List			: ArUserIdentType;		(*The identifier, returned from ArUserInitList.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserCreate	(*Create a new user; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserDelete(*Delete a user; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserCreateRole	(*Create a new role; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		RoleName		: STRING[128];			(*The role name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserDeleteRole(*Delete a role; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		RoleName		: STRING[128];			(*The role name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserSetPassword	(*Set password; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		Password		: STRING[128];			(*The password.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserSetToken	(*Set authentication Token for a user; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		Token			: STRING[128];			(*The authentication token.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserAssignRole 	(*Assign a role to a user; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		RoleName		: STRING[128];			(*The role name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK 

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserReleaseRole (*Remove a role from a user; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		UserName		: STRING[128];			(*The user name.*)
		RoleName		: STRING[128];			(*The role name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserExport (*Write all users to a file; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		FilePath		: STRING[128];			(*The path of the file to create.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserExportEx (*Write all users to a file located on file device; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		Device			: STRING[128];			(*Name of the file device where the file should be located.*)
		LocalPath		: STRING[128];			(*The path(name) of the file to create.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserImport (*Delete existing users and import users from a file; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		FilePath		: STRING[128];			(*The path of the file to import.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserImportEx (*Delete existing users and import users from a file located on a file device; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		Device			: STRING[128];			(*Name of the file device where the file is located.*)
		LocalPath		: STRING[128];			(*The path(name) of the file to import.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserGetProperty (*Get the Value of a user or role property; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		ElementType		: BYTE;					(*arUSER_USER_PROPERTIES or arUSER_ROLE_PROPERTIES*)
		ElementName		: STRING[128];			(*The username or the rolename.*)
		PropertyName	: STRING[128];			(*The property name.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
		PropertyValue	: STRING[128];			(*The value of the property.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK ArUserSetProperty (*Change the Value of a user or role property, create the property if it does not exist; asynchronous execution.*)
	VAR_INPUT
		Execute			: BOOL;					(*Start execution.*)
		ElementType		: BYTE;					(*arUSER_USER_PROPERTIES or arUSER_ROLE_PROPERTIES*)
		ElementName		: STRING[128];			(*The username or the rolename.*)
		PropertyName	: STRING[128];			(*The property name.*)
		PropertyValue	: STRING[128];			(*The value of the property.*)
	END_VAR
	
	VAR_OUTPUT
		Done			: BOOL;					(*Execution done.*)
		Busy			: BOOL;					(*Execution running.*)
		Error			: BOOL;					(*Execution failed.*)
		ErrorID			: DINT;  				(*Execution error: see help.*)
	END_VAR
	
	VAR	
        Internal		: ArUserAsyncInternalType;(*Internal variable.*)
	END_VAR
END_FUNCTION_BLOCK
