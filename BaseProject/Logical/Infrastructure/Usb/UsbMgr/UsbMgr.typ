(*Structure types*)

TYPE
	DevLink_FUBType : 	STRUCT  (*Contains all FileIO function blocks*)
		UsbNodeListGet_0 : UsbNodeListGet; (*UsbNoteListGet instance*)
		UsbNodeGet_0 : UsbNodeGet; (*UsbNodeGet instance*)
		UsbMsDeviceReady_0 : UsbMsDeviceReady; (*UsbMsDeviceReady instance*)
		DevLink_0 : DevLink; (*DevLink instance*)
		DevUnlink_0 : DevUnlink; (*DevUnlink instance*)
	END_STRUCT;
	DevLinkControlType : 	STRUCT  (*Control structure which contains everything necessary for the file handling machine*)
		Step : StepType; (*Current step*)
		Commands : UsbCommandsType; (*Commands*)
		Parameters : UsbParametersType; (*Parameters*)
		FUB : DevLink_FUBType; (*All FileIO FUBs*)
	END_STRUCT;
	UsbCommandsType : 	STRUCT  (*USB commands structure*)
		GetUSBList : BOOL; (*Get usb list *)
		GetUSBInfo : BOOL; (*Get usb info*)
		DevLink : BOOL; (*Devlink*)
		DevUnlink : BOOL; (*Devunlink*)
		ErrAck : BOOL; (*Acknowledge error*)
	END_STRUCT;
	UsbParametersType : 	STRUCT  (*USB parameters structure*)
		ErrorID : UINT; (*FUB error ID*)
		NodeList : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF UDINT; (*List of connected usb devices*)
		NodeInfoList : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF usbNode_typ; (*Buffer for usb info*)
		FileDevName : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF STRING[30]; (*File device names*)
		FileDevHandle : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF UDINT; (*File device handle (needed for unlinking the device)*)
		LinkParam : STRING[30]; (*Parameter string to link a device*)
		Index : USINT; (*List index*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	StepType : 
		( (*Enumeration of the possible machine states*)
		STATE_WAIT := 0, (*Wait state*)
		STATE_GET_USB_LIST, (*Getting list of usb devices*)
		STATE_GET_USB_INFO, (*Getting info from a usb device*)
		STATE_DEV_LINK, (*Linking device*)
		STATE_DEV_UNLINK, (*Unlinking device*)
		STATE_ERROR_USB (*Some FUB returned an error*)
		);
END_TYPE
