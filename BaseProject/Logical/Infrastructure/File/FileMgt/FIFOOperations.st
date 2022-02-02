
ACTION FIFOOperation: 
    
	R_TRIG_CheckStatus(CLK := (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CHANGE_DIR) OR 
		(MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CHANGE_DEVICE) OR 
		(MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_CREATE));
	
	IF R_TRIG_CheckStatus.Q THEN	
		hmiFile.Commands.CheckFolder := TRUE;
	END_IF	

	(* Autodelete oldest files based on scanning option*)
    CASE hmiFile.Status.DeleteStep OF
	
        FILE_DELETE_WAIT: (* Wait for check the correct device selection *)		
			IF (hmiFile.Status.DeviceName = hmiFile.Parameters.Fifo.DeviceName) THEN
				hmiFile.Status.DeleteStep := FILE_SCAN_FOLDER_WAIT;
			END_IF
			
		FILE_SCAN_FOLDER_WAIT: (* Wait for check for old files command *)		
			IF (hmiFile.Commands.CheckFolder = TRUE) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				hmiFile.Commands.CheckFolder := FALSE;
				hmiFile.Status.DeleteStep := FILE_SORT_BY_DATE;
			ELSIF (hmiFile.Status.DeviceName <> hmiFile.Parameters.Fifo.DeviceName) THEN
				hmiFile.Status.DeleteStep := FILE_DELETE_WAIT;	
			END_IF	
			
		FILE_SORT_BY_DATE: (* Sort by date so the oldest files are at the end *)	
			hmiFile.Parameters.OldSortOrder :=  MpFileManagerUIConnect.File.SortOrder;	
            IF (MpFileManagerUIConnect.File.SortOrder <> mpFILE_SORT_BY_MOD_TIME_DESC) THEN
                MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_DESC;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                MpFileManagerUIConnect.File.Refresh := TRUE;
            END_IF
            
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) THEN
                hmiFile.Status.DeleteStep := FILE_CHECK_FOR_FILTER;
            END_IF				
			
        FILE_CHECK_FOR_FILTER: (* Check which delete filter is active *)
            IF (hmiFile.Parameters.Fifo.FifoType = FILE_FIFO_NUM_OF_FILES) THEN
                hmiFile.Status.DeleteStep := FILE_SELECT_OLDEST_FILES_0;              
            ELSIF (hmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER) THEN     
				hmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
			ELSIF (hmiFile.Parameters.Fifo.FifoType = FILE_FIFO_OLDER_THAN) THEN
                hmiFile.Status.DeleteStep := FILE_SORT_BY_DATE;         
			END_IF			
	
        FILE_SELECT_OLDEST_FILES_0: (* Scan and select all file over the filter setting *)		
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				IF MpFileManagerUIConnect.File.PathInfo.FileCount > 1 THEN
           			MpFileManagerUIConnect.File.MultiSelect := TRUE;
				END_IF	
				hmiFile.Status.AutoDeleteSelected := 0;
				FOR i:=0 TO ((SIZEOF(hmiFile.Status.FileNames)/SIZEOF(hmiFile.Status.FileNames[0]))-1) DO    
					IF i >= hmiFile.Parameters.Fifo.MaxNumberOfFiles THEN 						
						MpFileManagerUIConnect.File.List.Items[0].IsSelected := FALSE;
						IF (MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_NONE) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN			
							MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
							hmiFile.Status.AutoDeleteSelected := hmiFile.Status.AutoDeleteSelected + 1;
						END_IF
					END_IF	
				END_FOR		
				
				IF (hmiFile.Status.AutoDeleteSelected > 0) THEN
					hmiFile.Status.DeleteStep := FILE_DELETE_FILES;
				ELSE 
					MpFileManagerUIConnect.File.MultiSelect := FALSE;
					hmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;
				END_IF
			END_IF
			
		FILE_CALC_FOLDER_SIZE: (* Calculate the overall file size in the open folder *)
				hmiFile.Status.FolderSize := 0;         
				FOR i:=0 TO ((SIZEOF(hmiFile.Status.FileNames)/SIZEOF(hmiFile.Status.FileNames[0]))-1) DO    
					IF MpFileManagerUIConnect.File.List.Items[i].ItemType <> mpFILE_ITEM_TYPE_FOLDER THEN
						hmiFile.Status.FolderSize := hmiFile.Status.FolderSize + MpFileManagerUIConnect.File.List.Items[i].Size;	
					END_IF	
				END_FOR	 
				IF (hmiFile.Status.FolderSize > hmiFile.Parameters.Fifo.MaxFolderSize) THEN
					hmiFile.Status.DeleteStep := FILE_SELECT_OLDEST_FILES_1; 
				ELSE
					hmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;	
				END_IF	   
			
		FILE_SELECT_OLDEST_FILES_1: (* Scan and select all file over the filter setting *)		
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN					
				MpFileManagerUIConnect.File.List.Items[(MpFileManagerUIConnect.File.PathInfo.FileCount-1)].IsSelected := TRUE;	
				hmiFile.Status.DeleteStep := FILE_DELETE_FILES;
			END_IF	
		
        FILE_DELETE_FILES: (*Set command to delete the selected oldest files *)
			IF  (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
				MpFileManagerUIConnect.File.Delete := TRUE;	
			END_IF
					
			IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_DELETE) THEN        
				hmiFile.Status.DeleteStep := FILE_CONFIRM_DELETE;
            END_IF
			
        FILE_CONFIRM_DELETE: (* Confirm the file delete *)
            IF (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_DELETE)  THEN
                MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
            ELSIF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE THEN
				IF (hmiFile.Parameters.Fifo.FifoType = FILE_FIFO_SIZE_OF_FOLDER) THEN
                	hmiFile.Status.DeleteStep := FILE_CALC_FOLDER_SIZE;
				ELSE
					hmiFile.Status.DeleteStep := FILE_RESET_SORT_BY;
					MpFileManagerUIConnect.File.MultiSelect := FALSE;
				END_IF		
            END_IF
			
		FILE_RESET_SORT_BY: (* Restore old sort order *)		
            IF (MpFileManagerUIConnect.File.SortOrder <> hmiFile.Parameters.OldSortOrder) THEN
                MpFileManagerUIConnect.File.SortOrder := hmiFile.Parameters.OldSortOrder;
            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
                MpFileManagerUIConnect.File.Refresh := TRUE;
            END_IF
            
            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_REFRESH) THEN
                hmiFile.Status.DeleteStep := FILE_DELETE_WAIT;
            END_IF		
        
    END_CASE
	
END_ACTION
