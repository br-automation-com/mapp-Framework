/* Automation Studio generated header file */
/* Do not edit ! */
/* MpUserX 5.16.0 */

#ifndef _MPUSERX_
#define _MPUSERX_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpUserX_VERSION
#define _MpUserX_VERSION 5.16.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "MpBase.h"
#endif

#ifdef _SG4
		#include "MpBase.h"
#endif

#ifdef _SGC
		#include "MpBase.h"
#endif



/* Datatypes and datatypes of function blocks */
typedef enum MpUserXAccessRightEnum
{	mpUSERX_ACCESS_UNDEFINED = 0,
	mpUSERX_ACCESS_NONE = 1,
	mpUSERX_ACCESS_VIEW = 2,
	mpUSERX_ACCESS_ACTUATE = 3,
	mpUSERX_ACCESS_FULL = 4
} MpUserXAccessRightEnum;

typedef enum MpUserXUIMessageEnum
{	mpUSERX_MSG_NONE = 0,
	mpUSERX_MSG_ERROR = 1,
	mpUSERX_MSG_CONFIRM_DELETE = 2,
	mpUSERX_MSG_CONFIRM_LOCK = 3,
	mpUSERX_MSG_CONFIRM_UNLOCK = 4,
	mpUSERX_MSG_CONFIRM_ROLE_DELETE = 5
} MpUserXUIMessageEnum;

typedef enum MpUserXMgrUIImportConfirmEnum
{	mpUSERX_CONFIRM_USER = 0,
	mpUSERX_CONFIRM_ROLE = 1
} MpUserXMgrUIImportConfirmEnum;

typedef enum MpUserXUIStatusEnum
{	mpUSERX_UI_STATUS_IDLE = 0,
	mpUSERX_UI_STATUS_WAIT_DLG = 1,
	mpUSERX_UI_STATUS_EXECUTE = 2,
	mpUSERX_UI_STATUS_ERROR = 99
} MpUserXUIStatusEnum;

typedef enum MpUserXImportModeEnum
{	mpUSERX_IMPORT_SKIP = 0,
	mpUSERX_IMPORT_IGNORE_EXISITNG = 1,
	mpUSERX_IMPORT_OVERWRITE = 2,
	mpUSERX_IMPORT_OVERWRITE_ONLY = 4,
	mpUSERX_IMPORT_REMOVE_EXISTING = 5
} MpUserXImportModeEnum;

typedef enum MpUserXUserMgmtEnum
{	mpUSERX_USERMGMT_LOCAL = 0,
	mpUSERX_USERMGMT_CENTRAL = 1,
	mpUSERX_USERMGMT_LOCALANDCENTRAL = 2
} MpUserXUserMgmtEnum;

typedef enum MpUserXServerEnum
{	mpUSERX_SERVER_ACTIVE_DIRECTORY = 0,
	mpUSERX_SERVER_389DS = 1
} MpUserXServerEnum;

typedef enum MpUserXUIPasswordCriteriaEnum
{	mpUSERX_PASSWORD_CRIT_NONE = 0,
	mpUSERX_PASSWORD_CRIT_LENGTH = 1,
	mpUSERX_PASSWORD_CRIT_ALPHA = 2,
	mpUSERX_PASSWORD_CRIT_CASE = 3,
	mpUSERX_PASSWORD_CRIT_SPECIAL = 4
} MpUserXUIPasswordCriteriaEnum;

typedef enum MpUserXErrorEnum
{	mpUSERX_NO_ERROR = 0,
	mpUSERX_ERR_ACTIVATION = -1064239103,
	mpUSERX_ERR_MPLINK_NULL = -1064239102,
	mpUSERX_ERR_MPLINK_INVALID = -1064239101,
	mpUSERX_ERR_MPLINK_CHANGED = -1064239100,
	mpUSERX_ERR_MPLINK_CORRUPT = -1064239099,
	mpUSERX_ERR_MPLINK_IN_USE = -1064239098,
	mpUSERX_ERR_PAR_NULL = -1064239097,
	mpUSERX_ERR_CONFIG_NULL = -1064239096,
	mpUSERX_ERR_CONFIG_NO_PV = -1064239095,
	mpUSERX_ERR_CONFIG_LOAD = -1064239094,
	mpUSERX_WRN_CONFIG_LOAD = -2137980917,
	mpUSERX_ERR_CONFIG_SAVE = -1064239092,
	mpUSERX_ERR_CONFIG_INVALID = -1064239091,
	mpUSERX_ERR_PASSWORD_INCORRECT = -1064144896,
	mpUSERX_ERR_USER_NOT_EXISTING = -1064144895,
	mpUSERX_ERR_USER_EXISTS = -1064144894,
	mpUSERX_ERR_LOGIN_ID_INVALID = -1064144893,
	mpUSERX_ERR_ADMIN_INVALID = -1064144892,
	mpUSERX_ERR_INSUFFICIENT_RIGHTS = -1064144891,
	mpUSERX_ERR_ROLE_NOT_PRESENT = -1064144890,
	mpUSERX_ERR_PASSWORD_WEAK = -1064144889,
	mpUSERX_ERR_USER_IS_LOCKED = -1064144888,
	mpUSERX_ERR_PASSWORD_CHANGE_REQ = -1064144887,
	mpUSERX_ERR_TOO_MANY_LOGINS = -1064144886,
	mpUSERX_ERR_NO_ADMIN_RIGHTS = -1064144885,
	mpUSERX_ERR_LOGIN_INST_EXISTS = -1064144884,
	mpUSERX_ERR_NOT_LOGGED_IN = -1064144883,
	mpUSERX_ERR_PASSWORD_IDENTICAL = -1064144881,
	mpUSERX_ERR_LOGIN_ID_EXISTS = -1064144880,
	mpUSERX_WRN_PASSWORD_CHANGE_REQ = -2137886702,
	mpUSERX_ERR_ROLE_INDEX_NOT_OK = -1064144877,
	mpUSERX_ERR_NO_ROLENAME = -1064144876,
	mpUSERX_ERR_LOGGED_IN = -1064144875,
	mpUSERX_ERR_MISSING_UICONNECT = -1064144874,
	mpUSERX_ERR_NO_USERNAME = -1064144873,
	mpUSERX_ERR_NO_PASSWORD = -1064144872,
	mpUSERX_ERR_MISSING_LOGIN = -1064144871,
	mpUSERX_ERR_PASSWORD_CONFIRM = -1064144870,
	mpUSERX_ERR_IMPORT_DATA = -1064144868,
	mpUSERX_ERR_LOAD_IMPORT_FILE = -1064144867,
	mpUSERX_ERR_SAVE_EXPORT_FILE = -1064144866,
	mpUSERX_ERR_ROLENAME_TOO_LONG = -1064144865,
	mpUSERX_ERR_USERNAME_TOO_LONG = -1064144864,
	mpUSERX_ERR_PASSWORD_TOO_LONG = -1064144863,
	mpUSERX_INF_WAIT_LOGIN_FB = 1083338786,
	mpUSERX_ERR_USERNAME_TOO_SHORT = -1064144861,
	mpUSERX_ERR_ROLE_EXISTS = -1064144860,
	mpUSERX_ERR_FAILED_SIGNATURES = -1064144858,
	mpUSERX_ERR_SIGNATURE_BUSY = -1064144857,
	mpUSERX_ERR_PASSWORD_REPEAT = -1064144856,
	mpUSERX_ERR_IMPORT_FILE_FORMAT = -1064144855,
	mpUSERX_WRN_KEY_DUPLICATE = -2137886678,
	mpUSERX_ERR_INFO_NOT_FOUND = -1064144853,
	mpUSERX_ERR_EMPTY_KEY = -1064144852,
	mpUSERX_ERR_BUFFER_TOO_SMALL = -1064144851,
	mpUSERX_ERR_LDAP_ERROR = -1064144850,
	mpUSERX_ERR_NO_SERVER_CONNECTION = -1064144849,
	mpUSERX_ERR_INVALID_CREDENTIALS = -1064144848,
	mpUSERX_ERR_ACTION_NOT_ALLOWED = -1064144847,
	mpUSERX_WRN_LDAP_WARNING = -2137886670,
	mpUSERX_ERR_PASSWORD_RESTRICTION = -1064144845,
	mpUSERX_ERR_FUNCTION_UNAVAILABLE = -1064144844,
	mpUSERX_WRN_PASSWORD_WILL_EXPIRE = -2137886667
} MpUserXErrorEnum;

typedef enum MpUserXLoginAlarmEnum
{	mpUSERX_ALM_USER_LOCKED = 0
} MpUserXLoginAlarmEnum;

typedef struct MpUserXUIMessageBoxType
{	unsigned short LayerStatus;
	enum MpUserXUIMessageEnum Type;
	unsigned short ErrorNumber;
	plcbit Confirm;
	plcbit Cancel;
} MpUserXUIMessageBoxType;

typedef struct MpUserXMgrUIUserListType
{	plcwstring UserNames[20][51];
	unsigned char UserOptions[20];
	unsigned short MaxSelection;
	unsigned short SelectedIndex;
	plcbit PageUp;
	plcbit StepUp;
	plcbit PageDown;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpUserXMgrUIUserListType;

typedef struct MpUserXMgrUIAdditionalDataType
{	plcwstring Key[21];
	plcwstring Value[256];
} MpUserXMgrUIAdditionalDataType;

typedef struct MpUserXMgrUIUserInfoType
{	plcwstring UserName[51];
	plcwstring FullName[101];
	unsigned short Roles[10];
	plcbit Locked;
	plcbit Expired;
	unsigned char RemainingAttempts;
	plcstring Language[21];
	plcstring DisplayUnit[21];
	plcdt Creation;
	plcdt FirstLogin;
	plcdt LastLogin;
	plcdt PasswordExpired;
	struct MpUserXMgrUIAdditionalDataType AdditionalData[10];
} MpUserXMgrUIUserInfoType;

typedef struct MpUserXMgrUIRoleListType
{	plcwstring Names[10][51];
	unsigned short SelectedIndex;
	unsigned short MaxSelection;
	plcbit PageUp;
	plcbit StepUp;
	plcbit PageDown;
	plcbit StepDown;
	float RangeStart;
	float RangeEnd;
} MpUserXMgrUIRoleListType;

typedef struct MpUserXMgrUIRoleInfoType
{	plcwstring Name[51];
	unsigned short Index;
	signed long Level;
	plcbit Admin;
	enum MpUserXAccessRightEnum AccessRights[20];
} MpUserXMgrUIRoleInfoType;

typedef struct MpUserXMgrUIRoleDlgType
{	unsigned short LayerStatus;
	plcwstring Name[51];
	unsigned short Index;
	signed long Level;
	signed long LevelLimit;
	plcbit Admin;
	enum MpUserXAccessRightEnum AccessRights[20];
	enum MpUserXAccessRightEnum AccessRightsLimit[20];
	plcbit Confirm;
	plcbit Cancel;
} MpUserXMgrUIRoleDlgType;

typedef struct MpUserXMgrUIRoleCreateDlgType
{	unsigned short LayerStatus;
	plcwstring Name[51];
	signed long Level;
	signed long LevelLimit;
	plcbit Admin;
	enum MpUserXAccessRightEnum AccessRights[20];
	enum MpUserXAccessRightEnum AccessRightsLimit[20];
	plcbit Confirm;
	plcbit Cancel;
} MpUserXMgrUIRoleCreateDlgType;

typedef struct MpUserXMgrUIRoleCreateType
{	plcbit ShowDialog;
	plcbit Lock;
	struct MpUserXMgrUIRoleCreateDlgType Dialog;
} MpUserXMgrUIRoleCreateType;

typedef struct MpUserXMgrUIRoleEditType
{	plcbit ShowDialog;
	plcbit Lock;
	struct MpUserXMgrUIRoleDlgType Dialog;
} MpUserXMgrUIRoleEditType;

typedef struct MpUserXMgrUICreateDlgType
{	unsigned short LayerStatus;
	plcwstring UserName[51];
	plcwstring FullName[101];
	unsigned short Roles[10];
	unsigned char RoleOption[20];
	plcwstring NewPassword[51];
	plcwstring ConfirmPassword[51];
	plcstring Language[21];
	plcstring DisplayUnit[21];
	enum MpUserXUIPasswordCriteriaEnum CriteriaNotMet;
	unsigned short NewPasswordOk;
	unsigned short ConfirmPasswordOk;
	unsigned short UserNameOk;
	plcbit Confirm;
	plcbit Cancel;
	struct MpUserXMgrUIAdditionalDataType AdditionalData[10];
} MpUserXMgrUICreateDlgType;

typedef struct MpUserXMgrUICreateType
{	plcbit ShowDialog;
	plcbit Lock;
	struct MpUserXMgrUICreateDlgType Dialog;
} MpUserXMgrUICreateType;

typedef struct MpUserXMgrUIExportDlgType
{	unsigned short LayerStatus;
	plcstring FileName[256];
	plcbit Confirm;
	plcbit Cancel;
} MpUserXMgrUIExportDlgType;

typedef struct MpUserXMgrUIExportType
{	plcbit ShowDialog;
	struct MpUserXMgrUIExportDlgType Dialog;
} MpUserXMgrUIExportType;

typedef struct MpUserXMgrUISetupConfirmType
{	plcbit OverwriteUser;
	plcbit OverwriteRole;
} MpUserXMgrUISetupConfirmType;

typedef struct MpUserXMgrUISetupType
{	unsigned short UserListSize;
	unsigned char ScrollWindow;
	plcstring FileDevice[21];
	plcstring FileExtension[21];
	unsigned short RoleListSize;
	struct MpUserXMgrUISetupConfirmType Confirmation;
} MpUserXMgrUISetupType;

typedef struct MpUserXMgrUIImportListType
{	plcstring FileNames[5][256];
	unsigned short SelectedIndex;
	unsigned short MaxSelection;
} MpUserXMgrUIImportListType;

typedef struct MpUserXMgrUIImportDlgType
{	unsigned short LayerStatus;
	struct MpUserXMgrUIImportListType List;
	plcstring FileName[256];
	plcbit Users;
	plcbit Roles;
	plcbit Confirm;
	plcbit Cancel;
} MpUserXMgrUIImportDlgType;

typedef struct MpUserXMgrUIImportConfirmType
{	unsigned short LayerStatus;
	enum MpUserXMgrUIImportConfirmEnum Type;
	plcwstring Name[51];
	unsigned short NumberOfConflicts;
	plcbit ApplyForAll;
	plcbit Confirm;
	plcbit Cancel;
} MpUserXMgrUIImportConfirmType;

typedef struct MpUserXMgrUIImportType
{	plcbit ShowDialog;
	struct MpUserXMgrUIImportDlgType Dialog;
	struct MpUserXMgrUIImportConfirmType ConfirmDialog;
} MpUserXMgrUIImportType;

typedef struct MpUserXMgrUIUserType
{	struct MpUserXMgrUIUserListType List;
	struct MpUserXMgrUIUserInfoType Info;
	struct MpUserXMgrUICreateType Create;
	struct MpUserXMgrUICreateType Edit;
	plcbit Remove;
	plcbit Lock;
} MpUserXMgrUIUserType;

typedef struct MpUserXMgrUIRoleSelectType
{	plcwstring Names[20][51];
	unsigned short MaxSelection;
} MpUserXMgrUIRoleSelectType;

typedef struct MpUserXMgrUIRoleType
{	struct MpUserXMgrUIRoleListType List;
	struct MpUserXMgrUIRoleInfoType Info;
	struct MpUserXMgrUIRoleEditType Edit;
	struct MpUserXMgrUIRoleCreateType Create;
	plcbit Remove;
	struct MpUserXMgrUIRoleSelectType SelectList;
} MpUserXMgrUIRoleType;

typedef struct MpUserXMgrUIConnectType
{	unsigned short DefaultLayerStatus;
	enum MpUserXUIStatusEnum Status;
	struct MpUserXMgrUIUserType User;
	struct MpUserXMgrUIRoleType Role;
	struct MpUserXUIMessageBoxType MessageBox;
	struct MpUserXMgrUIExportType Export;
	struct MpUserXMgrUIImportType Import;
} MpUserXMgrUIConnectType;

typedef struct MpUserXLoginUIPwdDlgType
{	plcwstring OldPassword[51];
	plcwstring NewPassword[51];
	plcwstring ConfirmPassword[51];
	unsigned short LayerStatus;
	plcbit Confirm;
	plcbit Cancel;
	enum MpUserXUIPasswordCriteriaEnum CriteriaNotMet;
	unsigned short NewPasswordOk;
	unsigned short ConfirmPasswordOk;
} MpUserXLoginUIPwdDlgType;

typedef struct MpUserXLoginUIPwdType
{	plcbit ShowDialog;
	struct MpUserXLoginUIPwdDlgType Dialog;
} MpUserXLoginUIPwdType;

typedef struct MpUserXLoginUILoginType
{	plcbit Login;
	plcbit Logout;
	plcwstring UserName[51];
	plcwstring Password[51];
} MpUserXLoginUILoginType;

typedef struct MpUserXLoginUIConnectType
{	enum MpUserXUIStatusEnum Status;
	plcwstring CurrentUser[51];
	plcstring Language[21];
	plcstring DisplayUnit[21];
	plcbit LoggedIn;
	signed long UserLevel;
	struct MpUserXLoginUILoginType Login;
	struct MpUserXLoginUIPwdType ChangePassword;
	struct MpUserXUIMessageBoxType MessageBox;
	unsigned short DefaultLayerStatus;
} MpUserXLoginUIConnectType;

typedef struct MpUserXConfigType
{	plcbit NoDelete;
	plcbit PasswordChangeReq;
	plcbit PasswordCase;
	plcbit PasswordAlpha;
	unsigned short PasswordLength;
	unsigned short LoginAttempts;
	signed long PasswordChangeInterval;
	signed long UserExpirationTime;
	unsigned short UserNameLength;
	unsigned short SignAttempts;
	unsigned short PasswordHistory;
	plcbit PasswordSpecial;
	plcbit EditSameLevel;
	enum MpUserXImportModeEnum ImportUser;
	enum MpUserXImportModeEnum ImportRole;
	plcbit ImportUnchecked;
	signed long AdminUnlockTime;
	signed long AutoLogoutTime;
	signed long PasswordExpirationNotification;
} MpUserXConfigType;

typedef struct MpUserXHostType
{	plcstring Host[256];
	unsigned short Port;
	plcstring Certificate[256];
	plcstring BaseDN[256];
	plcstring UserLocationDN[256];
} MpUserXHostType;

typedef struct MpUserXGroupToRoleMappingType
{	plcstring TableName[51];
} MpUserXGroupToRoleMappingType;

typedef struct MpUserXServerType
{	enum MpUserXServerEnum Type;
	struct MpUserXHostType Hosts[10];
	struct MpUserXGroupToRoleMappingType Mapping;
	plcstring AdditionalUserData[10][101];
} MpUserXServerType;

typedef struct MpUserXServerConfigType
{	enum MpUserXUserMgmtEnum UserMgmtSystemType;
	struct MpUserXServerType Server;
} MpUserXServerConfigType;

typedef struct MpUserXMappingMappingType
{	plcwstring LocalRole[51];
	plcwstring ServerGroup[51];
} MpUserXMappingMappingType;

typedef struct MpUserXMappingConfigType
{	struct MpUserXMappingMappingType Mapping[100];
} MpUserXMappingConfigType;

typedef struct MpUserXLoginConfigType
{	signed long AutoLogout;
} MpUserXLoginConfigType;

typedef struct MpUserXSignatureUIDlgType
{	unsigned short LayerStatus;
	plcwstring UserName[51];
	plcwstring Password[51];
	plcwstring Comment[101];
	plcbit Confirm;
	plcbit Cancel;
} MpUserXSignatureUIDlgType;

typedef struct MpUserXSignatureUIConnectType
{	enum MpUserXUIStatusEnum Status;
	signed long SignAction;
	struct MpUserXSignatureUIDlgType Dialog;
	struct MpUserXUIMessageBoxType MessageBox;
	unsigned short DefaultLayerStatus;
} MpUserXSignatureUIConnectType;

typedef struct MpUserXStatusIDType
{	enum MpUserXErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpUserXStatusIDType;

typedef struct MpUserXDiagType
{	struct MpUserXStatusIDType StatusID;
} MpUserXDiagType;

typedef struct MpUserXLoginInfoType
{	plctime AutoLogoutRemain;
	struct MpUserXDiagType Diag;
	signed long DaysUntilPasswordExpiration;
} MpUserXLoginInfoType;

typedef struct MpUserXInfoType
{	struct MpUserXDiagType Diag;
} MpUserXInfoType;

typedef struct MpUserXInternalType
{	unsigned long pObject;
	unsigned long pInstance;
	signed long State;
} MpUserXInternalType;

typedef struct MpUserXLogin
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	signed long LifeSign;
	plcwstring (*UserName);
	plcwstring (*Password);
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	plcwstring CurrentUser[51];
	signed long CurrentLevel;
	enum MpUserXAccessRightEnum AccessRights[20];
	struct MpUserXLoginInfoType Info;
	/* VAR (analog) */
	struct MpUserXInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Login;
	plcbit Logout;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpUserXLogin_typ;

typedef struct MpUserXManagerUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpUserXMgrUISetupType UISetup;
	struct MpUserXMgrUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
	/* VAR (analog) */
	struct MpUserXInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpUserXManagerUI_typ;

typedef struct MpUserXLoginUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpUserXLoginUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
	/* VAR (analog) */
	struct MpUserXInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpUserXLoginUI_typ;

typedef struct MpUserXConfig
{
	/* VAR_INPUT (analog) */
	struct MpUserXConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
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
} MpUserXConfig_typ;

typedef struct MpUserXLoginConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpUserXLoginConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
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
} MpUserXLoginConfig_typ;

typedef struct MpUserXSignatureUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	signed long SignAction;
	struct MpUserXSignatureUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
	/* VAR (analog) */
	struct MpUserXInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpUserXSignatureUI_typ;

typedef struct MpUserXSignature
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	signed long ActionID;
	struct MpUserXInfoType Info;
	/* VAR (analog) */
	struct MpUserXInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit Released;
	plcbit Rejected;
} MpUserXSignature_typ;

typedef struct MpUserXServerConfig
{
	/* VAR_INPUT (analog) */
	struct MpUserXServerConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
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
} MpUserXServerConfig_typ;

typedef struct MpUserXMappingConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpUserXMappingConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpUserXInfoType Info;
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
} MpUserXMappingConfig_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpUserXLogin(struct MpUserXLogin* inst);
_BUR_PUBLIC void MpUserXManagerUI(struct MpUserXManagerUI* inst);
_BUR_PUBLIC void MpUserXLoginUI(struct MpUserXLoginUI* inst);
_BUR_PUBLIC void MpUserXConfig(struct MpUserXConfig* inst);
_BUR_PUBLIC void MpUserXLoginConfig(struct MpUserXLoginConfig* inst);
_BUR_PUBLIC void MpUserXSignatureUI(struct MpUserXSignatureUI* inst);
_BUR_PUBLIC void MpUserXSignature(struct MpUserXSignature* inst);
_BUR_PUBLIC void MpUserXServerConfig(struct MpUserXServerConfig* inst);
_BUR_PUBLIC void MpUserXMappingConfig(struct MpUserXMappingConfig* inst);
_BUR_PUBLIC signed long MpUserXLevel(struct MpComIdentType* MpLink);
_BUR_PUBLIC MpUserXAccessRightEnum MpUserXAccessRight(struct MpComIdentType* MpLink, unsigned short Right);
_BUR_PUBLIC plcbit MpUserXHasRole(struct MpComIdentType* MpLink, plcwstring* Role);
_BUR_PUBLIC signed long MpUserXGetData(plcwstring* UserName, plcwstring* Key, plcwstring* Value, unsigned long ValueSize);


#ifdef __cplusplus
};
#endif
#endif /* _MPUSERX_ */

