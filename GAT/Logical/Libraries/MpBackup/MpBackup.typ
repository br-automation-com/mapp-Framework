
TYPE
	MpBackupCoreInfoType : 	STRUCT  (*Info structure of core function block*)
		LastBackup : MpBackupLastBackupType; (*Last backup created*)
		Project : MpBackupProjectInfoType; (*Project information*)
		Diag : MpBackupDiagType; (*Diagnostic structure for the function block*)
		Automatic : MpBackupAutoInfoType; (*Information about automatic processes*)
	END_STRUCT;
	MpBackupInfoType : 	STRUCT 
		Diag : MpBackupDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpBackupDiagType : 	STRUCT 
		StatusID : MpBackupStatusIDType; (*StatusID diagnostic structure *)
	END_STRUCT;
	MpBackupStatusIDType : 	STRUCT 
		ID : MpBackupErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpBackupCoreConfigType : 	STRUCT  (*Configuration structure*)
		AutomaticBackup : MpBackupAutoBackupType := (0); (*Create a backup automatically within defined interval*)
		AutomaticUpdate : MpBackupAutoUpdateType := (0); (*Check for new updates automatically*)
	END_STRUCT;
	MpBackupAutoBackupType : 	STRUCT 
		Enabled : BOOL; (*TRUE if backups should be automatically created*)
		NamePrefix : STRING[50]; (*Defines the first part of the backup name. MpBackup automatically adds a timestamp at the end. Format: myPrefix_%Y_%m_%d_%H_%M_%S*)
		DeviceName : STRING[255]; (*Absolute path including file device on which the cyclic backup needs to be created (Device/Path)*)
		Mode : MpBackupIntervalType; (*Defines automatic backup creation mode*)
		OverwriteOldest : MpBackupOverwriteOldestType; (*Defines if old backups should be deleted manually*)
	END_STRUCT;
	MpBackupIntervalType : 	STRUCT 
		Interval : MpBackupIntervalEnum; (*Specifies the interval a backup should be created*)
		Day : MpBackupDayEnum; (*Specifies the day of week the backup should be created*)
		Time : TIME_OF_DAY; (*Specifies the time of day the backup should be created (Seconds since 00:00)*)
	END_STRUCT;
	MpBackupOverwriteOldestType : 	STRUCT 
		Enabled : BOOL; (*Overwrite oldest backup automatically when maximum number of backups is exceeded*)
		MaximumNumberOfBackups : UINT; (*Maximum number of backups on the specified device name*)
	END_STRUCT;
	MpBackupLastBackupType : 	STRUCT 
		Name : STRING[255]; (*Name of last backup created*)
		DateTime : DATE_AND_TIME; (*Data and Time when last backup was created*)
		GenerationType : MpBackupGenerationTypeEnum; (*Specifies if last backup was created manually or automatically*)
	END_STRUCT;
	MpBackupGenerationTypeEnum : 
		(
		mpBACKUP_GENERATION_AUTO := 1, (*Backup was created automatically by mapp backup*)
		mpBACKUP_GENERATION_MANUAL := 0 (*Backup was created manually using function block interface of mapp backup*)
		);
	MpBackupIntervalEnum : 
		(
		mpBACKUP_INTERVAL_DAILY := 0,
		mpBACKUP_INTERVAL_WEEKLY := 1
		);
	MpBackupDayEnum : 
		(
		mpBACKUP_DAY_MONDAY := 0,
		mpBACKUP_DAY_TUESDAY := 1,
		mpBACKUP_DAY_WEDNESDAY := 2,
		mpBACKUP_DAY_THURSDAY := 3,
		mpBACKUP_DAY_FRIDAY := 4,
		mpBACKUP_DAY_SATURDAY := 5,
		mpBACKUP_DAY_SUNDAY := 6
		);
	MpBackupProjectInfoCurrentType : 	STRUCT 
		ConfigurationID : STRING[255]; (*ConfigurationID of the project *)
		ConfigurationVersion : STRING[64]; (*Configuration version of the project *)
	END_STRUCT;
	MpBackupProjectInfoRequestType : 	STRUCT 
		Name : STRING[255]; (*Name of backup/update for which this information has been requested*)
		ConfigurationID : STRING[255]; (*ConfigurationID of the project *)
		ConfigurationVersion : STRING[64]; (*Configuration version of the project *)
	END_STRUCT;
	MpBackupProjectInfoType : 	STRUCT 
		Current : MpBackupProjectInfoCurrentType; (*Project installed on target system*)
		Requested : MpBackupProjectInfoRequestType; (*Project of specified backup/update*)
	END_STRUCT;
	MpBackupAutoInfoType : 	STRUCT 
		Backup : MpBackupAutoBackupInfoType; (*Automatic backup creation information*)
		Update : MpBackupAutoUpdateInfoType; (*Automatic update information*)
	END_STRUCT;
	MpBackupAutoBackupInfoType : 	STRUCT 
		InProgress : BOOL; (*TRUE if an automic backup is currently being created*)
	END_STRUCT;
	MpBackupAutoUpdateInfoType : 	STRUCT 
		IsAvailable : BOOL; (*A newer project version is available*)
		Name : STRING[255]; (*Name of the update*)
		ConfigurationID : STRING[255]; (*ConfigurationID of the project *)
		ConfigurationVersion : STRING[64]; (*Configuration version of the project *)
	END_STRUCT;
	MpBackupAutoUpdateType : 	STRUCT 
		Mode : MpBackupAutoUpdateModeEnum; (*Automatic update mode*)
		DeviceName : STRING[255]; (*Absolute path including file device on which the updates are provided (Device/Path)*)
		Check : MpBackupUpdateCheckType; (*Defines automatic update check mode*)
	END_STRUCT;
	MpBackupUpdateCheckType : 	STRUCT 
		Type : MpBackupUpdateCheckEnum; (*Specifies the interval an event should be triggered*)
		Day : MpBackupDayEnum; (*Specifies the day of week an event should be triggered*)
		Time : TIME_OF_DAY; (*Specifies the time of day an event should be triggered (Seconds since 00:00)*)
	END_STRUCT;
	MpBackupUpdateCheckEnum : 
		(
		mpBACKUP_UPDATE_CHECK_DAILY := 0,
		mpBACKUP_UPDATE_CHECK_WEEKLY := 1,
		mpBACKUP_UPDATE_CHECK_ON_ENABLE := 2
		);
	MpBackupAutoUpdateModeEnum : 
		(
		mpBACKUP_AUTO_UPDATE_DISABLED := 0, (*Disabled automatic update*)
		mpBACKUP_AUTO_UPDATE_NOTIFY := 1 (*Enable automatic update check. A notification will be shown if an update is available*)
		);
END_TYPE
