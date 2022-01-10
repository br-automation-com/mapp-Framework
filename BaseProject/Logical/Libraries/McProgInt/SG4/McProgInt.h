/* Automation Studio generated header file */
/* Do not edit ! */
/* McProgInt 5.16.2 */

#ifndef _MCPROGINT_
#define _MCPROGINT_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _McProgInt_VERSION
#define _McProgInt_VERSION 5.16.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <McBase.h>
#endif
 
#ifdef _SG3
#include <McBase.h>
#endif
 
#ifdef _SGC
#include <McBase.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef struct McProgIntIpMonitorType
{	plcbit Handshake;
	plcbit Reserve[3];
	plcstring StatusMsg[264];
	plcstring LastErrorMsg[120];
	unsigned short LastErrorCode;
	unsigned short LoadedProgCount;
	plcstring ProgName[264];
	plcstring NcblockL2[264];
	plcstring NcblockL1[264];
	plcstring Ncblock[264];
	plcstring NcblockN1[264];
	plcstring NcblockN2[264];
	unsigned long CurLineNum;
	unsigned long CurBlockNum;
	unsigned long LoadFreadTime;
	unsigned long LoadPrepTime;
	unsigned long LoadSepLinesTime;
	unsigned long LoadParseTime;
	unsigned long LoadParseLexTime;
	unsigned long BreakpointCount;
	unsigned long IpvarAccessCount;
	unsigned long ExecTime;
	unsigned long IdleTime;
	unsigned long NumParallelEvents;
	unsigned long ParallelCycleCount;
	plcstring ParallelActionText[12][264];
	unsigned long ParallelEvalCount[12];
	unsigned long ParallelExecCount[12];
	unsigned long NumFubsExecIpsynch;
	unsigned long NumFubsExecPpsynch;
	plcstring Callstack[12][264];
	unsigned long SharedMem_size;
	unsigned long IpMemSize;
	unsigned long IpCurFileMemSize;
	unsigned long SysFreeMem;
	unsigned long ReadingLineNum;
	unsigned long TranslatingLineNuM;
	unsigned long GeneratingAilLineNum;
	unsigned long ParsingAilLineNum;
	plcbit ParallelEnabled;
	plcbit ParallelRdisableSet;
	plcbit StopAtM1;
	plcbit Unused;
	plcstring CurProgFileName[264];
	plcstring CurProgName[264];
} McProgIntIpMonitorType;

typedef struct McProgIntFileMonitorEntryType
{	plcstring (*Name)[264];
	plcstring (*PathName)[264];
	plcstring (*DirName)[264];
	plcstring (*DeviceName)[264];
	unsigned long ProgramNumber;
	unsigned long StorageType;
	unsigned long TimeStamp;
	plcbit PrecompiledLCF;
	struct McProgIntFileMonitorEntryType* Next;
} McProgIntFileMonitorEntryType;

typedef struct McProgIntFileMonitorAccessType
{	plcbit Valid;
	struct McProgIntFileMonitorEntryType* First;
} McProgIntFileMonitorAccessType;

typedef struct McProgIntFileMonitorLineType
{	plcstring Name[32];
	unsigned long ProgramNumber;
	unsigned long StorageType;
} McProgIntFileMonitorLineType;

typedef struct McProgIntFileMonitorType
{	plcbit Handshake;
	unsigned long SetOffset;
	unsigned long Offset;
	struct McProgIntFileMonitorLineType File[32];
	struct McProgIntFileMonitorAccessType DirectAccess;
} McProgIntFileMonitorType;

typedef double McSlaveAxisType[15];

typedef struct McPointType
{	struct McPosType Pos;
	struct McOrientType Orient;
	McSlaveAxisType SlaveAxis;
} McPointType;

typedef double McJointAxisType[6];

typedef struct McAxisTargetType
{	McJointAxisType JointAxis;
	McSlaveAxisType SlaveAxis;
} McAxisTargetType;

typedef struct McLatchPositionsType
{	plcbit TriggerEvent;
	unsigned long CoordSystem;
	double Position[15];
} McLatchPositionsType;

typedef double McRotationMatrixType[9];






#ifdef __cplusplus
};
#endif
#endif /* _MCPROGINT_ */

