                                                                      
{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetInaNode			(*reads the node number from the AR registry for a INA device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		InaNode			: USINT;		(*INA node number*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetInaNode			(*enters the node number into the AR registry for INA device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: DINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		InaNode			: USINT;		(*INA node number*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetIPAddr				(*reads IP address from the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pIPAddr			: UDINT;		(*IP address given as a pointer*)
		Len				: USINT;		(*length of the string (pIPAddr) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetIPAddr				(*enters IP address into the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pIPAddr			: UDINT;		(*IP address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
		Option			: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSubnetMask			(*reads subnet mask from the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pSubnetMask		: UDINT;		(*subnet mask given as a pointer*)
		Len				: USINT;		(*length of the string (pSubnetMask) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
		i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSubnetMask			(*enters subnet mask into the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pSubnetMask		: UDINT;		(*subnet mask given as a pointer, valid range "1.0.0.1" - "255.255.255.254"*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetClusterIPAddr				(*reads Cluster IP address from the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pIPAddr			: UDINT;		(*Cluster IP address given as a pointer*)
		pSubnetMask		: UDINT;		(*Cluster subnet mask given as a pointer*)
		LenIp			: USINT;		(*length of the string (pIPAddr) -> ideally, Len = 16*)
		LenSnmk			: USINT;		(*length of the string (pSubnetMask) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetClusterIPAddr				(*enters Cluster IP address into the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pIPAddr			: UDINT;		(*Cluster IP address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
		pSubnetMask		: UDINT;		(*Cluster subnet mask given as a pointer, valid range "1.0.0.1" - "255.255.255.254"*)
		Option			: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDefaultGateway		(*reads default gateway from AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pGateway		: UDINT;		(*default gateway address given as pointer*)
		Len				: USINT;		(*length of the string (pGateway) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDefaultGateway		(*enters default gateway into AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pGateway		: UDINT;		(*default gateway address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetBroadcastAddr		(*reads broadcast address from AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pBroadcastAddr	: UDINT;		(*broadcast address given as a pointer*)
		Len				: USINT;		(*length of the string (pBroadcastAddr) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetBroadcastAddr		(*enters broadcast address into the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pBroadcastAddr	: UDINT;		(*broadcast address given as a pointer, valid range "1.0.0.1" - "255.255.255.255"*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetEthBaudrate		(*reads the baud rate from the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		Baudrate		: UDINT;		(*baud rate, e.g. cfgETHBAUDRATE_AUTO, cfgETHBAUDRATE_10, cfgETHBAUDRATE_10FD ...*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetEthBaudrate		(*enters the baud rate into the AR registry for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		Baudrate		: UDINT;		(*Ethernet baud rate, e.g. cfgETHBAUDRATE_AUTO, cfgETHBAUDRATE_10, cfgETHBAUDRATE_10FD ...*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetEthConfigMode		(*reads the configuration mode; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		ConfigMode		: UDINT;		(*configuration mode: cfgCONFIGMODE_MANUALLY, cfgCONFIGMODE_DHCPCLIENT*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetEthConfigMode		(*modifies the configuration mode for Ethernet device; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		ConfigMode		: UDINT;		(*configuration mode: cfgCONFIGMODE_MANUALLY, cfgCONFIGMODE_DHCPCLIENT*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetHostName			(*reads a host name for a target; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pHostName		: UDINT;		(*hostname*)
		Len				: USINT;		(*length of the string (HostName)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetHostName			(*sets a host name for a target; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pHostName		: UDINT;		(*hostname*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetHostNameIf			(*reads a host name for a interface; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pHostName		: UDINT;		(*hostname*)
		Len				: USINT;		(*length of the string (HostName)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetHostNameIf			(*sets a host name for a interface; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pHostName		: UDINT;		(*hostname*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetMacAddr			(*reads the MAC address of an Ethernet device*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*INA device name given as pointer (syntax: SL<x>.SS<y>.IF<z>)*)
		pMacAddr		: UDINT;		(*MAC address (pointer to buffer where the MAC address should be written)*)
		Len				: USINT;		(*length of the MAC address (buffer - pMacAddr) -> normally 6 bytes*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetFTPServer			(*enables/disables the FTP server; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		Option			: UDINT;		(*options: cfgOPTION_DISABLE, cfgOPTION_ENABLE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetTimeOffset			(*returns the configured time offset; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		timeoffset		: INT;			(*configured time offset*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetTimeOffset			(*sets a time offset; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
        timeoffset		: INT;			(*configured time offset*)
        option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSntpServer			(*starts the SNTP server; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
        start			: UDINT;		(*1 Starts the SNTP server*)
        option			: UDINT;		(*Options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSntpClient			(*starts and stops the SNTP client; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		run				: UDINT;		(*0 stop client, 1 start client*)
		pServerAddr		: UDINT;		(*pointer to a string with the IP address of the SNTP server*)
		sntpcInterval	: UINT;			(*interval in minutes that it takes for the SNTP client to synchronize the time with the server*)
		rtcInterval		: UINT;			(*interval in minutes that it takes to synchronize the RTC with the software time during SNTP operation*)
		option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		syncStatus		: USINT;		(*0 Client not active, 1 Client already active, but time not received from server, ...*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSntpcData			(*returns the parameters relevant for the SNTP client; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pServerAddr		: UDINT;		(*pointer to a long enough string to contain the server address or server name*)
		Len				: USINT;		(*length of the string (pServerAddr)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		run				: UDINT;		(*1 Client active, 0 Client inactive*)
        sntpcInterval	: UINT;			(*interval that it takes for the SNTP client to synchronize the time with the server*)
        rtcInterval		: UINT;			(*interval that it take to synchronize the RTC with the software time during SNTP operation*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSntpsData			(*returns whether the SNTP server is active; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		run				: UDINT;		(*1 server active, 0 server inactive*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetNtpServer			(*starts or stops the NTP-Server; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)(**)(*#PAR*)
        start			: UDINT;		(*0 stop server, 1 start server*)(**)(*#PAR*)
       	option			: UDINT;		(*Options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)(**)(*#PAR*)
	END_VAR
	
	VAR_OUTPUT
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)(**)(*#PAR*)
	END_VAR
	
	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
		i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetNtpsData			(*returns whether the NTP server is active; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)(**)(*#PAR*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)(**)(*#PAR*)
		run				: UDINT;		(*1 server active, 0 server inactive*)(**)(*#PAR*)
	END_VAR

	VAR
       	i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
		i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetNtpClient			(*starts or stops the NTP client; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)(**)(*#PAR*)
		start			: UDINT;		(*0 stop client, 1 start/restart client*)(**)(*#PAR*)
		pServerAddress1	: UDINT;		(*string with the IP address of the first NTP server*)(**)(*#PAR*)
		pServerAddress2	: UDINT;		(*string with the IP address of the second NTP server or ""*)(**)(*#PAR*)
		pServerAddress3	: UDINT;		(*string with the IP address of the third NTP server or ""*)(**)(*#PAR*)
		pServerAddress4	: UDINT;		(*string with the IP address of the fourth NTP server or ""*)(**)(*#PAR*)
		option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)(**)(*#PAR*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)(**)(*#PAR*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
		i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetNtpcData			(*returns the parameters relevant for the NTP client; asynchronous execution*)
	VAR_INPUT
	    enable			: BOOL;			(*enables execution*)(**)(*#PAR*)
		pServerAddress1	: UDINT;		(*string that contains the server address or server name*)(**)(*#PAR*)
		pServerAddress2	: UDINT;		(*string that contains the server address or server name*)(**)(*#PAR*)
		pServerAddress3	: UDINT;		(*string that contains the server address or server name*)(**)(*#PAR*)
		pServerAddress4	: UDINT;		(*string that contains the server address or server name*)(**)(*#PAR*)
		len				: USINT;		(*length of the strings pServerAddress[x]*)(**)(*#PAR*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)(**)(*#PAR*)
		run				: UDINT;		(*0 Client inactive, 1 Client active*)(**)(*#PAR*)
		syncStatus		: UDINT;		(*0 client not synchronized, 1 client already synchronized*)(**)(*#PAR*)
	END_VAR

	VAR
      	i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetTimeZone			(*function block returns the ID of the currently active timezone; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		timezoneID		: UINT;
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetTimeZone			(*function block can be used to set the time zone using its ID; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		timezoneID		: UINT;
		option			: UDINT;
	END_VAR

	VAR_OUTPUT
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetTimeZoneInfo		(*function block returns the time offset between a timezone and GMT during normal time (gmt) and during summer time (gmtDst); asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		timezoneID		: UINT;
	END_VAR

	VAR_OUTPUT
		gmt				: INT;
		gmtDst			: INT;
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetTimeZoneEntry		(*function block returns the times when the time switches for a particular timezone in a specified year; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		timezoneID		: UINT;
		year			: UINT;
	END_VAR

	VAR_OUTPUT
		dateDst			: DATE_AND_TIME;
		dateNormal		: DATE_AND_TIME;
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDst				(*function block returns whether automatic daylight savings time is activated (1) or not (0); asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		dst				: BOOL;
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDst				(*function block can be used to enable or disable automatic daylight savings time; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		dst				: BOOL;
		option			: UDINT;
	END_VAR

	VAR_OUTPUT
        status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetCIFSDomain			(*cifs - reads domain name from the AR registry; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDomain			: UDINT;		(*Domainname given as a pointer*)
		Len				: USINT;		(*length of the string (pDomain) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		isWorkgroup		: USINT;		(*specifies if Workgroup or Domain*)
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetCIFSDomain			(*cifs - enters domain into the AR registry; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDomain			: UDINT;		(*Domainname given as pointer*)
		isWorkgroup		: USINT;		(*specifies if Workgroup or Domain cfgOPTION_NON_WORKGROUP, cfgOPTION_WORKGROUP*)
		Option			: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetCIFSDefaultuser	(*cifs - reads default user from the AR registry; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		pDefaultuser		: UDINT;		(*Default Username given as a pointer*)
		lenUser				: USINT;		(*length of the string (pDefaultuser) -> ideally, Len = 16*)
		pDefaultpassword	: UDINT;		(*Default Password given as a pointer*)
		lenPassword			: USINT;		(*length of the string (pDefaultpassword) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetCIFSDefaultuser	(*cifs - enters default user into the AR registry; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		pDefaultuser		: UDINT;		(*Default Username given as pointer*)
		pDefaultpassword	: UDINT;		(*Default Password given as a pointer*)
		Option				: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDhcpServer 	(*dhcp - starts or stops dhcp server; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		start				: UDINT;		(*1 = start server; 0 = stop server*)
		option				: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDhcpsData 	(*dhcp - configures dhcp server; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		pInterfaceList		: UDINT;		(*provided interfaces*)
		pLeases				: UDINT;		(*provided leases*)
		numLeases			: UDINT;		(*number of leases*)
		option				: UDINT;		(*options:  cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDhcpsData 	(*dhcp - reads configuration of dhcp server; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		pInterfaceList		: UDINT;		(*provided interfaces*)
		len					: UDINT;		(*length of the string (pInterfaces)*)
		pLeases				: UDINT;		(*provided leases*)
		numLeases			: UDINT;		(*number of leases*)
	END_VAR

	VAR_OUTPUT
		startMode		: UDINT;		(*1 = server is working; 0 = server is not working*)
		numNeeded		: UDINT;		(*needed length*)
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDhcpcOption 	(*dhcp - sets an option for a dhcp client; asynchronous execution*)
	VAR_INPUT
		enable				: BOOL;			(*enables execution*)
		code				: USINT;		(*number of the option*)
		length				: USINT;		(*length of the option*)
		pValue				: UDINT;		(*value of the option*)
		pDevice				: UDINT;		(*provided interface*)
		option				: UDINT;		(*reserved*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION_BLOCK CfgSetSdmStatus			(*enables/disables data refresh of system diagnostics manager; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		start			: UDINT;		(*options: cfgOPTION_ENABLE_SDM; cfgOPTION_DISABLE_SDM*)
		Option			: UDINT;		(*reserve*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION_BLOCK CfgGetSdmStatus			(*returns whether the system diagnostics manager is active; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		run				: UDINT;		(*status: cfgSTATUS_SDM_ENABLED, cfgSTATUS_SDM_DISABLED*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION CfgClearNV		: UINT			(*clear non volatile data*)
END_FUNCTION

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSdmColor			(*set the system diagnostics manager color scheme; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		red  			: UDINT;  		(*red value (0-255)*)
		green  			: UDINT;  		(*green value (0-255)*)
		blue  			: UDINT;  		(*blue value (0-255)*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSdmColor			(*get the system diagnostics manager color scheme; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, 0xXXXX = see help*)
		red  			: UDINT;  		(*red value (0-255)*)
		green  			: UDINT;  		(*green value (0-255)*)
		blue  			: UDINT;  		(*blue value (0-255)*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSdmCustomData1 	(*sdm - get custom data 1; asynchronous execution *)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*Devicename given as a pointer*)
		lenDevice		: UDINT;		(*length of the string (pDevice) -> ideally, Len = 255*)
		pFile			: UDINT;		(*Filename given as a pointer*)
		lenFile			: UDINT;		(*length of the string (pFile) -> ideally, Len = 255*)
		pDatamodule		: UDINT;		(*Datamodulename given as a pointer*)
		lenDatamodule	: UDINT;		(*length of the string (pDatamodule) -> ideally, Len = 255*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSdmCustomData1 	(*sdm - set custom data 1; asynchronous execution *)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*Devicename given as a pointer*)
		pFile			: UDINT;		(*Filename given as a pointer*)
		pDatamodule		: UDINT;		(*Datamodulename given as a pointer*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetSdmCustomData2 	(*sdm - get custom data 2; asynchronous execution *)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*Devicename given as a pointer*)
		lenDevice		: UDINT;		(*length of the string (pDevice) -> ideally, Len = 255*)
		pFile			: UDINT;		(*Filename given as a pointer*)
		lenFile			: UDINT;		(*length of the string (pFile) -> ideally, Len = 255*)
		pDatamodule		: UDINT;		(*Datamodulename given as a pointer*)
		lenDatamodule	: UDINT;		(*length of the string (pDatamodule) -> ideally, Len = 255*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetSdmCustomData2 	(*sdm - set custom data 2; asynchronous execution *)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice			: UDINT;		(*Devicename given as a pointer*)
		pFile			: UDINT;		(*Filename given as a pointer*)
		pDatamodule		: UDINT;		(*Datamodulename given as a pointer*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebMimeType 	(*webserver - set mime type; asynchronous execution *)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pFileExtension	: UDINT;		(*Fileextension gives a pointer*)
		pMimeType		: UDINT;		(*MimeType given as a pointer*)
		len				: UDINT;		(*length of the string (pMimeType) -> ideally, Len = 255*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetWebMimeType 	(*webserver - get mime type; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		mode			: BOOL;			(*cfgWEB_MODE_MIME_DEL(0) or cfgWEB_MODE_MIME_ADD(1)*)
		pFileExtension	: UDINT;		(*Fileextension gives a pointer*)
		pMimeType		: UDINT;		(*MimeType given as a pointer*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK


{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebServerHttpsConfig (*webserver - get port number and name of configured ssl configuration; asynchronous execution*)
	VAR_INPUT
		enable :  BOOL; (*enables execution*)
	END_VAR
	VAR_OUTPUT
		status : UINT; (*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		sslCfgName :  STRING[255]; (*name of SSL configuration*)
		port :  UINT; (*port number*)
	END_VAR
	VAR
		i_state :  UINT; (*internal variable*)
		i_result : UINT; (*internal variable*)
		i_tmp :  UDINT; (*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebServerPort 	(*webserver - get port number; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		port  			: UINT;  		(*port number*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebServerDevice 	(*webserver - get webserver root directory; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDevice 		: UDINT;  		(*Root directory name given as pointer*)
		len				: UDINT;		(*length of the string (pDevice) -> ideally, Len = 255*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebAspGoform 	(*webserver - get webserver ASP form; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		mode			: UINT;			(*webserver - get webserver ASP form*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetWebAspGoform 	(*webserver - set webserver ASP form; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		mode			: UINT;			(*webserver - set webserver ASP form*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetWebServerStatus 	(*webserver - get webserver status; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		mode			: UINT;			(*cfgWEB_MODE_DISABLED(0) cfgWEB_MODE_ENABLED(1)*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetWebServerStatus 	(*webserver - set webserver status; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		mode			: UINT;			(*cfgWEB_MODE_DISABLED(0) cfgWEB_MODE_ENABLED(1)*)
		Option			: UDINT;		(*options: cfgOPTION_VOLATILE, cfgOPTION_NON_VOLATILE*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDnsMode		(*returns whether the DNS service is active and using DHCP; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
		mode			: UINT;		(*cfgOPTION_DNS_OFF (0) or cfgOPTION_DNS_ON_CONFIG (1) or cfgOPTION_DNS_ON_DHCP (2)*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDnsMode	(*Activate or deactivate the DNS service, get server address from configuration or from DHCP; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		mode			: UINT;			(*cfgOPTION_DNS_OFF (0) or cfgOPTION_DNS_ON_CONFIG (1) or cfgOPTION_DNS_ON_DHCP (2)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDnsSuffix		(*Get the DNS suffix / default Domain; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pSuffix			: UDINT;		(*pointer to a long enough string to contain the Dns suffix*)
		Len				: USINT;		(*length of the string (pSuffix)*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDnsSuffix	(*Set the DNS suffix / default Domain; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pSuffix			: UDINT;		(*pointer to a string with the DNS suffix*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgGetDnsAddress		(*Get the configured  DNS server address; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDnsAddr1		: UDINT;		(*First DNS Server address given as pointer*)
		pDnsAddr2		: UDINT;		(*Second DNS Server address given as pointer*)
		pDnsAddr3		: UDINT;		(*Third DNS Server address given as pointer*)
		Len1			: USINT;		(*length of the string (pDnsAddr1) -> ideally, Len = 16*)
		Len2			: USINT;		(*length of the string (pDnsAddr2) -> ideally, Len = 16*)
		Len3			: USINT;		(*length of the string (pDnsAddr3) -> ideally, Len = 16*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgSetDnsAddress		(*Set up to three DNS server address; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pDnsAddr1		: UDINT;		(*First DNS Server address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
		pDnsAddr2		: UDINT;		(*Second DNS Server address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
		pDnsAddr3		: UDINT;		(*Third DNS Server address given as pointer, valid range "1.0.0.1" - "247.255.255.255"*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgRouteAdd		(*add a static route; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pIPAddr			: UDINT;		(*Destination IP address given as pointer*)
		pSubnetMask		: UDINT;		(*Subnetmask given as pointer*)
		pGateway		: UDINT;		(*Gateway given as pointer*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} {REDUND_UNREPLICABLE} FUNCTION_BLOCK CfgRouteDelete		(*delete a static route; asynchronous execution*)
	VAR_INPUT
		enable			: BOOL;			(*enables execution*)
		pIPAddr			: UDINT;		(*Destination IP address given as pointer*)
		pSubnetMask		: UDINT;		(*Subnetmask given as pointer*)
		pGateway		: UDINT;		(*Gateway given as pointer*)
	END_VAR

	VAR_OUTPUT
		status			: UINT;			(*execution status: ERR_OK, ERR_FUB_ENABLE_FALSE, ERR_FUB_BUSY, 0xXXXX = see help*)
	END_VAR

	VAR
        i_state			: UINT;			(*internal variable*)
		i_result		: UINT;			(*internal variable*)
        i_tmp			: UDINT;		(*internal variable*)
	END_VAR
END_FUNCTION_BLOCK
