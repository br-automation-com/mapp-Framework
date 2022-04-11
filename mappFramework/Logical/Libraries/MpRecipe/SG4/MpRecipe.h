/* Automation Studio generated header file */
/* Do not edit ! */
/* MpRecipe 5.18.0 */

#ifndef _MPRECIPE_
#define _MPRECIPE_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpRecipe_VERSION
#define _MpRecipe_VERSION 5.18.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "sys_lib.h"
		#include "MpBase.h"
#endif

#ifdef _SG4
		#include "sys_lib.h"
		#include "MpBase.h"
#endif

#ifdef _SGC
		#include "sys_lib.h"
		#include "MpBase.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpRecipeUIMessageEnum
{	mpRECIPE_UI_MSG_NONE = 0,
	mpRECIPE_UI_MSG_CONFIRM_LOAD = 1,
	mpRECIPE_UI_MSG_CONFIRM_SAVE = 2,
	mpRECIPE_UI_MSG_CONFIRM_CREATE = 3,
	mpRECIPE_UI_MSG_CONFIRM_DELETE = 4,
	mpRECIPE_UI_MSG_CONFIRM_RENAME = 5
} MpRecipeUIMessageEnum;

typedef enum MpRecipeUIStatusEnum
{	mpRECIPE_UI_STATUS_IDLE = 0,
	mpRECIPE_UI_STATUS_LOAD = 1,
	mpRECIPE_UI_STATUS_SAVE = 2,
	mpRECIPE_UI_STATUS_CREATE = 3,
	mpRECIPE_UI_STATUS_REFRESH = 4,
	mpRECIPE_UI_STATUS_NOTIFY = 5,
	mpRECIPE_UI_STATUS_DELETE = 6,
	mpRECIPE_UI_STATUS_RENAME = 7,
	mpRECIPE_UI_STATUS_ERROR = 99
} MpRecipeUIStatusEnum;

typedef enum MpRecipeUISortOrderEnum
{	mpRECIPE_UI_SORT_ASCENDING = 0,
	mpRECIPE_UI_SORT_DESCENDING = 1,
	mpRECIPE_UI_SORT_DATE_ASCENDING = 2,
	mpRECIPE_UI_SORT_DATE_DESCENDING = 3
} MpRecipeUISortOrderEnum;

typedef enum MpRecipeXmlLoadEnum
{	mpRECIPE_XML_LOAD_ALL = 0,
	mpRECIPE_XML_LOAD_HEADER = 1
} MpRecipeXmlLoadEnum;

typedef enum MpRecipeCsvLoadEnum
{	mpRECIPE_CSV_LOAD_ALL = 0,
	mpRECIPE_CSV_LOAD_HEADER = 1
} MpRecipeCsvLoadEnum;

typedef enum MpRecipeXmlAlarmEnum
{	mpRECIPE_ALM_SAVE_FAILED = 0,
	mpRECIPE_ALM_SAVE_FAILED_PART = 1,
	mpRECIPE_ALM_LOAD_FAILED = 2,
	mpRECIPE_ALM_LOAD_FAILED_PART = 3
} MpRecipeXmlAlarmEnum;

typedef enum MpRecipeErrorEnum
{	mpRECIPE_NO_ERROR = 0,
	mpRECIPE_ERR_ACTIVATION = -1064239103,
	mpRECIPE_ERR_MPLINK_NULL = -1064239102,
	mpRECIPE_ERR_MPLINK_INVALID = -1064239101,
	mpRECIPE_ERR_MPLINK_CHANGED = -1064239100,
	mpRECIPE_ERR_MPLINK_CORRUPT = -1064239099,
	mpRECIPE_ERR_MPLINK_IN_USE = -1064239098,
	mpRECIPE_ERR_CONFIG_INVALID = -1064239091,
	mpRECIPE_ERR_SAVE_DATA = -1064140799,
	mpRECIPE_ERR_LOAD_DATA = -1064140798,
	mpRECIPE_ERR_INVALID_FILE_DEV = -1064140797,
	mpRECIPE_ERR_INVALID_FILE_NAME = -1064140796,
	mpRECIPE_ERR_CMD_IN_PROGRESS = -1064140795,
	mpRECIPE_WRN_SAVE_WITH_WARN = -2137882618,
	mpRECIPE_WRN_LOAD_WITH_WARN = -2137882617,
	mpRECIPE_ERR_SAVE_WITH_ERRORS = -1064140792,
	mpRECIPE_ERR_LOAD_WITH_ERRORS = -1064140791,
	mpRECIPE_ERR_MISSING_RECIPE = -1064140790,
	mpRECIPE_ERR_MISSING_MPFILE = -1064140789,
	mpRECIPE_ERR_INVALID_SORT_ORDER = -1064140788,
	mpRECIPE_WRN_MISSING_UICONNECT = -2137882611,
	mpRECIPE_ERR_INVALID_PV_NAME = -1064140786,
	mpRECIPE_ERR_INVALID_LOAD_TYPE = -1064140785,
	mpRECIPE_ERR_LISTING_FILES = -1064140784,
	mpRECIPE_ERR_PV_NAME_NULL = -1064140783,
	mpRECIPE_WRN_NO_PV_REGISTERED = -2137882606,
	mpRECIPE_ERR_SYNC_SAVE_ACTIVE = -1064140781,
	mpRECIPE_ERR_DELETING_FILE = -1064140780,
	mpRECIPE_WRN_EMPTY_RECIPE = -2137882603,
	mpRECIPE_INF_WAIT_RECIPE_FB = 1083342870,
	mpRECIPE_ERR_RENAMING_FILE = -1064140777,
	mpRECIPE_WRN_NO_PV_FOUND = -2137882600,
	mpRECIPE_WRN_LIST_SIZE = -2137882599
} MpRecipeErrorEnum;

typedef struct MpRecipeStatusIDType
{	enum MpRecipeErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpRecipeStatusIDType;

typedef struct MpRecipeDiagType
{	struct MpRecipeStatusIDType StatusID;
} MpRecipeDiagType;

typedef struct MpRecipeInfoType
{	struct MpRecipeDiagType Diag;
} MpRecipeInfoType;

typedef struct MpRecipeUISetupConfirmType
{	plcbit RecipeLoad;
	plcbit RecipeSave;
	plcbit RecipeCreate;
	plcbit RecipeDelete;
	plcbit RecipeRename;
} MpRecipeUISetupConfirmType;

typedef struct MpRecipeUISetupType
{	unsigned short RecipeListSize;
	unsigned char RecipeListScrollWindow;
	struct MpRecipeUISetupConfirmType Confirmation;
	plcbit AutoLoadHeader;
} MpRecipeUISetupType;

typedef struct MpRecipeUIMessageBoxType
{	unsigned short LayerStatus;
	enum MpRecipeUIMessageEnum Type;
	plcbit Confirm;
	plcbit Cancel;
} MpRecipeUIMessageBoxType;

typedef struct MpRecipeUINewType
{	plcstring FileName[256];
	plcbit Create;
} MpRecipeUINewType;

typedef struct MpRecipeUIRecipeListType
{	plcstring Names[20][256];
	unsigned short SelectedIndex;
	unsigned short MaxSelection;
	plcbit PageUp;
	plcbit PageDown;
	plcbit StepUp;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
	unsigned long Sizes[20];
	plcstring LastModified[20][51];
} MpRecipeUIRecipeListType;

typedef struct MpRecipeUIHeaderType
{	plcstring Name[101];
	plcstring Description[256];
	plcstring Version[21];
	plcdt DateTime;
} MpRecipeUIHeaderType;

typedef struct MpRecipeUIRecipeType
{	struct MpRecipeUIRecipeListType List;
	plcbit Load;
	plcbit Save;
	plcstring Filter[256];
	enum MpRecipeUISortOrderEnum SortOrder;
	plcbit Refresh;
	plcbit UpdateNotification;
	plcbit Delete;
	plcbit Rename;
	plcstring NewFileName[256];
	struct MpRecipeUIHeaderType Header;
} MpRecipeUIRecipeType;

typedef struct MpRecipeUIConnectType
{	enum MpRecipeUIStatusEnum Status;
	struct MpRecipeUIRecipeType Recipe;
	struct MpRecipeUINewType New;
	struct MpRecipeUIMessageBoxType MessageBox;
	unsigned short DefaultLayerStatus;
} MpRecipeUIConnectType;

typedef struct MpRecipeXmlInfoType
{	unsigned long FileSize;
	unsigned long PendingSync;
	struct MpRecipeDiagType Diag;
	plcstring LastLoadedRecipe[256];
} MpRecipeXmlInfoType;

typedef struct MpRecipeXmlHeaderType
{	plcstring Name[101];
	plcstring Description[256];
	plcstring Version[21];
	plcdt DateTime;
} MpRecipeXmlHeaderType;

typedef struct MpRecipeCsvHeaderType
{	plcstring Name[101];
	plcstring Description[256];
	plcstring Version[21];
	plcdt DateTime;
} MpRecipeCsvHeaderType;

typedef struct MpRecipeCsvInfoType
{	unsigned long FileSize;
	unsigned long PendingSync;
	plcstring LastLoadedRecipe[256];
	struct MpRecipeDiagType Diag;
} MpRecipeCsvInfoType;

typedef struct MpRecipeRegParSync
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*PVName);
	plcstring (*Category);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRecipeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit ConfirmSave;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateNotification;
	plcbit SaveNotification;
} MpRecipeRegParSync_typ;

typedef struct MpRecipeRegPar
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*PVName);
	plcstring (*Category);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRecipeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateNotification;
} MpRecipeRegPar_typ;

typedef struct MpRecipeXml
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*DeviceName);
	plcstring (*FileName);
	struct MpRecipeXmlHeaderType* Header;
	plcstring (*Category);
	enum MpRecipeXmlLoadEnum LoadType;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRecipeXmlInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	plcbit UpdateNotification;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpRecipeXml_typ;

typedef struct MpRecipeUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpRecipeUISetupType UISetup;
	struct MpRecipeUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRecipeInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpRecipeUI_typ;

typedef struct MpRecipeCsv
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*DeviceName);
	plcstring (*FileName);
	struct MpRecipeCsvHeaderType* Header;
	plcstring (*Category);
	enum MpRecipeCsvLoadEnum LoadType;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpRecipeCsvInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	plcbit UpdateNotification;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpRecipeCsv_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpRecipeRegParSync(struct MpRecipeRegParSync* inst);
_BUR_PUBLIC void MpRecipeRegPar(struct MpRecipeRegPar* inst);
_BUR_PUBLIC void MpRecipeXml(struct MpRecipeXml* inst);
_BUR_PUBLIC void MpRecipeUI(struct MpRecipeUI* inst);
_BUR_PUBLIC void MpRecipeCsv(struct MpRecipeCsv* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPRECIPE_ */

