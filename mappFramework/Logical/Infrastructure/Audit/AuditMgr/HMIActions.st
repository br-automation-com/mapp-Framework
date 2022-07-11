

ACTION QueryTableConfig:
    
//	// Configure visible list
//	HmiAlarmX.Status.TableConfig[0] := '{ "specRows": [{"from":';
//	HmiAlarmX.Status.Query.QueryCount := 0;
//    FOR i := 0 TO 9 DO
//        IF HmiAlarmX.Status.Query.Message[i] <> "" THEN
//			HmiAlarmX.Status.Query.QueryCount := i + 1;
//		END_IF
//    END_FOR
//    brsitoa((HmiAlarmX.Status.Query.QueryCount), ADR(HmiAlarmX.Status.TableConfig[0]) + brsstrlen(ADR(HmiAlarmX.Status.TableConfig[0])));
//    brsstrcat(ADR(HmiAlarmX.Status.TableConfig[0]),  ADR(',"to":19, "visible":false}]}'));
	
END_ACTION
