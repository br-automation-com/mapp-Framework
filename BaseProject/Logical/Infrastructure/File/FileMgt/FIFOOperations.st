
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
				HmiFile.Parameters.OldSortOrder :=  MpFileManagerUIConnect.File.SortOrder;
			END_IF	
			
		FILE_SELECT_DEVICE: 
			// Sort by date so the oldest files are at the end 				
            IF (HmiFile.Status.DeviceName <> HmiFile.Parameters.Fifo.DeviceName) THEN
				FOR i:=0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0]))-1) DO
        			IF HmiFile.Parameters.Fifo.DeviceName = MpFileManagerUIConnect.DeviceList.DeviceNames[i] THEN
						MpFileManagerUIConnect.DeviceList.SelectedIndex := i;
					END_IF
    			END_FOR
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
            
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) THEN
                HmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
            END_IF				
			
		FILE_CHECK_FOR_FILTER: 
			// Check which delete filter is active 
            IF (HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES) THEN
                HmiFile.Status.DeleteStep := FILE_SELECT_OLDEST_FILES_0;              
            ELSIF (HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER) THEN     
				HmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
//			ELSIF (HmiFile.Parameters.Fifo.FifoType = FILE_FIFO_OLDER_THAN) THEN
//                HmiFile.Status.DeleteStep := FILE_SORT_BY_DATE;         
			END_IF			
	
		FILE_SELECT_OLDEST_FILES_0: 
			// Scan and select all file over the filter setting	
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				IF MpFileManagerUIConnect.File.PathInfo.FileCount > 1 THEN
           			MpFileManagerUIConnect.File.MultiSelect := TRUE;
				END_IF	
				HmiFile.Status.AutoDeleteSelected := 0;
				FOR i:=0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0]))-1) DO    
					IF i >= HmiFile.Parameters.Fifo.MaxNumberOfFiles THEN 						
						MpFileManagerUIConnect.File.List.Items[0].IsSelected := FALSE;
						IF (MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_NONE) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN			
							MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
							HmiFile.Status.AutoDeleteSelected := HmiFile.Status.AutoDeleteSelected + 1;
						END_IF
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
				FOR i:=0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0]))-1) DO    
					IF MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_FOLDER THEN
						HmiFile.Status.FolderSize := HmiFile.Status.FolderSize + UDINT_TO_REAL(MpFileManagerUIConnect.File.List.Items[i].Size);	
					END_IF	
				END_FOR	 
				IF (HmiFile.Status.FolderSize > HmiFile.Parameters.Fifo.MaxFolderSize) THEN
					HmiFile.Status.DeleteStep := FILE_SELECT_OLDEST_FILES_1; 
				ELSE
					HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;	
				END_IF	   
			
		FILE_SELECT_OLDEST_FILES_1: 
			// Scan and select all file over the filter setting 	
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN					
				MpFileManagerUIConnect.File.List.Items[(MpFileManagerUIConnect.File.PathInfo.FileCount-1)].IsSelected := TRUE;	
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
					HmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;
					MpFileManagerUIConnect.File.MultiSelect := FALSE;
				END_IF		
            END_IF
			
		FILE_RESET_SORT_BY:  
			// Restore old sort order 		
            IF (MpFileManagerUIConnect.File.SortOrder <> HmiFile.Parameters.OldSortOrder) THEN
                MpFileManagerUIConnect.File.SortOrder := HmiFile.Parameters.OldSortOrder;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                MpFileManagerUIConnect.File.Refresh := TRUE;
            END_IF
            
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) THEN
                HmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
				IF (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_BUSY) THEN
					MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
				END_IF						
            END_IF		
	END_CASE
	
	TON_ScanFolder(PT := DINT_TO_TIME(HmiFile.Parameters.Fifo.ScanInterval * 60000));
	
END_ACTION
