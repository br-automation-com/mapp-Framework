ACTION FIFOOperation:

	R_TRIG_CheckStatus(CLK := (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_CHANGE_DIR) OR
	(MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_CHANGE_DEVICE) OR
	(MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_CREATE));

	IF R_TRIG_CheckStatus.Q OR TON_ScanFolder.Q THEN
		HmiFile.Commands.CheckFolder := HmiFile.Parameters.Fifo.Enable;
	END_IF

	//device name declare
	HmiFile.Parameters.Fifo.DeviceName := HmiFile.Status.DeviceDataProvider[HmiFile.Parameters.Fifo.SelectedDevice];

	brsmemset(ADR(HmiFile.Status.FifoSelect[0]), 0, SIZEOF(HmiFile.Status.FifoSelect));
	FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
		IF (HmiFile.Parameters.Fifo.DeviceName = MpFileManagerUIConnect.DeviceList.DeviceNames[i]) AND HmiFile.Parameters.Fifo.Enable THEN
			HmiFile.Status.FifoSelect[i] := 1;
			EXIT;
		END_IF
	END_FOR

	// Autodelete oldest files based on scanning option
	CASE HmiFile.Status.DeleteStep OF
		FILE_DISABLED:
			IF (HmiFile.Parameters.Fifo.Enable = TRUE) THEN
				MpFileManagerUI_FIFO.Enable := TRUE;
				HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
			ELSE
				brsmemset(ADR(HmiFile.Status.FifoSelect[0]), 0, SIZEOF(HmiFile.Status.FifoSelect));
			END_IF
			
		FILE_DELETE_WAIT:
			IF (HmiFile.Parameters.Fifo.Enable = TRUE) THEN
				// Wait for check the correct device selection
				TON_ScanFolder.IN := TRUE;
				HmiFile.Status.FifoConfigEnable := TRUE;
				IF TON_ScanFolder.Q THEN
					TON_ScanFolder.IN := FALSE;
					HmiFile.Status.FifoConfigEnable := FALSE;
					Fifo_Count := 0;
					HmiFile.Status.DeleteStep := FILE_SCAN_FOLDER_WAIT;
				END_IF
			ELSE
				HmiFile.Status.DeleteStep := FILE_DISABLED;
			END_IF

		FILE_SCAN_FOLDER_WAIT:
			// Wait for check for old files command
			IF (HmiFile.Commands.CheckFolder = TRUE) AND ((MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) OR (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_ERROR)) THEN
				HmiFile.Commands.CheckFolder := FALSE;
				HmiFile.Status.DeleteStep := FILE_SELECT_DEVICE;
				HmiFile.Parameters.OldSortOrder := MpFileManagerUIConnect_FIFO.File.SortOrder;
			END_IF

		FILE_SELECT_DEVICE:
			//
			FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect_FIFO.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect_FIFO.DeviceList.DeviceNames[0])) - 1) DO
				IF HmiFile.Parameters.Fifo.DeviceName = MpFileManagerUIConnect_FIFO.DeviceList.DeviceNames[i] THEN
					MpFileManagerUIConnect_FIFO.DeviceList.SelectedIndex := i;
					EXIT;
				END_IF
			END_FOR
			IF (HmiFile.Parameters.Fifo.DeviceName <> MpFileManagerUIConnect_FIFO.DeviceList.DeviceNames[MpFileManagerUIConnect_FIFO.DeviceList.SelectedIndex]) THEN
				// file device not found
				HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
			ELSIF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect_FIFO.File.Refresh := TRUE;
				HmiFile.Status.DeleteStep := FILE_REFRESH;
			END_IF

		FILE_REFRESH:
			IF ((MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) AND (MpFileManagerUIConnect_FIFO.File.Refresh = FALSE)) THEN
				HmiFile.Status.DeleteStep := FILE_SORT_BY_DATE;
			END_IF

		FILE_SORT_BY_DATE:
			// Sort by date so the oldest files are at the end
			IF (MpFileManagerUIConnect_FIFO.File.SortOrder <> mpFILE_SORT_BY_MOD_TIME_DESC) THEN
				MpFileManagerUIConnect_FIFO.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_DESC;
			ELSIF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect_FIFO.File.Refresh := TRUE;
				MpFileManagerUI_FIFO();
			END_IF

			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_REFRESH) AND (MpFileManagerUIConnect_FIFO.File.Refresh = FALSE) THEN
				HmiFile.Status.DeleteStep := FILE_SORT_BY_DATE_WAIT;
			END_IF

		FILE_SORT_BY_DATE_WAIT:
			// Wait for the file manager to complete sorting change
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				HmiFile.Status.DeleteStep := FILE_GO_TO_END;
			END_IF

		FILE_GO_TO_END:
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items)/SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0])) - 1) DO
					MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := FALSE;
				END_FOR
				IF (MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount >= (SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items)/SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0]))) THEN
					// Page down until we get to the end, then start deleting
					IF (MpFileManagerUIConnect_FIFO.File.List.RangeStart <> 0) THEN
						MpFileManagerUIConnect_FIFO.File.List.PageDown := TRUE;
						HmiFile.Status.DeleteStep := FILE_GO_TO_END_1;
					ELSE
						Fifo_Count := 0;
						HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
					END_IF
				ELSE
					Fifo_Count := 0;
					HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
				END_IF
			END_IF

		FILE_GO_TO_END_1:
			TON_Wait.IN := (MpFileManagerUIConnect_FIFO.File.List.PageDown = FALSE);
			TON_Wait.PT := T#200ms;
			IF (TON_Wait.Q = TRUE) THEN
				TON_Wait.IN := FALSE;
				Fifo_Count := Fifo_Count + 1;
				// in case we are stuck trying to get to the last page
				HmiFile.Status.DeleteStep := SEL(Fifo_Count > 10, FILE_GO_TO_END, FILE_DELETE_WAIT);
			END_IF
			TON_Wait();

		FILE_CHECK_FOR_FILTER:
			// Check which delete filter is active
			CASE HmiFile.Parameters.Fifo.FifoType OF
				FILE_FIFO_NUM_OF_FILES:
					HmiFile.Status.DeleteStep := SEL(MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount <= HmiFile.Parameters.Fifo.MaxNumberOfFiles, FILE_SELECT_OLDEST_FILES_0, FILE_DELETE_WAIT);

				FILE_FIFO_SIZE_OF_FOLDER:
					CurrentIndex := 0;
					HmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
			END_CASE

		FILE_SELECT_OLDEST_FILES_0:
			// Scan and select all file over the filter setting
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				IF MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount > 1 THEN
					MpFileManagerUIConnect_FIFO.File.MultiSelect := TRUE;
				END_IF
				HmiFile.Status.AutoDeleteSelected := 0;
				// start from the first file to delete and select everything after
				// e.g. if there are 100 files and we want to keep 60 files around then we'd start at 60 + 0 MOD 50 = 10 and go to index 49
				FileNameArraySize := SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items)/SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0]);
				IF (HmiFile.Parameters.Fifo.MaxNumberOfFiles >= FileNameArraySize) THEN
					StartIndex := FileNameArraySize - (UDINT_TO_USINT(MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount - HmiFile.Parameters.Fifo.MaxNumberOfFiles + MpFileManagerUIConnect_FIFO.File.PathInfo.FolderCount) MOD FileNameArraySize);
				ELSE
					StartIndex := UDINT_TO_USINT(HmiFile.Parameters.Fifo.MaxNumberOfFiles + MpFileManagerUIConnect_FIFO.File.PathInfo.FolderCount) MOD FileNameArraySize;
				END_IF
				IF (StartIndex = FileNameArraySize) THEN
					StartIndex := 0;
				END_IF

				IF (StartIndex > 0) THEN
					FOR i := 0 TO (StartIndex - 1) DO
						MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := FALSE;
					END_FOR
				END_IF

				FOR i := StartIndex TO (FileNameArraySize - 1) DO
					MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := FALSE;
					IF (MpFileManagerUIConnect_FIFO.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_NONE) AND NOT MpFileManagerUIConnect_FIFO.File.List.Items[i].IsFolder THEN
						MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := TRUE;
						HmiFile.Status.AutoDeleteSelected := HmiFile.Status.AutoDeleteSelected + 1;
					END_IF
				END_FOR

				IF (HmiFile.Status.AutoDeleteSelected > 0) THEN
					HmiFile.Status.DeleteStep := FILE_DELETE_FILES;
				ELSE
					MpFileManagerUIConnect_FIFO.File.MultiSelect := FALSE;
					HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;
				END_IF
			END_IF

		FILE_CALC_FOLDER_SIZE:
			IF (CurrentIndex = 0) THEN
				HmiFile.Status.FolderSize := 0;
			END_IF
			DirRead_FolderSize.enable := TRUE;
			DirRead_FolderSize.pDevice := ADR(HmiFile.Parameters.Fifo.DeviceName);
			DirRead_FolderSize.pPath := 0;
			DirRead_FolderSize.entry := CurrentIndex;
			DirRead_FolderSize.option := fiFILE;
			DirRead_FolderSize.pData := ADR(DirectoryData);
			DirRead_FolderSize.data_len := SIZEOF(DirectoryData);
			DirRead_FolderSize();
			IF ((DirRead_FolderSize.status = ERR_OK) OR (DirRead_FolderSize.status = fiERR_NO_MORE_ENTRIES)) THEN
				HmiFile.Status.FolderSize := HmiFile.Status.FolderSize + UDINT_TO_REAL(DirectoryData.Filelength);
				CurrentIndex := CurrentIndex + 1;
				IF (CurrentIndex >= MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount) THEN
					HmiFile.Status.DeleteStep := SEL(HmiFile.Status.FolderSize > HmiFile.Parameters.Fifo.MaxFolderSize*1024, FILE_RESET_SORT_BY, FILE_SELECT_OLDEST_FILES_1);
				END_IF
			END_IF

		FILE_SELECT_OLDEST_FILES_1:
			// Scan and select all file over the filter setting
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				FOR i:=0 TO ((SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items)/SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0])) - 1) DO
					MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := FALSE;
				END_FOR
				FOR i:=0 TO ((SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items)/SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0])) - 1) DO
					IF ((MpFileManagerUIConnect_FIFO.File.List.Items[i].Size = 0) OR
						((HmiFile.Parameters.Fifo.MaxFolderSize*1024) > (HmiFile.Status.FolderSize - UDINT_TO_REAL(MpFileManagerUIConnect_FIFO.File.List.Items[i].Size)))) THEN
						EXIT;
					END_IF
					MpFileManagerUIConnect_FIFO.File.List.Items[i].IsSelected := TRUE;
					HmiFile.Status.FolderSize := HmiFile.Status.FolderSize - UDINT_TO_REAL(MpFileManagerUIConnect_FIFO.File.List.Items[i].Size);
				END_FOR
				MpFileManagerUIConnect_FIFO.File.MultiSelect := (i > 1);
				HmiFile.Status.DeleteStep := FILE_DELETE_FILES;
			END_IF

		FILE_DELETE_FILES:
			// Set command to delete the selected oldest files
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect_FIFO.File.Delete := TRUE;
			END_IF

			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_DELETE) THEN
				HmiFile.Status.DeleteStep := FILE_CONFIRM_DELETE;
			END_IF

		FILE_CONFIRM_DELETE:
			// Confirm the file delete
			IF (MpFileManagerUIConnect_FIFO.MessageBox.Type = mpFILE_MSG_CONFIRM_DELETE) THEN
				MpFileManagerUIConnect_FIFO.MessageBox.Confirm := TRUE;
			ELSIF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) AND (MpFileManagerUIConnect_FIFO.MessageBox.LayerStatus = 1) THEN
				HmiFile.Status.DeleteStep := FILE_CONFIRM_DELETE_WAIT;
			END_IF

		FILE_CONFIRM_DELETE_WAIT:
			IF ((MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_REFRESH) OR (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE)) THEN
				MpFileManagerUIConnect_FIFO.File.MultiSelect := FALSE;
				IF (HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER) THEN
					HmiFile.Status.DeleteStep := SEL((HmiFile.Status.FolderSize > (HmiFile.Parameters.Fifo.MaxFolderSize*1024)), FILE_RESET_SORT_BY, FILE_GO_TO_END);
				ELSE
					// if more files need to be deleted then go back to select the oldest files
					HmiFile.Status.DeleteStep := SEL((MpFileManagerUIConnect_FIFO.File.PathInfo.FileCount > HmiFile.Parameters.Fifo.MaxNumberOfFiles), FILE_RESET_SORT_BY, FILE_GO_TO_END);
				END_IF
			END_IF

		FILE_RESET_SORT_BY:
			// Restore old sort order
			IF (MpFileManagerUIConnect_FIFO.File.SortOrder <> HmiFile.Parameters.OldSortOrder) THEN
				MpFileManagerUIConnect_FIFO.File.SortOrder := HmiFile.Parameters.OldSortOrder;
			ELSIF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect_FIFO.File.Refresh := TRUE;
				HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY_WAIT;
			END_IF

		FILE_RESET_SORT_BY_WAIT:
			// Wait for file manager to complete restoring previous sorting mode
			IF (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_REFRESH) OR (MpFileManagerUIConnect_FIFO.Status = mpFILE_UI_STATUS_IDLE) THEN
				HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
				IF (MpFileManagerUIConnect_FIFO.MessageBox.Type = mpFILE_MSG_BUSY) THEN
					MpFileManagerUIConnect_FIFO.MessageBox.Confirm := TRUE;
				END_IF
			END_IF
	END_CASE
	
	
	
	// FIFO objects manage
	IF HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES THEN
		HmiFile.Status.FIFOLayerObjects.MaxFolderSizeVisiblity := HIDE;
		HmiFile.Status.FIFOLayerObjects.MaxNumberOfFilesVisiblity := DISPLAY;
		
	ELSIF HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER THEN
		HmiFile.Status.FIFOLayerObjects.MaxFolderSizeVisiblity := DISPLAY;
		HmiFile.Status.FIFOLayerObjects.MaxNumberOfFilesVisiblity := HIDE;
		
	ELSE
		HmiFile.Status.FIFOLayerObjects.MaxFolderSizeVisiblity := HIDE;
		HmiFile.Status.FIFOLayerObjects.MaxNumberOfFilesVisiblity := HIDE;
	END_IF
	

	// Save current archive setings to retain variable
	FifoSettingsRetain := HmiFile.Parameters.Fifo;	
	
	// Timer to scan file device in intervals
	TON_ScanFolder(PT := DINT_TO_TIME(HmiFile.Parameters.Fifo.ScanInterval * 60000));

	MpFileManagerUIConnect_FIFO.DeviceList.DeviceNames[0] := HmiFile.Parameters.Fifo.DeviceName;
	MpFileManagerUI_FIFO.UIConnect := ADR(MpFileManagerUIConnect_FIFO);
	// Assign MpLink
	MpFileManagerUI_FIFO.MpLink := ADR(gMpLinkFileManagerUIFile_FIFO);

	MpFileManagerUI_FIFO.UISetup.FileListSize := SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items) / SIZEOF(MpFileManagerUIConnect_FIFO.File.List.Items[0]);
	// Call function block
	MpFileManagerUI_FIFO();

END_ACTION
