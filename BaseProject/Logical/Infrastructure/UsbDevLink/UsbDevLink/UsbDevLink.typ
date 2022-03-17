(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:    MITC
 * Created:   21 October, 2015/1:30 PM 
 *********************************************************************************
 * DevLinkTask data types of project
 *********************************************************************************)

TYPE
	StepType : 
		( (*enumeration of the possible machine states*)
		STATE_WAIT := 0, (*waiting for cmds*)
		STATE_GET_USB_LIST, (*getting list of usb devices*)
		STATE_GET_USB_INFO, (*getting info from a usb device*)
		STATE_DEV_LINK, (*linking device*)
		STATE_DEV_UNLINK, (*unlinking device*)
		STATE_ERROR_USB (*some FUB returned an error*)
		);
	CommandType : 	STRUCT  (*possible machine cmds*)
		GetUSBList : BOOL; (*get usb list cmd*)
		GetUSBInfo : BOOL; (*get usb info cmd*)
		DevLink : BOOL; (*link cmd*)
		DevUnlink : BOOL; (*unlink cmd*)
		ErrAck : BOOL; (*error acknowledge cmd*)
	END_STRUCT;
	DevLink_FUBType : 	STRUCT  (*contains all needed FileIO FUBs*)
		UsbNodeListGet_0 : UsbNodeListGet;
		UsbNodeGet_0 : UsbNodeGet;
		UsbMsDeviceReady_0 : UsbMsDeviceReady;
		DevLink_0 : DevLink;
		DevUnlink_0 : DevUnlink;
	END_STRUCT;
	DevLinkCtrlType : 	STRUCT  (*Control structure which contains everything necessary for the file handling machine*)
		Step : StepType; (*actual step*)
		Cmd : CommandType; (*when in STATE_WAIT a cmd with value true will change the machine state*)
		FUB : DevLink_FUBType; (*all DevLink FUBs*)
		Params : ParamsType; (*parameters like file device, error ID, Buffer, ...*)
	END_STRUCT;
	ParamsType : 	STRUCT  (*Parameter structure*)
		ErrorID : UINT; (*the error id from a FUB is stored here in case of error*)
		NodeList : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF UDINT; (*List of connected usb devices*)
		NodeInfoList : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF usbNode_typ; (*Buffer for usb info*)
		FileDevName : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF STRING[30]; (*file device names*)
		FileDevHandle : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF UDINT; (*needed for unlinking the device again*)
		LinkParam : STRING[30]; (*param string to link a device*)
		Index : USINT; (*list index*)
	END_STRUCT;
END_TYPE
