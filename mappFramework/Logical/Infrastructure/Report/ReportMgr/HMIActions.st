ACTION ReportManager:
    
	// If the current format and the selected format do not match, disable the function block for a cycle and make the change
	IF HmiReport.Parameters.UseAdvancedFormat AND (CurrentFormat = FORMAT_SIMPLE) THEN
		MpReportCore_0.Enable := FALSE;
		MpReportCore_0.MpLink := ADR(gMpLinkAdvancedReport);
		MpReportCore_0.Name := ADR('AdvancedReport');
		CurrentFormat := FORMAT_ADVANCED;
	ELSIF NOT HmiReport.Parameters.UseAdvancedFormat AND (CurrentFormat = FORMAT_ADVANCED) THEN
		MpReportCore_0.Enable := FALSE;
		MpReportCore_0.MpLink := ADR(gMpLinkSimpleReport);
		MpReportCore_0.Name := ADR('SimpleReport');
		CurrentFormat := FORMAT_SIMPLE;
	ELSE
		MpReportCore_0.Enable := TRUE;		
	END_IF
	
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
		HmiReport.Status.TempFilePath[i] := '/FileDevice:mappReportFiles/';                
		brsstrcat(ADR(HmiReport.Status.TempFilePath[i]),ADR(HmiReport.Status.FileNames[i])); 
		HmiReport.Status.FilePath[i] := HmiReport.Status.TempFilePath[i];                
	END_FOR
	
	// Create a file path to be linked to the pdf viewer
	HmiReport.Parameters.PathOfReportToView := HmiReport.Status.FilePath[HmiReport.Status.SelectedIndex];
    
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
END_ACTION