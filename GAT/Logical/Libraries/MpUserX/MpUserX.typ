
TYPE
	MpUserXAccessRightEnum : 
		(
		mpUSERX_ACCESS_UNDEFINED := 0, (*Access right undefined*)
		mpUSERX_ACCESS_NONE := 1, (*No access rights*)
		mpUSERX_ACCESS_VIEW := 2, (*Read access*)
		mpUSERX_ACCESS_ACTUATE := 3, (*Processes can be started/stopped but not edited*)
		mpUSERX_ACCESS_FULL := 4 (*Full access (read-write access)*)
		);
	MpUserXUIMessageEnum : 
		(
		mpUSERX_MSG_NONE := 0, (*No dialog box*)
		mpUSERX_MSG_ERROR := 1, (*Dialog box: Errors*)
		mpUSERX_MSG_CONFIRM_DELETE := 2, (*Dialog box: Confirmation of user deletion*)
		mpUSERX_MSG_CONFIRM_LOCK := 3, (*Dialog box: Confirmation of user block*)
		mpUSERX_MSG_CONFIRM_UNLOCK := 4, (*Dialog box: Confirmation of user unblock*)
		mpUSERX_MSG_CONFIRM_ROLE_DELETE := 5 (*Dialog box: Confirmation of role deletion*)
		);
	MpUserXMgrUIImportConfirmEnum : 
		(
		mpUSERX_CONFIRM_USER := 0, (*Confirm overwrite of existing user*)
		mpUSERX_CONFIRM_ROLE := 1 (*Confirm overwrite of existing role*)
		);
	MpUserXUIStatusEnum : 
		(
		mpUSERX_UI_STATUS_IDLE := 0, (*Indicates that no process is currently active*)
		mpUSERX_UI_STATUS_WAIT_DLG := 1, (*Waiting for confirmation or cancelation*)
		mpUSERX_UI_STATUS_EXECUTE := 2, (*Executing a command*)
		mpUSERX_UI_STATUS_ERROR := 99 (*The last operation generated an error*)
		);
	MpUserXImportModeEnum : 
		(
		mpUSERX_IMPORT_SKIP := 0, (*Do not import*)
		mpUSERX_IMPORT_IGNORE_EXISITNG := 1, (*Ignore existing items*)
		mpUSERX_IMPORT_OVERWRITE := 2, (*Overwrite existing items*)
		mpUSERX_IMPORT_OVERWRITE_ONLY := 4, (*Only overwrite items*)
		mpUSERX_IMPORT_REMOVE_EXISTING := 5 (*Remove existing items before import*)
		);
	MpUserXUserMgmtEnum : 
		(
		mpUSERX_USERMGMT_LOCAL := 0, (*Use local user management system*)
		mpUSERX_USERMGMT_CENTRAL := 1, (*Use central user management system*)
		mpUSERX_USERMGMT_LOCALANDCENTRAL := 2 (*Use both user management systems*)
		);
	MpUserXServerEnum : 
		(
		mpUSERX_SERVER_ACTIVE_DIRECTORY := 0, (*Use active directory server*)
		mpUSERX_SERVER_389DS := 1 (*Use 389 directory server*)
		);
	MpUserXUIMessageBoxType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box *)
		Type : MpUserXUIMessageEnum; (*Type of dialog box*)
		ErrorNumber : UINT; (*Current error number to be displayed *)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXMgrUIUserListType : 	STRUCT 
		UserNames : ARRAY[0..19]OF WSTRING[50]; (*List of all available users*)
		UserOptions : ARRAY[0..19]OF USINT; (*Controls the display of elements in the list*)
		MaxSelection : UINT; (*Index of the entry currently selected in the list*)
		SelectedIndex : UINT; (*Index of the last entry in the list*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time*)
		StepUp : BOOL; (* Selects the previous entry in the list*)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed-Start [%]*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed-End[%]*)
	END_STRUCT;
	MpUserXMgrUIUserInfoType : 	STRUCT 
		UserName : WSTRING[50]; (*Username for logging in*)
		FullName : WSTRING[100]; (*Complete username*)
		Roles : ARRAY[0..9]OF UINT; (*Assigned roles*)
		Locked : BOOL; (*User is blocked*)
		Expired : BOOL; (*User password expired*)
		RemainingAttempts : USINT; (*Number of login attempts left before the user is blocked*)
		Language : STRING[20]; (*Preferred language*)
		DisplayUnit : STRING[20]; (*Preferred unit*)
		Creation : DATE_AND_TIME; (*Date and time this user was created*)
		FirstLogin : DATE_AND_TIME; (*Date and time of the first login*)
		LastLogin : DATE_AND_TIME; (*Date and time of the last login*)
		PasswordExpired : DATE_AND_TIME; (*Date and time of password expiration*)
		AdditionalData : ARRAY[0..9]OF MpUserXMgrUIAdditionalDataType; (*Additional user data*)
	END_STRUCT;
	MpUserXMgrUIAdditionalDataType : 	STRUCT 
		Key : WSTRING[20]; (*Value identifier*)
		Value : WSTRING[255]; (*Value*)
	END_STRUCT;
	MpUserXMgrUIRoleListType : 	STRUCT 
		Names : ARRAY[0..9]OF WSTRING[50]; (*List of all available user roles*)
		SelectedIndex : UINT; (*Index of the entry currently selected in the list*)
		MaxSelection : UINT; (*Index of the last entry in the list*)
		PageUp : BOOL; (*Jumps to the start of the current page and then scrolls up one page at a time*)
		StepUp : BOOL; (* Selects the previous entry in the list*)
		PageDown : BOOL; (*Jumps to the end of the current page and then scrolls down one page at a time*)
		StepDown : BOOL; (*Selects the next entry in the list*)
		RangeStart : REAL; (*Shows a bar indicating which part of the list is currently being displayed-Start [%]*)
		RangeEnd : REAL; (*Shows a bar indicating which part of the list is currently being displayed-End[%]*)
	END_STRUCT;
	MpUserXMgrUIRoleInfoType : 	STRUCT 
		Name : WSTRING[50]; (*Name of the user role*)
		Index : UINT; (*Index of the user role*)
		Level : DINT; (*Level of the user role*)
		Admin : BOOL; (*Indicates whether this role has administrator rights*)
		AccessRights : ARRAY[0..19]OF MpUserXAccessRightEnum; (*List with the access rights for individual actions*)
	END_STRUCT;
	MpUserXMgrUIRoleDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		Name : WSTRING[50]; (*Name of the user role*)
		Index : UINT; (*Index of the user role in list*)
		Level : DINT; (*Level of the user role*)
		LevelLimit : DINT; (*Max. Level allowed to set*)
		Admin : BOOL; (*Defines whether this role has administrator rights*)
		AccessRights : ARRAY[0..19]OF MpUserXAccessRightEnum; (*List with the access rights for individual actions*)
		AccessRightsLimit : ARRAY[0..19]OF MpUserXAccessRightEnum; (*Limit-values for the access-rights*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXMgrUIRoleCreateDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		Name : WSTRING[50]; (*Name of the user role*)
		Level : DINT; (*Level of the user role*)
		LevelLimit : DINT; (*Max. Level allowed to set*)
		Admin : BOOL; (*Defines whether this role has administrator rights*)
		AccessRights : ARRAY[0..19]OF MpUserXAccessRightEnum; (*List with the access rights for individual actions*)
		AccessRightsLimit : ARRAY[0..19]OF MpUserXAccessRightEnum; (*Limit-values for the access-rights*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXMgrUIRoleCreateType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Lock : BOOL; (*Blocks the function for editing user role*)
		Dialog : MpUserXMgrUIRoleCreateDlgType; (*Dialog box for editing a user role*)
	END_STRUCT;
	MpUserXMgrUIRoleEditType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Lock : BOOL; (*Blocks the function for editing user role*)
		Dialog : MpUserXMgrUIRoleDlgType; (*Dialog box for editing a user role*)
	END_STRUCT;
	MpUserXMgrUICreateDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		UserName : WSTRING[50]; (*Username*)
		FullName : WSTRING[100]; (*Full name of the new user*)
		Roles : ARRAY[0..9]OF UINT; (*Assigned roles*)
		RoleOption : ARRAY[0..19]OF USINT; (*Sorts and removes user roles in the drop-down list that cannot be selected*)
		NewPassword : WSTRING[50]; (*New password*)
		ConfirmPassword : WSTRING[50]; (*Password confirmation*)
		Language : STRING[20]; (*Preferred language of the new user*)
		DisplayUnit : STRING[20]; (*Preferred unit of the new user*)
		CriteriaNotMet : MpUserXUIPasswordCriteriaEnum; (*Password criterion not met by new password*)
		NewPasswordOk : UINT; (*New password OK (all criterions met)*)
		ConfirmPasswordOk : UINT; (*Password-confirmation OK*)
		UserNameOk : UINT; (*UserName OK*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
		AdditionalData : ARRAY[0..9]OF MpUserXMgrUIAdditionalDataType; (*Additional user data*)
	END_STRUCT;
	MpUserXMgrUICreateType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Lock : BOOL; (*Blocks the function for editing/creating users*)
		Dialog : MpUserXMgrUICreateDlgType; (*Dialog box for creating a user*)
	END_STRUCT;
	MpUserXMgrUIExportDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		FileName : STRING[255]; (*Name of the file to be exported*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXMgrUIExportType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Dialog : MpUserXMgrUIExportDlgType; (*Dialog box for exporting user data*)
	END_STRUCT;
	MpUserXMgrUISetupConfirmType : 	STRUCT 
		OverwriteUser : BOOL; (*Confirmation by operator for overwriting existing users required*)
		OverwriteRole : BOOL; (*Confirmation by operator for overwriting existing roles required*)
	END_STRUCT;
	MpUserXMgrUISetupType : 	STRUCT 
		UserListSize : UINT := 20; (*Number of users to be displayed on one page of the list in the HMI application*)
		ScrollWindow : USINT := 1; (*Determines how many entries from the list are displayed in advance when scrolling up and down*)
		FileDevice : STRING[20] := 'HD'; (*File device (data storage medium) for exporting/importing user data*)
		FileExtension : STRING[20] := 'usr'; (*File extension for export/import file*)
		RoleListSize : UINT := 9; (*Number of roles to be displayed on one page of the list in the HMI application*)
		Confirmation : MpUserXMgrUISetupConfirmType; (*Displaying the confirmation window*)
	END_STRUCT;
	MpUserXMgrUIImportListType : 	STRUCT 
		FileNames : ARRAY[0..4]OF STRING[255]; (*List of all files available for import*)
		SelectedIndex : UINT; (*Index of the entry currently selected in the list*)
		MaxSelection : UINT; (*Index of the last entry in the list*)
	END_STRUCT;
	MpUserXMgrUIImportDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		List : MpUserXMgrUIImportListType; (*List of all files available for import, as well as the navigation of the list*)
		FileName : STRING[255]; (*Name of the file to be imported*)
		Users : BOOL; (*Options that specifies whether user data should be applied*)
		Roles : BOOL; (*Options that specifies whether user group settings should be applied*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXMgrUIImportConfirmType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box*)
		Type : MpUserXMgrUIImportConfirmEnum; (*Confirmation type (user or group)*)
		Name : WSTRING[50]; (*Name of user / group*)
		NumberOfConflicts : UINT; (*Number of remaining conflicts*)
		ApplyForAll : BOOL; (*Apply selection for all remaining conflicts*)
		Confirm : BOOL; (*Confirm overwrite of item*)
		Cancel : BOOL; (*Reject overwrite of item (ignore)*)
	END_STRUCT;
	MpUserXMgrUIImportType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Dialog : MpUserXMgrUIImportDlgType; (*Dialog box for importing user data*)
		ConfirmDialog : MpUserXMgrUIImportConfirmType; (*Import confirmation dialog*)
	END_STRUCT;
	MpUserXMgrUIUserType : 	STRUCT 
		List : MpUserXMgrUIUserListType; (*List of all users, as well as the navigation of the list*)
		Info : MpUserXMgrUIUserInfoType; (*Contains detailed information about users*)
		Create : MpUserXMgrUICreateType; (*Contains the data necessary to create a user*)
		Edit : MpUserXMgrUICreateType; (*Contains the data necessary to edit a user*)
		Remove : BOOL; (*Deletes the selected user*)
		Lock : BOOL; (*Blocks the selected user*)
	END_STRUCT;
	MpUserXMgrUIRoleSelectType : 	STRUCT 
		Names : ARRAY[0..19]OF WSTRING[50]; (*List of all available user groups (not scrollable)*)
		MaxSelection : UINT; (*Index of the last entry in the list*)
	END_STRUCT;
	MpUserXMgrUIRoleType : 	STRUCT 
		List : MpUserXMgrUIRoleListType; (*List of all user roles, as well as the navigation of the list*)
		Info : MpUserXMgrUIRoleInfoType; (*Contains detailed information about user role*)
		Edit : MpUserXMgrUIRoleEditType; (*Contains the data necessary to edit a user role*)
		Create : MpUserXMgrUIRoleCreateType; (*Contains the data necessary to create a user-role*)
		Remove : BOOL; (*Deletes the selected role*)
		SelectList : MpUserXMgrUIRoleSelectType; (*List for selecting roles from dropdown*)
	END_STRUCT;
	MpUserXMgrUIConnectType : 	STRUCT 
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page where the user management system is being displayed*)
		Status : MpUserXUIStatusEnum; (*Current operation*)
		User : MpUserXMgrUIUserType; (*User information*)
		Role : MpUserXMgrUIRoleType; (*User role information*)
		MessageBox : MpUserXUIMessageBoxType; (*Controls dialog boxes*)
		Export : MpUserXMgrUIExportType; (*Exports the user and user group settings*)
		Import : MpUserXMgrUIImportType; (*Imports the user and user group settings*)
	END_STRUCT;
	MpUserXUIPasswordCriteriaEnum : 
		(
		mpUSERX_PASSWORD_CRIT_NONE := 0, (*None*)
		mpUSERX_PASSWORD_CRIT_LENGTH := 1, (*Password length*)
		mpUSERX_PASSWORD_CRIT_ALPHA := 2, (*Password alpha-numeric*)
		mpUSERX_PASSWORD_CRIT_CASE := 3, (*Password case-sensitive (upper- and lower-case characters)*)
		mpUSERX_PASSWORD_CRIT_SPECIAL := 4 (*Password must contain special characters*)
		);
	MpUserXLoginUIPwdDlgType : 	STRUCT 
		OldPassword : WSTRING[50]; (*Old password*)
		NewPassword : WSTRING[50]; (*New password*)
		ConfirmPassword : WSTRING[50]; (*Confirmation of the new password*)
		LayerStatus : UINT; (*Visibility of the dialog box (status data point for the dialog box layer)*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
		CriteriaNotMet : MpUserXUIPasswordCriteriaEnum; (*Password criterion not met by new password*)
		NewPasswordOk : UINT; (*New password OK (all criterions met)*)
		ConfirmPasswordOk : UINT; (*Password-confirmation OK*)
	END_STRUCT;
	MpUserXLoginUIPwdType : 	STRUCT 
		ShowDialog : BOOL; (*Command that opens the dialog box*)
		Dialog : MpUserXLoginUIPwdDlgType; (*Dialog box for changing the password*)
	END_STRUCT;
	MpUserXLoginUILoginType : 	STRUCT 
		Login : BOOL; (*Command for logging in*)
		Logout : BOOL; (*Command for logging out*)
		UserName : WSTRING[50]; (*Username*)
		Password : WSTRING[50]; (*Password*)
	END_STRUCT;
	MpUserXLoginUIConnectType : 	STRUCT 
		Status : MpUserXUIStatusEnum; (*Current operation*)
		CurrentUser : WSTRING[50]; (*Currently logged in user*)
		Language : STRING[20]; (*Preferred language of the current (or previous) active user*)
		DisplayUnit : STRING[20]; (*Preferred unit of the current (or previous) active user*)
		LoggedIn : BOOL; (*User is logged in*)
		UserLevel : DINT; (*Current user-level*)
		Login : MpUserXLoginUILoginType; (*Basic login information*)
		ChangePassword : MpUserXLoginUIPwdType; (*Used to change the password*)
		MessageBox : MpUserXUIMessageBoxType; (*Controls dialog boxes*)
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page where logging in and out takes place*)
	END_STRUCT;
	MpUserXConfigType : 	STRUCT 
		NoDelete : BOOL := TRUE; (*Deletion of users not allowed*)
		PasswordChangeReq : BOOL := FALSE; (*Requires password change on first login*)
		PasswordCase : BOOL := FALSE; (*Requires password to have both upper- and lowercase letters*)
		PasswordAlpha : BOOL := TRUE; (*Requires password to have alphanumeric characters*)
		PasswordLength : UINT := 5; (*Minimum password length*)
		LoginAttempts : UINT := 3; (*Maximum number of failed login attempts until the user is blocked*)
		PasswordChangeInterval : DINT := 0; (*Interval in which the password must be changed*)
		UserExpirationTime : DINT := 0; (*Expiration time for the validity of the user account*)
		UserNameLength : UINT := 1; (*Minimum user-name length*)
		SignAttempts : UINT := 3; (*Maximum number of signature attempts before the signature procedure is aborted*)
		PasswordHistory : UINT := 0; (*Length of password-history to prohibit reuse of passwords*)
		PasswordSpecial : BOOL := FALSE; (*Requires password to contain special characters*)
		EditSameLevel : BOOL := FALSE; (*Allow admin-user to edit users (create, change, remove) with same user-level (within same group)*)
		ImportUser : MpUserXImportModeEnum := mpUSERX_IMPORT_OVERWRITE; (*Import mode for users*)
		ImportRole : MpUserXImportModeEnum := mpUSERX_IMPORT_OVERWRITE; (*Import mode for roles*)
		ImportUnchecked : BOOL := FALSE; (*Ignore check-sum in input file*)
		AdminUnlockTime : DINT := 3600; (*Automatic Unlock Time for Administrators (0=disabled)*)
		AutoLogoutTime : DINT := 3600; (*Auto Logout Time for all sessions on the system (0=disabled)*)
		PasswordExpirationNotification : DINT := 0; (*Defines how long before password expiration users should receive a password expiration notification. (0=disabled)*)
	END_STRUCT;
	MpUserXHostType : 	STRUCT 
		Host : STRING[255]; (*DNS name or IPv4 address of the server the client will connect to*)
		Port : UINT := 636; (*Port*)
		Certificate : STRING[255]; (*Server certificate*)
		BaseDN : STRING[255]; (*Base distinguished name (Active Directory Server)*)
		UserLocationDN : STRING[255]; (*User location distinguished name (389 Directory Server)*)
	END_STRUCT;
	MpUserXGroupToRoleMappingType : 	STRUCT 
		TableName : STRING[50]; (*Name of the group to role mapping table*)
	END_STRUCT;
	MpUserXServerType : 	STRUCT 
		Type : MpUserXServerEnum := mpUSERX_SERVER_ACTIVE_DIRECTORY; (*Determines which server type should be used*)
		Hosts : ARRAY[0..9]OF MpUserXHostType; (*Host list*)
		Mapping : MpUserXGroupToRoleMappingType; (*Settings for mapping*)
		AdditionalUserData : ARRAY[0..9]OF STRING[100]; (*Settings for additional data that should be fetched from server*)
	END_STRUCT;
	MpUserXServerConfigType : 	STRUCT 
		UserMgmtSystemType : MpUserXUserMgmtEnum := mpUSERX_USERMGMT_LOCAL; (*Select user management system type*)
		Server : MpUserXServerType; (*Server settings*)
	END_STRUCT;
	MpUserXMappingConfigType : 	STRUCT 
		Mapping : ARRAY[0..99]OF MpUserXMappingMappingType; (*Entry of mapping table*)
	END_STRUCT;
	MpUserXMappingMappingType : 	STRUCT 
		LocalRole : WSTRING[50]; (*Local role*)
		ServerGroup : WSTRING[50]; (*Server group*)
	END_STRUCT;
	MpUserXLoginConfigType : 	STRUCT 
		AutoLogout : DINT := 600; (*Automatic logout time (for inactive users) [s]*)
	END_STRUCT;
	MpUserXSignatureUIDlgType : 	STRUCT 
		LayerStatus : UINT; (*Visibility of the dialog box (status data point for the dialog box layer)*)
		UserName : WSTRING[50]; (*Username*)
		Password : WSTRING[50]; (*Password*)
		Comment : WSTRING[100]; (*Optional comment added by signing operator*)
		Confirm : BOOL; (*Confirms the operation*)
		Cancel : BOOL; (*Cancels the operation*)
	END_STRUCT;
	MpUserXSignatureUIConnectType : 	STRUCT 
		Status : MpUserXUIStatusEnum; (*Current status of the signature-procedure*)
		SignAction : DINT; (*Start signature procedure by setting this to a value not equal to 0. The value will be available on the CheckAction-FB.*)
		Dialog : MpUserXSignatureUIDlgType;
		MessageBox : MpUserXUIMessageBoxType; (*Controls dialog boxes*)
		DefaultLayerStatus : UINT; (*Status data point for the default layer of the visualization page where logging in and out takes place*)
	END_STRUCT;
END_TYPE

(*FB Infor Types*)

TYPE
	MpUserXLoginInfoType : 	STRUCT 
		AutoLogoutRemain : TIME; (*Time remaining before automatic logout [s]*)
		Diag : MpUserXDiagType; (*Diagnostic structure for the status ID*)
		DaysUntilPasswordExpiration : DINT; (*Time remaining before password expires [days]*)
	END_STRUCT;
	MpUserXInfoType : 	STRUCT 
		Diag : MpUserXDiagType; (*Diagnostic structure for the status ID*)
	END_STRUCT;
	MpUserXDiagType : 	STRUCT 
		StatusID : MpUserXStatusIDType; (*StatusID diagnostic structure*)
	END_STRUCT;
	MpUserXStatusIDType : 	STRUCT 
		ID : MpUserXErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
END_TYPE

(*FB Internal Types*)

TYPE
	MpUserXInternalType : 	STRUCT 
		pObject : UDINT;
		pInstance : UDINT; (*Marker for FB-instance (overload detection)*)
		State : DINT; (*State for internal life-time management*)
	END_STRUCT;
END_TYPE
