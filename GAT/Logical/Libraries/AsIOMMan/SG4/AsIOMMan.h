/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASIOMMAN_
#define _ASIOMMAN_
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
 #define iommCONFIG 2U
 #define iommMAPPING 1U
 #define iommERR_DUPOBJECT 30177U
 #define iommERR_WRONG_NAME 30176U
 #define iommERR_MODULE_TYPE 30175U
 #define iommERR_NOSUCH_MODULE 30174U
 #define iommERR_COPY 30173U
 #define iommERR_DEINSTALL 30172U
 #define iommERR_INSTALL 30171U
 #define iommERR_INTERNAL 30170U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char iommCONFIG;
 _GLOBAL_CONST unsigned char iommMAPPING;
 _GLOBAL_CONST unsigned short iommERR_DUPOBJECT;
 _GLOBAL_CONST unsigned short iommERR_WRONG_NAME;
 _GLOBAL_CONST unsigned short iommERR_MODULE_TYPE;
 _GLOBAL_CONST unsigned short iommERR_NOSUCH_MODULE;
 _GLOBAL_CONST unsigned short iommERR_COPY;
 _GLOBAL_CONST unsigned short iommERR_DEINSTALL;
 _GLOBAL_CONST unsigned short iommERR_INSTALL;
 _GLOBAL_CONST unsigned short iommERR_INTERNAL;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct AsIOMMCreate
{
	/* VAR_INPUT (analog) */
	unsigned long pDataObject;
	unsigned long pNewModule;
	unsigned char moduleKind;
	unsigned char memType;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short errCode;
	/* VAR (analog) */
	unsigned short StateMan;
	unsigned short ErrMan;
	unsigned long Init;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOMMCreate_typ;

typedef struct AsIOMMRemove
{
	/* VAR_INPUT (analog) */
	unsigned long pModuleName;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short errCode;
	/* VAR (analog) */
	unsigned short StateMan;
	unsigned short ErrMan;
	unsigned long Init;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOMMRemove_typ;

typedef struct AsIOMMCopy
{
	/* VAR_INPUT (analog) */
	unsigned long pModuleName;
	unsigned long pNewModule;
	unsigned char memType;
	unsigned long option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short errCode;
	unsigned long ident;
	/* VAR (analog) */
	unsigned short StateMan;
	unsigned short ErrMan;
	unsigned long Init;
	/* VAR_INPUT (digital) */
	plcbit enable;
} AsIOMMCopy_typ;

typedef struct AsIOMMCompare
{
	/* VAR_INPUT (analog) */
	unsigned long pModuleName;
	unsigned long pDataObject;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned short errCode;
	/* VAR (analog) */
	unsigned short StateMan;
	unsigned short ErrMan;
	unsigned long Init;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR_OUTPUT (digital) */
	plcbit isEqual;
} AsIOMMCompare_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void AsIOMMCreate(struct AsIOMMCreate* inst);
_BUR_PUBLIC void AsIOMMRemove(struct AsIOMMRemove* inst);
_BUR_PUBLIC void AsIOMMCopy(struct AsIOMMCopy* inst);
_BUR_PUBLIC void AsIOMMCompare(struct AsIOMMCompare* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASIOMMAN_ */

