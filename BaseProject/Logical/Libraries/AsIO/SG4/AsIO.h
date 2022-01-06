/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASIO_
#define _ASIO_
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
 #define asio_INVERTED_FLAG 64U
 #define asio_PV_NOT_FOUND 32U
 #define asio_TYPE_MISMATCH 16U
 #define asio_UNRES_IO_FLAG 128U
 #define asio_IO_SIMULATION_FLAG 64U
 #define asio_IO_OUTPUT_FLAG 32U
 #define asio_IO_INPUT_FLAG 16U
 #define asio_UNRES_LINK_FLAG 8U
 #define asio_F_ACT_FLAG 4U
 #define asio_P_ACT_FLAG 2U
 #define asio_VALID_FLAG 1U
 #define asioERR_NOSUCH_DP 30151U
 #define asioERR_INTERNAL 30150U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char asio_INVERTED_FLAG;
 _GLOBAL_CONST unsigned char asio_PV_NOT_FOUND;
 _GLOBAL_CONST unsigned char asio_TYPE_MISMATCH;
 _GLOBAL_CONST unsigned char asio_UNRES_IO_FLAG;
 _GLOBAL_CONST unsigned char asio_IO_SIMULATION_FLAG;
 _GLOBAL_CONST unsigned char asio_IO_OUTPUT_FLAG;
 _GLOBAL_CONST unsigned char asio_IO_INPUT_FLAG;
 _GLOBAL_CONST unsigned char asio_UNRES_LINK_FLAG;
 _GLOBAL_CONST unsigned char asio_F_ACT_FLAG;
 _GLOBAL_CONST unsigned char asio_P_ACT_FLAG;
 _GLOBAL_CONST unsigned char asio_VALID_FLAG;
 _GLOBAL_CONST unsigned short asioERR_NOSUCH_DP;
 _GLOBAL_CONST unsigned short asioERR_INTERNAL;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct AsIODPStatus
{
	/* VAR_INPUT (analog) */
	unsigned long pDatapoint;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned char flags;
	unsigned char datatype;
	unsigned long value;
	unsigned long forceValue;
	unsigned long defaultValue;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIODPStatus_typ;

typedef struct AsIOSetForceValue
{
	/* VAR_INPUT (analog) */
	unsigned long pDatapoint;
	unsigned long value;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOSetForceValue_typ;

typedef struct AsIOEnableForcing
{
	/* VAR_INPUT (analog) */
	unsigned long pDatapoint;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOEnableForcing_typ;

typedef struct AsIODisableForcing
{
	/* VAR_INPUT (analog) */
	unsigned long pDatapoint;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIODisableForcing_typ;

typedef struct AsIOGlobalDisableForcing
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOGlobalDisableForcing_typ;

typedef struct AsIOFListDP
{
	/* VAR_INPUT (analog) */
	unsigned long flagsValue;
	unsigned long flagsMask;
	unsigned long pFilterString;
	unsigned long pLastDatapoint;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long pDatapoint;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	unsigned char buffer[256];
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOFListDP_typ;

typedef struct AsIOListDP
{
	/* VAR_INPUT (analog) */
	unsigned long pLastDatapoint;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long pDatapoint;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned long unused;
	unsigned char buffer[128];
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOListDP_typ;

typedef struct AsIOPVInfo
{
	/* VAR_INPUT (analog) */
	unsigned long pDatapoint;
	unsigned long index;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long pPvName;
	unsigned long pPvContext;
	unsigned char flags;
	/* VAR (analog) */
	unsigned short i_state;
	unsigned short i_result;
	unsigned char bufferA[128];
	unsigned char bufferB[128];
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOPVInfo_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void AsIODPStatus(struct AsIODPStatus* inst);
_BUR_PUBLIC void AsIOSetForceValue(struct AsIOSetForceValue* inst);
_BUR_PUBLIC void AsIOEnableForcing(struct AsIOEnableForcing* inst);
_BUR_PUBLIC void AsIODisableForcing(struct AsIODisableForcing* inst);
_BUR_PUBLIC void AsIOGlobalDisableForcing(struct AsIOGlobalDisableForcing* inst);
_BUR_PUBLIC void AsIOFListDP(struct AsIOFListDP* inst);
_BUR_PUBLIC void AsIOListDP(struct AsIOListDP* inst);
_BUR_PUBLIC void AsIOPVInfo(struct AsIOPVInfo* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASIO_ */

