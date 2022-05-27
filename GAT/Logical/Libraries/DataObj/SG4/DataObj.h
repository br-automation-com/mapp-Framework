/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _DATAOBJ_
#define _DATAOBJ_
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
 #define doTEMP 65U
 #define doFIXRAM 5U
 #define doMEMCARD 4U
 #define doUSRRAM 3U
 #define doUSRROM 2U
 #define doNO_CS 1U
 #define doSYSROM 0U
 #define doERR_MODULDELETE_SYSROM 20615U
 #define doERR_BURNINGOBJECT 20614U
 #define doERR_ILLSTATE 20611U
 #define doERR_NOMEMORY 20603U
 #define doERR_BRINSTALL 20604U
 #define doERR_DUPOBJECT 20601U
 #define doERR_ILLOBJECT 20605U
 #define doERR_WRONGTIME 20610U
 #define doERR_ILLMEMTYPE 20602U
 #define doERR_ILLOBJTYPE 20606U
 #define doERR_WRONGOFFSET 20607U
 #define doERR_ILLPARAMETER 20600U
 #define doERR_STARTHANDLER 20612U
 #define doERR_ILLEGALLENGTH 20608U
 #define doERR_MODULNOTFOUND 20609U
 #define doERR_CHECKSUM_WARNING 20630U
 #define doERR_TOOLONG_MODULNAME 20613U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char doTEMP;
 _GLOBAL_CONST unsigned char doFIXRAM;
 _GLOBAL_CONST unsigned char doMEMCARD;
 _GLOBAL_CONST unsigned char doUSRRAM;
 _GLOBAL_CONST unsigned char doUSRROM;
 _GLOBAL_CONST unsigned char doNO_CS;
 _GLOBAL_CONST unsigned char doSYSROM;
 _GLOBAL_CONST unsigned short doERR_MODULDELETE_SYSROM;
 _GLOBAL_CONST unsigned short doERR_BURNINGOBJECT;
 _GLOBAL_CONST unsigned short doERR_ILLSTATE;
 _GLOBAL_CONST unsigned short doERR_NOMEMORY;
 _GLOBAL_CONST unsigned short doERR_BRINSTALL;
 _GLOBAL_CONST unsigned short doERR_DUPOBJECT;
 _GLOBAL_CONST unsigned short doERR_ILLOBJECT;
 _GLOBAL_CONST unsigned short doERR_WRONGTIME;
 _GLOBAL_CONST unsigned short doERR_ILLMEMTYPE;
 _GLOBAL_CONST unsigned short doERR_ILLOBJTYPE;
 _GLOBAL_CONST unsigned short doERR_WRONGOFFSET;
 _GLOBAL_CONST unsigned short doERR_ILLPARAMETER;
 _GLOBAL_CONST unsigned short doERR_STARTHANDLER;
 _GLOBAL_CONST unsigned short doERR_ILLEGALLENGTH;
 _GLOBAL_CONST unsigned short doERR_MODULNOTFOUND;
 _GLOBAL_CONST unsigned short doERR_CHECKSUM_WARNING;
 _GLOBAL_CONST unsigned short doERR_TOOLONG_MODULNAME;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct DatObjCreate
{
	/* VAR_INPUT (analog) */
	unsigned char grp;
	unsigned long pName;
	unsigned long len;
	unsigned char MemType;
	unsigned long Option;
	unsigned long pCpyData;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long ident;
	unsigned long pDatObjMem;
	/* VAR (analog) */
	unsigned long i_state;
	unsigned long i_result;
	unsigned char i_spare[105];
	unsigned long i_spare_1;
	unsigned short i_spare_2;
	unsigned long i_spare_3;
	unsigned char i_spare_4;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjCreate_typ;

typedef struct DatObjWrite
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long Offset;
	unsigned long pSource;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjWrite_typ;

typedef struct DatObjRead
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long Offset;
	unsigned long pDestination;
	unsigned long len;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjRead_typ;

typedef struct DatObjDelete
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR (analog) */
	unsigned long i_state;
	unsigned long i_result;
	unsigned char i_spare;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjDelete_typ;

typedef struct DatObjMove
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned char MemType;
	unsigned long Option;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long identNew;
	unsigned long pDatObjMem;
	/* VAR (analog) */
	unsigned long i_state;
	unsigned long i_result;
	unsigned char i_spare[41];
	unsigned long i_spare_1;
	unsigned char i_spare_2;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjMove_typ;

typedef struct DatObjCopy
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	unsigned long pNameTarget;
	unsigned char MemTypeTarget;
	unsigned long OptionTarget;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long identNew;
	unsigned long pDatObjMemNew;
	/* VAR (analog) */
	unsigned long i_state;
	unsigned long i_result;
	unsigned char i_spare[41];
	unsigned long i_spare_1;
	unsigned char i_spare_2;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjCopy_typ;

typedef struct DatObjInfo
{
	/* VAR_INPUT (analog) */
	unsigned long pName;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	unsigned long ident;
	unsigned long pDatObjMem;
	unsigned long len;
	unsigned char MemType;
	unsigned long Option;
	plcdt ChangeDate;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjInfo_typ;

typedef struct DatObjChangeDate
{
	/* VAR_INPUT (analog) */
	unsigned long pName;
	plcdt SetDate;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjChangeDate_typ;

typedef struct DatObjAttach
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjAttach_typ;

typedef struct DatObjDetach
{
	/* VAR_INPUT (analog) */
	unsigned long ident;
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} DatObjDetach_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void DatObjCreate(struct DatObjCreate* inst);
_BUR_PUBLIC void DatObjWrite(struct DatObjWrite* inst);
_BUR_PUBLIC void DatObjRead(struct DatObjRead* inst);
_BUR_PUBLIC void DatObjDelete(struct DatObjDelete* inst);
_BUR_PUBLIC void DatObjMove(struct DatObjMove* inst);
_BUR_PUBLIC void DatObjCopy(struct DatObjCopy* inst);
_BUR_PUBLIC void DatObjInfo(struct DatObjInfo* inst);
_BUR_PUBLIC void DatObjChangeDate(struct DatObjChangeDate* inst);
_BUR_PUBLIC void DatObjAttach(struct DatObjAttach* inst);
_BUR_PUBLIC void DatObjDetach(struct DatObjDetach* inst);


#ifdef __cplusplus
};
#endif
#endif /* _DATAOBJ_ */

