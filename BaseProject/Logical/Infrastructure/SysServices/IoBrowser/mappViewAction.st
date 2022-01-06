(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Author:    MITC
 * Created:   September 29, 2021/09:24 
 * This action sets all the strings and pointers so that the mappView page can 
 * present the IO information in a user friendly way
 *********************************************************************************)

ACTION mappViewAction: 
	(* Set pointers to the correct Forcing handler for easier interface to HMI *)
	IF (uSelectedModule <> uLastSelectedModule) OR (uSelectedChannel <> uLastSelectedChannel) THEN
		(* Check range *)
		IF (uSelectedModule <= gatMAX_IDX_IO_MODULES) AND (uSelectedChannel <= gatMAX_IDX_IO_MODULES) THEN
			IF uSelectedChannel >= IoModules[uSelectedModule].NrOfIoChannels THEN
				uSelectedChannel				:= 0;
			END_IF;
			pIoChannel ACCESS ADR(IoModules[uSelectedModule].IoChannels[uSelectedChannel]);
			pIoChannelTemp ACCESS ADR(IoModules[uSelectedModule].IoChannels[uSelectedChannel]);
			brsmemset(ADR(sIoChannelList), 0, SIZEOF(sIoChannelList));
			brsmemset(ADR(sIoPvList), 0, SIZEOF(sIoPvList));
			brsmemset(ADR(iIoValueList), 0, SIZEOF(iIoValueList));
			brsmemset(ADR(sTableConfigChannels), 0, SIZEOF(sTableConfigChannels));
			FOR uChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
				brsstrcpy(ADR(sIoChannelList[uChannelIdx]), ADR(IoModules[uSelectedModule].IoChannels[uChannelIdx].ChannelName));
				IF brsstrlen(ADR(sIoChannelList[uChannelIdx])) = 0 THEN
					(* Configure visible table entries *)
					brsstrcpy(ADR(sTableConfigChannels), ADR('{ "specRows": [{"from":'));
					brsitoa(uChannelIdx, ADR(sTableConfigChannels) + brsstrlen(ADR(sTableConfigChannels)));
					brsstrcat(ADR(sTableConfigChannels),  ADR(',"to":31, "visible":false}]}'));
					EXIT;
				END_IF;
				brsstrcpy(ADR(sIoPvList[uChannelIdx]), ADR('$$IAT/Audit/DP/'));
				IF brsstrlen(ADR(IoModules[uSelectedModule].IoChannels[uChannelIdx].PvName)) = 0 THEN
					brsstrcat(ADR(sIoPvList[uChannelIdx]), ADR('None'));
				ELSE
					brsstrcat(ADR(sIoPvList[uChannelIdx]), ADR(IoModules[uSelectedModule].IoChannels[uChannelIdx].PvName));
				END_IF;
			END_FOR;
			uLastSelectedModule					:= uSelectedModule;
			uLastSelectedChannel				:= uSelectedChannel;
		END_IF;
		(* Set Io refresh flags *)
		FOR uModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			FOR uChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
				IoModules[uModuleIdx].IoChannels[uChannelIdx].IoForcing.RefreshActualValue	:= (uModuleIdx = uSelectedModule);
			END_FOR;
		END_FOR;
	END_IF;
	
	(* Update IO values *)
	FOR uChannelIdx := 0 TO gatMAX_IDX_IO_CHANNELS DO
		IF IoModules[uSelectedModule].IoChannels[uChannelIdx].IoForcing.ActualValue > 32767 THEN
			iIoValueList[uChannelIdx]				:= IoModules[uSelectedModule].IoChannels[uChannelIdx].IoForcing.ActualValue - 65536;
		ELSE
			iIoValueList[uChannelIdx]				:= IoModules[uSelectedModule].IoChannels[uChannelIdx].IoForcing.ActualValue;
		END_IF;
		CASE IoModules[uSelectedModule].IoChannels[uChannelIdx].Type OF
			IO_DIG_INPUT, IO_DIG_OUTPUT:
				IF (IoModules[uSelectedModule].IoChannels[uChannelIdx].IoForcing.ActualValue = 1) THEN
					brsstrcpy(ADR(sIoValueList[uChannelIdx]), ADR('ON'));
				ELSE
					brsstrcpy(ADR(sIoValueList[uChannelIdx]), ADR('OFF'));
				END_IF;
			IO_ANA_INPUT, IO_ANA_OUTPUT, IO_PWM_OUTPUT:
				brsftoa(DINT_TO_REAL(REAL_TO_DINT(DINT_TO_REAL(iIoValueList[uChannelIdx]) / 32.767)) / 10, ADR(sIoValueList[uChannelIdx]));
				brsstrcat(ADR(sIoValueList[uChannelIdx]), ADR(' %'));
			IO_TEMP_INPUT:
				brsftoa(DINT_TO_REAL(iIoValueList[uChannelIdx]) / 10, ADR(sIoValueList[uChannelIdx]));
				brsstrcat(ADR(sIoValueList[uChannelIdx]), ADR(' C'));
			ELSE
				brsitoa(iIoValueList[uChannelIdx], ADR(sIoValueList[uChannelIdx]));
		END_CASE;
	END_FOR;
	
	(* Init Io Module list when handler is ready *)
	IF EDGEPOS(GatIoForcingHandler_0.Ready) THEN
		brsmemset(ADR(sTableConfigStations), 0, SIZEOF(sTableConfig));
		brsmemset(ADR(sStationList), 0, SIZEOF(sStationList));
		(* Init station list *)
		FOR uModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			IF FIND(RIGHT(IoModules[uModuleIdx].ModulePath, 6), '.') > 0 THEN
				brsmemset(ADR(sTempStationPath), 0, SIZEOF(sTempStationPath));
				brsstrcpy(ADR(sTempStationPath), ADR('$$IAT/IoStations/'));
				brsmemcpy(ADR(sTempStationPath) + brsstrlen(ADR(sTempStationPath)), ADR(IoModules[uModuleIdx].ModulePath), brsstrlen(ADR(IoModules[uModuleIdx].ModulePath)) - 7 + FIND(RIGHT(IoModules[uModuleIdx].ModulePath, 6), '.'));
			END_IF;
			FOR uStationIdx := 0 TO gatMAX_IDX_IO_MODULES DO
				IF brsstrcmp(ADR(sStationList[uStationIdx]), ADR(sTempStationPath)) = 0 THEN
					(* Station already registered *)
					EXIT;
				END_IF;
				IF brsstrlen(ADR(sStationList[uStationIdx])) = 0 THEN
					(* Reached end of list, add new station *)
					brsstrcpy(ADR(sStationList[uStationIdx]), ADR(sTempStationPath));
					EXIT;
				END_IF;
			END_FOR;
		END_FOR;
		(* Set station table configuration *)
		FOR uStationIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			IF brsstrlen(ADR(sStationList[uStationIdx])) = 0 THEN
				brsstrcpy(ADR(sTableConfigStations), ADR('{ "specRows": [{"from":'));
				brsitoa(uStationIdx, ADR(sTableConfigStations) + brsstrlen(ADR(sTableConfigStations)));
				brsstrcat(ADR(sTableConfigStations),  ADR(',"to":'));
				brsstrcat(ADR(sTableConfigStations),  ADR('19, "visible":false}]}'));
				EXIT;
			END_IF;
		END_FOR;
		(* Trigger station selection *)
		uSelectedStation							:= 0;
		uLastSelectedStation						:= 1;
	END_IF;
	
	(* Init Module list after station selection *)
	IF uSelectedStation <> uLastSelectedStation THEN
		brsmemset(ADR(sTableConfig), 0, SIZEOF(sTableConfig));
		brsmemset(ADR(sModuleList), 0, SIZEOF(sModuleList));
		brsmemset(ADR(sSelectedStation), 0, SIZEOF(sSelectedStation));
		brsstrcpy(ADR(sSelectedStation), ADR(sStationList[uSelectedStation]) + brsstrlen(ADR('$$IAT/IoStations/')));
		(* Init module list *)
		brsmemset(ADR(sTableConfig), 0, SIZEOF(sTableConfig));
		bLastModuleInvisible					:= FALSE;
		FOR uModuleIdx := 0 TO gatMAX_IDX_IO_MODULES DO
			brsstrcpy(ADR(sModuleList[uModuleIdx]), ADR(IoModules[uModuleIdx].ModuleName));
			IF (FIND(IoModules[uModuleIdx].ModulePath, sSelectedStation) = 0) THEN
				(* Wrong station, make station invisible *)
				IF NOT bLastModuleInvisible THEN
					IF brsstrlen(ADR(sTableConfig)) = 0 THEN
						brsstrcpy(ADR(sTableConfig), ADR('{ "specRows": [{"from":'));
					ELSE
						brsstrcat(ADR(sTableConfig), ADR(', {"from":'));
					END_IF;
					brsitoa(uModuleIdx, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
					brsstrcat(ADR(sTableConfig),  ADR(',"to":'));
				END_IF;
				bLastModuleInvisible				:= TRUE;
			ELSE
				(* Correct station, make module visible and select it if it's the first module of the station *)
				IF uSelectedModule = uLastSelectedModule THEN
					uSelectedModule					:= uModuleIdx;
					uLastSelectedModule				:= uSelectedModule + 1;
				END_IF;
				IF bLastModuleInvisible THEN
					brsitoa(uModuleIdx - 1, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
					brsstrcat(ADR(sTableConfig),  ADR(', "visible":false}'));
				END_IF;
				bLastModuleInvisible				:= FALSE;
			END_IF;
			IF brsstrlen(ADR(sModuleList[uModuleIdx])) = 0 THEN
				(* Reached end of modules, make rest of list invisible *)
				IF NOT bLastModuleInvisible THEN
					IF brsstrlen(ADR(sTableConfig)) = 0 THEN
						brsstrcpy(ADR(sTableConfig), ADR('{ "specRows": [{"from":'));
					ELSE
						brsstrcat(ADR(sTableConfig), ADR(', {"from":'));
					END_IF;
					brsitoa(uModuleIdx, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
					brsstrcat(ADR(sTableConfig),  ADR(',"to":'));
				END_IF;
				brsstrcat(ADR(sTableConfig),  ADR('19, "visible":false}]}'));
				EXIT;
			ELSIF uModuleIdx = gatMAX_IDX_IO_MODULES THEN
				(* Reached end of modules, close table config *)
				IF bLastModuleInvisible THEN
					brsitoa(uModuleIdx, ADR(sTableConfig) + brsstrlen(ADR(sTableConfig)));
					brsstrcat(ADR(sTableConfig),  ADR(', "visible":false}]}'));
				ELSE
					brsstrcat(ADR(sTableConfig),  ADR(']}'));
				END_IF;
			END_IF;
		END_FOR;
	END_IF;
	uLastSelectedStation						:= uSelectedStation;
END_ACTION
