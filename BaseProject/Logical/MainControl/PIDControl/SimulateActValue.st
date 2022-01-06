(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   23 July, 2021/08:47 
 * Simulation of the actual value
 *********************************************************************************)

ACTION SimulateActValue:
	IF bSimulationActive THEN
		rSimAddValue	:= (rSimAddValue * 0.99) + (rOutValue * 0.01);
		rActValue		:= (rActValue * 0.9999) + (0.01 * rSimAddValue);
	END_IF;
END_ACTION
