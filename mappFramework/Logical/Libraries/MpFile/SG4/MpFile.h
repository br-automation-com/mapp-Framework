/* Automation Studio generated header file */
/* Do not edit ! */
/* MpFile 5.18.0 */

#ifndef _MPFILE_
#define _MPFILE_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpFile_VERSION
#define _MpFile_VERSION 5.18.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
		#include "FileIO.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
		#include "FileIO.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
		#include "FileIO.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpFileManagerUIItemTypeEnum
{	mpFILE_ITEM_TYPE_NONE = 0,
	mpFILE_ITEM_TYPE_FOLDER = 1,
	mpFILE_ITEM_TYPE_FILE = 2,
	mpFILE_ITEM_TYPE_TXT = 3,
	mpFILE_ITEM_TYPE_HTML = 4,
	mpFILE_ITEM_TYPE_DOC = 5,
	mpFILE_ITEM_TYPE_XLS = 6,
	mpFILE_ITEM_TYPE_XML = 7,
	mpFILE_ITEM_TYPE_CSV = 8,
	mpFILE_ITEM_TYPE_JPG = 9,
	mpFILE_ITEM_TYPE_BMP = 10,
	mpFILE_ITEM_TYPE_USER1 = 89,
	mpFILE_ITEM_TYPE_USER2 = 90,
	mpFILE_ITEM_TYPE_USER3 = 91,
	mpFILE_ITEM_TYPE_USER4 = 92,
	mpFILE_ITEM_TYPE_USER5 = 93,
	mpFILE_ITEM_TYPE_USER6 = 94,
	mpFILE_ITEM_TYPE_USER7 = 95,
	mpFILE_ITEM_TYPE_USER8 = 96,
	mpFILE_ITEM_TYPE_USER9 = 97,
	mpFILE_ITEM_TYPE_USER10 = 98,
	mpFILE_ITEM_TYPE_UNKNOWN = 99
} MpFileManagerUIItemTypeEnum;

typedef enum MpFileManagerUISortOrderEnum
{	mpFILE_SORT_BY_NAME_ASC = 0,
	mpFILE_SORT_BY_NAME_DESC = 1,
	mpFILE_SORT_BY_SIZE_ASC = 2,
	mpFILE_SORT_BY_SIZE_DES = 3,
	mpFILE_SORT_BY_MOD_TIME_ASC = 4,
	mpFILE_SORT_BY_MOD_TIME_DESC = 5
} MpFileManagerUISortOrderEnum;

typedef enum MpFileManagerUIMessageEnum
{	mpFILE_MSG_OK = 0,
	mpFILE_MSG_CONFIRM_DELETE = 1,
	mpFILE_MSG_CONFIRM_OVERWRITE = 2,
	mpFILE_MSG_BUSY = 3
} MpFileManagerUIMessageEnum;

typedef enum MpFileManagerUIStatusEnum
{	mpFILE_UI_STATUS_IDLE = 0,
	mpFILE_UI_STATUS_REFRESH = 1,
	mpFILE_UI_STATUS_CHANGE_PAGE = 2,
	mpFILE_UI_STATUS_CHANGE_DIR = 3,
	mpFILE_UI_STATUS_CHANGE_DEVICE = 4,
	mpFILE_UI_STATUS_CREATE = 5,
	mpFILE_UI_STATUS_RENAME = 6,
	mpFILE_UI_STATUS_DELETE = 7,
	mpFILE_UI_STATUS_COPY = 8,
	mpFILE_UI_STATUS_CUT = 9,
	mpFILE_UI_STATUS_PASTE = 10,
	mpFILE_UI_STATUS_SORT = 11,
	mpFILE_UI_STATUS_ERROR = 99
} MpFileManagerUIStatusEnum;

typedef enum MpFileErrorEnum
{	mpFILE_NO_ERROR = 0,
	mpFILE_ERR_ACTIVATION = -1064239103,
	mpFILE_ERR_MPLINK_NULL = -1064239102,
	mpFILE_ERR_MPLINK_INVALID = -1064239101,
	mpFILE_ERR_MPLINK_CHANGED = -1064239100,
	mpFILE_ERR_MPLINK_CORRUPT = -1064239099,
	mpFILE_ERR_MPLINK_IN_USE = -1064239098,
	mpFILE_ERR_MISSING_UICONNECT = -1064165376,
	mpFILE_ERR_CMD_NOT_ALLOWED = -1064165375,
	mpFILE_ERR_NOTHING_TO_PASTE = -1064165374,
	mpFILE_ERR_NOTHING_SELECTED = -1064165373,
	mpFILE_ERR_DIR_ALREADY_EXISTS = -1064165372,
	mpFILE_ERR_INVALID_FILE_DEV = -1064165371,
	mpFILE_ERR_NAME_EMPTY = -1064165370,
	mpFILE_ERR_INVALID_NAME = -1064165369,
	mpFILE_ERR_PASTE_NOT_ALLOWED = -1064165368,
	mpFILE_ERR_FILE_SYSTEM = -1064165367,
	mpFILE_ERR_INSUFF_ACCESS_RIGHT = -1064165358,
	mpFILE_ERR_ITEM_IS_LOCKED = -1064165357,
	mpFILE_ERR_COPY_ITEM = -1064165356,
	mpFILE_ERR_ERASE_ITEM = -1064165355,
	mpFILE_ERR_INVALID_PATH = -1064165354,
	mpFILE_ERR_INVALID_PARAMETER = -1064165353,
	mpFILE_ERR_RENAME_ITEM = -1064165352,
	mpFILE_ERR_CREATE_ITEM = -1064165351,
	mpFILE_ERR_READ_ITEM = -1064165350,
	mpFILE_ERR_WRITE_ITEM = -1064165349,
	mpFILE_INF_OVERWRITE = 1083318300
} MpFileErrorEnum;

typedef enum MpFileUIAlarmEnum
{	mpFILE_ALM_DEVICE_NOT_FOUND = 0,
	mpFILE_ALM_ALREADY_EXISTING = 1,
	mpFILE_ALM_ERROR_FILE_SYSTEM = 2
} MpFileUIAlarmEnum;

typedef struct MpFileManagerUIItemType
{	plcstring Name[256];
	unsigned long Size;
	plcdt LastModified;
	enum MpFileManagerUIItemTypeEnum ItemType;
	plcbit IsSelected;
	plcbit IsFolder;
} MpFileManagerUIItemType;

typedef struct MpFileStatusIDType
{	enum MpFileErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpFileStatusIDType;

typedef struct MpFileDiagType
{	struct MpFileStatusIDType StatusID;
} MpFileDiagType;

typedef struct MpFileInfoType
{	struct MpFileDiagType Diag;
} MpFileInfoType;

typedef struct MpFileManagerUISetupType
{	unsigned short FileListSize;
	unsigned char FileListScrollWindow;
} MpFileManagerUISetupType;

typedef struct MpFileManagerUIDeviceListType
{	plcstring DeviceNames[10][51];
	unsigned short SelectedIndex;
} MpFileManagerUIDeviceListType;

typedef struct MpFileManagerUIFileListType
{	struct MpFileManagerUIItemType Items[50];
	plcbit PageUp;
	plcbit StepUp;
	plcbit PageDown;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpFileManagerUIFileListType;

typedef struct MpFileManagerUIPathInfoType
{	plcstring CurrentDir[256];
	unsigned long FileCount;
	unsigned long FolderCount;
} MpFileManagerUIPathInfoType;

typedef struct MpFileManagerUIFileType
{	struct MpFileManagerUIFileListType List;
	plcstring Filter[256];
	enum MpFileManagerUISortOrderEnum SortOrder;
	plcbit Refresh;
	struct MpFileManagerUIPathInfoType PathInfo;
	plcbit EnterFolder;
	plcbit FolderUp;
	plcbit MultiSelect;
	plcbit Delete;
	plcbit Copy;
	plcbit Cut;
	plcbit Paste;
	plcstring NewName[256];
	plcbit Rename;
	plcbit CreateFolder;
} MpFileManagerUIFileType;

typedef struct MpFileManagerUIMessageBoxType
{	unsigned short LayerStatus;
	enum MpFileManagerUIMessageEnum Type;
	unsigned short ErrorNumber;
	plcbit Confirm;
	plcbit Cancel;
} MpFileManagerUIMessageBoxType;

typedef struct MpFileManagerUIConnectType
{	enum MpFileManagerUIStatusEnum Status;
	struct MpFileManagerUIDeviceListType DeviceList;
	struct MpFileManagerUIFileType File;
	struct MpFileManagerUIMessageBoxType MessageBox;
	unsigned short DefaultLayerStatus;
} MpFileManagerUIConnectType;

typedef struct MpFileManagerConfigType
{	plcstring CustomizedFileType[10][6];
} MpFileManagerConfigType;

typedef struct MpFileManagerUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpFileManagerUISetupType UISetup;
	struct MpFileManagerUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpFileInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpFileManagerUI_typ;

typedef struct MpFileManagerConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpFileManagerConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpFileInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpFileManagerConfig_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpFileManagerUI(struct MpFileManagerUI* inst);
_BUR_PUBLIC void MpFileManagerConfig(struct MpFileManagerConfig* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPFILE_ */

