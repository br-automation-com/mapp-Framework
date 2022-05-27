
{REDUND_ERROR} FUNCTION GatDegreeToDistance : REAL (*This function translates a given degree and radius to the corresponding length on a linear axis*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Degree : REAL;
		Radius : REAL;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK GatIoForcingHandler
	VAR_INPUT
		Enable : BOOL; (*Enable of function block*)
		IoModules : REFERENCE TO ARRAY[0..gatMAX_IDX_IO_MODULES] OF GatIoModulesType; (*Reference to Module array*)
		SelectedRefreshMode : BOOL; (*Optional: Only selecteded channels will be refreshed: Depending on the number of IO channels in the project, this may greatly improve the performance*)
		ResetAllForcing : BOOL; (*Reset forcing on all io channels*)
	END_VAR
	VAR_OUTPUT
		Initializing : BOOL; (*Function block is initializing the module and Io structure*)
		Ready : BOOL; (*Initialization is complete, Io channels can be forced now*)
		CommandBusy : BOOL; (*Command is busy*)
		CommandDone : BOOL; (*Command is done*)
	END_VAR
	VAR
		Internal : GatIoForcHandInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION GatIoIsVisible : BOOL
	VAR_INPUT
		ChannelName : REFERENCE TO STRING[80];
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION GatMakeIoDpName : BOOL (*Creates the IO data point name from the given information*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IoChannel : GatIoChannelType;
		DpName : REFERENCE TO STRING[100];
	END_VAR
END_FUNCTION
