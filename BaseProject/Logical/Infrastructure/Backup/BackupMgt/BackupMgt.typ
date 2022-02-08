
TYPE
	AutomaticBackupInterval_enum : 
		(
		BACKUP_EVERYDAY,
		BACKUP_MONDAY,
		BACKUP_TUESDAY,
		BACKUP_WEDNESDAY,
		BACKUP_THURSDAY,
		BACKUP_FRIDAY,
		BACKUP_SATURDAY,
		BACKUP_SUNDAY
		);
	AutomaticBackupMode_type : 	STRUCT 
		Interval : AutomaticBackupInterval_enum;
		Hour : USINT;
		Minute : USINT;
	END_STRUCT;
	AutomaticBackup_type : 	STRUCT 
		Enable : BOOL;
		Prefix : STRING[50];
		Device : STRING[255];
		Mode : AutomaticBackupMode_type;
		OverwriteOldest : MpBackupOverwriteOldestType;
	END_STRUCT;
	BackupHmiCommands_type : 	STRUCT 
		Create : BOOL;
		RestoreAuto : BOOL;
		Restore : BOOL;
		Delete : BOOL;
		CopyToUSB : BOOL;
		CopyFromUSB : BOOL;
		SaveConfig : BOOL;
	END_STRUCT;
	BackupHmiParameters_type : 	STRUCT 
		Name : STRING[80] := 'myBackup';
		SelectedIndex : USINT;
		AutomaticBackup : AutomaticBackup_type;
	END_STRUCT;
	BackupHmiStatus_type : 	STRUCT 
		Busy : BOOL;
		CreateAllowed : BOOL;
		RestoreAllowed : BOOL;
		FileNames : ARRAY[0..49]OF STRING[80];
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME;
		Size : ARRAY[0..49]OF UDINT;
		Info : MpBackupProjectInfoRequestType;
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
	END_STRUCT;
	BackupHmiInterface_type : 	STRUCT 
		Commands : BackupHmiCommands_type;
		Parameters : BackupHmiParameters_type;
		Status : BackupHmiStatus_type;
	END_STRUCT;
	BackupState_enum : 
		(
		BACKUP_IDLE,
		BACKUP_CREATING,
		BACKUP_RESTORING,
		BACKUP_DELETING,
		BACKUP_ERROR
		);
END_TYPE
