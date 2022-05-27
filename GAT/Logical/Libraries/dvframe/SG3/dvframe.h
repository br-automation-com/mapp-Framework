/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _DVFRAME_
#define _DVFRAME_
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
 #define ARG_BAUD 0U
 #define ARG_MISC 16U
 #define frmERR_OK 0U
 #define ARG_PVPOLLADR 15U
 #define frmERR_MAXOPEN 8254U
 #define frmERR_NOINPUT 60U
 #define ARG_TXPVPOLLADR 17U
 #define frmERR_NOBUFFER 8071U
 #define frmERR_PA_DB_SB 8256U
 #define MISC_RECEIVE_ALL 2U
 #define frmERR_NOTOPENED 8251U
 #define frmERR_INPUTERROR 8079U
 #define frmERR_NORESOURCES 8258U
 #define ARG_EVSEND_TASKEVENT 18U
 #define ARG_EVSEND_TASKIDENT 14U
 #define frmERR_INVALIDBUFFER 8072U
 #define frmERR_IOCTL_NOTVALID 8073U
 #define frmERR_MODEDESCRIPTION 8253U
 #define frmERR_TRANSMITOVERRUN 8078U
 #define frmERR_FUB_ENABLE_FALSE 65534U
 #define frmERR_DEVICEDESCRIPTION 8252U
 #define frmERR_IOCTL_NOTSUPPORTED 8257U
#else
 _IEC_CONST unsigned long ARG_BAUD = 0U;
 _IEC_CONST unsigned long ARG_MISC = 16U;
 _IEC_CONST unsigned short frmERR_OK = 0U;
 _IEC_CONST unsigned long ARG_PVPOLLADR = 15U;
 _IEC_CONST unsigned short frmERR_MAXOPEN = 8254U;
 _IEC_CONST unsigned short frmERR_NOINPUT = 60U;
 _IEC_CONST unsigned long ARG_TXPVPOLLADR = 17U;
 _IEC_CONST unsigned short frmERR_NOBUFFER = 8071U;
 _IEC_CONST unsigned short frmERR_PA_DB_SB = 8256U;
 _IEC_CONST unsigned long MISC_RECEIVE_ALL = 2U;
 _IEC_CONST unsigned short frmERR_NOTOPENED = 8251U;
 _IEC_CONST unsigned short frmERR_INPUTERROR = 8079U;
 _IEC_CONST unsigned short frmERR_NORESOURCES = 8258U;
 _IEC_CONST unsigned long ARG_EVSEND_TASKEVENT = 18U;
 _IEC_CONST unsigned long ARG_EVSEND_TASKIDENT = 14U;
 _IEC_CONST unsigned short frmERR_INVALIDBUFFER = 8072U;
 _IEC_CONST unsigned short frmERR_IOCTL_NOTVALID = 8073U;
 _IEC_CONST unsigned short frmERR_MODEDESCRIPTION = 8253U;
 _IEC_CONST unsigned short frmERR_TRANSMITOVERRUN = 8078U;
 _IEC_CONST unsigned short frmERR_FUB_ENABLE_FALSE = 65534U;
 _IEC_CONST unsigned short frmERR_DEVICEDESCRIPTION = 8252U;
 _IEC_CONST unsigned short frmERR_IOCTL_NOTSUPPORTED = 8257U;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct XOPENCONFIG
{	unsigned short idle;
	unsigned short delimc;
	unsigned char delim[2];
	unsigned short tx_cnt;
	unsigned short rx_cnt;
	unsigned short tx_len;
	unsigned short rx_len;
	unsigned short argc;
	unsigned long argv;
} XOPENCONFIG;

typedef struct FRM_mode
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long mode;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_mode_typ;

typedef struct FRM_ctrl
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned short ioctrl;
	unsigned long inarg;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long outarg;
	/* VAR (analog) */
	plcstring internal[44];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_ctrl_typ;

typedef struct FRM_robuf
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_robuf_typ;

typedef struct FRM_gbuf
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_gbuf_typ;

typedef struct FRM_rbuf
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_rbuf_typ;

typedef struct FRM_close
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_close_typ;

typedef struct FRM_write
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_write_typ;

typedef struct FRM_read
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_read_typ;

typedef struct FRM_xopen
{
	/* VAR_INPUT (analog) */
	unsigned long device;
	unsigned long mode;
	unsigned long config;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long ident;
	/* VAR (analog) */
	plcstring internal[28];
	/* VAR_INPUT (digital) */
	plcbit enable;
} FRM_xopen_typ;



/* Prototyping of functions and function blocks */
void FRM_mode(struct FRM_mode* inst);
void FRM_ctrl(struct FRM_ctrl* inst);
void FRM_robuf(struct FRM_robuf* inst);
void FRM_gbuf(struct FRM_gbuf* inst);
void FRM_rbuf(struct FRM_rbuf* inst);
void FRM_close(struct FRM_close* inst);
void FRM_write(struct FRM_write* inst);
void FRM_read(struct FRM_read* inst);
void FRM_xopen(struct FRM_xopen* inst);


#ifdef __cplusplus
};
#endif
#endif /* _DVFRAME_ */

