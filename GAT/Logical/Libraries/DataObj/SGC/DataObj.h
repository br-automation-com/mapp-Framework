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

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
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
 _IEC_CONST unsigned char doTEMP = 65U;
 _IEC_CONST unsigned char doFIXRAM = 5U;
 _IEC_CONST unsigned char doMEMCARD = 4U;
 _IEC_CONST unsigned char doUSRRAM = 3U;
 _IEC_CONST unsigned char doUSRROM = 2U;
 _IEC_CONST unsigned char doNO_CS = 1U;
 _IEC_CONST unsigned char doSYSROM = 0U;
 _IEC_CONST unsigned short doERR_BURNINGOBJECT = 20614U;
 _IEC_CONST unsigned short doERR_ILLSTATE = 20611U;
 _IEC_CONST unsigned short doERR_NOMEMORY = 20603U;
 _IEC_CONST unsigned short doERR_BRINSTALL = 20604U;
 _IEC_CONST unsigned short doERR_DUPOBJECT = 20601U;
 _IEC_CONST unsigned short doERR_ILLOBJECT = 20605U;
 _IEC_CONST unsigned short doERR_WRONGTIME = 20610U;
 _IEC_CONST unsigned short doERR_ILLMEMTYPE = 20602U;
 _IEC_CONST unsigned short doERR_ILLOBJTYPE = 20606U;
 _IEC_CONST unsigned short doERR_WRONGOFFSET = 20607U;
 _IEC_CONST unsigned short doERR_ILLPARAMETER = 20600U;
 _IEC_CONST unsigned short doERR_STARTHANDLER = 20612U;
 _IEC_CONST unsigned short doERR_ILLEGALLENGTH = 20608U;
 _IEC_CONST unsigned short doERR_MODULNOTFOUND = 20609U;
 _IEC_CONST unsigned short doERR_CHECKSUM_WARNING = 20630U;
 _IEC_CONST unsigned short doERR_TOOLONG_MODULNAME = 20613U;
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



/* Prototyping of functions and function blocks */
void DatObjCreate(struct DatObjCreate* inst);
void DatObjWrite(struct DatObjWrite* inst);
void DatObjRead(struct DatObjRead* inst);
void DatObjDelete(struct DatObjDelete* inst);
void DatObjMove(struct DatObjMove* inst);
void DatObjCopy(struct DatObjCopy* inst);
void DatObjInfo(struct DatObjInfo* inst);
void DatObjChangeDate(struct DatObjChangeDate* inst);


#ifdef __cplusplus
};
#endif
#endif /* _DATAOBJ_ */

                                                           
