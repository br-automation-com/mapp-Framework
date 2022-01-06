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

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define iommERR_INTERNAL 30170U
 #define iommERR_INSTALL 30171U
 #define iommERR_DEINSTALL 30172U
 #define iommERR_COPY 30173U
 #define iommERR_NOSUCH_MODULE 30174U
 #define iommERR_MODULE_TYPE 30175U
 #define iommERR_WRONG_NAME 30176U
 #define iommERR_DUPOBJECT 30177U
 #define iommMAPPING 1U
 #define iommCONFIG 2U
#else
 _IEC_CONST unsigned short iommERR_INTERNAL = 30170U;
 _IEC_CONST unsigned short iommERR_INSTALL = 30171U;
 _IEC_CONST unsigned short iommERR_DEINSTALL = 30172U;
 _IEC_CONST unsigned short iommERR_COPY = 30173U;
 _IEC_CONST unsigned short iommERR_NOSUCH_MODULE = 30174U;
 _IEC_CONST unsigned short iommERR_MODULE_TYPE = 30175U;
 _IEC_CONST unsigned short iommERR_WRONG_NAME = 30176U;
 _IEC_CONST unsigned short iommERR_DUPOBJECT = 30177U;
 _IEC_CONST unsigned char iommMAPPING = 1U;
 _IEC_CONST unsigned char iommCONFIG = 2U;
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



/* Prototyping of functions and function blocks */
void AsIOMMCreate(struct AsIOMMCreate* inst);
void AsIOMMRemove(struct AsIOMMRemove* inst);
void AsIOMMCopy(struct AsIOMMCopy* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ASIOMMAN_ */

                                                           
