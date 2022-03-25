ACTION FormatDeviceDataProvider:
    
	// Select CF device if USB device is not available
    FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
        IF gUSBAvailable[Index] THEN
	
            brsstrcpy(ADR(HmiFile.Status.DeviceDataProvider[Index + 7]), ADR('{"value":"USB'));
            brsitoa(Index + 1, ADR(HmiFile.Status.DeviceDataProvider[Index + 7]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[Index + 7])));
            
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[Index + 7]), ADR('","text":"USB'));
            brsitoa(Index + 1, ADR(HmiFile.Status.DeviceDataProvider[Index + 7]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[Index + 7])));
            brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[Index + 7]), ADR('"}'));
           
		    brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]), ADR('USB'));
            brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7])));
        ELSE
            brsmemset(ADR(HmiFile.Status.DeviceDataProvider[Index + 7]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[Index + 7]));
            brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 7]));
        END_IF
    END_FOR
	
	// Configure visible device list
    brsstrcpy(ADR(HmiFile.Status.TableConfig[0]), ADR('{ "specRows": [{"from":'));
	FOR i := 0 TO 9 DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			DeviceCount := i + 1;
		END_IF
	END_FOR
	brsitoa((DeviceCount), ADR(HmiFile.Status.TableConfig[0]) + brsstrlen(ADR(HmiFile.Status.TableConfig[0])));
    brsstrcat(ADR(HmiFile.Status.TableConfig[0]),  ADR(',"to":9, "visible":false}]}'));
	
    
    // Configure visible file list
    brsstrcpy(ADR(HmiFile.Status.TableConfig[1]), ADR('{ "specRows": [{"from":'));
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
				IF (i = HmiFile.Parameters.SelectedIndex) THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
				ELSE
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
				END_IF
			ELSIF (MpFileManagerUIConnect.File.MultiSelect = TRUE) AND HmiFile.Commands.MultiSelect THEN
				IF (i = HmiFile.Parameters.SelectedIndex) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
					HmiFile.Commands.MultiSelect := FALSE;
				ELSIF (i = HmiFile.Parameters.SelectedIndex) AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
					MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
					HmiFile.Commands.MultiSelect := FALSE;
				END_IF
			END_IF
		END_IF
    END_FOR
    
	// Read currently selected device name for HMI
	HmiFile.Status.DeviceName := MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex];
	
	// Read if current selected object is folder
	HmiFile.Status.IsFolder := MpFileManagerUIConnect.File.List.Items[HmiFile.Parameters.SelectedIndex].IsFolder;
	
	// Control the folder structure when entering and leaving folders
	IF (HmiFile.Commands.EnterFolder) AND MpFileManagerUIConnect.File.List.Items[HmiFile.Parameters.SelectedIndex].IsFolder THEN
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
	
	IF FolderDepthCount > 0 THEN
		HmiFile.Status.BackButton := TRUE;
	ELSE
		HmiFile.Status.BackButton := FALSE;
	END_IF
    
END_ACTION