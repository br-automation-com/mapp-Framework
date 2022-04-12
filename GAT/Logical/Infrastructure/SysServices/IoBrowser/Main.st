//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* This program provides an Io browser and the related interface for
//* mappView widgets.
//*********************************************************************************

PROGRAM _INIT
	// Init Io handler 
	GatIoForcingHandler_0.Enable := TRUE;
	GatIoForcingHandler_0.SelectedRefreshMode := TRUE;
	GatIoForcingHandler_0.IoModules := ADR(IoModules);

	// Init refresh selection 
	FOR ChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
		IoModules[0].IoChannels[ChannelIdx].IoForcing.RefreshActualValue := TRUE;
	END_FOR

	// Init Table configs for mappView 
	brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":0,"to":19, "visible":false}]}'));
	brsstrcpy(ADR(TableConfigStations), ADR('{ "specRows": [{"from":0,"to":19, "visible":false}]}'));
	brsstrcpy(ADR(TableConfigChannels), ADR('{ "specRows": [{"from":0,"to":31, "visible":false}]}'));

	// Init pointers 
	IoChannel ACCESS ADR(IoModules[0].IoChannels[0]);
	IoChannelTemp ACCESS ADR(IoModules[0].IoChannels[0]);
END_PROGRAM

PROGRAM _CYCLIC
	// Action to prepare all necessary table configs etc for mappView according to the station/module selection 
	mappViewAction;
	
	// Function block call 
	GatIoForcingHandler_0();
END_PROGRAM

PROGRAM _EXIT
	// Disabled function block call 
	GatIoForcingHandler_0.Enable := FALSE;
	GatIoForcingHandler_0();
END_PROGRAM
