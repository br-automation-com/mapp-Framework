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
	// BEGIN OF STATE MACHINE 
	CASE DevLinkCtrl.Step OF
		// WAIT STEP 
		STATE_WAIT:
			// UPDATE USB INFO LIST IF THE NODE LIST HAS CHANGED 
			IF (brsmemcmp(ADR(DevLinkCtrl.Params.NodeList), ADR(LastNodeList), SIZEOF(LastNodeList)) <> 0) THEN
				DevLinkCtrl.Cmd.GetUSBInfo := TRUE;
				// preserve the previously created drive information in CASE the order has changed when unplugging a device 
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
				// SKIP IF LOADING USB LIST INFORMATION 
				IF DevLinkCtrl.Cmd.GetUSBInfo THEN
					EXIT;
				END_IF
				// ALWAYS KEEP DEVICES LINKED WHEN AVAILABLE 
				IF ((DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] = 0) AND AttachedUSB[DevLinkCtrl.Params.Index]
					AND (DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index] <> 0)) THEN
					DevLinkCtrl.Cmd.DevLink := TRUE;
					EXIT;
				END_IF
				// UNLINK DEVICE IF IT IS NOT CONNECTED ANYMORE 
				IF ((DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] <> 0) AND
					(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index].interfaceClass <> 8)) THEN
					DevLinkCtrl.Cmd.DevUnlink := TRUE;
					EXIT;
				END_IF
			END_FOR
	
			// CHECK FOR USB DEVICES EVERY 3 SEC 
			TON_0.PT := t#3s;
			IF (TON_0.Q AND NOT DevLinkCtrl.Cmd.GetUSBInfo AND NOT DevLinkCtrl.Cmd.DevLink AND NOT DevLinkCtrl.Cmd.DevUnlink) THEN
				DevLinkCtrl.Cmd.GetUSBList := TRUE;
				TON_0.IN := FALSE;
			ELSE
				TON_0.IN := TRUE;
			END_IF
			TON_0();
	
			IF DevLinkCtrl.Cmd.GetUSBInfo THEN
				// get usb info cmd 
				DevLinkCtrl.Cmd.GetUSBInfo := FALSE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeInfoList), 0, SIZEOF(DevLinkCtrl.Params.NodeInfoList));
				DevLinkCtrl.Step := STATE_GET_USB_INFO;
				DevLinkCtrl.Params.Index := 0;
			ELSIF DevLinkCtrl.Cmd.GetUSBList THEN
				// get usb list cmd 
				DevLinkCtrl.Cmd.GetUSBList := FALSE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeList), 0, SIZEOF(DevLinkCtrl.Params.NodeList));
				DevLinkCtrl.Step := STATE_GET_USB_LIST;
			ELSIF DevLinkCtrl.Cmd.DevLink THEN
				// link cmd 
				DevLinkCtrl.Cmd.DevLink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_LINK;
			ELSIF DevLinkCtrl.Cmd.DevUnlink THEN
				// unlink cmd 
				DevLinkCtrl.Cmd.DevUnlink := FALSE;
				DevLinkCtrl.Step := STATE_DEV_UNLINK;
			END_IF
			// END OF WAIT STEP 

			// GET USB LIST STEP 
		STATE_GET_USB_LIST:
			// SET FUB PARAMS 
			DevLinkCtrl.FUB.UsbNodeListGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeListGet_0.bufferSize := SIZEOF(DevLinkCtrl.Params.NodeList);
			DevLinkCtrl.FUB.UsbNodeListGet_0.pBuffer := ADR(DevLinkCtrl.Params.NodeList);
	
			// ERROR HANDLING 
			IF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status = ERR_OK) OR (DevLinkCtrl.FUB.UsbNodeListGet_0.status = asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_WAIT;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> ERR_FUB_ENABLE_FALSE)
				AND (DevLinkCtrl.FUB.UsbNodeListGet_0.status <> asusbERR_USB_NOTFOUND)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.UsbNodeListGet_0.status;
				DevLinkCtrl.FUB.UsbNodeListGet_0.enable := FALSE;
			END_IF
			// CALL OF FUB 
			DevLinkCtrl.FUB.UsbNodeListGet_0();
			// END OF GET USB LIST STEP 
	
			// GET USB INFO STEP 
		STATE_GET_USB_INFO:
			// SET FUB PARAMS 
			DevLinkCtrl.FUB.UsbNodeGet_0.bufferSize := SIZEOF(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]);
			DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
			DevLinkCtrl.FUB.UsbNodeGet_0.nodeId := DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index];
			DevLinkCtrl.FUB.UsbNodeGet_0.pBuffer := ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]);

			// CHECK IF DevLinkCtrl.Params.Index CONTAINS AN ENTRY 
			IF (DevLinkCtrl.Params.NodeList[DevLinkCtrl.Params.Index] = 0) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := TRUE;
				brsmemset(ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]), 0, SIZEOF(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index]));
				DevLinkCtrl.Params.Index := DevLinkCtrl.Params.Index + 1;
			END_IF

			// ERROR HANDLING 
			IF (DevLinkCtrl.FUB.UsbNodeGet_0.status = ERR_OK) THEN
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
				DevLinkCtrl.Params.Index := DevLinkCtrl.Params.Index + 1;
			ELSIF ((DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.UsbNodeGet_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.UsbNodeGet_0.status;
				DevLinkCtrl.FUB.UsbNodeGet_0.enable := FALSE;
			END_IF

			// END OF LIST REACHED 
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

			// CALL OF FUB
			DevLinkCtrl.FUB.UsbNodeGet_0();
			// END OF GET USB INFO STEP

			// LINK DEVICE STEP
		STATE_DEV_LINK:
            // SET FUB PARAMS 
			DevLinkCtrl.FUB.DevLink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevLink_0.pDevice := ADR(DevLinkCtrl.Params.FileDevName[DevLinkCtrl.Params.Index]);
			brsstrcpy(ADR(DevLinkCtrl.Params.LinkParam), ADR('/DEVICE='));
			brsstrcat(ADR(DevLinkCtrl.Params.LinkParam), ADR(DevLinkCtrl.Params.NodeInfoList[DevLinkCtrl.Params.Index].ifName));
			DevLinkCtrl.FUB.DevLink_0.pParam := ADR(DevLinkCtrl.Params.LinkParam);
	
			// ERROR HANDLING 
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
			// CALL OF FUB 
			DevLinkCtrl.FUB.DevLink_0();
			// END OF LINK DEVICE STEP 
	
			// UNLINK DEVICE STEP 
		STATE_DEV_UNLINK:
			// SET FUB PARAMS 
			DevLinkCtrl.FUB.DevUnlink_0.enable := TRUE;
			DevLinkCtrl.FUB.DevUnlink_0.handle := DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index];
	
			// CHECK IF WE HAVE A HANDLE 
			IF (DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] = 0) THEN
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF
	
			// ERROR HANDLING 
			IF (DevLinkCtrl.FUB.DevUnlink_0.status = ERR_OK) THEN
				DevLinkCtrl.Params.FileDevHandle[DevLinkCtrl.Params.Index] := 0;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			ELSIF ((DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_BUSY) AND (DevLinkCtrl.FUB.DevUnlink_0.status <> ERR_FUB_ENABLE_FALSE)) THEN
				DevLinkCtrl.Step := STATE_ERROR_USB;
				DevLinkCtrl.Params.ErrorID := DevLinkCtrl.FUB.DevUnlink_0.status;
				DevLinkCtrl.FUB.DevUnlink_0.enable := FALSE;
			END_IF
			// CALL OF FUB 
			DevLinkCtrl.FUB.DevUnlink_0();
			// END OF UNLINK DEVICE STEP 
	
			// WAIT FOR ERRACK CMD STEP 
		STATE_ERROR_USB:
			// DELETE ERROR ID AND GO BACK TO WAIT STEP WHEN ERROR IS ACKNOWLEDGED 
			IF DevLinkCtrl.Cmd.ErrAck THEN
				DevLinkCtrl.Params.ErrorID := 0;
				DevLinkCtrl.Cmd.ErrAck := FALSE;
				DevLinkCtrl.Step := STATE_WAIT;
			END_IF
		// END OF WAIT FOR ERRACK STEP 
	END_CASE;
	// END OF STATE MACHINE 
END_PROGRAM

PROGRAM _EXIT
	// Insert code here 
END_PROGRAM
