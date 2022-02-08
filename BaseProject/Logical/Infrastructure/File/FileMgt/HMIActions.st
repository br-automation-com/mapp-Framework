
ACTION FormatDeviceDataProvider: 
    
	// Select CF device if USB device is not available 
    FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
        IF gbUSBAvail[Index] THEN
		
            brsstrcpy(ADR(hmiFile.Status.DeviceDataProvider[Index + 7]), ADR('{"value":"USB'));
            brsitoa(Index + 1, ADR(hmiFile.Status.DeviceDataProvider[Index + 7]) + brsstrlen(ADR(hmiFile.Status.DeviceDataProvider[Index + 7])));
            
			brsstrcat(ADR(hmiFile.Status.DeviceDataProvider[Index + 7]), ADR('","text":"USB'));
            brsitoa(Index + 1, ADR(hmiFile.Status.DeviceDataProvider[Index + 7]) + brsstrlen(ADR(hmiFile.Status.DeviceDataProvider[Index + 7])));
            brsstrcat(ADR(hmiFile.Status.DeviceDataProvider[Index + 7]), ADR('"}'));
           
		    brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]), ADR('USB'));
            brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7])));
        ELSE
            brsmemset(ADR(hmiFile.Status.DeviceDataProvider[Index + 7]), 0, SIZEOF(hmiFile.Status.DeviceDataProvider[Index + 7]));
            brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]));
        END_IF
    END_FOR
    
    // Configure visible file list 
    brsstrcpy(ADR(hmiFile.Status.TableConfig), ADR('{ "specRows": [{"from":'));
    brsitoa((MpFileManagerUIConnect.File.PathInfo.FileCount + MpFileManagerUIConnect.File.PathInfo.FolderCount), ADR(hmiFile.Status.TableConfig) + brsstrlen(ADR(hmiFile.Status.TableConfig)));
    brsstrcat(ADR(hmiFile.Status.TableConfig),  ADR(',"to":49, "visible":false}]}'));
    
END_ACTION

ACTION FileManager:
	
    MpFileManagerUI_0.MpLink := ADR(gFileMgrUIMpLink);
    MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
    MpFileManagerUI_0();
    FOR i:=0 TO ((SIZEOF(hmiFile.Status.FileNames)/SIZEOF(hmiFile.Status.FileNames[0]))-1) DO
        hmiFile.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
        hmiFile.Status.TimeStamps[i] := MpFileManagerUIConnect.File.List.Items[i].LastModified;
        hmiFile.Status.Size[i] := REAL_TO_UDINT(MpFileManagerUIConnect.File.List.Items[i].Size * 0.001);
		
		// Set image array based on item type 
		IF MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN
			hmiFile.Status.Type[i] := FOLDER;
		ELSIF NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN	
			hmiFile.Status.Type[i] := FILE_SELECTED;
		ELSE	
			hmiFile.Status.Type[i] := FILE;
		END_IF	
		
		// Set file selected when the table is clicked Single and MultiSelect 
		IF hmiFile.Status.DeleteStep = FILE_DELETE_WAIT THEN
			IF (MpFileManagerUIConnect.File.MultiSelect = FALSE) THEN
				IF (i = hmiFile.Parameters.SelectedIndex) THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
				ELSE	
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
				END_IF
			ELSIF (MpFileManagerUIConnect.File.MultiSelect = TRUE) AND hmiFile.Commands.MultiSelect THEN			
				IF (i = hmiFile.Parameters.SelectedIndex) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
					hmiFile.Commands.MultiSelect := FALSE;
				ELSIF (i = hmiFile.Parameters.SelectedIndex) AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
					hmiFile.Commands.MultiSelect := FALSE;
				END_IF
			END_IF
		END_IF
    END_FOR
    
	// Read currently selected device name for HMI 
	hmiFile.Status.DeviceName := MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex];
	
	// Read if current selected object is folder 
	hmiFile.Status.IsFolder := MpFileManagerUIConnect.File.List.Items[hmiFile.Parameters.SelectedIndex].IsFolder;
	
	// Control the folder structure when entering and leaving folders 
	IF (hmiFile.Commands.EnterFolder) AND MpFileManagerUIConnect.File.List.Items[hmiFile.Parameters.SelectedIndex].IsFolder THEN
		hmiFile.Commands.EnterFolder := FALSE;
		MpFileManagerUIConnect.File.EnterFolder := TRUE;
		FolderDepthCount := FolderDepthCount + 1;
	ELSE
		hmiFile.Commands.EnterFolder := FALSE;
	END_IF
	
	IF EDGEPOS(hmiFile.Commands.FolderUp) AND (hmiFile.Status.BackButton > 0) THEN
		hmiFile.Commands.FolderUp := FALSE;
		MpFileManagerUIConnect.File.FolderUp := TRUE;
		FolderDepthCount := FolderDepthCount - 1;
	END_IF	
	
	IF FolderDepthCount > 0 THEN 	
		hmiFile.Status.BackButton := TRUE;
	ELSE
		hmiFile.Status.BackButton := FALSE;
	END_IF		
    
END_ACTION