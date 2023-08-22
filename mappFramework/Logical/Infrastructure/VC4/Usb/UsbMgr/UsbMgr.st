//*********************************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: This task automatically detects and (un)links USB storage devices
//*********************************************************************************

PROGRAM _INIT
END_PROGRAM

PROGRAM _CYCLIC

	CASE StateMachine OF
		// -----------------------------------------------------------------------------------------------------------
		// Wait state
		// -----------------------------------------------------------------------------------------------------------
		USB_WAIT:
			// Refresh USB data every X seconds when enabled
			Node := 1;
			USB.Status := ERR_OK;
			IF USB.Cmd.AutoScan = TRUE THEN
				RefreshTimer(IN := 1, PT := USB.Par.RefreshInterval);
				// Get new USB data
				IF(RefreshTimer.Q) THEN
					RefreshTimer(IN := 0);
					USB.Status := ERR_FUB_BUSY;
					brsmemset(ADR(UsbData), 0, SIZEOF(UsbData));
					StateMachine := USB_CREATE_NODE_ID_LIST;
				END_IF
			ELSE
				RefreshTimer(IN := 0);
			END_IF
			// Refresh USB data every X seconds when enabled
			IF USB.Cmd.ErrorReset = TRUE THEN
				StateMachine := USB_ERROR;
			END_IF

			FOR i := 0 TO IDX_USB_DEV_LIST DO
				gUSBAvailable[i] := USB.Par.IsConnected[i+1];
			END_FOR

			// -----------------------------------------------------------------------------------------------------------
			// Get USB device list
			// -----------------------------------------------------------------------------------------------------------
		USB_CREATE_NODE_ID_LIST:
			GetUsbNodeList.enable := 1;
			GetUsbNodeList.pBuffer := ADR(NodeIdBuffer);
			GetUsbNodeList.bufferSize := SIZEOF(NodeIdBuffer);
			GetUsbNodeList.filterInterfaceClass := asusb_CLASS_MASS_STORAGE;
			GetUsbNodeList.filterInterfaceSubClass := 0;
			GetUsbNodeList;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF GetUsbNodeList.status = 0 THEN
				StateMachine := USB_READ_DEVICE_DATA;
				Node := 1;
				// No USB devices found
			ELSIF GetUsbNodeList.status = asusbERR_USB_NOTFOUND THEN
				// Unlink old device if it is gone now otherwise wait for next round
				FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
					IF(USB.Par.IsConnected[i] = TRUE) THEN
						Node := 1;
						StateMachine := USB_CHECK_LINKED;
						RETURN;
					END_IF
				END_FOR;
				StateMachine := USB_WAIT;
				// Error
			ELSIF GetUsbNodeList.status <> ERR_FUB_BUSY THEN
				USB.Status := GetUsbNodeList.status;
				USB.Err.State := StateMachine;
				IF GetUsbNodeList.status = asusbERR_BUFSIZE THEN
					USB.Err.Text := 'maximum number of devices reached';
				ELSE
					USB.Err.Text := 'error getting device list';
				END_IF;
				StateMachine := USB_ERROR;
			END_IF;
			// -----------------------------------------------------------------------------------------------------------
			// Get device information
			// -----------------------------------------------------------------------------------------------------------
		USB_READ_DEVICE_DATA:
			GetUsbNode.enable := 1;
			GetUsbNode.nodeId := NodeIdBuffer[Node];
			GetUsbNode.pBuffer := ADR(UsbData[Node]);
			GetUsbNode.bufferSize := SIZEOF (UsbData[Node]);
			GetUsbNode;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF GetUsbNode.status = 0 THEN
				// Make sure we have enough space to store USB data, proceed with next StateMachine when all devices are detetced
				IF (Node = GetUsbNodeList.listNodes) OR (Node = MAX_IDX_USB_DEV_LIST) THEN
					Node := 1;
					StateMachine := USB_CHECK_LINKED;
					// Get next USB device
				ELSE
					Node := Node + 1;
				END_IF;
				// Error
			ELSIF GetUsbNode.status <> ERR_FUB_BUSY THEN
				USB.Status := GetUsbNode.status;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'error getting device data';
				StateMachine := USB_ERROR;
			END_IF;
			// -----------------------------------------------------------------------------------------------------------
			// Check if linked device are still present
			// -----------------------------------------------------------------------------------------------------------
		USB_CHECK_LINKED:
			// Proceed to new devices when last device was checked
			IF(Node > MAX_IDX_USB_DEV_LIST) THEN
				Node := 1;
				StateMachine := USB_LINK_NEW;
				RETURN;
			END_IF

			// -----------------------------------------------------------------------------------------------------------
			// Check if device is still active
			IsLinked := FALSE;
			FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
				// Compare old and new data
				IF(brsmemcmp(ADR(UsbDataOld[Node]), ADR(UsbData[i]), SIZEOF(UsbData[i])) = 0) AND
					(USB.Par.IgnoreDongle = FALSE OR (USB.Par.IgnoreDongle = TRUE AND UsbData[i].productId <> BrProductId AND UsbData[i].vendorId <> BrVendorId)) THEN
					// Clear data, mark as linked and EXIT loop
					brsmemset(ADR(UsbData[i]), 0, SIZEOF(UsbData[i]));
					IsLinked := TRUE;
					EXIT;
				END_IF
			END_FOR;

			// -----------------------------------------------------------------------------------------------------------
			// Find next linked device
			IF(IsLinked OR UsbDataOld[Node].interfaceClass = 0) THEN
				IF(Node < MAX_IDX_USB_DEV_LIST) THEN
					Node := Node + 1;
					WHILE(Node < MAX_IDX_USB_DEV_LIST AND UsbDataOld[Node].interfaceClass = 0) DO
						Node := Node + 1;
					END_WHILE;
					IF(Node = MAX_IDX_USB_DEV_LIST AND UsbDataOld[Node].interfaceClass = 0) THEN
						Node := Node + 1;
					END_IF
				ELSE
					Node := Node + 1;
				END_IF
				// Unlink device if it is missing
			ELSE
				StateMachine := USB_UNLINK_DEVICE;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Link new devices
			// -----------------------------------------------------------------------------------------------------------
		USB_LINK_NEW:
			// Return to wait state when last device was checked
			IF(Node > MAX_IDX_USB_DEV_LIST) THEN
				StateMachine := USB_WAIT;
				RETURN;
			END_IF

			// -----------------------------------------------------------------------------------------------------------
			// Find next new device
			IF(UsbData[Node].interfaceClass <> 0) THEN
				IF(USB.Par.IgnoreDongle = FALSE OR (UsbData[Node].productId <> BrProductId AND UsbData[Node].vendorId <> BrVendorId)) THEN
					StateMachine := USB_LINK_DEVICE;
					RETURN;
				END_IF
			END_IF
			Node := Node + 1;
			// -----------------------------------------------------------------------------------------------------------
			// Link device
			// -----------------------------------------------------------------------------------------------------------
		USB_LINK_DEVICE:
			// Find empty slot
			FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
				IF(UsbDataOld[i].interfaceClass = 0) THEN
					EXIT;
				END_IF
			END_FOR;
			// No more slot available
			IF(i = MAX_IDX_USB_DEV_LIST AND UsbDataOld[i].interfaceClass <> 0) THEN
				USB.Status := ERR_MAX_DEVICE;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'maximum number of device reached';
				StateMachine := USB_ERROR;
				RETURN;
			END_IF
			// Create device string
			brsstrcpy(ADR(DevicePara), ADR('/DEVICE='));
			brsstrcat(ADR(DevicePara), ADR(UsbData[Node].ifName));
			brsstrcpy(ADR(DeviceName), ADR('USB'));
			brsitoa(i, ADR(tmpSTR));
			brsstrcat(ADR(DeviceName), ADR(tmpSTR));
			// Link device
			DevLinkSys.enable := 1;
			DevLinkSys.pDevice := ADR(DeviceName);
			DevLinkSys.pParam := ADR(DevicePara);
			DevLinkSys;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF DevLinkSys.status = 0 THEN
				// Store data for new device
				brsmemcpy(ADR(UsbDataOld[i]), ADR(UsbData[Node]), SIZEOF(UsbData[Node]));
				USB.Par.IsConnected[i] := TRUE;
				LinkHandle[i] := DevLinkSys.handle;
				Node := Node + 1;
				StateMachine := USB_LINK_NEW;
				// Error
			ELSIF DevLinkSys.status <> ERR_FUB_BUSY THEN
				USB.Status := DevLinkSys.status;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'error linking device';
				StateMachine := USB_ERROR;
			END_IF;
			// -----------------------------------------------------------------------------------------------------------
			// UnLink device
			// -----------------------------------------------------------------------------------------------------------
		USB_UNLINK_DEVICE:
			DevUnlinkSys.enable := 1;
			DevUnlinkSys.handle := LinkHandle[Node];
			DevUnlinkSys;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF DevUnlinkSys.status = 0 THEN
				// Clear data
				brsmemset(ADR(UsbDataOld[Node]), 0, SIZEOF(UsbDataOld[Node]));
				USB.Par.IsConnected[Node] := FALSE;
				LinkHandle[Node] := 0;
				// Find next linked device
				WHILE(Node < MAX_IDX_USB_DEV_LIST AND UsbDataOld[Node].interfaceClass = 0) DO
					Node := Node + 1;
				END_WHILE;
				IF(Node = MAX_IDX_USB_DEV_LIST AND UsbDataOld[Node].interfaceClass = 0) THEN
					Node := Node + 1;
				END_IF
				StateMachine := USB_CHECK_LINKED;
				// Error
			ELSIF DevUnlinkSys.status <> ERR_FUB_BUSY THEN
				// Clear data
				brsmemset(ADR(UsbDataOld[Node]), 0, SIZEOF(UsbDataOld[Node]));
				USB.Par.IsConnected[Node] := FALSE;
				LinkHandle[Node] := 0;

				brsitoa(Node, ADR(tmpSTR));
				USB.Status := DevUnlinkSys.status;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'error unlinking device no ';
				brsstrcat(ADR(USB.Err.Text), ADR(tmpSTR));
				StateMachine := USB_ERROR;
			END_IF;
			// -----------------------------------------------------------------------------------------------------------
			// Error state
			// -----------------------------------------------------------------------------------------------------------
		USB_ERROR:
			// Get more error information
			IF(USB.Status = 0) THEN
				USB.Status := FileIoGetSysError();
			END_IF

			// Unlink device
			IF(USB.Err.State = USB_LINK_DEVICE) THEN
				DevUnlinkSys.enable := 1;
				DevUnlinkSys.handle := DevLinkSys.handle;
				DevUnlinkSys;
			END_IF

			// Reset error
			IF(USB.Cmd.ErrorReset AND DevUnlinkSys.status <> ERR_FUB_BUSY) THEN
				USB.Cmd.ErrorReset := FALSE;
				brsmemset(ADR(USB.Err), 0, SIZEOF(USB.Err));
				StateMachine := USB_WAIT;
			END_IF
	END_CASE;

END_PROGRAM

PROGRAM _EXIT
	FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
		REPEAT
			DevUnlinkSys.enable := 1;
			DevUnlinkSys.handle := LinkHandle[i];
			DevUnlinkSys;
			UNTIL DevUnlinkSys.status <> ERR_FUB_BUSY
		END_REPEAT;
	END_FOR;
END_PROGRAM
