ACTION FormatDeviceDataProvider:

	// Select CF device if USB device is not available
	FOR i := 0 TO IDX_USB_DEV_LIST DO
		tempIdx := (i + USBOffset);

		IF gUSBAvailable[i] THEN

			HmiFile.Status.DeviceDataProvider[tempIdx] := '{"value":"USB';
			brsitoa(i + 1, ADR(HmiFile.Status.DeviceDataProvider[tempIdx]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[tempIdx])));

			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[tempIdx]), ADR('","text":"USB'));
			brsitoa(i + 1, ADR(HmiFile.Status.DeviceDataProvider[tempIdx]) + brsstrlen(ADR(HmiFile.Status.DeviceDataProvider[tempIdx])));
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[tempIdx]), ADR('"}'));

			PathCheck.DeviceList.DeviceNames[tempIdx] := 'USB';
			brsitoa(i + 1, ADR(PathCheck.DeviceList.DeviceNames[tempIdx]) + brsstrlen(ADR(PathCheck.DeviceList.DeviceNames[tempIdx])));
		ELSE
			brsmemset(ADR(HmiFile.Status.DeviceDataProvider[tempIdx]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[tempIdx]));
			brsmemset(ADR(PathCheck.DeviceList.DeviceNames[tempIdx]), 0, SIZEOF(PathCheck.DeviceList.DeviceNames[tempIdx]));
		END_IF
	END_FOR

	//Check initilized folder for existance and remove any from the device list that don't exist
	MaxDeviceNameIndex := ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames) / SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1);
	NextOpenIndex := 0;
	FOR index := 0 TO MaxDeviceNameIndex DO	
		IdentStatus := ST_ident(ADR(PathCheck.PrgName[index]),0,ADR(Ident));
		//Assign device name to next available slot in table according to if the path is valid
		IF (IdentStatus = 0) THEN		//path is valid
			MpFileManagerUIConnect.DeviceList.DeviceNames[NextOpenIndex] := PathCheck.DeviceList.DeviceNames[index + 1];
			NextOpenIndex := NextOpenIndex + 1;
		END_IF;
		//Clear the remaining index slots with invalid path checks
		IF index > NextOpenIndex THEN
			MpFileManagerUIConnect.DeviceList.DeviceNames[index] := '';
		END_IF	
	END_FOR;

	// Configure visible device list
	HmiFile.Status.TableConfig[0] := '{ "specRows": [{"from":';
	FOR i := 0 TO MaxDeviceNameIndex DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			DeviceCount := i + 1;
		END_IF
	END_FOR
	brsitoa((DeviceCount), ADR(HmiFile.Status.TableConfig[0]) + brsstrlen(ADR(HmiFile.Status.TableConfig[0])));
	brsstrcat(ADR(HmiFile.Status.TableConfig[0]), ADR(',"to":9, "visible":false}]}'));

	// Configure visible file list
	HmiFile.Status.TableConfig[1] := '{ "specRows": [{"from":';
	brsitoa((MpFileManagerUIConnect.File.PathInfo.FileCount + MpFileManagerUIConnect.File.PathInfo.FolderCount), ADR(HmiFile.Status.TableConfig[1]) + brsstrlen(ADR(HmiFile.Status.TableConfig[1])));
	brsstrcat(ADR(HmiFile.Status.TableConfig[1]), ADR(',"to":49, "visible":false}]}'));

	// Create device data provider for FIFO drop down
	FOR i := 0 TO MaxDeviceNameIndex DO
		IF (MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '') THEN
			HmiFile.Status.DeviceDataProvider[i] := '{"value":"';
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i]), ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i]));
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i]), ADR('","text":"'));
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i]), ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[i]));
			brsstrcat(ADR(HmiFile.Status.DeviceDataProvider[i]), ADR('"}'));
		ELSE
			brsmemset(ADR(HmiFile.Status.DeviceDataProvider[i]), 0, SIZEOF(HmiFile.Status.DeviceDataProvider[i]));
		END_IF
	END_FOR

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
	END_FOR


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
	HmiFile.Status.DefaultFileSelected := ((MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].Name = CONCAT(DEFAULT_PARAMETERS,PARAMETERS_FILE_EXTENSION)) OR 
																				(MpFileManagerUIConnect.File.List.Items[HmiFile.Status.SelectedIndex].Name = CONCAT(DEFAULT_MACHINE_CONFIGURATION,
																				MACHINE_CONFIG_FILE_EXTENSION))) AND MpFileManagerUIConnect.DeviceList.SelectedIndex = 0;

END_ACTION