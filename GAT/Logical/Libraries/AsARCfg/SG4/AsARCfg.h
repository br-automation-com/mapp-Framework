/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASARCFG_
#define _ASARCFG_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <runtime.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define cfgDHCP_OPTION_VENDOR_CLASS_ID 60U
 #define cfgSDM_COLOR_DEFAULT 2147483648U
 #define cfgSTATUS_NTP_INACTIVE 0U
 #define cfgSTATUS_NTP_ACTIVE 1U
 #define cfgNTP_STOP 0U
 #define cfgNTP_START 1U
 #define cfgOPTION_DNS_ON_DHCP 2U
 #define cfgOPTION_DNS_ON_CONFIG 1U
 #define cfgOPTION_DNS_OFF 0U
 #define cfgWEB_MODE_ENABLED 1U
 #define cfgWEB_MODE_DISABLED 0U
 #define cfgWEB_MODE_MIME_ADD 1U
 #define cfgWEB_MODE_MIME_DEL 0U
 #define cfgWEB_MODE_GOFORM_NO_WRITE 2U
 #define cfgWEB_MODE_GOFORM_ENABLE 1U
 #define cfgWEB_MODE_GOFORM_DISABLE 0U
 #define cfgSTATUS_SDM_DISABLED 2U
 #define cfgSTATUS_SDM_ENABLED 1U
 #define cfgOPTION_DISABLE_SDM 2U
 #define cfgOPTION_ENABLE_SDM 1U
 #define cfgOPTION_NON_WORKGROUP 0U
 #define cfgOPTION_WORKGROUP 1U
 #define cfgOPTION_ENABLE 1U
 #define cfgOPTION_DISABLE 0U
 #define cfgCONFIGMODE_DHCPCLIENT 1U
 #define cfgCONFIGMODE_MANUALLY 0U
 #define cfgOPTION_VOLATILE 0U
 #define cfgOPTION_NON_VOLATILE 1U
 #define cfgETHBAUDRATE_1000FD 1001U
 #define cfgETHBAUDRATE_100AUTO 102U
 #define cfgETHBAUDRATE_100FD 101U
 #define cfgETHBAUDRATE_100 100U
 #define cfgETHBAUDRATE_10AUTO 12U
 #define cfgETHBAUDRATE_10FD 11U
 #define cfgETHBAUDRATE_10 10U
 #define cfgETHBAUDRATE_AUTO 0U
 #define cfgERR_DST 29035U
 #define cfgERR_ROUTE_TABLE 29034U
 #define cfgERR_NTP_CLIENT 29033U
 #define cfgERR_NTP_SERVER 29032U
 #define cfgERR_DHCP_NO_DHCP_IP_OBTAINED 29031U
 #define cfgERR_WEBSERV_DISABLED 29030U
 #define cfgERR_SDM_DISABLED 29029U
 #define cfgERR_FUNCTION_NOT_FOUND 29028U
 #define cfgERR_CLEAR_NV_DATA 29027U
 #define cfgERR_SDM_FUNCTION_NOT_FOUND 29026U
 #define cfgERR_DHCP_CONFIG 29025U
 #define cfgERR_LEASE_TIMEOUT 29024U
 #define cfgERR_LEASE_EXISTS 29023U
 #define cfgERR_LEASES_BUFFER 29022U
 #define cfgERR_INTERFACELIST_BUFFER 29021U
 #define cfgERR_DHCP_SERVER_STARTED 29020U
 #define cfgERR_CIFS_DEFAULTPW_INVALID 29019U
 #define cfgERR_INANODE_NUMBER_SET 29018U
 #define cfgERR_CIFS_DEFAULTUSER_INVALID 29017U
 #define cfgERR_CIFS_DOMAIN_INVALID 29016U
 #define cfgERR_YEAR_INVALID 29015U
 #define cfgERR_TIMEZONE 29014U
 #define cfgERR_SYSTEM 29013U
 #define cfgERR_SNTP_INTERVAL 29012U
 #define cfgERR_SNTP_CLIENT 29011U
 #define cfgERR_SNTP_SERVER 29010U
 #define cfgERR_PARAM_NOT_SET 29009U
 #define cfgERR_FTP_SDOWN 29008U
 #define cfgERR_FTP_SINIT 29007U
 #define cfgERR_INANODE_NOT_SUPPORTED 29006U
 #define cfgERR_ARREG 29005U
 #define cfgERR_SET_NOT_POSSIBLE 29004U
 #define cfgERR_VALUE_INVALID 29003U
 #define cfgERR_OPTION_INVALID 29002U
 #define cfgERR_DEVICE_INVALID 29001U
 #define cfgERR_DEVICE_NOT_EXIST 29000U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char cfgDHCP_OPTION_VENDOR_CLASS_ID;
 _GLOBAL_CONST unsigned long cfgSDM_COLOR_DEFAULT;
 _GLOBAL_CONST unsigned short cfgSTATUS_NTP_INACTIVE;
 _GLOBAL_CONST unsigned short cfgSTATUS_NTP_ACTIVE;
 _GLOBAL_CONST unsigned short cfgNTP_STOP;
 _GLOBAL_CONST unsigned short cfgNTP_START;
 _GLOBAL_CONST unsigned char cfgOPTION_DNS_ON_DHCP;
 _GLOBAL_CONST unsigned char cfgOPTION_DNS_ON_CONFIG;
 _GLOBAL_CONST unsigned char cfgOPTION_DNS_OFF;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_ENABLED;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_DISABLED;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_MIME_ADD;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_MIME_DEL;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_GOFORM_NO_WRITE;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_GOFORM_ENABLE;
 _GLOBAL_CONST unsigned short cfgWEB_MODE_GOFORM_DISABLE;
 _GLOBAL_CONST unsigned char cfgSTATUS_SDM_DISABLED;
 _GLOBAL_CONST unsigned char cfgSTATUS_SDM_ENABLED;
 _GLOBAL_CONST unsigned char cfgOPTION_DISABLE_SDM;
 _GLOBAL_CONST unsigned char cfgOPTION_ENABLE_SDM;
 _GLOBAL_CONST unsigned char cfgOPTION_NON_WORKGROUP;
 _GLOBAL_CONST unsigned char cfgOPTION_WORKGROUP;
 _GLOBAL_CONST unsigned long cfgOPTION_ENABLE;
 _GLOBAL_CONST unsigned long cfgOPTION_DISABLE;
 _GLOBAL_CONST unsigned long cfgCONFIGMODE_DHCPCLIENT;
 _GLOBAL_CONST unsigned long cfgCONFIGMODE_MANUALLY;
 _GLOBAL_CONST unsigned long cfgOPTION_VOLATILE;
 _GLOBAL_CONST unsigned long cfgOPTION_NON_VOLATILE;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_1000FD;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_100AUTO;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_100FD;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_100;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_10AUTO;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_10FD;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_10;
 _GLOBAL_CONST unsigned long cfgETHBAUDRATE_AUTO;
 _GLOBAL_CONST unsigned short cfgERR_DST;
 _GLOBAL_CONST unsigned short cfgERR_ROUTE_TABLE;
 _GLOBAL_CONST unsigned short cfgERR_NTP_CLIENT;
 _GLOBAL_CONST unsigned short cfgERR_NTP_SERVER;
 _GLOBAL_CONST unsigned short cfgERR_DHCP_NO_DHCP_IP_OBTAINED;
 _GLOBAL_CONST unsigned short cfgERR_WEBSERV_DISABLED;
 _GLOBAL_CONST unsigned short cfgERR_SDM_DISABLED;
 _GLOBAL_CONST unsigned short cfgERR_FUNCTION_NOT_FOUND;
 _GLOBAL_CONST unsigned short cfgERR_CLEAR_NV_DATA;
 _GLOBAL_CONST unsigned short cfgERR_SDM_FUNCTION_NOT_FOUND;
 _GLOBAL_CONST unsigned short cfgERR_DHCP_CONFIG;
 _GLOBAL_CONST unsigned short cfgERR_LEASE_TIMEOUT;
 _GLOBAL_CONST unsigned short cfgERR_LEASE_EXISTS;
 _GLOBAL_CONST unsigned short cfgERR_LEASES_BUFFER;
 _GLOBAL_CONST unsigned short cfgERR_INTERFACELIST_BUFFER;
 _GLOBAL_CONST unsigned short cfgERR_DHCP_SERVER_STARTED;
 _GLOBAL_CONST unsigned short cfgERR_CIFS_DEFAULTPW_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_INANODE_NUMBER_SET;
 _GLOBAL_CONST unsigned short cfgERR_CIFS_DEFAULTUSER_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_CIFS_DOMAIN_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_YEAR_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_TIMEZONE;
 _GLOBAL_CONST unsigned short cfgERR_SYSTEM;
 _GLOBAL_CONST unsigned short cfgERR_SNTP_INTERVAL;
 _GLOBAL_CONST unsigned short cfgERR_SNTP_CLIENT;
 _GLOBAL_CONST unsigned short cfgERR_SNTP_SERVER;
 _GLOBAL_CONST unsigned short cfgERR_PARAM_NOT_SET;
 _GLOBAL_CONST unsigned short cfgERR_FTP_SDOWN;
 _GLOBAL_CONST unsigned short cfgERR_FTP_SINIT;
 _GLOBAL_CONST unsigned short cfgERR_INANODE_NOT_SUPPORTED;
 _GLOBAL_CONST unsigned short cfgERR_ARREG;
 _GLOBAL_CONST unsigned short cfgERR_SET_NOT_POSSIBLE;
 _GLOBAL_CONST unsigned short cfgERR_VALUE_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_OPTION_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_DEVICE_INVALID;
 _GLOBAL_CONST unsigned short cfgERR_DEVICE_NOT_EXIST;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct cfgLease_typ
{	plcstring name[9];
	plcstring startAdr[17];
	plcstring stopAdr[17];
	plcstring subnetMask[17];
	plcstring defaultGateway[17];
	signed long leaseTimeout;
} cfgLease_typ;

typedef struct CfgGetInaNode
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned char InaNode;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetInaNode_typ;

typedef struct CfgSetInaNode
{
	/* VAR_INPUT (analog) */
	signed long pDevice;
	unsigned char InaNode;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetInaNode_typ;

typedef struct CfgGetIPAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pIPAddr;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetIPAddr_typ;

typedef struct CfgSetIPAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pIPAddr;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetIPAddr_typ;

typedef struct CfgGetSubnetMask
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pSubnetMask;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSubnetMask_typ;

typedef struct CfgSetSubnetMask
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pSubnetMask;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSubnetMask_typ;

typedef struct CfgGetClusterIPAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pIPAddr;
	unsigned long pSubnetMask;
	unsigned char LenIp;
	unsigned char LenSnmk;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetClusterIPAddr_typ;

typedef struct CfgSetClusterIPAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pIPAddr;
	unsigned long pSubnetMask;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetClusterIPAddr_typ;

typedef struct CfgGetDefaultGateway
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pGateway;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetDefaultGateway_typ;

typedef struct CfgSetDefaultGateway
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pGateway;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDefaultGateway_typ;

typedef struct CfgGetBroadcastAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pBroadcastAddr;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetBroadcastAddr_typ;

typedef struct CfgSetBroadcastAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pBroadcastAddr;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetBroadcastAddr_typ;

typedef struct CfgGetEthBaudrate
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long Baudrate;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetEthBaudrate_typ;

typedef struct CfgSetEthBaudrate
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long Baudrate;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetEthBaudrate_typ;

typedef struct CfgGetEthConfigMode
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long ConfigMode;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetEthConfigMode_typ;

typedef struct CfgSetEthConfigMode
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long ConfigMode;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetEthConfigMode_typ;

typedef struct CfgGetHostName
{
	/* VAR_INPUT (analog) */
	unsigned long pHostName;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetHostName_typ;

typedef struct CfgSetHostName
{
	/* VAR_INPUT (analog) */
	unsigned long pHostName;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetHostName_typ;

typedef struct CfgGetHostNameIf
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pHostName;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetHostNameIf_typ;

typedef struct CfgSetHostNameIf
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pHostName;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetHostNameIf_typ;

typedef struct CfgGetMacAddr
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pMacAddr;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetMacAddr_typ;

typedef struct CfgSetFTPServer
{
	/* VAR_INPUT (analog) */
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetFTPServer_typ;

typedef struct CfgGetTimeOffset
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	signed short timeoffset;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetTimeOffset_typ;

typedef struct CfgSetTimeOffset
{
	/* VAR_INPUT (analog) */
	signed short timeoffset;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetTimeOffset_typ;

typedef struct CfgSetSntpServer
{
	/* VAR_INPUT (analog) */
	unsigned long start;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSntpServer_typ;

typedef struct CfgSetSntpClient
{
	/* VAR_INPUT (analog) */
	unsigned long run;
	unsigned long pServerAddr;
	unsigned short sntpcInterval;
	unsigned short rtcInterval;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned char syncStatus;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSntpClient_typ;

typedef struct CfgGetSntpcData
{
	/* VAR_INPUT (analog) */
	unsigned long pServerAddr;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long run;
	unsigned short sntpcInterval;
	unsigned short rtcInterval;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSntpcData_typ;

typedef struct CfgGetSntpsData
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long run;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSntpsData_typ;

typedef struct CfgSetNtpServer
{
	/* VAR_INPUT (analog) */
	unsigned long start;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetNtpServer_typ;

typedef struct CfgGetNtpsData
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long run;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetNtpsData_typ;

typedef struct CfgSetNtpClient
{
	/* VAR_INPUT (analog) */
	unsigned long start;
	unsigned long pServerAddress1;
	unsigned long pServerAddress2;
	unsigned long pServerAddress3;
	unsigned long pServerAddress4;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetNtpClient_typ;

typedef struct CfgGetNtpcData
{
	/* VAR_INPUT (analog) */
	unsigned long pServerAddress1;
	unsigned long pServerAddress2;
	unsigned long pServerAddress3;
	unsigned long pServerAddress4;
	unsigned char len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long run;
	unsigned long syncStatus;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetNtpcData_typ;

typedef struct CfgGetTimeZone
{
	/* VAR_OUTPUT (analog) */
	unsigned short timezoneID;
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetTimeZone_typ;

typedef struct CfgSetTimeZone
{
	/* VAR_INPUT (analog) */
	unsigned short timezoneID;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetTimeZone_typ;

typedef struct CfgGetTimeZoneInfo
{
	/* VAR_INPUT (analog) */
	unsigned short timezoneID;
	/* VAR_OUTPUT (analog) */
	signed short gmt;
	signed short gmtDst;
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetTimeZoneInfo_typ;

typedef struct CfgGetTimeZoneEntry
{
	/* VAR_INPUT (analog) */
	unsigned short timezoneID;
	unsigned short year;
	/* VAR_OUTPUT (analog) */
	plcdt dateDst;
	plcdt dateNormal;
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetTimeZoneEntry_typ;

typedef struct CfgGetDst
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR_OUTPUT (digital) */
	plcbit dst;
} CfgGetDst_typ;

typedef struct CfgSetDst
{
	/* VAR_INPUT (analog) */
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
	plcbit dst;
} CfgSetDst_typ;

typedef struct CfgGetCIFSDomain
{
	/* VAR_INPUT (analog) */
	unsigned long pDomain;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned char isWorkgroup;
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetCIFSDomain_typ;

typedef struct CfgSetCIFSDomain
{
	/* VAR_INPUT (analog) */
	unsigned long pDomain;
	unsigned char isWorkgroup;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetCIFSDomain_typ;

typedef struct CfgGetCIFSDefaultuser
{
	/* VAR_INPUT (analog) */
	unsigned long pDefaultuser;
	unsigned char lenUser;
	unsigned long pDefaultpassword;
	unsigned char lenPassword;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetCIFSDefaultuser_typ;

typedef struct CfgSetCIFSDefaultuser
{
	/* VAR_INPUT (analog) */
	unsigned long pDefaultuser;
	unsigned long pDefaultpassword;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetCIFSDefaultuser_typ;

typedef struct CfgSetDhcpServer
{
	/* VAR_INPUT (analog) */
	unsigned long start;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDhcpServer_typ;

typedef struct CfgSetDhcpsData
{
	/* VAR_INPUT (analog) */
	unsigned long pInterfaceList;
	unsigned long pLeases;
	unsigned long numLeases;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDhcpsData_typ;

typedef struct CfgGetDhcpsData
{
	/* VAR_INPUT (analog) */
	unsigned long pInterfaceList;
	unsigned long len;
	unsigned long pLeases;
	unsigned long numLeases;
	/* VAR_OUTPUT (analog) */
	unsigned long startMode;
	unsigned long numNeeded;
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetDhcpsData_typ;

typedef struct CfgSetDhcpcOption
{
	/* VAR_INPUT (analog) */
	unsigned char code;
	unsigned char length;
	unsigned long pValue;
	unsigned long pDevice;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDhcpcOption_typ;

typedef struct CfgSetSdmStatus
{
	/* VAR_INPUT (analog) */
	unsigned long start;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSdmStatus_typ;

typedef struct CfgGetSdmStatus
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long run;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSdmStatus_typ;

typedef struct CfgSetSdmColor
{
	/* VAR_INPUT (analog) */
	unsigned long red;
	unsigned long green;
	unsigned long blue;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSdmColor_typ;

typedef struct CfgGetSdmColor
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long red;
	unsigned long green;
	unsigned long blue;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSdmColor_typ;

typedef struct CfgGetSdmCustomData1
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long lenDevice;
	unsigned long pFile;
	unsigned long lenFile;
	unsigned long pDatamodule;
	unsigned long lenDatamodule;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSdmCustomData1_typ;

typedef struct CfgSetSdmCustomData1
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pFile;
	unsigned long pDatamodule;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSdmCustomData1_typ;

typedef struct CfgGetSdmCustomData2
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long lenDevice;
	unsigned long pFile;
	unsigned long lenFile;
	unsigned long pDatamodule;
	unsigned long lenDatamodule;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetSdmCustomData2_typ;

typedef struct CfgSetSdmCustomData2
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long pFile;
	unsigned long pDatamodule;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetSdmCustomData2_typ;

typedef struct CfgGetWebMimeType
{
	/* VAR_INPUT (analog) */
	unsigned long pFileExtension;
	unsigned long pMimeType;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebMimeType_typ;

typedef struct CfgSetWebMimeType
{
	/* VAR_INPUT (analog) */
	unsigned long pFileExtension;
	unsigned long pMimeType;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
	plcbit mode;
} CfgSetWebMimeType_typ;

typedef struct CfgGetWebServerHttpsConfig
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	plcstring sslCfgName[256];
	unsigned short port;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebServerHttpsConfig_typ;

typedef struct CfgGetWebServerPort
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short port;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebServerPort_typ;

typedef struct CfgGetWebServerDevice
{
	/* VAR_INPUT (analog) */
	unsigned long pDevice;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebServerDevice_typ;

typedef struct CfgGetWebAspGoform
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short mode;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebAspGoform_typ;

typedef struct CfgSetWebAspGoform
{
	/* VAR_INPUT (analog) */
	unsigned short mode;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetWebAspGoform_typ;

typedef struct CfgGetWebServerStatus
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short mode;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetWebServerStatus_typ;

typedef struct CfgSetWebServerStatus
{
	/* VAR_INPUT (analog) */
	unsigned short mode;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetWebServerStatus_typ;

typedef struct CfgGetDnsMode
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short mode;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetDnsMode_typ;

typedef struct CfgSetDnsMode
{
	/* VAR_INPUT (analog) */
	unsigned short mode;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDnsMode_typ;

typedef struct CfgGetDnsSuffix
{
	/* VAR_INPUT (analog) */
	unsigned long pSuffix;
	unsigned char Len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetDnsSuffix_typ;

typedef struct CfgSetDnsSuffix
{
	/* VAR_INPUT (analog) */
	unsigned long pSuffix;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDnsSuffix_typ;

typedef struct CfgGetDnsAddress
{
	/* VAR_INPUT (analog) */
	unsigned long pDnsAddr1;
	unsigned long pDnsAddr2;
	unsigned long pDnsAddr3;
	unsigned char Len1;
	unsigned char Len2;
	unsigned char Len3;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgGetDnsAddress_typ;

typedef struct CfgSetDnsAddress
{
	/* VAR_INPUT (analog) */
	unsigned long pDnsAddr1;
	unsigned long pDnsAddr2;
	unsigned long pDnsAddr3;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgSetDnsAddress_typ;

typedef struct CfgRouteAdd
{
	/* VAR_INPUT (analog) */
	unsigned long pIPAddr;
	unsigned long pSubnetMask;
	unsigned long pGateway;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgRouteAdd_typ;

typedef struct CfgRouteDelete
{
	/* VAR_INPUT (analog) */
	unsigned long pIPAddr;
	unsigned long pSubnetMask;
	unsigned long pGateway;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} CfgRouteDelete_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void CfgGetInaNode(struct CfgGetInaNode* inst);
_BUR_PUBLIC void CfgSetInaNode(struct CfgSetInaNode* inst);
_BUR_PUBLIC void CfgGetIPAddr(struct CfgGetIPAddr* inst);
_BUR_PUBLIC void CfgSetIPAddr(struct CfgSetIPAddr* inst);
_BUR_PUBLIC void CfgGetSubnetMask(struct CfgGetSubnetMask* inst);
_BUR_PUBLIC void CfgSetSubnetMask(struct CfgSetSubnetMask* inst);
_BUR_PUBLIC void CfgGetClusterIPAddr(struct CfgGetClusterIPAddr* inst);
_BUR_PUBLIC void CfgSetClusterIPAddr(struct CfgSetClusterIPAddr* inst);
_BUR_PUBLIC void CfgGetDefaultGateway(struct CfgGetDefaultGateway* inst);
_BUR_PUBLIC void CfgSetDefaultGateway(struct CfgSetDefaultGateway* inst);
_BUR_PUBLIC void CfgGetBroadcastAddr(struct CfgGetBroadcastAddr* inst);
_BUR_PUBLIC void CfgSetBroadcastAddr(struct CfgSetBroadcastAddr* inst);
_BUR_PUBLIC void CfgGetEthBaudrate(struct CfgGetEthBaudrate* inst);
_BUR_PUBLIC void CfgSetEthBaudrate(struct CfgSetEthBaudrate* inst);
_BUR_PUBLIC void CfgGetEthConfigMode(struct CfgGetEthConfigMode* inst);
_BUR_PUBLIC void CfgSetEthConfigMode(struct CfgSetEthConfigMode* inst);
_BUR_PUBLIC void CfgGetHostName(struct CfgGetHostName* inst);
_BUR_PUBLIC void CfgSetHostName(struct CfgSetHostName* inst);
_BUR_PUBLIC void CfgGetHostNameIf(struct CfgGetHostNameIf* inst);
_BUR_PUBLIC void CfgSetHostNameIf(struct CfgSetHostNameIf* inst);
_BUR_PUBLIC void CfgGetMacAddr(struct CfgGetMacAddr* inst);
_BUR_PUBLIC void CfgSetFTPServer(struct CfgSetFTPServer* inst);
_BUR_PUBLIC void CfgGetTimeOffset(struct CfgGetTimeOffset* inst);
_BUR_PUBLIC void CfgSetTimeOffset(struct CfgSetTimeOffset* inst);
_BUR_PUBLIC void CfgSetSntpServer(struct CfgSetSntpServer* inst);
_BUR_PUBLIC void CfgSetSntpClient(struct CfgSetSntpClient* inst);
_BUR_PUBLIC void CfgGetSntpcData(struct CfgGetSntpcData* inst);
_BUR_PUBLIC void CfgGetSntpsData(struct CfgGetSntpsData* inst);
_BUR_PUBLIC void CfgSetNtpServer(struct CfgSetNtpServer* inst);
_BUR_PUBLIC void CfgGetNtpsData(struct CfgGetNtpsData* inst);
_BUR_PUBLIC void CfgSetNtpClient(struct CfgSetNtpClient* inst);
_BUR_PUBLIC void CfgGetNtpcData(struct CfgGetNtpcData* inst);
_BUR_PUBLIC void CfgGetTimeZone(struct CfgGetTimeZone* inst);
_BUR_PUBLIC void CfgSetTimeZone(struct CfgSetTimeZone* inst);
_BUR_PUBLIC void CfgGetTimeZoneInfo(struct CfgGetTimeZoneInfo* inst);
_BUR_PUBLIC void CfgGetTimeZoneEntry(struct CfgGetTimeZoneEntry* inst);
_BUR_PUBLIC void CfgGetDst(struct CfgGetDst* inst);
_BUR_PUBLIC void CfgSetDst(struct CfgSetDst* inst);
_BUR_PUBLIC void CfgGetCIFSDomain(struct CfgGetCIFSDomain* inst);
_BUR_PUBLIC void CfgSetCIFSDomain(struct CfgSetCIFSDomain* inst);
_BUR_PUBLIC void CfgGetCIFSDefaultuser(struct CfgGetCIFSDefaultuser* inst);
_BUR_PUBLIC void CfgSetCIFSDefaultuser(struct CfgSetCIFSDefaultuser* inst);
_BUR_PUBLIC void CfgSetDhcpServer(struct CfgSetDhcpServer* inst);
_BUR_PUBLIC void CfgSetDhcpsData(struct CfgSetDhcpsData* inst);
_BUR_PUBLIC void CfgGetDhcpsData(struct CfgGetDhcpsData* inst);
_BUR_PUBLIC void CfgSetDhcpcOption(struct CfgSetDhcpcOption* inst);
_BUR_PUBLIC void CfgSetSdmStatus(struct CfgSetSdmStatus* inst);
_BUR_PUBLIC void CfgGetSdmStatus(struct CfgGetSdmStatus* inst);
_BUR_PUBLIC void CfgSetSdmColor(struct CfgSetSdmColor* inst);
_BUR_PUBLIC void CfgGetSdmColor(struct CfgGetSdmColor* inst);
_BUR_PUBLIC void CfgGetSdmCustomData1(struct CfgGetSdmCustomData1* inst);
_BUR_PUBLIC void CfgSetSdmCustomData1(struct CfgSetSdmCustomData1* inst);
_BUR_PUBLIC void CfgGetSdmCustomData2(struct CfgGetSdmCustomData2* inst);
_BUR_PUBLIC void CfgSetSdmCustomData2(struct CfgSetSdmCustomData2* inst);
_BUR_PUBLIC void CfgGetWebMimeType(struct CfgGetWebMimeType* inst);
_BUR_PUBLIC void CfgSetWebMimeType(struct CfgSetWebMimeType* inst);
_BUR_PUBLIC void CfgGetWebServerHttpsConfig(struct CfgGetWebServerHttpsConfig* inst);
_BUR_PUBLIC void CfgGetWebServerPort(struct CfgGetWebServerPort* inst);
_BUR_PUBLIC void CfgGetWebServerDevice(struct CfgGetWebServerDevice* inst);
_BUR_PUBLIC void CfgGetWebAspGoform(struct CfgGetWebAspGoform* inst);
_BUR_PUBLIC void CfgSetWebAspGoform(struct CfgSetWebAspGoform* inst);
_BUR_PUBLIC void CfgGetWebServerStatus(struct CfgGetWebServerStatus* inst);
_BUR_PUBLIC void CfgSetWebServerStatus(struct CfgSetWebServerStatus* inst);
_BUR_PUBLIC void CfgGetDnsMode(struct CfgGetDnsMode* inst);
_BUR_PUBLIC void CfgSetDnsMode(struct CfgSetDnsMode* inst);
_BUR_PUBLIC void CfgGetDnsSuffix(struct CfgGetDnsSuffix* inst);
_BUR_PUBLIC void CfgSetDnsSuffix(struct CfgSetDnsSuffix* inst);
_BUR_PUBLIC void CfgGetDnsAddress(struct CfgGetDnsAddress* inst);
_BUR_PUBLIC void CfgSetDnsAddress(struct CfgSetDnsAddress* inst);
_BUR_PUBLIC void CfgRouteAdd(struct CfgRouteAdd* inst);
_BUR_PUBLIC void CfgRouteDelete(struct CfgRouteDelete* inst);
_BUR_PUBLIC unsigned short CfgClearNV(void);


#ifdef __cplusplus
};
#endif
#endif /* _ASARCFG_ */

