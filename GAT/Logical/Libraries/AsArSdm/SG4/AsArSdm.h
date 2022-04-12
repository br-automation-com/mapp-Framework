/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASARSDM_
#define _ASARSDM_
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
 #define sdmOPTION_VOLATILE 0U
 #define sdmOPTION_NON_VOLATILE 1U
 #define sdm_APPMODE_ERROR 3U
 #define sdm_APPMODE_WARNING 2U
 #define sdm_APPMODE_OK 1U
 #define sdm_APPMODE_NOTUSED 0U
 #define sdm_SYSTEMDUMP_DATA 1U
 #define sdm_SYSTEMDUMP_PARAM 0U
 #define sdmERR_OPTION_INVALID 34906U
 #define sdmERR_INVALID_VALUE 34905U
 #define sdmERR_INVALID_POINTER 34904U
 #define sdmERR_INVALID_DEVICE 34903U
 #define sdmERR_SYSTEMDUMP 34902U
 #define sdmERR_ARREG 34901U
 #define sdmERR_NOT_EXIST 34900U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned long sdmOPTION_VOLATILE;
 _GLOBAL_CONST unsigned long sdmOPTION_NON_VOLATILE;
 _GLOBAL_CONST unsigned short sdm_APPMODE_ERROR;
 _GLOBAL_CONST unsigned short sdm_APPMODE_WARNING;
 _GLOBAL_CONST unsigned short sdm_APPMODE_OK;
 _GLOBAL_CONST unsigned short sdm_APPMODE_NOTUSED;
 _GLOBAL_CONST unsigned short sdm_SYSTEMDUMP_DATA;
 _GLOBAL_CONST unsigned short sdm_SYSTEMDUMP_PARAM;
 _GLOBAL_CONST unsigned short sdmERR_OPTION_INVALID;
 _GLOBAL_CONST unsigned short sdmERR_INVALID_VALUE;
 _GLOBAL_CONST unsigned short sdmERR_INVALID_POINTER;
 _GLOBAL_CONST unsigned short sdmERR_INVALID_DEVICE;
 _GLOBAL_CONST unsigned short sdmERR_SYSTEMDUMP;
 _GLOBAL_CONST unsigned short sdmERR_ARREG;
 _GLOBAL_CONST unsigned short sdmERR_NOT_EXIST;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct SdmSystemDump
{
	/* VAR_INPUT (analog) */
	unsigned long configuration;
	unsigned long pDevice;
	unsigned long pFile;
	unsigned long pParam;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} SdmSystemDump_typ;

typedef struct SdmSetAppParam
{
	/* VAR_INPUT (analog) */
	unsigned long appMode;
	unsigned long pLink;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long i_tmp;
	/* VAR_INPUT (digital) */
	plcbit enable;
} SdmSetAppParam_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void SdmSystemDump(struct SdmSystemDump* inst);
_BUR_PUBLIC void SdmSetAppParam(struct SdmSetAppParam* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASARSDM_ */

