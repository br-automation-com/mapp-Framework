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

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
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
 #define frmERR_INIT_IN_PROGRESS 8068U
 #define frmERR_IF_UNREACHABLE 8067U
 #define frmERR_INVALIDBUFFER 8072U
 #define frmERR_IOCTL_NOTVALID 8073U
 #define frmERR_MODEDESCRIPTION 8253U
 #define frmERR_TRANSMITOVERRUN 8078U
 #define frmERR_FUB_ENABLE_FALSE 65534U
 #define frmERR_DEVICEDESCRIPTION 8252U
 #define frmERR_IOCTL_NOTSUPPORTED 8257U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned long ARG_BAUD;
 _GLOBAL_CONST unsigned long ARG_MISC;
 _GLOBAL_CONST unsigned short frmERR_OK;
 _GLOBAL_CONST unsigned long ARG_PVPOLLADR;
 _GLOBAL_CONST unsigned short frmERR_MAXOPEN;
 _GLOBAL_CONST unsigned short frmERR_NOINPUT;
 _GLOBAL_CONST unsigned long ARG_TXPVPOLLADR;
 _GLOBAL_CONST unsigned short frmERR_NOBUFFER;
 _GLOBAL_CONST unsigned short frmERR_PA_DB_SB;
 _GLOBAL_CONST unsigned long MISC_RECEIVE_ALL;
 _GLOBAL_CONST unsigned short frmERR_NOTOPENED;
 _GLOBAL_CONST unsigned short frmERR_INPUTERROR;
 _GLOBAL_CONST unsigned short frmERR_NORESOURCES;
 _GLOBAL_CONST unsigned long ARG_EVSEND_TASKEVENT;
 _GLOBAL_CONST unsigned long ARG_EVSEND_TASKIDENT;
 _GLOBAL_CONST unsigned short frmERR_INIT_IN_PROGRESS;
 _GLOBAL_CONST unsigned short frmERR_IF_UNREACHABLE;
 _GLOBAL_CONST unsigned short frmERR_INVALIDBUFFER;
 _GLOBAL_CONST unsigned short frmERR_IOCTL_NOTVALID;
 _GLOBAL_CONST unsigned short frmERR_MODEDESCRIPTION;
 _GLOBAL_CONST unsigned short frmERR_TRANSMITOVERRUN;
 _GLOBAL_CONST unsigned short frmERR_FUB_ENABLE_FALSE;
 _GLOBAL_CONST unsigned short frmERR_DEVICEDESCRIPTION;
 _GLOBAL_CONST unsigned short frmERR_IOCTL_NOTSUPPORTED;
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

typedef struct FRM_writeAcknowledged
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
} FRM_writeAcknowledged_typ;

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
_BUR_PUBLIC void FRM_mode(struct FRM_mode* inst);
_BUR_PUBLIC void FRM_ctrl(struct FRM_ctrl* inst);
_BUR_PUBLIC void FRM_robuf(struct FRM_robuf* inst);
_BUR_PUBLIC void FRM_gbuf(struct FRM_gbuf* inst);
_BUR_PUBLIC void FRM_rbuf(struct FRM_rbuf* inst);
_BUR_PUBLIC void FRM_close(struct FRM_close* inst);
_BUR_PUBLIC void FRM_write(struct FRM_write* inst);
_BUR_PUBLIC void FRM_writeAcknowledged(struct FRM_writeAcknowledged* inst);
_BUR_PUBLIC void FRM_read(struct FRM_read* inst);
_BUR_PUBLIC void FRM_xopen(struct FRM_xopen* inst);


#ifdef __cplusplus
};
#endif
#endif /* _DVFRAME_ */

