var
	nCnt: integer;
	aTopicList: THndTopicsInfoArray;
	sHelpId: string;
	
begin
	aTopicList := HndTopicsEx.GetTopicListGenerated(False, False);
	for nCnt := 0 to length(aTopicList) - 1 do
	begin
		sHelpId := aTopicList[nCnt].HelpId;
		printfln('%s=%s.htm', [sHelpId, sHelpId]);
	end;
end.