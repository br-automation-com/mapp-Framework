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

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
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
 #define cfgETHBAUDRATE_100FD 101U
 #define cfgETHBAUDRATE_100 100U
 #define cfgETHBAUDRATE_10FD 11U
 #define cfgETHBAUDRATE_10 10U
 #define cfgETHBAUDRATE_AUTO 0U
 #define cfgERR_CLEAR_NV_DATA 29027U
 #define cfgERR_SDM_FUNCTION_NOT_FOUND 29026U
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
 _IEC_CONST unsigned char cfgSTATUS_SDM_DISABLED = 2U;
 _IEC_CONST unsigned char cfgSTATUS_SDM_ENABLED = 1U;
 _IEC_CONST unsigned char cfgOPTION_DISABLE_SDM = 2U;
 _IEC_CONST unsigned char cfgOPTION_ENABLE_SDM = 1U;
 _IEC_CONST unsigned char cfgOPTION_NON_WORKGROUP = 0U;
 _IEC_CONST unsigned char cfgOPTION_WORKGROUP = 1U;
 _IEC_CONST unsigned long cfgOPTION_ENABLE = 1U;
 _IEC_CONST unsigned long cfgOPTION_DISABLE = 0U;
 _IEC_CONST unsigned long cfgCONFIGMODE_DHCPCLIENT = 1U;
 _IEC_CONST unsigned long cfgCONFIGMODE_MANUALLY = 0U;
 _IEC_CONST unsigned long cfgOPTION_VOLATILE = 0U;
 _IEC_CONST unsigned long cfgOPTION_NON_VOLATILE = 1U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_1000FD = 1001U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_100FD = 101U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_100 = 100U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_10FD = 11U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_10 = 10U;
 _IEC_CONST unsigned long cfgETHBAUDRATE_AUTO = 0U;
 _IEC_CONST unsigned short cfgERR_CLEAR_NV_DATA = 29027U;
 _IEC_CONST unsigned short cfgERR_SDM_FUNCTION_NOT_FOUND = 29026U;
 _IEC_CONST unsigned short cfgERR_LEASE_TIMEOUT = 29024U;
 _IEC_CONST unsigned short cfgERR_LEASE_EXISTS = 29023U;
 _IEC_CONST unsigned short cfgERR_LEASES_BUFFER = 29022U;
 _IEC_CONST unsigned short cfgERR_INTERFACELIST_BUFFER = 29021U;
 _IEC_CONST unsigned short cfgERR_DHCP_SERVER_STARTED = 29020U;
 _IEC_CONST unsigned short cfgERR_CIFS_DEFAULTPW_INVALID = 29019U;
 _IEC_CONST unsigned short cfgERR_INANODE_NUMBER_SET = 29018U;
 _IEC_CONST unsigned short cfgERR_CIFS_DEFAULTUSER_INVALID = 29017U;
 _IEC_CONST unsigned short cfgERR_CIFS_DOMAIN_INVALID = 29016U;
 _IEC_CONST unsigned short cfgERR_YEAR_INVALID = 29015U;
 _IEC_CONST unsigned short cfgERR_TIMEZONE = 29014U;
 _IEC_CONST unsigned short cfgERR_SYSTEM = 29013U;
 _IEC_CONST unsigned short cfgERR_SNTP_INTERVAL = 29012U;
 _IEC_CONST unsigned short cfgERR_SNTP_CLIENT = 29011U;
 _IEC_CONST unsigned short cfgERR_SNTP_SERVER = 29010U;
 _IEC_CONST unsigned short cfgERR_PARAM_NOT_SET = 29009U;
 _IEC_CONST unsigned short cfgERR_FTP_SDOWN = 29008U;
 _IEC_CONST unsigned short cfgERR_FTP_SINIT = 29007U;
 _IEC_CONST unsigned short cfgERR_INANODE_NOT_SUPPORTED = 29006U;
 _IEC_CONST unsigned short cfgERR_ARREG = 29005U;
 _IEC_CONST unsigned short cfgERR_SET_NOT_POSSIBLE = 29004U;
 _IEC_CONST unsigned short cfgERR_VALUE_INVALID = 29003U;
 _IEC_CONST unsigned short cfgERR_OPTION_INVALID = 29002U;
 _IEC_CONST unsigned short cfgERR_DEVICE_INVALID = 29001U;
 _IEC_CONST unsigned short cfgERR_DEVICE_NOT_EXIST = 29000U;
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



/* Prototyping of functions and function blocks */
void CfgGetInaNode(struct CfgGetInaNode* inst);
void CfgGetIPAddr(struct CfgGetIPAddr* inst);
void CfgGetSubnetMask(struct CfgGetSubnetMask* inst);
void CfgGetMacAddr(struct CfgGetMacAddr* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASARCFG_ */

                                                           
