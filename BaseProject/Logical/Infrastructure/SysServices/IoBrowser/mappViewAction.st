(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Author:    MITC
 * Created:   September 29, 2021/09:24 
 * This action sets all the strings and pointers so that the mappView page can 
 * present the IO information in a user friendly way
 *********************************************************************************)

ACTION mappViewAction: 
	(* Set pointers to the correct Forcing handler for easier interface to HMI *)
	IF (SelectedModule <> LastSelectedModule) OR (SelectedChannel <> LastSelectedChannel) THEN
		(* Check range *)
		IF (SelectedModule <= gatMAX_IDX_IO_MODULES) AND (SelectedChannel <= gatMAX_IDX_IO_MODULES) THEN
			IF SelectedChannel >= IoModules[SelectedModule].NrOfIoChannels THEN
				SelectedChannel := 0;
			END_IF
			IoChannel ACCESS ADR(IoModules[SelectedModule].IoChannels[SelectedChannel]);
			IoChannelTemp ACCESS ADR(IoModules[SelectedModule].IoChannels[SelectedChannel]);
			brsmemset(ADR(IoChannelList), 0, SIZEOF(IoChannelList));
			brsmemset(ADR(IoPvList), 0, SIZEOF(IoPvList));
			brsmemset(ADR(IoValueList), 0, SIZEOF(IoValueList));
			brsmemset(ADR(TableConfigChannels), 0, SIZEOF(TableConfigChannels));
			FOR ChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
				brsstrcpy(ADR(IoChannelList[ChannelIdx]), ADR(IoModules[SelectedModule].IoChannels[ChannelIdx].ChannelName));
				IF brsstrlen(ADR(IoChannelList[ChannelIdx])) = 0 THEN
					(* Configure visible table entries *)
					brsstrcpy(ADR(TableConfigChannels), ADR('{ "specRows": [{"from":'));
					brsitoa(ChannelIdx, ADR(TableConfigChannels) + brsstrlen(ADR(TableConfigChannels)));
					brsstrcat(ADR(TableConfigChannels),  ADR(',"to":31, "visible":false}]}'));
					EXIT;
				END_IF
				brsstrcpy(ADR(IoPvList[ChannelIdx]), ADR('$$IAT/Audit/DP/'));
				IF brsstrlen(ADR(IoModules[SelectedModule].IoChannels[ChannelIdx].PvName)) = 0 THEN
					brsstrcat(ADR(IoPvList[ChannelIdx]), ADR('None'));
				ELSE
					brsstrcat(ADR(IoPvList[ChannelIdx]), ADR(IoModules[SelectedModule].IoChannels[ChannelIdx].PvName));
				END_IF
			END_FOR
			LastSelectedModule := SelectedModule;
			LastSelectedChannel := SelectedChannel;
		END_IF
		(* Set Io refresh flags *)
		FOR ModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			FOR ChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
				IoModules[ModuleIdx].IoChannels[ChannelIdx].IoForcing.RefreshActualValue := (ModuleIdx = SelectedModule);
			END_FOR
		END_FOR
	END_IF
	
	(* Update IO values *)
	FOR ChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
		IF IoModules[SelectedModule].IoChannels[ChannelIdx].IoForcing.ActualValue > 32767 THEN
			IoValueList[ChannelIdx] := IoModules[SelectedModule].IoChannels[ChannelIdx].IoForcing.ActualValue - 65536;
		ELSE
			IoValueList[ChannelIdx] := IoModules[SelectedModule].IoChannels[ChannelIdx].IoForcing.ActualValue;
		END_IF
		CASE IoModules[SelectedModule].IoChannels[ChannelIdx].Type OF
			IO_DIG_INPUT, IO_DIG_OUTPUT:
				IF (IoModules[SelectedModule].IoChannels[ChannelIdx].IoForcing.ActualValue = 1) THEN
					brsstrcpy(ADR(IoValueListString[ChannelIdx]), ADR('ON'));
				ELSE
					brsstrcpy(ADR(IoValueListString[ChannelIdx]), ADR('OFF'));
				END_IF
			IO_ANA_INPUT, IO_ANA_OUTPUT, IO_PWM_OUTPUT:
				brsftoa(DINT_TO_REAL(REAL_TO_DINT(DINT_TO_REAL(IoValueList[ChannelIdx]) / 32.767)) / 10, ADR(IoValueListString[ChannelIdx]));
				brsstrcat(ADR(IoValueListString[ChannelIdx]), ADR(' %'));
			IO_TEMP_INPUT:
				brsftoa(DINT_TO_REAL(IoValueList[ChannelIdx]) / 10, ADR(IoValueListString[ChannelIdx]));
				brsstrcat(ADR(IoValueListString[ChannelIdx]), ADR(' C'));
			ELSE
				brsitoa(IoValueList[ChannelIdx], ADR(IoValueListString[ChannelIdx]));
		END_CASE
	END_FOR
	
	(* Init Io Module list when handler is ready *)
	IF EDGEPOS(GatIoForcingHandler_0.Ready) THEN
		brsmemset(ADR(TableConfigStations), 0, SIZEOF(TableConfig));
		brsmemset(ADR(StationList), 0, SIZEOF(StationList));
		(* Init station list *)
		FOR ModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			IF FIND(RIGHT(IoModules[ModuleIdx].ModulePath, 6), '.') > 0 THEN
				brsmemset(ADR(TempStationPath), 0, SIZEOF(TempStationPath));
				brsstrcpy(ADR(TempStationPath), ADR('$$IAT/IoStations/'));
				brsmemcpy(ADR(TempStationPath) + brsstrlen(ADR(TempStationPath)), ADR(IoModules[ModuleIdx].ModulePath), brsstrlen(ADR(IoModules[ModuleIdx].ModulePath)) - 7 + FIND(RIGHT(IoModules[ModuleIdx].ModulePath, 6), '.'));
			END_IF
			FOR StationIdx := 0 TO gatMAX_IDX_IO_MODULES DO
				IF brsstrcmp(ADR(StationList[StationIdx]), ADR(TempStationPath)) = 0 THEN
					(* Station already registered *)
					EXIT;
				END_IF
				IF brsstrlen(ADR(StationList[StationIdx])) = 0 THEN
					(* Reached end of list, add new station *)
					brsstrcpy(ADR(StationList[StationIdx]), ADR(TempStationPath));
					EXIT;
				END_IF
			END_FOR
		END_FOR
		(* Set station table configuration *)
		FOR StationIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			IF brsstrlen(ADR(StationList[StationIdx])) = 0 THEN
				brsstrcpy(ADR(TableConfigStations), ADR('{ "specRows": [{"from":'));
				brsitoa(StationIdx, ADR(TableConfigStations) + brsstrlen(ADR(TableConfigStations)));
				brsstrcat(ADR(TableConfigStations),  ADR(',"to":'));
				brsstrcat(ADR(TableConfigStations),  ADR('19, "visible":false}]}'));
				EXIT;
			END_IF
		END_FOR
		(* Trigger station selection *)
		SelectedStationIndex := 0;
		LastSelectedStationIndex := 1;
	END_IF
	
	(* Init Module list after station selection *)
	IF SelectedStationIndex <> LastSelectedStationIndex THEN
		brsmemset(ADR(TableConfig), 0, SIZEOF(TableConfig));
		brsmemset(ADR(ModuleList), 0, SIZEOF(ModuleList));
		brsmemset(ADR(SelectedStation), 0, SIZEOF(SelectedStation));
		brsstrcpy(ADR(SelectedStation), ADR(StationList[SelectedStationIndex]) + brsstrlen(ADR('$$IAT/IoStations/')));
		(* Init module list *)
		brsmemset(ADR(TableConfig), 0, SIZEOF(TableConfig));
		LastModuleInvisible := FALSE;
		FOR ModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			brsstrcpy(ADR(ModuleList[ModuleIdx]), ADR(IoModules[ModuleIdx].ModuleName));
			IF (FIND(IoModules[ModuleIdx].ModulePath, SelectedStation) = 0) THEN
				(* Wrong station, make station invisible *)
				IF NOT LastModuleInvisible THEN
					IF brsstrlen(ADR(TableConfig)) = 0 THEN
						brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":'));
					ELSE
						brsstrcat(ADR(TableConfig), ADR(', {"from":'));
					END_IF
					brsitoa(ModuleIdx, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
					brsstrcat(ADR(TableConfig),  ADR(',"to":'));
				END_IF
				LastModuleInvisible := TRUE;
			ELSE
				(* Correct station, make module visible and select it if it's the first module of the station *)
				IF SelectedModule = LastSelectedModule THEN
					SelectedModule := ModuleIdx;
					LastSelectedModule := SelectedModule + 1;
				END_IF
				IF LastModuleInvisible THEN
					brsitoa(ModuleIdx - 1, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
					brsstrcat(ADR(TableConfig),  ADR(', "visible":false}'));
				END_IF
				LastModuleInvisible := FALSE;
			END_IF
			IF brsstrlen(ADR(ModuleList[ModuleIdx])) = 0 THEN
				(* Reached end of modules, make rest of list invisible *)
				IF NOT LastModuleInvisible THEN
					IF brsstrlen(ADR(TableConfig)) = 0 THEN
						brsstrcpy(ADR(TableConfig), ADR('{ "specRows": [{"from":'));
					ELSE
						brsstrcat(ADR(TableConfig), ADR(', {"from":'));
					END_IF
					brsitoa(ModuleIdx, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
					brsstrcat(ADR(TableConfig),  ADR(',"to":'));
				END_IF
				brsstrcat(ADR(TableConfig),  ADR('19, "visible":false}]}'));
				EXIT;
			ELSIF ModuleIdx = gatMAX_IDX_IO_MODULES THEN
				(* Reached end of modules, close table config *)
				IF LastModuleInvisible THEN
					brsitoa(ModuleIdx, ADR(TableConfig) + brsstrlen(ADR(TableConfig)));
					brsstrcat(ADR(TableConfig), ADR(', "visible":false}]}'));
				ELSE
					brsstrcat(ADR(TableConfig), ADR(']}'));
				END_IF
			END_IF
		END_FOR
	END_IF
	LastSelectedStationIndex := SelectedStationIndex;
END_ACTION
