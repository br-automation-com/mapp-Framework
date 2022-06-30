// Returns True if a manual command is active, false otherwise
FUNCTION ManualCommand
	
	ManualCommand := Commands.JogNegative OR Commands.JogPositive OR Commands.MoveAbsolute OR Commands.MoveAdditive OR Commands.MoveVelocity;
	
END_FUNCTION
