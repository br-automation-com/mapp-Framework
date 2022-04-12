
{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AR_OpenArCfg (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		Ident : {REDUND_UNREPLICABLE} UDINT;
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} AR_OpenArCfg_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AR_CloseArCfg (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Ident : {REDUND_UNREPLICABLE} UDINT;
		Store : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} AR_CloseArCfg_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AR_AddModule (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Ident : {REDUND_UNREPLICABLE} UDINT;
		ModuleName : REFERENCE TO STRING[80];
		FileDevice : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} AR_AddModule_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AR_GetModuleParInfo (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		mappViewDataProvider : {REDUND_UNREPLICABLE} BOOL; (*if FALSE, the value list array will be filled with only the value names; if TRUE, the array will be filled in the format of a mappView data provider (e.g. for a listbox widget)*)
		ModuleName : REFERENCE TO STRING[80];
		FileDevice : REFERENCE TO STRING[80];
		ParameterCfg : REFERENCE TO AR_ModuleParameterCfg_struct;
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} AR_GetModuleParInfo_Int_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK AR_AvailableModules (*Writes the list of available modules into the given array of strings*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		mappViewDataProvider : {REDUND_UNREPLICABLE} BOOL; (*if FALSE, the array will be filled with only the module names; if TRUE, the array will be filled in the format of a mappView data provider (e.g. for a listbox widget)*)
		FileDevice : REFERENCE TO STRING[30];
		ListOfAvailableModules : REFERENCE TO STRING[AR_MODULE_NAME_LEN];
		ListLength : {REDUND_UNREPLICABLE} USINT;
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} AR_AvailableModules_Int_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION AR_NumberOfModules : UDINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_RemoveModule : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_ReadParameter : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
		Parameter : REFERENCE TO STRING[80];
		ParameterValue : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_WriteParameter : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
		Parameter : REFERENCE TO STRING[80];
		ParameterValue : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_GetModuleInfo : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModuleNumber : UDINT;
		ModuleName : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_MoveModuleUp : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AR_MoveModuleDown : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION
