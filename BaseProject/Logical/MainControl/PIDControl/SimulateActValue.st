(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   23 July, 2021/08:47 
 * Simulation of the actual value
 *********************************************************************************)

ACTION SimulateActValue:
	IF SimulationActive THEN
		SimAddValue	:= (SimAddValue * 0.99) + (OutValue * 0.01);
		ActValue		:= (ActValue * 0.9999) + (0.01 * SimAddValue);
	END_IF
END_ACTION
