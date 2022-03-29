
TYPE
	AutomaticBackupIntervalEnum : 
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
	AutomaticBackupModeType : 	STRUCT 
		Interval : AutomaticBackupIntervalEnum;
		Hour : USINT;
		Minute : USINT;
	END_STRUCT;
	AutomaticBackupType : 	STRUCT 
		Enable : BOOL;
		Prefix : STRING[50];
		Device : STRING[255];
		Mode : AutomaticBackupModeType;
		OverwriteOldest : MpBackupOverwriteOldestType;
	END_STRUCT;
	BackupHmiCommandsType : 	STRUCT 
		Create : BOOL;
		RestoreAuto : BOOL;
		Restore : BOOL;
		Delete : BOOL;
		CopyToUSB : BOOL;
		CopyFromUSB : BOOL;
		SaveConfig : BOOL;
		Reset : BOOL;
	END_STRUCT;
	BackupHmiParametersType : 	STRUCT 
		Name : STRING[80] := 'myBackup';
		AutomaticBackup : AutomaticBackupType;
	END_STRUCT;
	BackupHmiStatusType : 	STRUCT 
		Busy : BOOL;
		Error : BOOL;
		CreateAllowed : BOOL;
		RestoreAllowed : BOOL;
		FileNames : ARRAY[0..49]OF STRING[80];
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME;
		Size : ARRAY[0..49]OF UDINT;
		Info : MpBackupProjectInfoRequestType;
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100];
		TableConfig : ARRAY[0..1]OF STRING[120];
		SimulationActive : BOOL;
		SelectedIndex : USINT; (*Index of the selected backup file*)
		LastSelectedIndex : USINT; (*Index of the last selected backup file*)
		LastSelectedDeviceIndex : UINT; (*Index of the last selected file device. Compared with MpFileManagerUIConnect.DeviceList.SelectedIndex*)
	END_STRUCT;
	BackupHmiInterfaceType : 	STRUCT  (*HMI interface structure*)
		Commands : BackupHmiCommandsType;
		Parameters : BackupHmiParametersType;
		Status : BackupHmiStatusType;
	END_STRUCT;
	BackupStateEnum : 
		( (*States for backup state machine*)
		BACKUP_IDLE,
		BACKUP_CREATING,
		BACKUP_RESTORING,
		BACKUP_DELETING,
		BACKUP_ERROR
		);
END_TYPE
