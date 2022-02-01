
ACTION FileCopyOperation: 
    
//	(* Export/Import recipes to/from USB *)
//    CASE hmiFile.Status.CopyStep OF
//        FILE_COPY_WAIT: (* Wait for export/import command *)
//            IF (hmiFile.Commands.ExportToUSB = TRUE) THEN
//                (* Check if USB device is available *)
//                IF (brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[1])) > 0) THEN
//                    
//                    (* USB is available proceed with export: select all files on the CF and trigger copy command *)
//                    IF (MpFileManagerUIConnect.DeviceList.SelectedIndex <> 0) THEN
//                        MpFileManagerUIConnect.DeviceList.SelectedIndex := 0;
//                        MpFileManagerUIConnect.File.MultiSelect := FALSE;
//                    ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
//                        
//                        IF NOT MpFileManagerUIConnect.File.MultiSelect THEN
//                            MpFileManagerUIConnect.File.MultiSelect := TRUE;
//                            FOR Index := 0 TO 49 DO
//                                MpFileManagerUIConnect.File.List.Items[Index].IsSelected := TRUE;
//                            END_FOR;
//                        ELSIF (brsstrlen(ADR(MpFileManagerUIConnect.File.List.Items[Index].Name)) = 0) THEN
//                            (* No files to copy, cancel operation *)
//                            hmiFile.Commands.ExportToUSB := FALSE;
//                        ELSE
//                            MpFileManagerUIConnect.File.Copy := TRUE;
//                            hmiFile.Status.CopyStep := FILE_COPY_TO_USB;
//                            hmiFile.Commands.ExportToUSB := FALSE;
//                        END_IF
//                        
//                    END_IF
//                    
//                ELSE
//                    (* No USB disk available, cancel operation *)
//                    hmiFile.Commands.ExportToUSB := FALSE;
//                END_IF
//                
//            ELSIF hmiFile.Commands.ImportFromUSB THEN
//                (* Check if USB device is available *)
//                IF (brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[1])) > 0) THEN
//                    (* USB is available proceed with import: select all files on the USB and trigger copy command *)
//                    
//                    IF (MpFileManagerUIConnect.DeviceList.SelectedIndex <> 1) THEN
//                        MpFileManagerUIConnect.DeviceList.SelectedIndex := 1;
//                        MpFileManagerUIConnect.File.MultiSelect := FALSE;
//                    ELSIF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE THEN
//                        
//                        IF NOT MpFileManagerUIConnect.File.MultiSelect THEN
//                            MpFileManagerUIConnect.File.MultiSelect := TRUE;
//                            FOR Index := 0 TO ((SIZEOF(MpFileManagerUIConnect.File.List.Items)/SIZEOF(MpFileManagerUIConnect.File.List.Items[0])) - 1) DO
//                                MpFileManagerUIConnect.File.List.Items[Index].IsSelected := TRUE;
//                            END_FOR
//                        ELSIF (brsstrlen(ADR(MpFileManagerUIConnect.File.List.Items[Index].Name)) = 0) THEN
//                            (* No files to copy, cancel operation *)
//                            hmiFile.Commands.ImportFromUSB := FALSE;
//                        ELSE
//                            MpFileManagerUIConnect.File.Copy := TRUE;
//                            hmiFile.Status.CopyStep := FILE_COPY_FROM_USB;
//                            hmiFile.Commands.ImportFromUSB := FALSE;
//                        END_IF
//                        
//                    END_IF
//                ELSE
//                    (* No USB disk available, cancel operation *)
//                    hmiFile.Commands.ImportFromUSB := FALSE;
//                END_IF
//                
//            END_IF
//			
//        FILE_COPY_TO_USB: (* Navigate to USB device and paste files *)
//            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
//                
//                IF (MpFileManagerUIConnect.DeviceList.SelectedIndex <> 1) THEN
//                    MpFileManagerUIConnect.DeviceList.SelectedIndex := 1;
//                    MpFileManagerUIConnect.File.MultiSelect := FALSE;
//                ELSE
//                    MpFileManagerUIConnect.File.Paste := TRUE;
//                END_IF
//                
//            END_IF
//            
//            IF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_PASTE THEN
//                hmiFile.Status.CopyStep := FILE_COPY_BUSY;
//            END_IF;
//
//        FILE_COPY_FROM_USB: (* Navigate to CF device and paste files *)
//            IF (MpFileManagerUIConnect.DeviceList.SelectedIndex <> 0) THEN
//                MpFileManagerUIConnect.DeviceList.SelectedIndex := 0;
//                MpFileManagerUIConnect.File.MultiSelect := FALSE;
//            ELSIF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE) THEN
//                MpFileManagerUIConnect.File.Paste := TRUE;
//            END_IF
//            
//            IF (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_PASTE) THEN
//                hmiFile.Status.CopyStep := FILE_COPY_BUSY;
//            END_IF
//	
//        FILE_COPY_BUSY: (* Wait for copying done *)
//            IF (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_OVERWRITE) OR (MpFileManagerUIConnect.MessageBox.Type = mpFILE_MSG_BUSY) THEN
//                (* TODO: Replace by confirm dialog *)
//                MpFileManagerUIConnect.MessageBox.Confirm := TRUE;
//            ELSIF MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE THEN
//                hmiFile.Status.CopyStep := FILE_COPY_WAIT;
//            END_IF
//        
//    END_CASE
	
END_ACTION
