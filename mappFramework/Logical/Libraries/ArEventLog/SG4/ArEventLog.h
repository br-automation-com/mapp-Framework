/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _AREVENTLOG_
#define _AREVENTLOG_
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
 #define arEVENTLOG_ADDFORMAT_CUST_MAX 150U
 #define arEVENTLOG_ADDFORMAT_CUST_BASE 100U
 #define arEVENTLOG_ADDFORMAT_CODED 2U
 #define arEVENTLOG_ADDFORMAT_TEXT 1U
 #define arEVENTLOG_ADDFORMAT_BINARY 0U
 #define arEVENTLOG_PERSISTENCE_PERSIST 2U
 #define arEVENTLOG_PERSISTENCE_REMANENT 1U
 #define arEVENTLOG_PERSISTENCE_VOLATILE 0U
 #define arEVENTLOG_SEVERITY_ERROR 3U
 #define arEVENTLOG_SEVERITY_WARNING 2U
 #define arEVENTLOG_SEVERITY_INFO 1U
 #define arEVENTLOG_SEVERITY_SUCCESS 0U
 #define arEVENTLOG_INF_SIZE 1076897555
 #define arEVENTLOG_WRN_ADDDATA_NULL (-2144327918)
 #define arEVENTLOG_WRN_FORMAT_INVALID (-2144327919)
 #define arEVENTLOG_WRN_NO_EVENTID (-2144327920)
 #define arEVENTLOG_ERR_FORMAT_INVALID (-1070586081)
 #define arEVENTLOG_ERR_DESCRIPTION_NULL (-1070586082)
 #define arEVENTLOG_ERR_NO_DESCRIPTION (-1070586083)
 #define arEVENTLOG_ERR_MODULE_EXISTS (-1070586084)
 #define arEVENTLOG_ERR_NO_ERRORNUMBER (-1070586085)
 #define arEVENTLOG_ERR_ADDDATA_NULL (-1070586086)
 #define arEVENTLOG_ERR_LOGBOOK_NOT_FOUND (-1070586087)
 #define arEVENTLOG_ERR_EVENTID_INVALID (-1070586088)
 #define arEVENTLOG_ERR_IDENT_SYSTEM (-1070586089)
 #define arEVENTLOG_ERR_IDENT_INVALID (-1070586090)
 #define arEVENTLOG_ERR_PERSISTENCE_INVAL (-1070586091)
 #define arEVENTLOG_ERR_SIZE_INVALID (-1070586092)
 #define arEVENTLOG_ERR_NAME_INVALID (-1070586093)
 #define arEVENTLOG_ERR_INTERNAL (-1070586094)
 #define arEVENTLOG_ERR_LOGBOOK_EXISTS (-1070586095)
 #define arEVENTLOG_ERR_EXISTING (-1070586095)
 #define arEVENTLOG_ERR_RECORDID_INVALID (-1070586096)
 #define arEVENTLOG_ERR_PARAMETER (-1070586096)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char arEVENTLOG_ADDFORMAT_CUST_MAX;
 _GLOBAL_CONST unsigned char arEVENTLOG_ADDFORMAT_CUST_BASE;
 _GLOBAL_CONST unsigned char arEVENTLOG_ADDFORMAT_CODED;
 _GLOBAL_CONST unsigned char arEVENTLOG_ADDFORMAT_TEXT;
 _GLOBAL_CONST unsigned char arEVENTLOG_ADDFORMAT_BINARY;
 _GLOBAL_CONST unsigned char arEVENTLOG_PERSISTENCE_PERSIST;
 _GLOBAL_CONST unsigned char arEVENTLOG_PERSISTENCE_REMANENT;
 _GLOBAL_CONST unsigned char arEVENTLOG_PERSISTENCE_VOLATILE;
 _GLOBAL_CONST unsigned char arEVENTLOG_SEVERITY_ERROR;
 _GLOBAL_CONST unsigned char arEVENTLOG_SEVERITY_WARNING;
 _GLOBAL_CONST unsigned char arEVENTLOG_SEVERITY_INFO;
 _GLOBAL_CONST unsigned char arEVENTLOG_SEVERITY_SUCCESS;
 _GLOBAL_CONST signed long arEVENTLOG_INF_SIZE;
 _GLOBAL_CONST signed long arEVENTLOG_WRN_ADDDATA_NULL;
 _GLOBAL_CONST signed long arEVENTLOG_WRN_FORMAT_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_WRN_NO_EVENTID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_FORMAT_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_DESCRIPTION_NULL;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_NO_DESCRIPTION;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_MODULE_EXISTS;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_NO_ERRORNUMBER;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_ADDDATA_NULL;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_LOGBOOK_NOT_FOUND;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_EVENTID_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_IDENT_SYSTEM;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_IDENT_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_PERSISTENCE_INVAL;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_SIZE_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_NAME_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_INTERNAL;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_LOGBOOK_EXISTS;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_EXISTING;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_RECORDID_INVALID;
 _GLOBAL_CONST signed long arEVENTLOG_ERR_PARAMETER;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct ArEventLogTimeStampType
{	unsigned long sec;
	unsigned long nsec;
} ArEventLogTimeStampType;

typedef struct ArEventLogAsyncInternalType
{	struct ArFBStateInternalType FBStateCtx;
	struct ArFBAsyFuMaInternalType AsyFuMaCtx;
} ArEventLogAsyncInternalType;

typedef struct ArEventLogInternalType
{	struct ArFBStateInternalType FBStateCtx;
} ArEventLogInternalType;

typedef unsigned long ArEventLogIdentType;

typedef struct ArEventLogCreate
{
	/* VAR_INPUT (analog) */
	plcstring Name[257];
	unsigned long Size;
	unsigned char Persistence;
	unsigned long Info;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArEventLogIdentType Ident;
	/* VAR (analog) */
	struct ArEventLogAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArEventLogCreate_typ;

typedef struct ArEventLogDelete
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct ArEventLogAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArEventLogDelete_typ;

typedef struct ArEventLogGetIdent
{
	/* VAR_INPUT (analog) */
	plcstring Name[257];
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArEventLogIdentType Ident;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogGetIdent_typ;

typedef unsigned long ArEventLogRecordIDType;

typedef struct ArEventLogWrite
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	signed long EventID;
	ArEventLogRecordIDType OriginRecordID;
	plcstring ObjectID[37];
	unsigned long AddDataSize;
	unsigned char AddDataFormat;
	unsigned long AddData;
	unsigned long TimeStamp;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArEventLogRecordIDType RecordID;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogWrite_typ;

typedef struct ArEventLogGetLatestRecordID
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArEventLogRecordIDType RecordID;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogGetLatestRecordID_typ;

typedef struct ArEventLogGetPreviousRecordID
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArEventLogRecordIDType PrevRecordID;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogGetPreviousRecordID_typ;

typedef struct ArEventLogRead
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	signed long EventID;
	ArEventLogRecordIDType OriginRecordID;
	unsigned char AddDataFormat;
	unsigned long AddDataSize;
	struct ArEventLogTimeStampType TimeStamp;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogRead_typ;

typedef plcstring ArEventLogLanguageCodeType[19];

typedef struct ArEventLogReadDescription
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	ArEventLogLanguageCodeType LanguageCode;
	plcstring Qualifier[251];
	unsigned long TextBuffer;
	unsigned long TextBufferSize;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArEventLogAsyncInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArEventLogReadDescription_typ;

typedef struct ArEventLogReadErrorNumber
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long ErrorNumber;
	unsigned char Severity;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogReadErrorNumber_typ;

typedef struct ArEventLogReadAddData
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	unsigned long AddData;
	unsigned long BytesToRead;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long AddDataSize;
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogReadAddData_typ;

typedef struct ArEventLogReadObjectID
{
	/* VAR_INPUT (analog) */
	ArEventLogIdentType Ident;
	ArEventLogRecordIDType RecordID;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	plcstring ObjectID[37];
	/* VAR (analog) */
	struct ArEventLogInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Error;
} ArEventLogReadObjectID_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ArEventLogCreate(struct ArEventLogCreate* inst);
_BUR_PUBLIC void ArEventLogDelete(struct ArEventLogDelete* inst);
_BUR_PUBLIC void ArEventLogGetIdent(struct ArEventLogGetIdent* inst);
_BUR_PUBLIC void ArEventLogWrite(struct ArEventLogWrite* inst);
_BUR_PUBLIC void ArEventLogGetLatestRecordID(struct ArEventLogGetLatestRecordID* inst);
_BUR_PUBLIC void ArEventLogGetPreviousRecordID(struct ArEventLogGetPreviousRecordID* inst);
_BUR_PUBLIC void ArEventLogRead(struct ArEventLogRead* inst);
_BUR_PUBLIC void ArEventLogReadDescription(struct ArEventLogReadDescription* inst);
_BUR_PUBLIC void ArEventLogReadErrorNumber(struct ArEventLogReadErrorNumber* inst);
_BUR_PUBLIC void ArEventLogReadAddData(struct ArEventLogReadAddData* inst);
_BUR_PUBLIC void ArEventLogReadObjectID(struct ArEventLogReadObjectID* inst);
_BUR_PUBLIC signed long ArEventLogMakeEventID(unsigned char Severity, unsigned short Facility, unsigned short ErrorCode);
_BUR_PUBLIC plcbit ArEventLogIsError(signed long EventID);
_BUR_PUBLIC plcbit ArEventLogIsWarning(signed long EventID);
_BUR_PUBLIC plcbit ArEventLogIsInformation(signed long EventID);
_BUR_PUBLIC plcbit ArEventLogIsSuccess(signed long EventID);
_BUR_PUBLIC plcbit ArEventLogIsCustomerArea(signed long EventID);
_BUR_PUBLIC plcbit ArEventLogAddDataInit(unsigned long Buffer, unsigned long BufferSize, unsigned char Format);
_BUR_PUBLIC plcbit ArEventLogAddDataUdint(unsigned long Buffer, unsigned long BufferSize, unsigned long Value);
_BUR_PUBLIC plcbit ArEventLogAddDataDint(unsigned long Buffer, unsigned long BufferSize, signed long Value);
_BUR_PUBLIC plcbit ArEventLogAddDataString(unsigned long Buffer, unsigned long BufferSize, unsigned long Value);
_BUR_PUBLIC plcbit ArEventLogAddDataQuantity(unsigned long Buffer, unsigned long BufferSize, double Value, signed long UnitID, unsigned long NamespaceURI);


#ifdef __cplusplus
};
#endif
#endif /* _AREVENTLOG_ */

