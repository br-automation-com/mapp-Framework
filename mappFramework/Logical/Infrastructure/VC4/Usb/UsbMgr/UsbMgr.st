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
				TON_01(IN := 1, PT := USB.Par.RefreshInterval);
				// Get new USB data
				IF(TON_01.Q) THEN
					TON_01(IN := 0);
					USB.Status := ERR_FUB_BUSY;
					brsmemset(ADR(Usb_data), 0, SIZEOF(Usb_data));
					StateMachine := USB_CREATE_NODE_ID_LIST;
				END_IF
			ELSE
				TON_01(IN := 0);
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
			UsbNodeListGet_0.enable := 1;
			UsbNodeListGet_0.pBuffer := ADR(Node_id_buffer);
			UsbNodeListGet_0.bufferSize := SIZEOF(Node_id_buffer);
			UsbNodeListGet_0.filterInterfaceClass := asusb_CLASS_MASS_STORAGE;
			UsbNodeListGet_0.filterInterfaceSubClass := 0;
			UsbNodeListGet_0;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF UsbNodeListGet_0.status = 0 THEN
				StateMachine := USB_READ_DEVICE_DATA;
				Node := 1;
				// No USB devices found
			ELSIF UsbNodeListGet_0.status = asusbERR_USB_NOTFOUND THEN
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
			ELSIF UsbNodeListGet_0.status <> ERR_FUB_BUSY THEN
				USB.Status := UsbNodeListGet_0.status;
				USB.Err.State := StateMachine;
				IF UsbNodeListGet_0.status = asusbERR_BUFSIZE THEN
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
			UsbNodeGet_0.enable := 1;
			UsbNodeGet_0.nodeId := Node_id_buffer[Node];
			UsbNodeGet_0.pBuffer := ADR(Usb_data[Node]);
			UsbNodeGet_0.bufferSize := SIZEOF (Usb_data[Node]);
			UsbNodeGet_0;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF UsbNodeGet_0.status = 0 THEN
				// Make sure we have enough space to store USB data, proceed with next StateMachine when all devices are detetced
				IF (Node = UsbNodeListGet_0.listNodes) OR (Node = MAX_IDX_USB_DEV_LIST) THEN
					Node := 1;
					StateMachine := USB_CHECK_LINKED;
					// Get next USB device
				ELSE
					Node := Node + 1;
				END_IF;
				// Error
			ELSIF UsbNodeGet_0.status <> ERR_FUB_BUSY THEN
				USB.Status := UsbNodeGet_0.status;
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
			Is_linked := FALSE;
			FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
				// Compare old and new data
				IF(brsmemcmp(ADR(Usb_data_old[Node]), ADR(Usb_data[i]), SIZEOF(Usb_data[i])) = 0) AND
					(USB.Par.IgnoreDongle = FALSE OR (USB.Par.IgnoreDongle = TRUE AND Usb_data[i].productId <> BRproductId AND Usb_data[i].vendorId <> BRvendorId)) THEN
					// Clear data, mark as linked and EXIT loop
					brsmemset(ADR(Usb_data[i]), 0, SIZEOF(Usb_data[i]));
					Is_linked := TRUE;
					EXIT;
				END_IF
			END_FOR;

			// -----------------------------------------------------------------------------------------------------------
			// Find next linked device
			IF(Is_linked OR Usb_data_old[Node].interfaceClass = 0) THEN
				IF(Node < MAX_IDX_USB_DEV_LIST) THEN
					Node := Node + 1;
					WHILE(Node < MAX_IDX_USB_DEV_LIST AND Usb_data_old[Node].interfaceClass = 0) DO
						Node := Node + 1;
					END_WHILE;
					IF(Node = MAX_IDX_USB_DEV_LIST AND Usb_data_old[Node].interfaceClass = 0) THEN
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
			IF(Usb_data[Node].interfaceClass <> 0) THEN
				IF(USB.Par.IgnoreDongle = FALSE OR (Usb_data[Node].productId <> BRproductId AND Usb_data[Node].vendorId <> BRvendorId)) THEN
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
				IF(Usb_data_old[i].interfaceClass = 0) THEN
					EXIT;
				END_IF
			END_FOR;
			// No more slot available
			IF(i = MAX_IDX_USB_DEV_LIST AND Usb_data_old[i].interfaceClass <> 0) THEN
				USB.Status := ERR_MAX_DEVICE;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'maximum number of device reached';
				StateMachine := USB_ERROR;
				RETURN;
			END_IF
			// Create device string
			brsstrcpy(ADR(Device_param), ADR('/DEVICE='));
			brsstrcat(ADR(Device_param), ADR(Usb_data[Node].ifName));
			brsstrcpy(ADR(Device_name), ADR('USB'));
			brsitoa(i, ADR(tmpSTR));
			brsstrcat(ADR(Device_name), ADR(tmpSTR));
			// Link device
			DevLink_0.enable := 1;
			DevLink_0.pDevice := ADR(Device_name);
			DevLink_0.pParam := ADR(Device_param);
			DevLink_0;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF DevLink_0.status = 0 THEN
				// Store data for new device
				brsmemcpy(ADR(Usb_data_old[i]), ADR(Usb_data[Node]), SIZEOF(Usb_data[Node]));
				USB.Par.IsConnected[i] := TRUE;
				Link_handle[i] := DevLink_0.handle;
				Node := Node + 1;
				StateMachine := USB_LINK_NEW;
				// Error
			ELSIF DevLink_0.status <> ERR_FUB_BUSY THEN
				USB.Status := DevLink_0.status;
				USB.Err.State := StateMachine;
				USB.Err.Text := 'error linking device';
				StateMachine := USB_ERROR;
			END_IF;
			// -----------------------------------------------------------------------------------------------------------
			// UnLink device
			// -----------------------------------------------------------------------------------------------------------
		USB_UNLINK_DEVICE:
			DevUnlink_0.enable := 1;
			DevUnlink_0.handle := Link_handle[Node];
			DevUnlink_0;

			// --------------------------------------------------------------------------------------------------------------------
			// Success
			IF DevUnlink_0.status = 0 THEN
				// Clear data
				brsmemset(ADR(Usb_data_old[Node]), 0, SIZEOF(Usb_data_old[Node]));
				USB.Par.IsConnected[Node] := FALSE;
				Link_handle[Node] := 0;
				// Find next linked device
				WHILE(Node < MAX_IDX_USB_DEV_LIST AND Usb_data_old[Node].interfaceClass = 0) DO
					Node := Node + 1;
				END_WHILE;
				IF(Node = MAX_IDX_USB_DEV_LIST AND Usb_data_old[Node].interfaceClass = 0) THEN
					Node := Node + 1;
				END_IF
				StateMachine := USB_CHECK_LINKED;
				// Error
			ELSIF DevUnlink_0.status <> ERR_FUB_BUSY THEN
				// Clear data
				brsmemset(ADR(Usb_data_old[Node]), 0, SIZEOF(Usb_data_old[Node]));
				USB.Par.IsConnected[Node] := FALSE;
				Link_handle[Node] := 0;

				brsitoa(Node, ADR(tmpSTR));
				USB.Status := DevUnlink_0.status;
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
				DevUnlink_0.enable := 1;
				DevUnlink_0.handle := DevLink_0.handle;
				DevUnlink_0;
			END_IF

			// Reset error
			IF(USB.Cmd.ErrorReset AND DevUnlink_0.status <> ERR_FUB_BUSY) THEN
				USB.Cmd.ErrorReset := FALSE;
				brsmemset(ADR(USB.Err), 0, SIZEOF(USB.Err));
				StateMachine := USB_WAIT;
			END_IF
	END_CASE;

END_PROGRAM

PROGRAM _EXIT
	FOR i:=1 TO MAX_IDX_USB_DEV_LIST DO
		REPEAT
			DevUnlink_0.enable := 1;
			DevUnlink_0.handle := Link_handle[i];
			DevUnlink_0;
			UNTIL DevUnlink_0.status <> ERR_FUB_BUSY
		END_REPEAT;
	END_FOR;
END_PROGRAM
