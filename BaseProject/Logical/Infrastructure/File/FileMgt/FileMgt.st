(*********************************************************************************
* Copyright: B&R Industrial Automation GmbH 
* Author:    B&R Industrial Automation GmbH 
* Created:   30. Sep 2020/08:00 
* Description: Tasks for File management control. The File management handling is done in this task.
*********************************************************************************)

PROGRAM _INIT

//	(*Create folder for this component on the user file device*)
//	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));		
//	
//	(*Check if folder already exist and if so disabled the function block call*)
//	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
//		DirCreate_New(enable := FALSE);
//	END_IF	
	
	(* Init Filemanager for exporting/importing files *)
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gFileMgrUIMpLink);
	MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]);
	MpFileManagerUIConnect.DeviceList.DeviceNames[0] := 'mappRecipe';
	MpFileManagerUIConnect.DeviceList.DeviceNames[1] := 'mappAudit';
	MpFileManagerUIConnect.DeviceList.DeviceNames[2] := 'mappReport';
	MpFileManagerUIConnect.DeviceList.DeviceNames[3] := 'mappData';
	MpFileManagerUIConnect.DeviceList.DeviceNames[4] := 'mappBackup';
	MpFileManagerUIConnect.DeviceList.DeviceNames[5] := 'mappAlarmX';
	MpFileManagerUIConnect.DeviceList.DeviceNames[6] := 'mappUserX';
	
	(* Init FIFO feature *)
	hmiFile.Parameters.Fifo.DeviceName := 'mappData';
    hmiFile.Parameters.Fifo.MaxFolderSize := 20000 (*kB*); 
	hmiFile.Parameters.Fifo.MaxNumberOfFiles := 20;
	
END_PROGRAM

PROGRAM _CYCLIC

   FormatDeviceDataProvider;	
   FileManager;
   IF hmiFile.Parameters.Fifo.Enable THEN
      FIFOOperation;
   END_IF 
    (* Error reset *)
    IF NOT MpFileManagerUI_0.Error THEN
        MpFileManagerUI_0.ErrorReset := FALSE;
    END_IF
	
    MpFileManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	(* Reset function blocks to unlink mapp links *)

    MpFileManagerUI_0.Enable := FALSE;
    MpFileManagerUI_0();
END_PROGRAM

