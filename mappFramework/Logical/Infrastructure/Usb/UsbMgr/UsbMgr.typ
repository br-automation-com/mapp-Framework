
TYPE
	UsbStateEnum : 
		(
		USB_WAIT, (*Wait for starting the Function chain*)
		USB_CREATE_NODE_ID_LIST, (*Create a list of Node-IDs from all active USB devices*)
		USB_READ_DEVICE_DATA, (*Read out the specific data from the Node-IDs*)
		USB_CHECK_LINKED, (*Check if device is still connected*)
		USB_LINK_NEW,
		USB_LINK_DEVICE, (*Link file device*)
		USB_UNLINK_DEVICE, (*Unlink the File Device from specific path*)
		USB_ERROR (*Jump to this step in every case of Error occuring in the Function chain*)
		);
	UsbCmdType : 	STRUCT 
		AutoScan : BOOL := TRUE; (*Scan USB ports automatically*)
		ErrorReset : BOOL; (*Reset error*)
	END_STRUCT;
	UsbParType : 	STRUCT 
		IgnoreDongle : BOOL := TRUE; (*Ignoe B&R license dongle*)
		RefreshInterval : UINT := 300; (*Intervall timer for USB device refresh*)
		IsConnected : ARRAY[0..MAX_IDX_USB_DEV_LIST]OF BOOL; (*Shows if a USB stick is connected*)
	END_STRUCT;
	UsbErrType : 	STRUCT 
		State : UsbStateEnum; (*State where the error occured*)
		Text : STRING[80]; (*Error text*)
	END_STRUCT;
	UsbMainType : 	STRUCT 
		Cmd : UsbCmdType; (*Command structure*)
		Par : UsbParType; (*Parameter structure*)
		Err : UsbErrType; (*Error structure*)
		Status : UINT; (*Current status*)
	END_STRUCT;
END_TYPE
