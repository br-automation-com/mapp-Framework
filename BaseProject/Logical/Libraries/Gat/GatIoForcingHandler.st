//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Created:   27 July, 2021/16:41
//* Handles Io forcing
//********************************************************************************

// Handles IO forcing for all modules
FUNCTION_BLOCK GatIoForcingHandler
	// Function block not enabled 
	IF NOT Enable THEN
		// Close arcfg 
		IF Internal.ArCfgIdent <> 0 THEN
			Internal.AR_CloseArCfg_Int.Ident := Internal.ArCfgIdent;
			Internal.AR_CloseArCfg_Int.Enable := TRUE;
			Internal.AR_CloseArCfg_Int.Store := FALSE;
			Internal.AR_CloseArCfg_Int();
			IF Internal.AR_CloseArCfg_Int.Status = ERR_OK THEN
				Internal.AR_CloseArCfg_Int.Enable := FALSE;
				Internal.AR_CloseArCfg_Int.Store := FALSE;
				Internal.AR_CloseArCfg_Int();
				Internal.ArCfgIdent := 0;
			END_IF
		END_IF
		// Close iomap 
		IF Internal.IoMapIdent <> 0 THEN
			Internal.IO_CloseIoMap_Int.Ident := Internal.IoMapIdent;
			Internal.IO_CloseIoMap_Int.Enable := TRUE;
			Internal.IO_CloseIoMap_Int.Store := FALSE;
			Internal.IO_CloseIoMap_Int();
			IF Internal.IO_CloseIoMap_Int.Status = ERR_OK THEN
				Internal.IO_CloseIoMap_Int.Enable := FALSE;
				Internal.IO_CloseIoMap_Int.Store := FALSE;
				Internal.IO_CloseIoMap_Int();
				Internal.IoMapIdent := 0;
			END_IF
		END_IF
		// Function block disabled, return here 
		Internal.InitState := 0;
		Internal.CommandState := 0;
		Internal.NrOfIoChannels := 0;
		Internal.NrOfModules := 0;
		Initializing := FALSE;
		Ready := FALSE;
		RETURN;
	END_IF
	
	// Initialize Io module and channel structure 
	IF NOT Ready THEN
		Initializing := TRUE;
		// Open arcfg 
		IF Internal.ArCfgIdent = 0 THEN
			Internal.InitState := 0;
			Internal.AR_OpenArCfg_Int.Enable := TRUE;
			Internal.AR_OpenArCfg_Int();
			IF Internal.AR_OpenArCfg_Int.Status = ERR_OK THEN
				Internal.ArCfgIdent := Internal.AR_OpenArCfg_Int.Ident;
				Internal.NrOfModules := AR_NumberOfModules(Internal.ArCfgIdent);
				Internal.AR_OpenArCfg_Int.Enable := FALSE;
				Internal.AR_OpenArCfg_Int();
			ELSE
				RETURN;
			END_IF
		END_IF
		// Open iomap 
		IF Internal.IoMapIdent = 0 THEN
			Internal.InitState := 0;
			Internal.IO_OpenIoMap_Int.Enable := TRUE;
			Internal.IO_OpenIoMap_Int();
			IF Internal.IO_OpenIoMap_Int.Status = ERR_OK THEN
				Internal.IdxIoChannel := 1;
				Internal.IoMapIdent := Internal.IO_OpenIoMap_Int.Ident;
				Internal.NrOfIoChannels := Internal.IO_OpenIoMap_Int.NumberOfChannels;
				Internal.IO_OpenIoMap_Int.Enable := FALSE;
				Internal.IO_OpenIoMap_Int();
				brsmemset(ADR(IoModules), 0, SIZEOF(IoModules));
			ELSE
				RETURN;
			END_IF
		END_IF
	
		// iomap and arcfg are open, start initialization 
		CASE Internal.InitState OF
			0: // Find all visible IoChannels and sort them by module path
				// Loop through IoChannels 
				IF IO_ReadChannel(Internal.IoMapIdent, Internal.IdxIoChannel, ADR(Internal.TempChannel.Type), ADR(Internal.TempChannel.Inverted),
					ADR(Internal.TempChannel.ChannelName), ADR(Internal.TempChannel.PvName), ADR(Internal.TempChannel.ModulePath), ADR(Internal.TempChannel.TaskClass)) THEN
					// Check visibility 
					IF (NOT GatIoIsVisible(ADR(Internal.TempChannel.ChannelName))) OR (brsstrlen(ADR(Internal.TempChannel.ModulePath)) = 0) THEN
						Internal.IdxIoChannel := Internal.IdxIoChannel + 1;
						IF Internal.IdxIoChannel > Internal.NrOfIoChannels THEN
							Internal.InitState := Internal.InitState + 1;
							Internal.IdxModule := 0;
						END_IF
						RETURN;
					END_IF
					// Search related module 
					FOR Internal.IdxModule := 0 TO gatMAX_IDX_IO_MODULES DO
						IF brsstrcmp(ADR(IoModules[Internal.IdxModule].ModulePath), ADR('')) = 0 THEN
							// Related module not in list yet, add module 
							brsstrcpy(ADR(IoModules[Internal.IdxModule].ModulePath), ADR(Internal.TempChannel.ModulePath));
						END_IF
						IF brsstrcmp(ADR(IoModules[Internal.IdxModule].ModulePath), ADR(Internal.TempChannel.ModulePath)) = 0 THEN
							// Module found 
							GatMakeIoDpName(Internal.TempChannel, ADR(Internal.TempChannel.IoForcing.DpName));
							IoModules[Internal.IdxModule].IoChannels[IoModules[Internal.IdxModule].NrOfIoChannels] := Internal.TempChannel;
							IoModules[Internal.IdxModule].NrOfIoChannels := IoModules[Internal.IdxModule].NrOfIoChannels + 1;
							Internal.IdxIoChannel := Internal.IdxIoChannel + 1;
							IF Internal.IdxIoChannel > Internal.NrOfIoChannels THEN
								Internal.InitState := Internal.InitState + 1;
								Internal.IdxModule := 0;
							END_IF
							RETURN;
						END_IF
					END_FOR
				END_IF

			1: // Add Module names to each io module
				// Check if module index is populated 
				IF brsstrlen(ADR(IoModules[Internal.IdxModule].ModulePath)) = 0 THEN
					Internal.IdxModule := Internal.IdxModule + 1;
					IF Internal.IdxModule > gatMAX_IDX_IO_MODULES THEN
						Internal.IdxModule := 0;
						Internal.IdxIoChannel := 0;
						Internal.InitState := Internal.InitState + 1;
					END_IF
					RETURN;
				END_IF
				// Loop through modules in arcfg to find the correct name 
				FOR Internal.IdxModuleNames := 1 TO Internal.NrOfModules DO
					AR_GetModuleInfo(Internal.ArCfgIdent, Internal.IdxModuleNames, ADR(IoModules[Internal.IdxModule].ModuleName), ADR(IoModules[Internal.IdxModule].ModulePath));
					IF brsstrcmp(ADR(IoModules[Internal.IdxModule].ModulePath), ADR(IoModules[Internal.IdxModule].IoChannels[0].ModulePath)) = 0 THEN
						// Correct name was found 
						Internal.IdxModule := Internal.IdxModule + 1;
						IF Internal.IdxModule > gatMAX_IDX_IO_MODULES THEN
							Internal.IdxModule := 0;
							Internal.IdxIoChannel := 0;
							Internal.InitState := Internal.InitState + 1;
						END_IF
						RETURN;
					END_IF
				END_FOR
	
			2: // Close iomap and arcfg
				Internal.AR_CloseArCfg_Int.Enable := TRUE;
				Internal.AR_CloseArCfg_Int.Ident := Internal.ArCfgIdent;
				Internal.AR_CloseArCfg_Int.Store := FALSE;
				Internal.IO_CloseIoMap_Int.Enable := TRUE;
				Internal.IO_CloseIoMap_Int.Ident := Internal.IoMapIdent;
				Internal.IO_CloseIoMap_Int.Store := FALSE;
	
				Internal.AR_CloseArCfg_Int();
				Internal.IO_CloseIoMap_Int();
	
				IF (Internal.AR_CloseArCfg_Int.Status = ERR_OK) AND (Internal.IO_CloseIoMap_Int.Status = ERR_OK) THEN
					Ready := TRUE;
					Initializing := FALSE;
					Internal.IoMapIdent := 0;
					Internal.ArCfgIdent := 0;
				END_IF
		END_CASE;
	ELSE // Ready = TRUE
		// Check if current indices are populated 
		WHILE (brsstrlen(ADR(IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].ChannelName)) = 0)
			OR (SelectedRefreshMode AND NOT IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.RefreshActualValue AND NOT (Internal.CommandState = 1)) DO
			Internal.IdxModule := Internal.IdxModule + 1;
			Internal.IdxIoChannel := 0;
			IF Internal.IdxModule > gatMAX_IDX_IO_MODULES THEN
				Internal.IdxModule := 0;
				RETURN;
			END_IF
		END_WHILE
	
		// Set force value 
		IF IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.ForceValue <> Internal.ForceValue[Internal.IdxModule, Internal.IdxIoChannel] THEN
			Internal.AsIOSetForceValue_Int.enable := TRUE;
			Internal.AsIOSetForceValue_Int.pDatapoint := ADR(IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.DpName);
			Internal.AsIOSetForceValue_Int.value := IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.ForceValue;
			Internal.AsIOSetForceValue_Int();
			IF Internal.AsIOSetForceValue_Int.status = ERR_OK THEN
				Internal.AsIOSetForceValue_Int.enable := FALSE;
				Internal.AsIOSetForceValue_Int();
				Internal.ForceValue[Internal.IdxModule, Internal.IdxIoChannel] := IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.ForceValue;
			END_IF
		END_IF
		// Enable/Disable forcing 
		IF IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.SetForceActive <> Internal.ForceEnabled[Internal.IdxModule, Internal.IdxIoChannel] THEN
			IF IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.SetForceActive THEN
				Internal.AsIOEnableForcing_Int.enable := TRUE;
				Internal.AsIOEnableForcing_Int.pDatapoint := ADR(IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.DpName);
				Internal.AsIOEnableForcing_Int();
				IF (Internal.AsIOEnableForcing_Int.status = ERR_OK) THEN
					Internal.AsIOEnableForcing_Int.enable := FALSE;
					Internal.AsIOEnableForcing_Int();
					Internal.ForceEnabled[Internal.IdxModule, Internal.IdxIoChannel] := TRUE;
				END_IF
			ELSE
				Internal.AsIODisableForcing_Int.enable := TRUE;
				Internal.AsIODisableForcing_Int.pDatapoint := ADR(IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.DpName);
				Internal.AsIODisableForcing_Int();
				IF (Internal.AsIODisableForcing_Int.status = ERR_OK) THEN
					Internal.AsIODisableForcing_Int.enable := FALSE;
					Internal.AsIODisableForcing_Int();
					Internal.ForceEnabled[Internal.IdxModule, Internal.IdxIoChannel] := FALSE;
				END_IF
			END_IF
		END_IF
		// Set actual value 
		Internal.AsIODPStatus_Int.enable := TRUE;
		Internal.AsIODPStatus_Int.pDatapoint := ADR(IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.DpName);
		Internal.AsIODPStatus_Int();
		IF Internal.AsIODPStatus_Int.status = ERR_OK THEN
			IF Internal.AsIODPStatus_Int.flags.2 THEN
				IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.ActualValue := Internal.AsIODPStatus_Int.forceValue;
			ELSE
				IoModules[Internal.IdxModule].IoChannels[Internal.IdxIoChannel].IoForcing.ActualValue := Internal.AsIODPStatus_Int.value;
			END_IF
			Internal.AsIODPStatus_Int.enable := FALSE;
			Internal.AsIODPStatus_Int();
		END_IF
		// Go to next index when nothing to do 
		IF ((Internal.AsIOSetForceValue_Int.status = ERR_FUB_ENABLE_FALSE) OR (Internal.AsIOSetForceValue_Int.status = ERR_OK))
			AND ((Internal.AsIOEnableForcing_Int.status = ERR_FUB_ENABLE_FALSE) OR (Internal.AsIOEnableForcing_Int.status = ERR_OK))
			AND ((Internal.AsIODisableForcing_Int.status = ERR_FUB_ENABLE_FALSE) OR (Internal.AsIODisableForcing_Int.status = ERR_OK))
			AND ((Internal.AsIODPStatus_Int.status = ERR_FUB_ENABLE_FALSE) OR (Internal.AsIODPStatus_Int.status = ERR_OK)) THEN
			Internal.IdxIoChannel := Internal.IdxIoChannel + 1;
			IF Internal.IdxIoChannel > gatMAX_IDX_IO_CHANNELS THEN
				Internal.IdxIoChannel := 0;
				Internal.IdxModule := Internal.IdxModule + 1;
			END_IF
			IF Internal.IdxModule > gatMAX_IDX_IO_MODULES THEN
				Internal.IdxModule := 0;
			END_IF
			// Handle command inputs 
			CASE Internal.CommandState OF
				0: // Wait for command 
					IF ResetAllForcing THEN
						FOR Internal.IdxModuleCmd := 0 TO gatMAX_IDX_IO_MODULES DO
							FOR Internal.IdxIoChannelCmd := 0 TO gatMAX_IDX_IO_CHANNELS DO
								IoModules[Internal.IdxModuleCmd].IoChannels[Internal.IdxIoChannelCmd].IoForcing.SetForceActive := FALSE;
							END_FOR
						END_FOR
						CommandBusy := TRUE;
						Internal.CommandState := 1;
					END_IF
				1: // ResetAllForcing 
					CommandBusy := TRUE;
					FOR Internal.IdxModuleCmd := 0 TO gatMAX_IDX_IO_MODULES DO
						FOR Internal.IdxIoChannelCmd := 0 TO gatMAX_IDX_IO_CHANNELS DO
							IF Internal.ForceEnabled[Internal.IdxModuleCmd, Internal.IdxIoChannelCmd] THEN
								RETURN;
							END_IF
						END_FOR
					END_FOR
					// All forcing is disabled 
					CommandBusy := FALSE;
					CommandDone := TRUE;
					Internal.CommandState := 10;
				10: // Command done 
					CommandDone := TRUE;
					IF NOT ResetAllForcing THEN
						CommandDone := FALSE;
						Internal.CommandState := 0;
					END_IF
			END_CASE;
		END_IF
	END_IF
END_FUNCTION_BLOCK

// Creates the IO data point name from the given information 
FUNCTION GatMakeIoDpName
	brsmemset(ADR(DpName), 0, SIZEOF(DpName));
	
	CASE IoChannel.Type OF
		IO_DIG_INPUT:
			brsstrcpy(ADR(DpName), ADR('%IX.'));

		IO_DIG_OUTPUT:
			brsstrcpy(ADR(DpName), ADR('%QX.'));
	
		IO_ANA_INPUT:
			brsstrcpy(ADR(DpName), ADR('%IW.'));
	
		IO_TEMP_INPUT:
			brsstrcpy(ADR(DpName), ADR('%IW.'));
	
		IO_RESISTOR_INPUT:
			brsstrcpy(ADR(DpName), ADR('%IW.'));

		IO_ANA_OUTPUT:
			brsstrcpy(ADR(DpName), ADR('%QW.'));
	
		IO_PWM_OUTPUT:
			brsstrcpy(ADR(DpName), ADR('%QW.'));

		IO_USINT_INPUT:
			brsstrcpy(ADR(DpName), ADR('%IB.'));

		IO_USINT_OUTPUT:
			brsstrcpy(ADR(DpName), ADR('%QB.'));
	
		IO_UDINT_INPUT:
			brsstrcpy(ADR(DpName), ADR('%ID.'));

		IO_UDINT_OUTPUT:
			brsstrcpy(ADR(DpName), ADR('%QD.'));
	END_CASE;
	
	brsstrcat(ADR(DpName), ADR(IoChannel.ModulePath));
	brsstrcat(ADR(DpName), ADR('.'));
	brsstrcat(ADR(DpName), ADR(IoChannel.ChannelName));
	
	GatMakeIoDpName := TRUE;
END_FUNCTION

// Determines whether an IO channel should be accessible on the HMI 
FUNCTION GatIoIsVisible
	GatIoIsVisible := TRUE;
	IF (brsmemcmp(ADR(ChannelName), ADR('DigitalOutput'), 13) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('DigitalInput'), 12) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('CounterInput'), 12) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('AnalogOutput'), 12) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('AnalogInput'), 11) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('Temperature'), 11) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('RelayOutput'), 11) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('PulseWidthCurrentPwm'), 20) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('PulseWidthCurrentPWM'), 20) = 0) THEN
		RETURN;
	END_IF
	IF (brsmemcmp(ADR(ChannelName), ADR('Counter'), 7) = 0) THEN
		RETURN;
	END_IF
	GatIoIsVisible := FALSE;
	RETURN;
END_FUNCTION
