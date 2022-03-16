
TYPE
	UserParType : 	STRUCT  (*Parameters Data Type for User Management*)
		FilePath : STRING[100];
		UserName : STRING[MAX_USER_ITEM_LEN];
		UserNameNew : STRING[MAX_USER_ITEM_LEN];
		UserRole : STRING[MAX_USER_ITEM_LEN];
		Password : STRING[MAX_USER_ITEM_LEN];
		PasswordRepeat : STRING[MAX_USER_ITEM_LEN];
		VisuSlotID : USINT;
	END_STRUCT;
	UserCmdType : 	STRUCT  (*Command Data Type for User Management*)
		UserCreate : BOOL; (*Create User*)
		UserDelete : BOOL; (*Delete User*)
		UserRename : BOOL; (*Rename User*)
		PasswordChange : BOOL; (*Change Password*)
		RoleAssign : BOOL; (*Assign Role*)
		RoleRemove : BOOL; (*Remove Role*)
		Import : BOOL;
		Export : BOOL;
		ListRefresh : BOOL; (*Refresh List*)
		ErrorReset : BOOL; (*Error Reset*)
	END_STRUCT;
	UserMainType : 	STRUCT  (*Main Control Data Type for User Management*)
		CMD : UserCmdType; (*Command of User Management*)
		PAR : UserParType; (*Parameters for User Management*)
		DAT : UserDatType; (*Data for User Management*)
		VIS : ARRAY[0..MAX_USER_CLIENTS]OF UserVisType; (*Vision related variables for User Management*)
		ERR : UserErrType; (*Errors in User Management*)
	END_STRUCT;
	UserDatType : 	STRUCT  (*Data Data Type for User Management*)
		Users : ARRAY[0..MAX_USER_NAMES]OF UserDetailsType; (*Users details*)
		Roles : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*Roles Details*)
		Status : STRING[200]; (*Status of the user*)
		UserActive : ARRAY[0..MAX_USER_CLIENTS]OF STRING[MAX_USER_ITEM_LEN]; (*Active User*)
	END_STRUCT;
	UserVisType : 	STRUCT  (*User to HMI Data Type for User Management*)
		ListUsers : ARRAY[0..MAX_USER_NAMES]OF STRING[MAX_USER_ITEM_LEN]; (*List of Users*)
		ListUserIndex : UINT; (*List users Index Selection*)
		ListUserValue : STRING[MAX_USER_ITEM_LEN]; (*List User Value*)
		ListUserRole : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*List User Role*)
		ListUserRoleIndex : UINT; (*List Users Role Index*)
		ListRoles : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*List Roles*)
		ListRoleIndex : UINT; (*List Roles Index*)
		RoleDeleteEnabled : BOOL; (*Delete Role*)
		UserDeleteEnabled : BOOL; (*User Delete*)
		ShowMessageBoxOK : BOOL; (*Show Message Box*)
		ShowMessageBoxError : BOOL; (*Show Error Message Box*)
	END_STRUCT;
	UserErrType : 	STRUCT  (*Errors Data Type for User Management*)
		No : DINT; (*Error  Numbers*)
		State : UserManagementEnum; (*User Management States*)
		Text : STRING[100]; (*Errors Text*)
	END_STRUCT;
	UserManagementEnum : 
		(
		IdleUser, (*Wait state*)
		DestroyList,
		CreateUser,
		DeleteUser,
		RenameUser,
		ExportList,
		ImportList,
		ChangePassword,
		ComparePassword,
		CreateUserListGetNext,
		CreateUserListGetFirst,
		AssignRole,
		ReleaseRole,
		RoleListMain,
		RoleListDeleteList,
		RoleListInitList,
		CreateRoleListGetFirst,
		CreateRoleListGetNext,
		RoleListGetNext,
		PropertyRead,
		PropertyWrite,
		ErrorUser
		);
	UserDetailsType : 	STRUCT 
		Roles : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*User Roles*)
		Name : STRING[MAX_USER_ITEM_LEN]; (*User Names*)
	END_STRUCT;
END_TYPE
