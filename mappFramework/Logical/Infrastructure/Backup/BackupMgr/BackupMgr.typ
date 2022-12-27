(*Structure types*)

TYPE
	BackupHmiInterfaceType : 	STRUCT  (*HMI interface structure*)
		Commands : BackupHmiCommandsType; (*Structure to hold the commands from the HMI*)
		Parameters : BackupHmiParametersType; (*Structure to hold the parameters for the HMI*)
		Status : BackupHmiStatusType; (*Structure to hold the status information from the HMI*)
	END_STRUCT;
	BackupHmiCommandsType : 	STRUCT  (*Structure to hold the commands from the HMI*)
		Create : BOOL; (*Create a backup*)
		Restore : BOOL; (*Restore a backup*)
		Update : BOOL; (*Install an update*)
		Delete : BOOL; (*Delete a backup*)
		SaveConfig : BOOL; (*Save automatic backup configuration settings*)
		Reset : BOOL; (*Error reset*)
	END_STRUCT;
	BackupHmiParametersType : 	STRUCT  (*Structure to hold the parameters for the HMI*)
		Name : STRING[80] := 'myBackup'; (*Name of the backup*)
		AutomaticBackup : AutomaticBackupType; (*Automatic backup settings*)
	END_STRUCT;
	BackupHmiStatusType : 	STRUCT  (*Structure to hold the status information from the HMI*)
		Busy : BOOL; (*Backup is busy executing an action*)
		Error : BOOL; (*Error flag*)
		CreateAllowed : BOOL; (*Bit to indicate it is allowable to create a backup right now*)
		RestoreAllowed : BOOL; (*Bit to indicate it is allowable to restore a backup right now*)
		BackupCtrlEnabled : BOOL; (*Disable control panel for Backup with in Sim*)
		FileNames : ARRAY[0..49]OF STRING[80]; (*Existing backup file names*)
		TimeStamps : ARRAY[0..49]OF DATE_AND_TIME; (*Time stamps for existing backups*)
		Info : MpBackupProjectInfoRequestType; (*Project information (name, configuration ID, configuration version)*)
		DeviceDataProvider : ARRAY[0..MAX_IDX_FILE_DEV]OF STRING[100]; (*Data provider for file device dropdown on automatic backup configuration pop-up*)
		TableConfig : ARRAY[0..1]OF STRING[120]; (*Table configuration for the list of available backups*)
		SimulationActive : BOOL; (*Flag for if simulation is active*)
		SelectedIndex : USINT; (*Index of the selected backup file*)
		LastSelectedIndex : USINT := 255; (*Index of the last selected backup file*)
		LastSelectedDeviceIndex : UINT; (*Index of the last selected file device. Compared with MpFileManagerUIConnect.DeviceList.SelectedIndex*)
		FileOverMax : BOOL; (*Active when more than 50 items detected*)
		Update : MpBackupAutoUpdateInfoType;
	END_STRUCT;
	AutomaticBackupType : 	STRUCT  (*Automatic backup settings*)
		Enable : BOOL; (*Enable automatic backup feature*)
		Prefix : STRING[50]; (*Name prefix for each automatic backup file*)
		Device : STRING[255]; (*File device to store the automatic backup*)
		Mode : AutomaticBackupModeType; (*Automatic backup time interval*)
		OverwriteOldest : MpBackupOverwriteOldestType; (*Defines whether older backups should be deleted or not*)
	END_STRUCT;
	AutomaticBackupModeType : 	STRUCT  (*Automatic backup time interval*)
		Interval : AutomaticBackupIntervalEnum; (*Day interval (daily, or a specfiic day of the week)*)
		Hour : USINT; (*Time (hour)*)
		Minute : USINT; (*Time (minutes)*)
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	AutomaticBackupIntervalEnum : 
		( (*Selection for how often to automatically create a backup*)
		BACKUP_EVERYDAY, (*Every day*)
		BACKUP_MONDAY, (*Every Monday*)
		BACKUP_TUESDAY, (*Every Tuesday*)
		BACKUP_WEDNESDAY, (*Every Wednesday*)
		BACKUP_THURSDAY, (*Every Thursday*)
		BACKUP_FRIDAY, (*Every Friday*)
		BACKUP_SATURDAY, (*Every Saturday*)
		BACKUP_SUNDAY (*Every Sunday*)
		);
	BackupStateEnum : 
		( (*States for backup state machine*)
		BACKUP_IDLE, (*Wait state*)
		BACKUP_CREATING, (*Creating a backup*)
		BACKUP_AUTOCREATE, (*Autobackup in progress*)
		BACKUP_REFRESHING_LIST, (*Refreshing backup list*)
		BACKUP_RESTORING, (*Restoring a backup*)
		BACKUP_UPDATING, (*Installing a new version*)
		BACKUP_DELETING, (*Deleting a backup*)
		BACKUP_SIM, (*CPU in simulation mode, don't do anything*)
		BACKUP_ERROR (*Error state*)
		);
END_TYPE
