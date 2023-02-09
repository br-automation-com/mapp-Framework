ACTION ReportFormat:

	// If the current format and the selected format do not match, disable the function block for a cycle and make the change
	IF HmiReport.Parameters.UseAdvancedFormat AND (HmiReport.Status.CurrentFormat = FORMAT_SIMPLE) THEN
		MpReportCore_0.Enable := FALSE;
		MpReportCore_0.MpLink := ADR(gMpLinkAdvancedReport);
		HmiReport.Parameters.Name := 'AdvancedReport';
		HmiReport.Status.CurrentFormat := FORMAT_ADVANCED;
	ELSIF NOT HmiReport.Parameters.UseAdvancedFormat AND (HmiReport.Status.CurrentFormat = FORMAT_ADVANCED) THEN
		MpReportCore_0.Enable := FALSE;
		MpReportCore_0.MpLink := ADR(gMpLinkSimpleReport);
		HmiReport.Parameters.Name := 'SimpleReport';		
		HmiReport.Status.CurrentFormat := FORMAT_SIMPLE;
	ELSE
		MpReportCore_0.Enable := TRUE;
	END_IF
	
END_ACTION

ACTION ReportFileExplorer:
	
	// Connections between the HMI structure and the report function block
	HmiReport.Status.Busy := MpReportCore_0.CommandBusy;
	HmiReport.Status.Error := MpReportCore_0.Error;
	MpReportCore_0.Language := ADR(HmiReport.Parameters.SelectedLanguage);

	// Set or reset bits based on when a report can be created, deleted, and/or viewed.
	HmiReport.Status.CreateAllowed := NOT(MpReportCore_0.CommandBusy);
	HmiReport.Status.ViewAllowed := (MpFileManagerUIConnect.File.List.Items[HmiReport.Status.SelectedIndex].ItemType = mpFILE_ITEM_TYPE_USER1);
	HmiReport.Status.DeleteAllowed := (MpFileManagerUIConnect.File.List.Items[HmiReport.Status.SelectedIndex].ItemType = mpFILE_ITEM_TYPE_USER1);

	// If the selected index on screen matches the index of a given file, mark that file as selected in the UIConnect structure
	FOR i := 0 TO ((SIZEOF(HmiReport.Status.FileNames)/SIZEOF(HmiReport.Status.FileNames[0])) - 1) DO
		IF (i = HmiReport.Status.SelectedIndex) AND NOT MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
			MpFileManagerUIConnect.File.List.Items[i].IsSelected := TRUE;
		ELSIF (i <> HmiReport.Status.SelectedIndex) AND MpFileManagerUIConnect.File.List.Items[i].IsSelected THEN
			MpFileManagerUIConnect.File.List.Items[i].IsSelected := FALSE;
		END_IF
	END_FOR

	// For every file, record its name, timestamp, size, and path
	FOR i := 0 TO ((SIZEOF(HmiReport.Status.FileNames)/SIZEOF(HmiReport.Status.FileNames[0])) - 1) DO
		HmiReport.Status.FileNames[i] := MpFileManagerUIConnect.File.List.Items[i].Name;
		HmiReport.Status.TimeStamps[i] := MpFileManagerUIConnect.File.List.Items[i].LastModified;
		HmiReport.Status.Size[i] := MpFileManagerUIConnect.File.List.Items[i].Size;
		// Concatonate strings to form the file path
		HmiReport.Status.TempFilePath[i] := '/FileDevice:';
		brsstrcat(ADR(HmiReport.Status.TempFilePath[i]),ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]));
		brsstrcat(ADR(HmiReport.Status.TempFilePath[i]),ADR('/'));
		brsstrcat(ADR(HmiReport.Status.TempFilePath[i]),ADR(HmiReport.Status.FileNames[i]));
		HmiReport.Status.FilePath[i] := HmiReport.Status.TempFilePath[i];
	END_FOR

	// Create a file path to be linked to the pdf viewer
	HmiReport.Parameters.PathOfReportToView := HmiReport.Status.FilePath[HmiReport.Status.SelectedIndex];
	
	// Add USB devices if available
	FOR i := 0 TO IDX_USB_DEV_LIST DO	 
		tempDeviceIndex := i + 1;
		IF gUSBAvailable[i] THEN			
			MpFileManagerUIConnect.DeviceList.DeviceNames[tempDeviceIndex] := 'USB';
			brsitoa(i + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[tempDeviceIndex]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[tempDeviceIndex])));
		ELSE
			MpFileManagerUIConnect.DeviceList.DeviceNames[tempDeviceIndex] := '';
		END_IF
	END_FOR	
	
	// Create array for the file device table
	IF ((MpFileManagerUIConnect.DeviceList.SelectedIndex <> HmiReport.Status.LastSelectedDeviceIndex) AND (MpFileManagerUIConnect.Status = mpFILE_UI_STATUS_IDLE)) THEN
		HmiReport.Status.LastSelectedDeviceIndex := MpFileManagerUIConnect.DeviceList.SelectedIndex;
		HmiReport.Status.LastSelectedIndex := HmiReport.Status.LastSelectedIndex + 1;
	END_IF
	
	// Configure device list so that only the rows with entries will show
	HmiReport.Status.TableConfig[0] := '{ "specRows": [{"from":';
	FOR i := 0 TO ((SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames)/SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[0])) - 1) DO
		IF MpFileManagerUIConnect.DeviceList.DeviceNames[i] <> '' THEN
			DeviceCount := i + 1;
		END_IF
	END_FOR
	brsitoa((DeviceCount), ADR(HmiReport.Status.TableConfig[0]) + brsstrlen(ADR(HmiReport.Status.TableConfig[0])));
	brsstrcat(ADR(HmiReport.Status.TableConfig[0]), ADR(',"to":9, "visible":false}]}'));

	// Configure file list so that only the rows with entries will show
	ItemCount := MpFileManagerUIConnect.File.PathInfo.FileCount + MpFileManagerUIConnect.File.PathInfo.FolderCount;
	HmiReport.Status.TableConfig[1] := '{ "specRows": [{"from":';
	brsitoa((ItemCount), ADR(HmiReport.Status.TableConfig[1]) + brsstrlen(ADR(HmiReport.Status.TableConfig[1])));
	brsstrcat(ADR(HmiReport.Status.TableConfig[1]), ADR(',"to":50, "visible":false}]}'));

	// If more than 50 items exist, set the File OverMax flag (used for page up/down buttons)
	HmiReport.Status.FileOverMax := ItemCount > 50;
	
	// Set file device to selected
	MpReportCore_0.DeviceName := ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[MpFileManagerUIConnect.DeviceList.SelectedIndex]);
	
	// Sort reports for next cycle
	IF HmiReport.Parameters.SortType = 'NameAsc' THEN
		MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_NAME_ASC;
	ELSIF HmiReport.Parameters.SortType = 'NameDesc' THEN
			MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_NAME_DESC;
	ELSIF HmiReport.Parameters.SortType = 'DateAsc' THEN
			MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_ASC;
	ELSIF HmiReport.Parameters.SortType = 'DateDesc' THEN
			MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_DESC;
	ELSIF HmiReport.Parameters.SortType = 'SizeAsc' THEN
			MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_SIZE_ASC;
	ELSIF HmiReport.Parameters.SortType = 'SizeDesc' THEN
			MpFileManagerUIConnect.File.SortOrder := mpFILE_SORT_BY_SIZE_DES;
	END_IF
	
END_ACTION