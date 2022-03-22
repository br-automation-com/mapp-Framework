//*********************************************************************************
//* Copyright: B&R Industrial Automation GmbH
//* Author:    MITC
//* Created:   September 26, 2021/09:19
//* This task shall automatically detect and (un)link USB storage devices
//*********************************************************************************

PROGRAM _INIT
	DevLinkCtrl.FUB.DevLink_0.enable := FALSE;
	DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
	DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
	DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
	DevLinkCtrl.FUB.DevLink_0();
	DevLinkCtrl.FUB.DevUnlink_0();
	DevLinkCtrl.FUB.UsbNodeGet_0();
	DevLinkCtrl.FUB.UsbNodeListGet_0();
	
	FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
		AttachedUSB[Index] := FALSE;
		gUSBAvailable[Index] := FALSE;
	END_FOR
END_PROGRAM

PROGRAM _CYCLIC

	CASE DevLinkCtrl.Step OF
		STATE_WAIT:
			// Update USB info list if the node list has changed
			IF (brsmemcmp(ADR(DevLinkCtrl.Params.NodeList), ADR(LastNodeList), SIZEOF(LastNodeList)) <> 0) THEN
				DevLinkCtrl.Cmd.GetUSBInfo := TRUE;
				// Preserve the previously created drive information in CASE the order has changed when unplugging a device 
				FOR DevLinkCtrl.Params.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
					FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
						IF ((DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index] = LastNodeList[Index]) AND
							(DevLinkCtrl.Params.Index <> Index) AND (LastNodeList[Index] <> 0)) THEN
							brsmemcpy(ADR(TempUSBInfo), ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]), ADR(DevLinkCtrl.Params.NodeInfoList[Index]), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(DevLinkCtrl.Params.NodeInfoList[Index]), ADR(TempUSBInfo), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(TempFileDevName), ADR(DevLinkCtrl.Params.FileDevName[DevLinkCtrl.Params.Index]), SIZEOF(TempFileDevName));
							brsmemcpy(ADR(DevLinkCtrl.Params.FileDevName[DevLinkCtrl.Params.Index]), ADR(DevLinkCtrl.Params.FileDevName[Index]), SIZEOF(TempFileDevName));
							brsmemcpy(ADR(DevLinkCtrl.Params.FileDevName[Index]), ADR(TempFileDevName), SIZEOF(TempFileDevName));
							TempFileDevHandle := DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index];
							DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] := DevLinkCtrl.Params.FileDevHandle[Index];
							DevLinkCtrl.Params.FileDevHandle[Index] := TempFileDevHandle;
						END_IF
					END_FOR
				END_FOR
				brsmemcpy(ADR(LastNodeList), ADR(DevLinkCtrl.Params.NodeList), SIZEOF(LastNodeList));
			END_IF
	
			FOR DevLinkCtrl.Params.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
				// Skip if loading USB list information 
				IF DevLinkCtrl.Cmd.GetUSBInfo THEN
					EXIT;
				END_IF
				// Always keep devices linked when available
				IF ((DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] = 0) AND AttachedUSB[DevLinkCtrl.Params.Index]
					AND (DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index] <> 0)) THEN
					DevLinkCtrl.Cmd.DevLink := TRUE;
					EXIT;
				END_IF
				// Unlink device if it is not connected anymore
				IF ((DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] <> 0) AND
					(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index].interfaceClass <> 8)) THEN
					DevLinkCtrl.Cmd.DevUnlink := TRUE;
					EXIT;
				END_IF
			END_FOR
	
			// Check for USB devices every 3 seconds 
			TON_0.PT := t#3s;
			IF (TON_0.Q AND NOT DevLinkCtrl.Cmd.GetUSBInfo AND NOT DevLinkCtrl.Cmd.DevLink AND NOT DevLinkCtrl.Cmd.DevUnlink) THEN
				DevLinkCtrl.Cmd.GetUSBList := TRUE;
				TON_0.IN := FALSE;
			ELSE
				TON_0.IN := TRUE;
			END_IF
			TON_0();
	
			IF DevLinkCtrl.Cmd.GetUSBInfo THEN
				// Get USB info cmd 
				DevLinkCtrl.Cmd.GetUSBInfo := FALSE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeInfoList), 0, SIZEOF(DevLinkCtrl.Params.NodeInfoList));
				DevLinkCtrl.Step := STATE_GET_USB_INFO;
				DevLinkCtrl.Params.Index := 0;
			ELSIF DevLinkCtrl.Cmd.GetUSBList THEN
				// Get USB list cmd 
				DevLinkCtrl.Cmd.GetUSBList := FALSE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeList), 0, SIZEOF(DevLinkCtrl.Params.NodeList));
				DevLinkCtrl.Step := STATE_GET_USB_LIST;
			ELSIF DevLinkCtrl.Cmd.DevLink THEN
				// Link cmd 
				DevLinkCtrl.Cmd.DevLink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_LINK;
			ELSIF DevLinkCtrl.Cmd.DevUnlink THEN
				// Unlink cmd 
				DevLinkCtrl.Cmd.DevUnlink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_UNLINK;
			END_IF

		STATE_GET_USB_LIST:
			// Set FUB parameters
			DevLinkCtrl.FUB.UsbNodeListGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeListGet_0.bufferSize := SIZEOF(DevLinkCtrl.Params.NodeList);
			DevLinkCtrl.FUB.UsbNodeListGet_0.pBuffer := ADR(DevLinkCtrl.Params.NodeList);
	
			// Error handling
			IF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status = ERR_OK) OR (DevLinkCtrl.FUB.UsbNodeListGet_0.status = asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_WAIT;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_ENABLE_FALSE)
				AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.UsbNodeListGet_0.status;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			END_IF

			DevLinkCtrl.FUB.UsbNodeListGet_0();

		STATE_GET_USB_INFO:
			// Set FUB parameters 
			DevLinkCtrl.FUB.UsbNodeGet_0.bufferSize := SIZEOF(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]);
			DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeGet_0.nodeId := DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index];
			DevLinkCtrl.FUB.UsbNodeGet_0.pBuffer := ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]);

			// Check if DevLinkCtrl.Params.Index contains an entry
			IF (DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index] = 0) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]), 0, SIZEOF(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]));
				DevLinkCtrl.Params.Index := DevLinkCtrl.Params.Index + 1;
			END_IF

			// Error handling
			IF (DevLinkCtrl.FUB.UsbNodeGet_0.status = ERR_OK) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
				DevLinkCtrl.Params.Index := DevLinkCtrl.Params.Index + 1;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.UsbNodeGet_0.status;
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
			END_IF

			// End of list reached
			IF (DevLinkCtrl.Params.Index > MAX_IDX_USB_DEV_LIST) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
				FOR DevLinkCtrl.Params.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
					IF (DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index].interfaceClass = 8) THEN
						AttachedUSB[DevLinkCtrl.Params.Index] := TRUE;
					ELSE
						AttachedUSB[DevLinkCtrl.Params.Index] := FALSE;
						gUSBAvailable[DevLinkCtrl.Params.Index] := FALSE;
					END_IF
				END_FOR
			END_IF
			
			DevLinkCtrl.FUB.UsbNodeGet_0();

		STATE_DEV_LINK:
            // Set FUB parameters
			DevLinkCtrl.FUB.DevLink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevLink_0.pDevice := ADR(DevLinkCtrl.Params.FileDevName[DevLinkCtrl.Params.Index]);
			brsstrcpy(ADR(DevLinkCtrl.Params.LinkParam), ADR('/DEVICE='));
			brsstrcat(ADR(DevLinkCtrl.Params.LinkParam), ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index].ifName));
			DevLinkCtrl.FUB.DevLink_0.pParam := ADR(DevLinkCtrl.Params.LinkParam);
	
			// Error handling
			IF (DevLinkCtrl.FUB.DevLink_0.status = ERR_OK) THEN
				DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] := DevLinkCtrl.FUB.DevLink_0.handle;
				DevLinkCtrl.Step := STATE_WAIT;
				DevLinkCtrl.FUB.DevLink_0.enable := FALSE;
				FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
					gUSBAvailable[Index] := AttachedUSB[Index];
				END_FOR
			ELSIF ((DevLinkCtrl.FUB.DevLink_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.DevLink_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.DevLink_0.status;
				DevLinkCtrl.FUB.DevLink_0.enable := FALSE;
			END_IF
			
			DevLinkCtrl.FUB.DevLink_0();

		STATE_DEV_UNLINK:
			// Set FUB parameters
			DevLinkCtrl.FUB.DevUnlink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevUnlink_0.handle := DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index];
	
			// Check if we have a handle
			IF (DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] = 0) THEN
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF
	
			// Error handling
			IF (DevLinkCtrl.FUB.DevUnlink_0.status = ERR_OK) THEN
				DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] := 0;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			ELSIF ((DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.DevUnlink_0.status;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
			END_IF

			DevLinkCtrl.FUB.DevUnlink_0();
 
		STATE_ERROR_USB:
			// Delete error ID and go back to wait step when error is acknowledged
			IF DevLinkCtrl.Cmd.ErrAck THEN
				DevLinkCtrl.Params.ErrorID := 0;
				DevLinkCtrl.Cmd.ErrAck := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF

	END_CASE;

END_PROGRAM

PROGRAM _EXIT
	// Insert code here 
END_PROGRAM
