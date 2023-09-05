ACTION VC4_Init:	
	
	brsmemset(ADR(HmiFile.Status.FifoSelect[0]), 0, SIZEOF(HmiFile.Status.FifoSelect));	
	IF HmiFile.Parameters.Fifo.Enable THEN
		HmiFile.Status.FifoSelect[HmiFile.Parameters.Fifo.SelectedDevice] := 1;
	END_IF;
	
	HmiFile.Status.FIFOLayerStatus := HIDE;
	
END_ACTION

ACTION VC4_Cyclic:

	MpFileManagerUISys.MpLink := ADR(gMpLinkFileManagerUIFile);
	MpFileManagerUISys.UIConnect := ADR(MpFileManagerUIConnect);
	MpFileManagerUISys();

	FOR i := 0 TO ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1) DO
		HmiFile.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
		
		// Time Stamp
		HmiFile.Status.TimeStamps[i] := DT_TO_STRING(MpFileManagerUIConnect.File.List.Items[i].LastModified);			
		HmiFile.Status.TimeStamps[i] := RIGHT(HmiFile.Status.TimeStamps[i], 19);

		// File size
		HmiFile.Status.Size[i] := REAL_TO_STRING(UDINT_TO_REAL(MpFileManagerUIConnect.File.List.Items[i].Size) * 0.001);

		// Set image array based on item type
		IF MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN
			HmiFile.Status.Type[i] := FOLDER;
		ELSIF NOT MpFileManagerUIConnect.File.List.Items[i].IsFolder AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
			HmiFile.Status.Type[i] := FILE_SELECTED;
		ELSE
			HmiFile.Status.Type[i] := FILE;
		END_IF		
		
		// Fill file info string arrays
		IF MpFileManagerUIConnect.File.List.Items[i].IsFolder THEN			
			HmiFile.Status.InfoFile.Type[i] := 'FOLDER'; 
		ELSE 
			HmiFile.Status.InfoFile.Type[i] := 'FILE';
		END_IF		
		IF MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN			
			HmiFile.Status.InfoFile.IsSelected[i] := '+';
		ELSE				
			HmiFile.Status.InfoFile.IsSelected[i] := '-';
		END_IF	   
	
		// If file does not exist, clear objects
		IF HmiFile.Status.FileNames[i] = '' THEN
			HmiFile.Status.TimeStamps[i] := '';
			HmiFile.Status.Size[i] := '';
			HmiFile.Status.InfoFile.IsSelected[i] := '';
			HmiFile.Status.InfoFile.Type[i] := '';
		END_IF;	
		
	END_FOR

	// Mutli selection
	IF (NOT MpFileManagerUIConnect.File.MultiSelect) THEN
		MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].IsSelected := TRUE;	
	ELSIF (MpFileManagerUIConnect.File.MultiSelect) AND HmiFile.Commands.FileList.Clicked THEN
		MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].IsSelected := NOT MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].IsSelected;
	END_IF
	HmiFile.Commands.FileList.Clicked := FALSE;
	

	// Read currently selected device name for HMI
	IF (MpFileManagerUIConnect.DeviceList.SelectedIndex >= (SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0]))) THEN
		MpFileManagerUIConnect.DeviceList.SelectedIndex := 0;
	END_IF
	HmiFile.Status.DeviceName := MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex];

	// Read if current selected object is folder
	IF (HmiFile.Status.SelectedIndex >= (SIZEOF(MpFileManagerUIConnect.File.List.Items) / SIZEOF(MpFileManagerUIConnect.File.List.Items[0]))) THEN
		HmiFile.Status.SelectedIndex := 0;
	END_IF
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
	
	// File SelectedIndex manager
	IF HmiFile.Commands.FileList.PageUp THEN 
		HmiFile.Commands.FileList.PageUp := FALSE;	
		HmiFile.Status.SelectedIndex := 0;	
		
	ELSIF HmiFile.Commands.FileList.PageDown THEN
		HmiFile.Commands.FileList.PageDown := FALSE;
		HmiFile.Status.SelectedIndex := ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1);
		
	ELSIF HmiFile.Commands.FileList.StepUp THEN
		HmiFile.Commands.FileList.StepUp := FALSE;
		IF HmiFile.Status.SelectedIndex <> 0 THEN
			HmiFile.Status.SelectedIndex := HmiFile.Status.SelectedIndex - 1;
		END_IF		
		
	ELSIF HmiFile.Commands.FileList.StepDown THEN
		HmiFile.Commands.FileList.StepDown := FALSE;		
		IF HmiFile.Status.SelectedIndex <> ((SIZEOF(HmiFile.Status.FileNames)/SIZEOF(HmiFile.Status.FileNames[0])) - 1) THEN
			HmiFile.Status.SelectedIndex := HmiFile.Status.SelectedIndex + 1;
		END_IF		
	END_IF

	HmiFile.Status.DefaultFileSelected := ((MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].Name = 'Default.par') OR 
		(MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].Name = 'Machine.mcfg')) AND
		MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;
	
END_ACTION

ACTION FormatDeviceDataProvider:
	
	// Select CF device if USB device is not available
	FOR i := 0 TO IDX_USB_DEV_LIST DO
		tempIdx := (i + USBOffset);

		IF gUSBAvailable[i] THEN
			PathCheck.DeviceList.DeviceNames[tempIdx] := 'USB';
			brsitoa(i + 1, ADR(PathCheck.DeviceList.DeviceNames[tempIdx]) + brsstrlen(ADR(PathCheck.DeviceList.DeviceNames[tempIdx])));
		ELSE
			brsmemset(ADR(HmiFile.Status.DeviceDataProvider[tempIdx]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[tempIdx]));
			brsmemset(ADR(PathCheck.DeviceList.DeviceNames[tempIdx]), 0, SIZEOF(PathCheck.DeviceList.DeviceNames[tempIdx]));
		END_IF
	END_FOR

	MaxDeviceNameIndex := ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1);
	// Check initilized folder for existance and remove any from the device list that don't exist
	IF (IdentStatus = 0) THEN
		// Copy device name from source list into the actual device list
		MpFileManagerUIConnect.DeviceList.DeviceNames[Index] := PathCheck.DeviceList.DeviceNames[DeviceListCount];
		Index := Index + 1;
		DeviceListCount := DeviceListCount + 1;

		IF (DeviceListCount > ((SIZEOF(PathCheck.DeviceList.DeviceNames) / SIZEOF(PathCheck.DeviceList.DeviceNames[0])) - 1)) THEN
			DeviceListCount := 0;
		END_IF
		IF (Index > MaxDeviceNameIndex) THEN
			Index := 0;
		END_IF
	ELSIF (IdentStatus = 3324) THEN
		DeviceListCount := DeviceListCount + 1;
		IF DeviceListCount > ((SIZEOF(PathCheck.DeviceList.DeviceNames) / SIZEOF(PathCheck.DeviceList.DeviceNames[0])) - 1) THEN
			// Delete entries past the actual number of devices found
			FOR i:=Index TO MaxDeviceNameIndex DO
				MpFileManagerUIConnect.DeviceList.DeviceNames[i] := '';
			END_FOR
			DeviceListCount := 0;
			Index := 0;
		END_IF
	END_IF

	IdentStatus := ST_ident(ADR(PathCheck.PrgName[DeviceListCount]),0,ADR(Ident));
	
	// Create device data provider for FIFO drop down
	FOR i := 0 TO MaxDeviceNameIndex DO
		IF (MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '') THEN
			HmiFile.Status.DeviceDataProvider[i] := MpFileManagerUIConnect.DeviceList.DeviceNames[i];
		ELSE
			brsmemset(ADR(HmiFile.Status.DeviceDataProvider[i]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[i]));
		END_IF
	END_FOR	
	
END_ACTION