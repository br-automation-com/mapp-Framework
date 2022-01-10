/* Automation Studio generated header file */
/* Do not edit ! */
/* MpTool 5.16.2 */

#ifndef _MPTOOL_
#define _MPTOOL_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpTool_VERSION
#define _MpTool_VERSION 5.16.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <MpBase.h> 
#include <McAxGroup.h> 
#include <SYS_LIB.h>
#endif
 
#ifdef _SG3
#include <MpBase.h> 
#include <McAxGroup.h> 
#include <SYS_LIB.h>
#endif
 
#ifdef _SGC
#include <MpBase.h> 
#include <McAxGroup.h> 
#include <SYS_LIB.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef enum MpToolErrorEnum
{	mpTOOL_NO_ERROR = 0,
	mpTOOL_ERR_GET_FAILED = -1067211776,
	mpTOOL_ERR_SET_FAILED = -1067211775,
	mpTOOL_ERR_CREATE_FAILED = -1067211774,
	mpTOOL_ERR_DELETE_FAILED = -1067211773,
	mpTOOL_INF_NO_MORE_ELEMENTS = 1080271876,
	mpTOOL_INF_NO_ELEMENT_FOUND = 1080271877,
	mpTOOL_ERR_EXECUTE_FAILED = -1067211770,
	mpTOOL_ERR_NEXT_FAILED = -1067211769,
	mpTOOL_ERR_ACTIVATION = -1064239103,
	mpTOOL_ERR_MPLINK_NULL = -1064239102,
	mpTOOL_ERR_MPLINK_INVALID = -1064239101,
	mpTOOL_ERR_MPLINK_CHANGED = -1064239100,
	mpTOOL_ERR_MPLINK_CORRUPT = -1064239099,
	mpTOOL_ERR_MPLINK_IN_USE = -1064239098,
	mpTOOL_ERR_PAR_NULL = -1064239097
} MpToolErrorEnum;

typedef enum McToolGetDataEnum
{	mcTOOL_GETDATA_TOOLTABLE = 0,
	mcTOOL_GETDATA_RECORD_GEO,
	mcTOOL_GETDATA_GEOMETRY,
	mcTOOL_GETDATA_DYNAMICS,
	mcTOOL_GETDATA_WIREFRAME
} McToolGetDataEnum;

typedef enum McToolManagerDeleteModeEnum
{	mcTOOL_MANAGER_DELETE_TOOLTABLE = 0,
	mcTOOL_MANAGER_DELETE_TABLE_GEO,
	mcTOOL_MANAGER_DELETE_RECORD,
	mcTOOL_MANAGER_DELETE_RECORD_GEO,
	mcTOOL_MANAGER_DELETE_GEOMETRY,
	mcTOOL_MANAGER_DELETE_DYNAMICS,
	mcTOOL_MANAGER_DELETE_WIREFRAME
} McToolManagerDeleteModeEnum;

typedef enum McToolManagerCreateModeEnum
{	mcTOOL_MANAGER_CREATE_TOOLTABLE = 0,
	mcTOOL_MANAGER_CREATE_RECORD,
	mcTOOL_MANAGER_CREATE_RECORD_GEO,
	mcTOOL_MANAGER_CREATE_GEOMETRY,
	mcTOOL_MANAGER_CREATE_DYNAMICS,
	mcTOOL_MANAGER_CREATE_WIREFRAME
} McToolManagerCreateModeEnum;

typedef enum McToolManagerGetModeEnum
{	mcTOOL_MANAGER_GET_RECORD = 0,
	mcTOOL_MANAGER_GET_RECORD_GEO,
	mcTOOL_MANAGER_GET_GEOMETRY,
	mcTOOL_MANAGER_GET_DYNAMICS,
	mcTOOL_MANAGER_GET_WIREFRAME
} McToolManagerGetModeEnum;

typedef enum McToolManagerSetModeEnum
{	mcTOOL_MANAGER_SET_RECORD = 0,
	mcTOOL_MANAGER_SET_RECORD_GEO,
	mcTOOL_MANAGER_SET_GEOMETRY,
	mcTOOL_MANAGER_SET_DYNAMICS,
	mcTOOL_MANAGER_SET_WIREFRAME
} McToolManagerSetModeEnum;

typedef struct McToolRecordType
{	plcstring Identifier[251];
	plcstring GeometryName[251];
	struct McToolGeometryType GeometryData;
	plcstring DynamicsName[251];
	plcstring WireFrameName[251];
} McToolRecordType;

typedef struct MpToolStatusIDType
{	enum MpToolErrorEnum ID;
	enum MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpToolStatusIDType;

typedef struct MpToolDiagType
{	struct MpToolStatusIDType StatusID;
} MpToolDiagType;

typedef struct MpToolManagerParType
{	plcstring ToolTable[251];
	struct McToolRecordType Record;
	plcstring GeometryName[251];
	struct McToolGeometryType GeometryData;
	enum McToolManagerCreateModeEnum CreateMode;
	enum McToolManagerDeleteModeEnum DeleteMode;
	enum McToolManagerGetModeEnum GetMode;
	enum McToolManagerSetModeEnum SetMode;
	plcstring DynamicsName[251];
	struct McToolDynamicsType DynamicsData;
	plcstring WireFrameName[251];
	struct McToolWireFrameType WireFrameData;
} MpToolManagerParType;

typedef struct MpToolManagerInfoType
{	struct McToolRecordType Record;
	plcstring GeometryName[251];
	struct McToolGeometryType GeometryData;
	struct MpToolDiagType Diag;
	plcstring DynamicsName[251];
	struct McToolDynamicsType DynamicsData;
	plcstring WireFrameName[251];
	struct McToolWireFrameType WireFrameData;
} MpToolManagerInfoType;

typedef struct MpToolGetDataInfoType
{	unsigned long NumberOfElements;
	unsigned long CurrentElement;
	struct MpToolDiagType Diag;
} MpToolGetDataInfoType;

typedef struct MpToolGetDataParType
{	enum McToolGetDataEnum Mode;
	plcstring ToolTable[251];
} MpToolGetDataParType;

typedef struct MpToolGetDataResultType
{	plcstring ToolTable[251];
	struct McToolRecordType Record;
	plcstring GeometryName[251];
	plcstring DynamicsName[251];
	plcstring WireFrameName[251];
	struct McToolGeometryType GeometryData;
	struct McToolDynamicsType DynamicsData;
	struct McToolWireFrameType WireFrameData;
} MpToolGetDataResultType;

typedef struct MpToolManager
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpToolManagerParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpToolManagerInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Create;
	plcbit Delete;
	plcbit Get;
	plcbit Set;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpToolManager_typ;

typedef struct MpToolGetData
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpToolGetDataParType* Parameters;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpToolGetDataResultType Result;
	struct MpToolGetDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Execute;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
	plcbit HasMoreElements;
} MpToolGetData_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpToolManager(struct MpToolManager* inst);
_BUR_PUBLIC void MpToolGetData(struct MpToolGetData* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPTOOL_ */

