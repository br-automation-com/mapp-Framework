/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASMEM_
#define _ASMEM_
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
 #define asmemERR_FREE 30503U
 #define asmemERR_INFO 30504U
 #define asmemERR_NOMEM 30502U
 #define asmemERR_CREATE 30500U
 #define asmemERR_DESTROY 30501U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned short asmemERR_FREE;
 _GLOBAL_CONST unsigned short asmemERR_INFO;
 _GLOBAL_CONST unsigned short asmemERR_NOMEM;
 _GLOBAL_CONST unsigned short asmemERR_CREATE;
 _GLOBAL_CONST unsigned short asmemERR_DESTROY;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct AsMemPartCreate
{
	/* VAR_INPUT (analog) */
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long ident;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartCreate_typ;

typedef struct AsMemPartDestroy
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartDestroy_typ;

typedef struct AsMemPartAlloc
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long mem;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartAlloc_typ;

typedef struct AsMemPartAllocClear
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long mem;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartAllocClear_typ;

typedef struct AsMemPartRealloc
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long memOld;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long mem;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartRealloc_typ;

typedef struct AsMemPartFree
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long mem;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartFree_typ;

typedef struct AsMemPartInfo
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long numBytesFree;
	unsigned long maxBlockSizeFree;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsMemPartInfo_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void AsMemPartCreate(struct AsMemPartCreate* inst);
_BUR_PUBLIC void AsMemPartDestroy(struct AsMemPartDestroy* inst);
_BUR_PUBLIC void AsMemPartAlloc(struct AsMemPartAlloc* inst);
_BUR_PUBLIC void AsMemPartAllocClear(struct AsMemPartAllocClear* inst);
_BUR_PUBLIC void AsMemPartRealloc(struct AsMemPartRealloc* inst);
_BUR_PUBLIC void AsMemPartFree(struct AsMemPartFree* inst);
_BUR_PUBLIC void AsMemPartInfo(struct AsMemPartInfo* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASMEM_ */

