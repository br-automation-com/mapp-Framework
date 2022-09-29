/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ARTEXTSYS_
#define _ARTEXTSYS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define arTEXTSYS_ERR_END_REACHED 2150639645U
 #define arTEXTSYS_ERR_NOT_EXISTS 2150639644U
 #define arTEXTSYS_INF_SUBSTITUTE_TEXT 1076897819
 #define arTEXTSYS_INF_LANGUAGE_DIFFERS 1076897818
 #define arTEXTSYS_ERR_NO_TEXT_FOUND 2150639640U
 #define arTEXTSYS_INF_NOT_SET_DURABLE 1076897814
 #define arTEXTSYS_ERR_TEXTDB_INTERNAL 2150639637U
 #define arTEXTSYS_ERR_TEXTDB_READER 2150639636U
 #define arTEXTSYS_ERR_TEXTDB_SCHEMA 2150639635U
 #define arTEXTSYS_INF_ALREADY_OPENED 1076897810
 #define arTEXTSYS_ERR_CANT_OPEN_TEXTDB 2150639633U
 #define arTEXTSYS_ERR_INVALID_HANDLE 2150639630U
 #define arTEXTSYS_ERR_ACCESS_DENIED 2150639629U
 #define arTEXTSYS_ERR_FAILED 2150639628U
 #define arTEXTSYS_ERR_INVALID_ARG 2150639627U
 #define arTEXTSYS_ERR_OUT_OF_MEMORY 3224381450U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_END_REACHED;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_NOT_EXISTS;
 _GLOBAL_CONST signed long arTEXTSYS_INF_SUBSTITUTE_TEXT;
 _GLOBAL_CONST signed long arTEXTSYS_INF_LANGUAGE_DIFFERS;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_NO_TEXT_FOUND;
 _GLOBAL_CONST signed long arTEXTSYS_INF_NOT_SET_DURABLE;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_TEXTDB_INTERNAL;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_TEXTDB_READER;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_TEXTDB_SCHEMA;
 _GLOBAL_CONST signed long arTEXTSYS_INF_ALREADY_OPENED;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_CANT_OPEN_TEXTDB;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_INVALID_HANDLE;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_ACCESS_DENIED;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_FAILED;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_INVALID_ARG;
 _GLOBAL_CONST unsigned long arTEXTSYS_ERR_OUT_OF_MEMORY;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum ArTextSysSearchModeEnum
{	arTEXTSYS_SEARCH_FALLBACK_SUBST,
	arTEXTSYS_SEARCH_LANGUAGE_ONLY,
	arTEXTSYS_SEARCH_FALLBACK
} ArTextSysSearchModeEnum;

typedef struct ArTextSysFormatArgumentType
{	unsigned short Datatype;
	unsigned long Data;
	unsigned long UnitNamespace;
	unsigned long UnitID;
} ArTextSysFormatArgumentType;

typedef struct ArTextSysExec1InternalType
{	unsigned short i_serno;
	unsigned short i_state;
	signed long Result;
} ArTextSysExec1InternalType;

typedef struct ArTextSysIter1InternalType
{	struct ArTextSysExec1InternalType i_base;
	signed long m_iter;
} ArTextSysIter1InternalType;

typedef plcstring ArTextSysLanguageCodeType[19];

typedef struct ArTextSysGetSystemLanguage
{
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetSystemLanguage_typ;

typedef struct ArTextSysSetSystemLanguage
{
	/* VAR_INPUT (analog) */
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysSetSystemLanguage_typ;

typedef struct ArTextSysGetNamespaceLanguages
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR (analog) */
	struct ArTextSysIter1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	plcbit First;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
	plcbit EndOfList;
} ArTextSysGetNamespaceLanguages_typ;

typedef struct ArTextSysGetText
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	unsigned long TextID;
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	enum ArTextSysSearchModeEnum SearchMode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetText_typ;

typedef struct ArTextSysFormatString
{
	/* VAR_INPUT (analog) */
	unsigned long FormatString;
	unsigned short ArgumentCount;
	struct ArTextSysFormatArgumentType ArgumentList[10];
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long MeasurementCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysFormatString_typ;

typedef struct ArTextSysGetFormattedText
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	unsigned long TextID;
	unsigned short ArgumentCount;
	struct ArTextSysFormatArgumentType ArgumentList[10];
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long MeasurementCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	enum ArTextSysSearchModeEnum SearchMode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetFormattedText_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ArTextSysGetSystemLanguage(struct ArTextSysGetSystemLanguage* inst);
_BUR_PUBLIC void ArTextSysSetSystemLanguage(struct ArTextSysSetSystemLanguage* inst);
_BUR_PUBLIC void ArTextSysGetNamespaceLanguages(struct ArTextSysGetNamespaceLanguages* inst);
_BUR_PUBLIC void ArTextSysGetText(struct ArTextSysGetText* inst);
_BUR_PUBLIC void ArTextSysFormatString(struct ArTextSysFormatString* inst);
_BUR_PUBLIC void ArTextSysGetFormattedText(struct ArTextSysGetFormattedText* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ARTEXTSYS_ */

