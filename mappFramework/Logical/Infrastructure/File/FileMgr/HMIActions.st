ACTION FormatDeviceDataProvider:
    
	// Select CF device if USB device is not available
    FOR i := 0 TO MAX_IDX_USB_DEV_LIST DO
        IF gUSBAvailable[i] THEN
	
			HmiFile.Status.DeviceDataProvider[i + USBOffset] := '{"value":"USB';
            brsitoa(i + 1, ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset])));
            
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset]), ADR('","text":"USB'));
            brsitoa(i + 1, ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset])));
            brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset]), ADR('"}'));
           
			PathCheck.DeviceList.DeviceNames[i + USBOffset] := 'USB';
			brsitoa(i + 1, ADR(PathCheck.DeviceList.DeviceNames[i + USBOffset]) + brsstrlen(ADR(PathCheck.DeviceList.DeviceNames[i + USBOffset])));
        ELSE
			brsmemset(ADR(HmiFile.Status.DeviceDataProvider[i + USBOffset]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[i + USBOffset]));
            brsmemset(ADR(PathCheck.DeviceList.DeviceNames[i + USBOffset]), 0, SIZEOF(PathCheck.DeviceList.DeviceNames[i + USBOffset]));
        END_IF
    END_FOR
	
	MaxDeviceNameIndex := ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1);
	//Check initilized folder for existance and remove any from the device list that don't exist	
	IF DirInfo_0.status = ERR_OK  THEN		
		IF PathCheck.DeviceList.DeviceNames[DeviceListCount] = '' THEN
			//Delete entries past the actual number of devices found
			FOR i:=Index TO MaxDeviceNameIndex DO 
				MpFileManagerUIConnect.DeviceList.DeviceNames[i] := '';
			END_FOR
			Index := -1;
			DeviceListCount := -1;			
		END_IF	
		// copy device name from source list into the actual device list 
		MpFileManagerUIConnect.DeviceList.DeviceNames[Index] := PathCheck.DeviceList.DeviceNames[DeviceListCount];		
		Index := Index + 1;	

		DeviceListCount := DeviceListCount + 1;
		IF (DeviceListCount > MaxDeviceNameIndex) THEN
			DeviceListCount := 0;
		END_IF
		IF (Index > MaxDeviceNameIndex) THEN
			Index := 0;
		END_IF
	ELSIF DirInfo_0.status = fiERR_DIR_NOT_EXIST  THEN
		DeviceListCount := DeviceListCount + 1;
		IF DeviceListCount > ((SIZEOF(PathCheck.DeviceList.DeviceNames) / SIZEOF(PathCheck.DeviceList.DeviceNames[0])) - 1) THEN
			DeviceListCount := 0;
		END_IF
	END_IF		
	
	DirInfo_0(enable:= TRUE, pDevice := ADR('UserPartition'), pPath := ADR(PathCheck.Folder[DeviceListCount]));
		
	// Configure visible device list
	HmiFile.Status.TableConfig[0] := '{ "specRows": [{"from":';
	FOR i := 0 TO MaxDeviceNameIndex DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			DeviceCount := i + 1;
		END_IF
	END_FOR
	brsitoa((DeviceCount), ADR(HmiFile.Status.TableConfig[0]) + brsstrlen(ADR(HmiFile.Status.TableConfig[0])));
    brsstrcat(ADR(HmiFile.Status.TableConfig[0]),  ADR(',"to":9, "visible":false}]}'));
	   
    // Configure visible file list
	HmiFile.Status.TableConfig[1] := '{ "specRows": [{"from":';
    brsitoa((MpFileManagerUIConnect.File.PathInfo.FileCount + MpFileManagerUIConnect.File.PathInfo.FolderCount), ADR(HmiFile.Status.TableConfig[1]) + brsstrlen(ADR(HmiFile.Status.TableConfig[1])));
    brsstrcat(ADR(HmiFile.Status.TableConfig[1]),  ADR(',"to":49, "visible":false}]}'));
    
END_ACTION

ACTION FileManager:
	
    MpFileManagerUI_0.MpLink := ADR(gMpLinkFileManagerUIFile);
    MpFileManagerUI_0.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUI_0();
	
    FOR i := 0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1) DO
        HmiFile.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
        HmiFile.Status.TimeStamps[i] := MpFileManagerUIConnect.File.List.Items[i].LastModified;
        HmiFile.Status.Size[i] := REAL_TO_UDINT(UDINT_TO_REAL(MpFileManagerUIConnect.File.List.Items[i].Size) * 0.001);
	
		// Set image array based on item type
		IF MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN
			HmiFile.Status.Type[i] := FOLDER;
		ELSIF NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
			HmiFile.Status.Type[i] := FILE_SELECTED;
		ELSE
			HmiFile.Status.Type[i] := FILE;
		END_IF
	
		// Set file selected when the table is clicked Single and MultiSelect
		IF HmiFile.Status.DeleteStep = FILE_DELETE_WAIT THEN
			IF (MpFileManagerUIConnect.File.MultiSelect = FALSE) THEN
				MpFileManagerUIConnect.File.List.Items[i].IsSelected := (i = HmiFile.Status.SelectedIndex);
            ELSIF (MpFileManagerUIConnect.File.MultiSelect = TRUE) AND (HmiFile.Commands.MultiSelect = TRUE) THEN
				IF (i = HmiFile.Status.SelectedIndex) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
                    MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
                    HmiFile.Commands.MultiSelect := FALSE;
                ELSIF (i = HmiFile.Status.SelectedIndex) AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
                    MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
					HmiFile.Commands.MultiSelect := FALSE;
				END_IF
			END_IF
		END_IF
    END_FOR
    
	// Read currently selected device name for HMI
	HmiFile.Status.DeviceName := MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex];
	
	// Read if current selected object is folder
	HmiFile.Status.IsFolder := MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].IsFolder;
	
	// Control the folder structure when entering and leaving folders
	IF (HmiFile.Commands.EnterFolder) AND MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].IsFolder THEN
		HmiFile.Commands.EnterFolder := FALSE;
		MpFileManagerUIConnect.File.EnterFolder := TRUE;
		FolderDepthCount := FolderDepthCount + 1;
	ELSE
		HmiFile.Commands.EnterFolder := FALSE;
	END_IF
	
	IF EDGEPOS(HmiFile.Commands.FolderUp) AND (HmiFile.Status.BackButton > 0) THEN
		HmiFile.Commands.FolderUp := FALSE;
		MpFileManagerUIConnect.File.FolderUp := TRUE;
		FolderDepthCount := FolderDepthCount - 1;
	END_IF
	
	HmiFile.Status.BackButton := (FolderDepthCount > 0);
    
END_ACTION