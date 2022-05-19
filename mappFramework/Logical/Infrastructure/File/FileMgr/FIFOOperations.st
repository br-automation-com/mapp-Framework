ACTION FIFOOperation:
    
	R_TRIG_CheckStatus(CLK := (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CHANGE_DIR) OR
		(MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CHANGE_DEVICE) OR
		(MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CREATE));
	
	IF R_TRIG_CheckStatus.Q OR TON_ScanFolder.Q THEN
		HmiFile.Commands.CheckFolder := TRUE;
	END_IF

    // Autodelete oldest files based on scanning option
    CASE HmiFile.Status.DeleteStep OF
	
        FILE_DELETE_WAIT:
            // Wait for check the correct device selection
            TON_ScanFolder.IN := (HmiFile.Status.CurrentPage <> 'File_page');
			IF TON_ScanFolder.Q THEN
				TON_ScanFolder.IN := FALSE;
				HmiFile.Status.DeleteStep := FILE_SCAN_FOLDER_WAIT;
			END_IF
	
		FILE_SCAN_FOLDER_WAIT:
			// Wait for check for old files command
			IF (HmiFile.Commands.CheckFolder = TRUE) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				HmiFile.Commands.CheckFolder := FALSE;
				HmiFile.Status.DeleteStep := FILE_SELECT_DEVICE;
				HmiFile.Parameters.OldSortOrder := MpFileManagerUIConnect.File.SortOrder;
			END_IF
	
		FILE_SELECT_DEVICE:
			// 
            IF (HmiFile.Status.DeviceName <> HmiFile.Parameters.Fifo.DeviceName) THEN
                FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
                    IF HmiFile.Parameters.Fifo.DeviceName = MpFileManagerUIConnect.DeviceList.DeviceNames[i] THEN
                        MpFileManagerUIConnect.DeviceList.SelectedIndex := i;
                        EXIT;
                    END_IF
                END_FOR
                IF (HmiFile.Parameters.Fifo.DeviceName <> MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]) THEN
                    // file device not found
                    HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
                END_IF
            END_IF
    
            IF (HmiFile.Status.DeviceName = HmiFile.Parameters.Fifo.DeviceName) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                HmiFile.Status.DeleteStep := FILE_SORT_BY_DATE;
            END_IF
	
		FILE_SORT_BY_DATE:
			// Sort by date so the oldest files are at the end
            IF (MpFileManagerUIConnect.File.SortOrder <> mpFILE_SORT_BY_MOD_TIME_DESC) THEN
                MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_DESC;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                MpFileManagerUIConnect.File.Refresh := TRUE;
            END_IF
			
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) AND (MpFileManagerUIConnect.File.Refresh = FALSE) THEN
                HmiFile.Status.DeleteStep := FILE_SORT_BY_DATE_WAIT;
            END_IF
			
       FILE_SORT_BY_DATE_WAIT:  
	        // Wait for the file manager to complete sorting change
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
            END_IF
	
        FILE_GO_TO_END:
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                IF (HmiFile.Parameters.Fifo.MaxNumberOfFiles >= (SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0]))) THEN
                    // Page down until we get to the end, then start deleting
                    IF (MpFileManagerUIConnect.File.List.RangeStart <> 0) THEN
                        FOR i := 0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1) DO
                            MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
                        END_FOR
                        MpFileManagerUIConnect.File.List.PageDown := TRUE;                    
                    ELSE
                        HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
                    END_IF
                ELSE
                    HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
                END_IF
            END_IF
            
		FILE_CHECK_FOR_FILTER:
			// Check which delete filter is active
            CASE HmiFile.Parameters.Fifo.FifoType OF
                FILE_FIFO_NUM_OF_FILES:
                    HmiFile.Status.DeleteStep := FILE_SELECT_OLDEST_FILES_0;
                    
                FILE_FIFO_SIZE_OF_FOLDER:
    				HmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
            END_CASE
	            
        FILE_SELECT_OLDEST_FILES_0:
			// Scan and select all file over the filter setting
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                IF MpFileManagerUIConnect.File.PathInfo.FileCount > 1 THEN
           			MpFileManagerUIConnect.File.MultiSelect := TRUE;
				END_IF
                HmiFile.Status.AutoDeleteSelected := 0;
                // start from the first file to delete and select everything after
                // e.g. if there are 100 files and we want to keep 60 files around then we'd start at 60 + 0 MOD 50 = 10 and go to index 49
                FileNameArraySize := SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0]);
                StartIndex := SEL(HmiFile.Parameters.Fifo.MaxNumberOfFiles >= FileNameArraySize, UDINT_TO_USINT(HmiFile.Parameters.Fifo.MaxNumberOfFiles + MpFileManagerUIConnect.File.PathInfo.FolderCount) MOD FileNameArraySize,
                                                                                                 FileNameArraySize - UDINT_TO_USINT(HmiFile.Parameters.Fifo.MaxNumberOfFiles + MpFileManagerUIConnect.File.PathInfo.FolderCount) MOD FileNameArraySize);
                FOR i := StartIndex TO (FileNameArraySize - 1) DO
                    MpFileManagerUIConnect.File.List.Items[0].IsSelected := FALSE;
                    IF (MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_NONE) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN
            			MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
            			HmiFile.Status.AutoDeleteSelected := HmiFile.Status.AutoDeleteSelected + 1;
            		END_IF
                END_FOR
	
				IF (HmiFile.Status.AutoDeleteSelected > 0) THEN
					HmiFile.Status.DeleteStep := FILE_DELETE_FILES;
				ELSE
					MpFileManagerUIConnect.File.MultiSelect := FALSE;
					HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;
                END_IF
            END_IF
	
		FILE_CALC_FOLDER_SIZE:
			// Calculate the overall file size in the open folder
            HmiFile.Status.FolderSize := 0;
            FOR i := 0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1) DO
            	IF MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_FOLDER THEN
            		HmiFile.Status.FolderSize := HmiFile.Status.FolderSize + UDINT_TO_REAL(MpFileManagerUIConnect.File.List.Items[i].Size);
            	END_IF
            END_FOR
            HmiFile.Status.DeleteStep := SEL(HmiFile.Status.FolderSize > HmiFile.Parameters.Fifo.MaxFolderSize, FILE_RESET_SORT_BY, FILE_SELECT_OLDEST_FILES_1);

        FILE_SELECT_OLDEST_FILES_1:
            // Scan and select all file over the filter setting
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                LastIndex := (MpFileManagerUIConnect.File.PathInfo.FileCount MOD ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1));
				MpFileManagerUIConnect.File.List.Items[LastIndex].IsSelected := TRUE;
				HmiFile.Status.DeleteStep := FILE_DELETE_FILES;
			END_IF
	
		FILE_DELETE_FILES:
			// Set command to delete the selected oldest files
			IF  (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect.File.Delete := TRUE;
			END_IF
	
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_DELETE) THEN
				HmiFile.Status.DeleteStep := FILE_CONFIRM_DELETE;
            END_IF
	
		FILE_CONFIRM_DELETE:
			// Confirm the file delete
            IF (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_DELETE) THEN
                MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) AND (MpFileManagerUIConnect.MessageBox.LayerStatus = 1) THEN
				IF (HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER) THEN
                	HmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
                ELSE
                    MpFileManagerUIConnect.File.MultiSelect := FALSE;
                    // if more files need to be deleted then go back to select the oldest files
                    HmiFile.Status.DeleteStep := SEL((MpFileManagerUIConnect.File.PathInfo.FileCount > HmiFile.Parameters.Fifo.MaxNumberOfFiles), FILE_RESET_SORT_BY, FILE_GO_TO_END);
                END_IF
            END_IF
	
		FILE_RESET_SORT_BY:
			// Restore old sort order
            IF (MpFileManagerUIConnect.File.SortOrder <> HmiFile.Parameters.OldSortOrder) THEN
                MpFileManagerUIConnect.File.SortOrder := HmiFile.Parameters.OldSortOrder;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                MpFileManagerUIConnect.File.Refresh := TRUE;
				HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY_WAIT;
            END_IF
			
		FILE_RESET_SORT_BY_WAIT:
			// Wait for file manager to complete restoring previous sorting mode
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) OR (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
				IF (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_BUSY) THEN
					MpFileManagerUIConnect.MessageBox.Confirm := TRUE;					
				END_IF
            END_IF
	END_CASE
	
	// Timer to scan file device in intervals 
	TON_ScanFolder(PT := DINT_TO_TIME(HmiFile.Parameters.Fifo.ScanInterval * 60000));
	
END_ACTION
