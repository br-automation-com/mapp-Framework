/* Automation Studio generated header file */
/* Do not edit ! */
/* IoMapMan 1.01.1 */

#ifndef _IOMAPMAN_
#define _IOMAPMAN_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _IoMapMan_VERSION
#define _IoMapMan_VERSION 1.01.1
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "runtime.h"
		#include "DataObj.h"
		#include "FileIO.h"
		#include "AsIOMMan.h"
#endif
#ifdef _SG4
		#include "runtime.h"
		#include "DataObj.h"
		#include "FileIO.h"
		#include "AsIOMMan.h"
#endif
#ifdef _SGC
		#include "runtime.h"
		#include "DataObj.h"
		#include "FileIO.h"
		#include "AsIOMMan.h"
#endif


/* Constants */
#ifdef _REPLACE_CONST
 #define ERR_IO_IDENT_INVALID 32000U
#else
 _GLOBAL_CONST unsigned long ERR_IO_IDENT_INVALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum IO_Type_enum
{	IO_DIG_OUTPUT = 0,
	IO_DIG_INPUT = 1,
	IO_ANA_OUTPUT = 2,
	IO_ANA_INPUT = 3,
	IO_USINT_OUTPUT = 4,
	IO_USINT_INPUT = 5,
	IO_UDINT_OUTPUT = 6,
	IO_UDINT_INPUT = 7,
	IO_PWM_OUTPUT = 8,
	IO_TEMP_INPUT = 9,
	IO_RESISTOR_INPUT = 10,
	IO_TYPE_OTHER = 11
} IO_Type_enum;

typedef struct IO_AddModuleIoCh_Internal_struct
{	struct FileRead FileRead_0;
	struct FileClose FileClose_0;
	struct FileOpen FileOpen_0;
	unsigned char State;
	plcstring FileName[31];
	unsigned long FileLen;
	unsigned long NewIoData;
} IO_AddModuleIoCh_Internal_struct;

typedef struct IO_CloseIoMap_Internal_struct
{	struct DatObjCreate DatObjCreate_0;
	struct DatObjDelete DatObjDelete_0;
	struct DatObjInfo DatObjInfo_0;
	struct AsIOMMRemove AsIOMMRemove_0;
	struct AsIOMMCreate AsIOMMCreate_0;
	unsigned long State;
} IO_CloseIoMap_Internal_struct;

typedef struct IO_OpenIoMap_Internal_struct
{	struct DatObjRead DatObjRead_0;
	struct DatObjDelete DatObjDelete_0;
	struct DatObjInfo DatObjInfo_0;
	struct AsIOMMCopy AsIOMMCopy_0;
	unsigned long State;
} IO_OpenIoMap_Internal_struct;

typedef struct IO_OpenIoMap
{
	/* VAR_OUTPUT (analog) */
	unsigned long Ident;
	unsigned long NumberOfChannels;
	unsigned long Status;
	/* VAR (analog) */
	struct IO_OpenIoMap_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
} IO_OpenIoMap_typ;

typedef struct IO_CloseIoMap
{
	/* VAR_INPUT (analog) */
	unsigned long Ident;
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct IO_CloseIoMap_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Store;
} IO_CloseIoMap_typ;

typedef struct IO_AddModuleIoChannels
{
	/* VAR_INPUT (analog) */
	unsigned long Ident;
	plcstring (*ModuleName);
	plcstring (*ModulePath);
	plcstring (*FileDevice);
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct IO_AddModuleIoCh_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
} IO_AddModuleIoChannels_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void IO_OpenIoMap(struct IO_OpenIoMap* inst);
_BUR_PUBLIC void IO_CloseIoMap(struct IO_CloseIoMap* inst);
_BUR_PUBLIC void IO_AddModuleIoChannels(struct IO_AddModuleIoChannels* inst);
_BUR_PUBLIC plcbit IO_RemoveChannel(unsigned long Ident, unsigned long ChannelNumber);
_BUR_PUBLIC plcbit IO_AddChannel(unsigned long Ident, enum IO_Type_enum Type, plcbit Inverted, unsigned char TaskClass, plcstring** PvName, plcstring** ModulePath, plcstring** ChannelName);
_BUR_PUBLIC plcbit IO_ReadChannel(unsigned long Ident, unsigned long ChannelNumber, enum IO_Type_enum* Type, plcbit* Inverted, plcstring** ChannelName, plcstring** PvName, plcstring** ModulePath, unsigned char* TaskClass);
_BUR_PUBLIC plcbit IO_ModifyChannel(unsigned long Ident, unsigned long ChannelNumber, enum IO_Type_enum Type, plcbit Inverted, unsigned char TaskClass, plcstring** PvName, plcstring** ModulePath, plcstring** ChannelName);
_BUR_PUBLIC unsigned long IO_NumberOfChannels(unsigned long Ident);
_BUR_PUBLIC plcbit IO_RemoveModuleChannels(unsigned long Ident, plcstring** ModulePath);
_BUR_PUBLIC plcbit IO_MoveModuleUp(unsigned long Ident, plcstring** ModulePath);
_BUR_PUBLIC plcbit IO_MoveModuleDown(unsigned long Ident, plcstring** ModulePath);


#ifdef __cplusplus
};
#endif
#endif /* _IOMAPMAN_ */

