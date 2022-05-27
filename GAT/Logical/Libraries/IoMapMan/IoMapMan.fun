
{REDUND_UNREPLICABLE} FUNCTION_BLOCK IO_OpenIoMap (*Reads the current IO map and gives an Ident for further reading and modification of the IO map information*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		Ident : {REDUND_UNREPLICABLE} UDINT; (*Ident used by other function blocks to read or modify information of the IO map*)
		NumberOfChannels : {REDUND_UNREPLICABLE} UDINT; (*number of IO channels in the IO map*)
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} IO_OpenIoMap_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK IO_CloseIoMap (*Closes the io map and frees the used memory, After this function block returns ERR_OK, the Ident should not be used anymore*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Ident : {REDUND_UNREPLICABLE} UDINT; (*Ident of the IO map to close*)
		Store : {REDUND_UNREPLICABLE} BOOL; (*If set, the modified information will be stored in the iomap data obj and become active, if not set, any modifications will be lost*)
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} IO_CloseIoMap_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK IO_AddModuleIoChannels (*Adds all IO channels for a Module to the io map*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : {REDUND_UNREPLICABLE} BOOL;
		Ident : {REDUND_UNREPLICABLE} UDINT;
		ModuleName : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
		FileDevice : REFERENCE TO STRING[80];
	END_VAR
	VAR_OUTPUT
		Status : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} IO_AddModuleIoCh_Internal_struct;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION IO_RemoveChannel : BOOL (*Removes a certain channel from the io map*)
	VAR_INPUT
		Ident : UDINT;
		ChannelNumber : UDINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_AddChannel : BOOL (*adds a channel to the io map*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		Type : IO_Type_enum;
		Inverted : BOOL;
		TaskClass : USINT;
		PvName : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
		ChannelName : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

FUNCTION IO_ReadChannel : BOOL (*reads the information of a single  io channel*)
	VAR_INPUT
		Ident : UDINT;
		ChannelNumber : UDINT;
		Type : REFERENCE TO IO_Type_enum;
		Inverted : REFERENCE TO BOOL;
		ChannelName : REFERENCE TO STRING[80];
		PvName : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
		TaskClass : REFERENCE TO USINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_ModifyChannel : BOOL (*modify a single io channel*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ChannelNumber : UDINT;
		Type : IO_Type_enum;
		Inverted : BOOL;
		TaskClass : USINT;
		PvName : REFERENCE TO STRING[80];
		ModulePath : REFERENCE TO STRING[80];
		ChannelName : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_NumberOfChannels : UDINT (*returns the number of io channels in the currently open io map*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_RemoveModuleChannels : BOOL (*removes all channels belonging to a certain module*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_MoveModuleUp : BOOL (*modifies the path of a module (ST+1)*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION IO_MoveModuleDown : BOOL (*modifies the path of a module (ST-1)*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Ident : UDINT;
		ModulePath : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION
