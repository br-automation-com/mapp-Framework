//*********************************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: This task automatically detects and (un)links USB storage devices
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
	
	FOR i := 0 TO MAX_IDX_USB_DEV_LIST DO
		AttachedUSB[i] := FALSE;
		gUSBAvailable[i] := FALSE;
	END_FOR
	
END_PROGRAM

PROGRAM _CYCLIC

	CASE DevLinkCtrl.Step OF
		STATE_WAIT:
			// Update USB info list if the node list has changed
			IF (brsmemcmp(ADR(DevLinkCtrl.Parameters.NodeList), ADR(LastNodeList), SIZEOF(LastNodeList)) <> 0) THEN
				DevLinkCtrl.Commands.GetUSBInfo := TRUE;
				// Preserve the previously created drive information in case the order has changed when unplugging a device 
				FOR DevLinkCtrl.Parameters.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
					FOR i := 0 TO MAX_IDX_USB_DEV_LIST DO
						IF ((DevLinkCtrl.Parameters.NodeList[DevLinkCtrl.Parameters.Index] = LastNodeList[i]) AND
							(DevLinkCtrl.Parameters.Index <> i) AND (LastNodeList[i] <> 0)) THEN
							brsmemcpy(ADR(TempUSBInfo), ADR(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]), ADR(DevLinkCtrl.Parameters.NodeInfoList[i]), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(DevLinkCtrl.Parameters.NodeInfoList[i]), ADR(TempUSBInfo), SIZEOF(TempUSBInfo));
							brsmemcpy(ADR(TempFileDeviceName), ADR(DevLinkCtrl.Parameters.FileDevName[DevLinkCtrl.Parameters.Index]), SIZEOF(TempFileDeviceName));
							brsmemcpy(ADR(DevLinkCtrl.Parameters.FileDevName[DevLinkCtrl.Parameters.Index]), ADR(DevLinkCtrl.Parameters.FileDevName[i]), SIZEOF(TempFileDeviceName));
							brsmemcpy(ADR(DevLinkCtrl.Parameters.FileDevName[i]), ADR(TempFileDeviceName), SIZEOF(TempFileDeviceName));
							TempFileDeviceHandle := DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index];
							DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] := DevLinkCtrl.Parameters.FileDevHandle[i];
							DevLinkCtrl.Parameters.FileDevHandle[i] := TempFileDeviceHandle;
						END_IF
					END_FOR
				END_FOR
				brsmemcpy(ADR(LastNodeList), ADR(DevLinkCtrl.Parameters.NodeList), SIZEOF(LastNodeList));
			END_IF
	
			FOR DevLinkCtrl.Parameters.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
				// Skip if loading USB list information 
				IF DevLinkCtrl.Commands.GetUSBInfo THEN
					EXIT;
				END_IF
				// Always keep devices linked when available
				IF ((DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] = 0) AND AttachedUSB[DevLinkCtrl.Parameters.Index]
					AND (DevLinkCtrl.Parameters.NodeList[DevLinkCtrl.Parameters.Index] <> 0)) THEN
					DevLinkCtrl.Commands.DevLink := TRUE;
					EXIT;
				END_IF
				// Unlink device if it is not connected anymore
				IF ((DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] <> 0) AND
					(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index].interfaceClass <> 8)) THEN
					DevLinkCtrl.Commands.DevUnlink := TRUE;
					EXIT;
				END_IF
			END_FOR
	
			// Check for USB devices every 3 seconds 
			TON_0.PT := t#3s;
			IF (TON_0.Q AND NOT DevLinkCtrl.Commands.GetUSBInfo AND NOT DevLinkCtrl.Commands.DevLink AND NOT DevLinkCtrl.Commands.DevUnlink) THEN
				DevLinkCtrl.Commands.GetUSBList := TRUE;
				TON_0.IN := FALSE;
			ELSE
				TON_0.IN := TRUE;
			END_IF
			TON_0();
	
			IF DevLinkCtrl.Commands.GetUSBInfo THEN
				// Get USB info Commands 
				DevLinkCtrl.Commands.GetUSBInfo := FALSE;
				brsmemset(ADR(DevLinkCtrl.Parameters.NodeInfoList), 0, SIZEOF(DevLinkCtrl.Parameters.NodeInfoList));
				DevLinkCtrl.Step := STATE_GET_USB_INFO;
				DevLinkCtrl.Parameters.Index := 0;
			ELSIF DevLinkCtrl.Commands.GetUSBList THEN
				// Get USB list Commands 
				DevLinkCtrl.Commands.GetUSBList := FALSE;
				brsmemset(ADR(DevLinkCtrl.Parameters.NodeList), 0, SIZEOF(DevLinkCtrl.Parameters.NodeList));
				DevLinkCtrl.Step := STATE_GET_USB_LIST;
			ELSIF DevLinkCtrl.Commands.DevLink THEN
				// Link Commands 
				DevLinkCtrl.Commands.DevLink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_LINK;
			ELSIF DevLinkCtrl.Commands.DevUnlink THEN
				// Unlink Commands 
				DevLinkCtrl.Commands.DevUnlink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_UNLINK;
			END_IF

		STATE_GET_USB_LIST:
			// Set FUB parameters
			DevLinkCtrl.FUB.UsbNodeListGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeListGet_0.bufferSize := SIZEOF(DevLinkCtrl.Parameters.NodeList);
			DevLinkCtrl.FUB.UsbNodeListGet_0.pBuffer := ADR(DevLinkCtrl.Parameters.NodeList);
	
			// Error handling
			IF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status = ERR_OK) OR (DevLinkCtrl.FUB.UsbNodeListGet_0.status = asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_WAIT;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_ENABLE_FALSE)
				AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Parameters.ErrorID := DevLinkCtrl.FUB.UsbNodeListGet_0.status;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			END_IF

			DevLinkCtrl.FUB.UsbNodeListGet_0();

		STATE_GET_USB_INFO:
			// Set FUB parameters 
			DevLinkCtrl.FUB.UsbNodeGet_0.bufferSize := SIZEOF(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]);
			DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeGet_0.nodeId := DevLinkCtrl.Parameters.NodeList[DevLinkCtrl.Parameters.Index];
			DevLinkCtrl.FUB.UsbNodeGet_0.pBuffer := ADR(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]);

			// Check if DevLinkCtrl.Parameters.Index contains an entry
			IF (DevLinkCtrl.Parameters.NodeList[DevLinkCtrl.Parameters.Index] = 0) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
				brsmemset(ADR(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]), 0, SIZEOF(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index]));
				DevLinkCtrl.Parameters.Index := DevLinkCtrl.Parameters.Index + 1;
			END_IF

			// Error handling
			IF (DevLinkCtrl.FUB.UsbNodeGet_0.status = ERR_OK) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
				DevLinkCtrl.Parameters.Index := DevLinkCtrl.Parameters.Index + 1;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Parameters.ErrorID := DevLinkCtrl.FUB.UsbNodeGet_0.status;
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
			END_IF

			// End of list reached
			IF (DevLinkCtrl.Parameters.Index > MAX_IDX_USB_DEV_LIST) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
				FOR DevLinkCtrl.Parameters.Index := 0 TO MAX_IDX_USB_DEV_LIST DO
					IF (DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index].interfaceClass = 8) THEN
						AttachedUSB[DevLinkCtrl.Parameters.Index] := TRUE;
					ELSE
						AttachedUSB[DevLinkCtrl.Parameters.Index] := FALSE;
						gUSBAvailable[DevLinkCtrl.Parameters.Index] := FALSE;
					END_IF
				END_FOR
			END_IF
			
			DevLinkCtrl.FUB.UsbNodeGet_0();

		STATE_DEV_LINK:
            // Set FUB parameters
			DevLinkCtrl.FUB.DevLink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevLink_0.pDevice := ADR(DevLinkCtrl.Parameters.FileDevName[DevLinkCtrl.Parameters.Index]);
			brsstrcpy(ADR(DevLinkCtrl.Parameters.LinkParam), ADR('/DEVICE='));
			brsstrcat(ADR(DevLinkCtrl.Parameters.LinkParam), ADR(DevLinkCtrl.Parameters.NodeInfoList[DevLinkCtrl.Parameters.Index].ifName));
			DevLinkCtrl.FUB.DevLink_0.pParam := ADR(DevLinkCtrl.Parameters.LinkParam);
	
			// Error handling
			IF (DevLinkCtrl.FUB.DevLink_0.status = ERR_OK) THEN
				DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] := DevLinkCtrl.FUB.DevLink_0.handle;
				DevLinkCtrl.Step := STATE_WAIT;
				DevLinkCtrl.FUB.DevLink_0.enable := FALSE;
				FOR i := 0 TO MAX_IDX_USB_DEV_LIST DO
					gUSBAvailable[i] := AttachedUSB[i];
				END_FOR
			ELSIF ((DevLinkCtrl.FUB.DevLink_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.DevLink_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Parameters.ErrorID := DevLinkCtrl.FUB.DevLink_0.status;
				DevLinkCtrl.FUB.DevLink_0.enable := FALSE;
			END_IF
			
			DevLinkCtrl.FUB.DevLink_0();

		STATE_DEV_UNLINK:
			// Set FUB parameters
			DevLinkCtrl.FUB.DevUnlink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevUnlink_0.handle := DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index];
	
			// Check if we have a handle
			IF (DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] = 0) THEN
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF
	
			// Error handling
			IF (DevLinkCtrl.FUB.DevUnlink_0.status = ERR_OK) THEN
				DevLinkCtrl.Parameters.FileDevHandle[DevLinkCtrl.Parameters.Index] := 0;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			ELSIF ((DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Parameters.ErrorID := DevLinkCtrl.FUB.DevUnlink_0.status;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
			END_IF

			DevLinkCtrl.FUB.DevUnlink_0();
 
		STATE_ERROR_USB:
			// Delete error ID and go back to wait step when error is acknowledged
			IF DevLinkCtrl.Commands.ErrAck THEN
				DevLinkCtrl.Parameters.ErrorID := 0;
				DevLinkCtrl.Commands.ErrAck := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF

	END_CASE;

END_PROGRAM

PROGRAM _EXIT
	
	// Insert code here 
	
END_PROGRAM
