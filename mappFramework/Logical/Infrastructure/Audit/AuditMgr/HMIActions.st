ACTION CustomEvents:

	// sample code how custom event function can be triggered
	IF EDGEPOS(CustomEvent[0].Set) THEN
		MpAuditCustomEvent(gMpLinkCustomEvents,CustomEvent[0].Type,CustomEvent[0].Msg,CustomEvent[0].Comment);
	END_IF
	
	IF EDGENEG(CustomEvent[1].Set) THEN
		MpAuditCustomEvent(gMpLinkCustomEvents,CustomEvent[1].Type,CustomEvent[1].Msg,CustomEvent[1].Comment);
	END_IF


END_ACTION

ACTION QueryTableConfig:
    
	// Configure visible list
	HmiAudit.Status.TableConfig[0] := '{ "specRows": [{"from":';
	HmiAudit.Status.Query.QueryCount := 0;
    FOR i := 0 TO 9 DO
        IF HmiAudit.Status.Query.Text[i] <> "" THEN
			HmiAudit.Status.Query.QueryCount := i + 1;
		END_IF
    END_FOR
    brsitoa((HmiAudit.Status.Query.QueryCount), ADR(HmiAudit.Status.TableConfig[0]) + brsstrlen(ADR(HmiAudit.Status.TableConfig[0])));
	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(',"to":19, "visible":false}]'));
	// hide operator column for the recipe query
	IF (HmiAudit.Status.Query.Option = 0) THEN 
    	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(', "specColumns": [ {"from":1, "to":1, "visible":true}]'));
	ELSIF (HmiAudit.Status.Query.Option = 1) THEN 
		brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR(', "specColumns": [ {"from":1, "to":1, "visible":false}]'));
	END_IF	

	brsstrcat(ADR(HmiAudit.Status.TableConfig[0]),  ADR('}'));
END_ACTION
