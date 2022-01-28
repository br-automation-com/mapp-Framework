
ACTION FormatDeviceDataProvider: 
    
	(* Select CF device if USB device is not available *)
    FOR Index := 0 TO MAX_IDX_USB_DEV_LIST DO
        IF gbUSBAvail[Index] THEN
            brsstrcpy(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]), ADR('{"value":"USB'));
            brsitoa(Index + 1, ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1])));
            brsstrcat(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]), ADR('","text":"USB'));
            brsitoa(Index + 1, ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]) + brsstrlen(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1])));
            brsstrcat(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]), ADR('"}'));
            brsstrcpy(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), ADR('USB'));
            brsitoa(Index + 1, ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]) + brsstrlen(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1])));
        ELSE
            brsmemset(ADR(hmiFile.Intern.DeviceDataProvider[Index + 1]), 0, SIZEOF(hmiFile.Intern.DeviceDataProvider[Index + 1]));
            brsmemset(ADR(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]), 0, SIZEOF(MpFileManagerUIConnect.DeviceList.DeviceNames[Index + 1]));
        END_IF
    END_FOR
    
    (* Configure visible file list *)
//    brsstrcpy(ADR(hmiFile.Intern.TableConfig), ADR('{ "specRows": [{"from":'));
//    brsitoa(Recipe.List.MaxSelection + 1, ADR(hmiFile.Intern.TableConfig) + brsstrlen(ADR(hmiFile.Intern.TableConfig)));
//    brsstrcat(ADR(hmiFile.Intern.TableConfig),  ADR(',"to":19, "visible":false}]}'));
    
END_ACTION