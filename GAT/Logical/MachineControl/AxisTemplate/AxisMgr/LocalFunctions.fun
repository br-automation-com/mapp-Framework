
{REDUND_ERROR} FUNCTION ManualCommand : BOOL (*Returns True if a manual command is active, false otherwise*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Commands : AxisControlCommandType;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION AutomaticCommand : BOOL (*Returns True if an automatic command is active*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Commands : AxisControlCommandType;
	END_VAR
END_FUNCTION
