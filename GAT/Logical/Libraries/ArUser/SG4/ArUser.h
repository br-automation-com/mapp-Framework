/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ARUSER_
#define _ARUSER_
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
 #define arUSER_ERR_INTERNAL (-1070585889)
 #define arUSER_WRN_END_OF_LIST (-2144327714)
 #define arUSER_ERR_FILE (-1070585891)
 #define arUSER_ERR_DOES_NOT_EXIST (-1070585892)
 #define arUSER_ERR_ALREADY_EXISTS (-1070585893)
 #define arUSER_ERR_PARAMETER (-1070585894)
 #define arUSER_USER_PROPERTIES 5U
 #define arUSER_ROLE_PROPERTIES 4U
 #define arUSER_USERROLES 3U
 #define arUSER_ROLE 2U
 #define arUSER_USER 1U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long arUSER_ERR_INTERNAL;
 _GLOBAL_CONST signed long arUSER_WRN_END_OF_LIST;
 _GLOBAL_CONST signed long arUSER_ERR_FILE;
 _GLOBAL_CONST signed long arUSER_ERR_DOES_NOT_EXIST;
 _GLOBAL_CONST signed long arUSER_ERR_ALREADY_EXISTS;
 _GLOBAL_CONST signed long arUSER_ERR_PARAMETER;
 _GLOBAL_CONST plcbyte arUSER_USER_PROPERTIES;
 _GLOBAL_CONST plcbyte arUSER_ROLE_PROPERTIES;
 _GLOBAL_CONST plcbyte arUSER_USERROLES;
 _GLOBAL_CONST plcbyte arUSER_ROLE;
 _GLOBAL_CONST plcbyte arUSER_USER;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct ArUserIdentType
{	unsigned long Handle;
	unsigned long MagicNumber;
} ArUserIdentType;

typedef struct ArUserAsyncInternalType
{	struct ArFBStateInternalType FBStateCtx;
	struct ArFBAsyFuMaInternalType AsyFuMaCtx;
} ArUserAsyncInternalType;

typedef struct ArUserInternalType
{	struct ArFBStateInternalType FBStateCtx;
} ArUserInternalType;

typedef struct ArUserAuthenticatePassword
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring Password[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
	plcbit IsAuthentic;
} ArUserAuthenticatePassword_typ;

typedef struct ArUserAuthenticateToken
{
	/* VAR_INPUT (analog) */
	plcstring Token[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	plcstring UserName[129];
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
	plcbit IsAuthentic;
} ArUserAuthenticateToken_typ;

typedef struct ArUserHasRole
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring RoleName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
	plcbit HasRole;
} ArUserHasRole_typ;

typedef struct ArUserInitList
{
	/* VAR_INPUT (analog) */
	plcbyte ListType;
	plcstring ElementName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct ArUserIdentType List;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserInitList_typ;

typedef struct ArUserGetNext
{
	/* VAR_INPUT (analog) */
	struct ArUserIdentType List;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	plcstring ElementName[129];
	/* VAR (analog) */
	struct ArUserInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArUserGetNext_typ;

typedef struct ArUserGetFirst
{
	/* VAR_INPUT (analog) */
	struct ArUserIdentType List;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	plcstring ElementName[129];
	/* VAR (analog) */
	struct ArUserInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArUserGetFirst_typ;

typedef struct ArUserDestroyList
{
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR_IN_OUT (analog and digital) */
	struct ArUserIdentType* List;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserDestroyList_typ;

typedef struct ArUserCreate
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserCreate_typ;

typedef struct ArUserDelete
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserDelete_typ;

typedef struct ArUserCreateRole
{
	/* VAR_INPUT (analog) */
	plcstring RoleName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserCreateRole_typ;

typedef struct ArUserDeleteRole
{
	/* VAR_INPUT (analog) */
	plcstring RoleName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserDeleteRole_typ;

typedef struct ArUserSetPassword
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring Password[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserSetPassword_typ;

typedef struct ArUserSetToken
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring Token[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserSetToken_typ;

typedef struct ArUserAssignRole
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring RoleName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserAssignRole_typ;

typedef struct ArUserReleaseRole
{
	/* VAR_INPUT (analog) */
	plcstring UserName[129];
	plcstring RoleName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserReleaseRole_typ;

typedef struct ArUserExport
{
	/* VAR_INPUT (analog) */
	plcstring FilePath[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserExport_typ;

typedef struct ArUserExportEx
{
	/* VAR_INPUT (analog) */
	plcstring Device[129];
	plcstring LocalPath[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserExportEx_typ;

typedef struct ArUserImport
{
	/* VAR_INPUT (analog) */
	plcstring FilePath[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserImport_typ;

typedef struct ArUserImportEx
{
	/* VAR_INPUT (analog) */
	plcstring Device[129];
	plcstring LocalPath[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserImportEx_typ;

typedef struct ArUserGetProperty
{
	/* VAR_INPUT (analog) */
	plcbyte ElementType;
	plcstring ElementName[129];
	plcstring PropertyName[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	plcstring PropertyValue[129];
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserGetProperty_typ;

typedef struct ArUserSetProperty
{
	/* VAR_INPUT (analog) */
	plcbyte ElementType;
	plcstring ElementName[129];
	plcstring PropertyName[129];
	plcstring PropertyValue[129];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct ArUserAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArUserSetProperty_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ArUserAuthenticatePassword(struct ArUserAuthenticatePassword* inst);
_BUR_PUBLIC void ArUserAuthenticateToken(struct ArUserAuthenticateToken* inst);
_BUR_PUBLIC void ArUserHasRole(struct ArUserHasRole* inst);
_BUR_PUBLIC void ArUserInitList(struct ArUserInitList* inst);
_BUR_PUBLIC void ArUserGetNext(struct ArUserGetNext* inst);
_BUR_PUBLIC void ArUserGetFirst(struct ArUserGetFirst* inst);
_BUR_PUBLIC void ArUserDestroyList(struct ArUserDestroyList* inst);
_BUR_PUBLIC void ArUserCreate(struct ArUserCreate* inst);
_BUR_PUBLIC void ArUserDelete(struct ArUserDelete* inst);
_BUR_PUBLIC void ArUserCreateRole(struct ArUserCreateRole* inst);
_BUR_PUBLIC void ArUserDeleteRole(struct ArUserDeleteRole* inst);
_BUR_PUBLIC void ArUserSetPassword(struct ArUserSetPassword* inst);
_BUR_PUBLIC void ArUserSetToken(struct ArUserSetToken* inst);
_BUR_PUBLIC void ArUserAssignRole(struct ArUserAssignRole* inst);
_BUR_PUBLIC void ArUserReleaseRole(struct ArUserReleaseRole* inst);
_BUR_PUBLIC void ArUserExport(struct ArUserExport* inst);
_BUR_PUBLIC void ArUserExportEx(struct ArUserExportEx* inst);
_BUR_PUBLIC void ArUserImport(struct ArUserImport* inst);
_BUR_PUBLIC void ArUserImportEx(struct ArUserImportEx* inst);
_BUR_PUBLIC void ArUserGetProperty(struct ArUserGetProperty* inst);
_BUR_PUBLIC void ArUserSetProperty(struct ArUserSetProperty* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ARUSER_ */

