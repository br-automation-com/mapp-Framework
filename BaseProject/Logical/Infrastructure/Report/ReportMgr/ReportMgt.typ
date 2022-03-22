
TYPE
	LanguageSelect : 	STRUCT 
		LanguageSelection : ARRAY[0..1]OF STRING[80] := ['en','de'];
		SelectedIndex : INT := 0;
	END_STRUCT;
END_TYPE
