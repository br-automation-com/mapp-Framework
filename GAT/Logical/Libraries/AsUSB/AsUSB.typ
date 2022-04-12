                                                                      
TYPE
    usbNode_typ			: STRUCT		(* statistics *)
	interfaceClass		: UINT;			(* Interface Class des USB Gerätes *)
	interfaceSubClass	: UINT;			(* Interface SubClass des USB Gerätes *)
	interfaceProtocol	: UINT;			(* Interface Protocol des USB Gerätes *)
	vendorId			: UINT;			(* Device Vendor ID *)
	productId			: UINT;			(* Device Product ID *)
	bcdDevice			: UINT;			(* USB device release version binary coded decimal *)
	ifName				: STRING[127];	(* USB IF Name *)
	END_STRUCT;
END_TYPE

TYPE
	usbDeviceDescr_typ	: STRUCT		(* statistics *)
    length				: USINT;		(* bLength *)
    descriptorType		: USINT;		(* bDescriptorType *)
    bcdUsb				: UINT;		    (* bcdUSB - USB release in BCD *)
    deviceClass			: USINT;	    (* bDeviceClass *)
    deviceSubClass		: USINT;		(* bDeviceSubClass *)
    deviceProtocol		: USINT;		(* bDeviceProtocol *)
    maxPacketSize0		: USINT;		(* bMaxPacketSize0 *)
    vendor				: UINT;			(* idVendor *)
    product				: UINT;			(* idProduct *)
    bcdDevice			: UINT;			(* bcdDevice - dev release in BCD *)
    manufacturerIndex	: USINT;		(* iManufacturer *)
    productIndex		: USINT;		(* iProduct *)
    serialNumberIndex	: USINT;		(* iSerialNumber *)
    numConfigurations	: USINT;		(* bNumConfigurations *)
	END_STRUCT;
END_TYPE

TYPE   
	usbConfigDescr_typ	: STRUCT		(* statistics *)
	bLength				: USINT;		(* Size of this descriptor in bytes *)
    bDescriptorType		: USINT;		(* CONFIGURATION Descriptor Type *)
    wTotalLength		: UINT;			(* Configuration data length *)
    bNumInterfaces		: USINT;		(* Number of interfaces supported *)
    bConfigurationValue	: USINT;		(* SetConfiguration() function argument *)
    iConfiguration		: USINT;	   	(* Configuration string descriptor *)
    bmAttributes		: USINT;	    (* Bitmap configuration characteristics *)
    MaxPower			: USINT;		(* Max pwr consumption (mA) of operational device on bus *)
	END_STRUCT;
END_TYPE

TYPE
	usbStringDescr_typ	: STRUCT		(* statistics *)
    length				: USINT;		(* bLength *)
    descriptorType		: USINT;		(* bDescriptorType *)
    string				: STRING[1];	(* bString - variable len *)
	END_STRUCT;
END_TYPE

TYPE
	usbInterfaceDescr_typ	: STRUCT	(* statistics *)
    bLength					: USINT;	(* Size of this descriptor in bytes *)
    bDescriptorType			: USINT;	(* Interface Descriptor Type *)
    bInterfaceNumber		: USINT;	(* Zero-based interface number *)
    bAlternateSetting		: USINT;	(* Alternate setting for interface *)
    bNumEndpoints			: USINT;    (* Num of endpoints (excluding endpoint zero) *)
    bInterfaceClass			: USINT;	(* Class code of this interface *)
    bInterfaceSubClass		: USINT;	(* Subclass code of this interface *)
    bInterfaceProtocol		: USINT;	(* Interface protocol code *)
    iInterface				: USINT;	(* Interface string descriptor *)
	END_STRUCT;
END_TYPE

TYPE
	usbEndpointDescr_typ	: STRUCT	(* statistics *)
    bLength					: USINT;	(* Descriptor length in bytes *)
    bDescriptorType			: USINT;	(* Endpoint Descriptor type *)
    bEndpointAddress		: USINT;	(* Endpoint address on the USB device *)
    bmAttributes			: USINT;	(* Endpoint transfer, sych & usage types attr *)
    wMaxPacketSize			: UINT;		(* Endpoint max packet size *)
    bInterval				: USINT;	(* Polling interval for endpoint data xfer *)
	END_STRUCT;
END_TYPE


