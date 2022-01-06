
TYPE
	User_Par_typ : 	STRUCT  (*Parameters Data Type for User Management*)
		FilePath : STRING[100];
		UserName : STRING[MAX_USER_ITEM_LEN];
		UserNameNew : STRING[MAX_USER_ITEM_LEN];
		UserRole : STRING[MAX_USER_ITEM_LEN];
		Password : STRING[MAX_USER_ITEM_LEN];
		PasswordRepeat : STRING[MAX_USER_ITEM_LEN];
		VisuSlotID : USINT;
	END_STRUCT;
	User_Cmd_typ : 	STRUCT  (*Command Data Type for User Management*)
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
	User_Main_typ : 	STRUCT  (*Main Control Data Type for User Management*)
		CMD : User_Cmd_typ; (*Command of User Management*)
		PAR : User_Par_typ; (*Parameters for User Management*)
		DAT : User_Dat_typ; (*Data for User Management*)
		VIS : ARRAY[0..MAX_USER_CLIENTS]OF User_Vis_typ; (*Vision related variables for User Management*)
		ERR : User_Err_typ; (*Errors in User Management*)
	END_STRUCT;
	User_Dat_typ : 	STRUCT  (*Data Data Type for User Management*)
		Users : ARRAY[0..MAX_USER_NAMES]OF User_Details_typ; (*Users details*)
		Roles : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*Roles Details*)
		Status : STRING[200]; (*Status of the user*)
		UserActive : ARRAY[0..MAX_USER_CLIENTS]OF STRING[MAX_USER_ITEM_LEN]; (*Active User*)
	END_STRUCT;
	User_Vis_typ : 	STRUCT  (*User to HMI Data Type for User Management*)
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
	User_Err_typ : 	STRUCT  (*Errors Data Type for User Management*)
		No : DINT; (*Error  Numbers*)
		State : user_management_enum; (*User Management States*)
		Text : STRING[100]; (*Errors Text*)
	END_STRUCT;
	user_management_enum : 
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
	User_Details_typ : 	STRUCT 
		Roles : ARRAY[0..MAX_USER_ROLES]OF STRING[MAX_USER_ITEM_LEN]; (*User Roles*)
		Name : STRING[MAX_USER_ITEM_LEN]; (*User Names*)
	END_STRUCT;
END_TYPE
