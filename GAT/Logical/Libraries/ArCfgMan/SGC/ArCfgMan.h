/* Automation Studio generated header file */
/* Do not edit ! */
/* ArCfgMan 1.01.1 */

#ifndef _ARCFGMAN_
#define _ARCFGMAN_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _ArCfgMan_VERSION
#define _ArCfgMan_VERSION 1.01.1
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
 #define AR_MODULE_NAME_LEN 70U
 #define ERR_AR_IDENT_INVALID 32000U
#else
 _GLOBAL_CONST unsigned long AR_MODULE_NAME_LEN;
 _GLOBAL_CONST unsigned long ERR_AR_IDENT_INVALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct AR_ModuleParameterCfg_struct
{	plcstring ParameterName[31];
	plcstring ValueList[25][61];
} AR_ModuleParameterCfg_struct;

typedef struct AR_AvailableModules_Int_struct
{	struct DirInfo DirInfo_0;
	struct DirRead DirRead_0;
	unsigned char State;
	unsigned long NumberOfFiles;
	struct fiDIR_READ_DATA FileInfo;
	unsigned long FileIndex;
	unsigned char ActModuleIndex;
} AR_AvailableModules_Int_struct;

typedef struct AR_GetModuleParInfo_Int_struct
{	struct FileRead FileRead_0;
	struct FileClose FileClose_0;
	struct FileOpen FileOpen_0;
	unsigned char State;
	plcstring FileName[31];
	unsigned long FileLen;
	unsigned long ModuleParamData;
} AR_GetModuleParInfo_Int_struct;

typedef struct AR_AddModule_Internal_struct
{	struct FileRead FileRead_0;
	struct FileClose FileClose_0;
	struct FileOpen FileOpen_0;
	unsigned char State;
	plcstring FileName[31];
	unsigned long FileLen;
	unsigned long NewModuleData;
} AR_AddModule_Internal_struct;

typedef struct AR_OpenArCfg_Internal_struct
{	struct DatObjRead DatObjRead_0;
	struct DatObjDelete DatObjDelete_0;
	struct DatObjInfo DatObjInfo_0;
	struct AsIOMMCopy AsIOMMCopy_0;
	unsigned long State;
} AR_OpenArCfg_Internal_struct;

typedef struct AR_CloseArCfg_Internal_struct
{	struct DatObjCreate DatObjCreate_0;
	struct DatObjDelete DatObjDelete_0;
	struct DatObjInfo DatObjInfo_0;
	struct AsIOMMRemove AsIOMMRemove_0;
	struct AsIOMMCreate AsIOMMCreate_0;
	unsigned long State;
} AR_CloseArCfg_Internal_struct;

typedef struct AR_OpenArCfg
{
	/* VAR_OUTPUT (analog) */
	unsigned long Ident;
	unsigned long Status;
	/* VAR (analog) */
	struct AR_OpenArCfg_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
} AR_OpenArCfg_typ;

typedef struct AR_CloseArCfg
{
	/* VAR_INPUT (analog) */
	unsigned long Ident;
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct AR_CloseArCfg_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Store;
} AR_CloseArCfg_typ;

typedef struct AR_AddModule
{
	/* VAR_INPUT (analog) */
	unsigned long Ident;
	plcstring (*ModuleName);
	plcstring (*FileDevice);
	plcstring (*ModulePath);
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct AR_AddModule_Internal_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
} AR_AddModule_typ;

typedef struct AR_GetModuleParInfo
{
	/* VAR_INPUT (analog) */
	plcstring (*ModuleName);
	plcstring (*FileDevice);
	struct AR_ModuleParameterCfg_struct* ParameterCfg;
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct AR_GetModuleParInfo_Int_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit mappViewDataProvider;
} AR_GetModuleParInfo_typ;

typedef struct AR_AvailableModules
{
	/* VAR_INPUT (analog) */
	plcstring (*FileDevice);
	plcstring (*ListOfAvailableModules);
	unsigned char ListLength;
	/* VAR_OUTPUT (analog) */
	unsigned long Status;
	/* VAR (analog) */
	struct AR_AvailableModules_Int_struct Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit mappViewDataProvider;
} AR_AvailableModules_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void AR_OpenArCfg(struct AR_OpenArCfg* inst);
_BUR_PUBLIC void AR_CloseArCfg(struct AR_CloseArCfg* inst);
_BUR_PUBLIC void AR_AddModule(struct AR_AddModule* inst);
_BUR_PUBLIC void AR_GetModuleParInfo(struct AR_GetModuleParInfo* inst);
_BUR_PUBLIC void AR_AvailableModules(struct AR_AvailableModules* inst);
_BUR_PUBLIC unsigned long AR_NumberOfModules(unsigned long Ident);
_BUR_PUBLIC plcbit AR_RemoveModule(unsigned long Ident, plcstring** ModulePath);
_BUR_PUBLIC plcbit AR_ReadParameter(unsigned long Ident, plcstring** ModulePath, plcstring** Parameter, plcstring** ParameterValue);
_BUR_PUBLIC plcbit AR_WriteParameter(unsigned long Ident, plcstring** ModulePath, plcstring** Parameter, plcstring** ParameterValue);
_BUR_PUBLIC plcbit AR_GetModuleInfo(unsigned long Ident, unsigned long ModuleNumber, plcstring** ModuleName, plcstring** ModulePath);
_BUR_PUBLIC plcbit AR_MoveModuleUp(unsigned long Ident, plcstring** ModulePath);
_BUR_PUBLIC plcbit AR_MoveModuleDown(unsigned long Ident, plcstring** ModulePath);


#ifdef __cplusplus
};
#endif
#endif /* _ARCFGMAN_ */

