
TYPE
	MpReportErrorEnum : 
		( (* Error numbers of library MpReport *)
		mpREPORT_NO_ERROR := 0, (* No error *)
		mpREPORT_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
		mpREPORT_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
		mpREPORT_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
		mpREPORT_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
		mpREPORT_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
		mpREPORT_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
		mpREPORT_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
		mpREPORT_ERR_TEXT_IDENT := -1064112128, (* Text not found in text system [Error: 61440, 0xc092f000] *)
		mpREPORT_ERR_LANGUAGE := -1064112127, (* Language not found [Error: 61441, 0xc092f001] *)
		mpREPORT_ERR_INVALID_FILE_DEV := -1064112126, (* Invalid file device [Error: 61442, 0xc092f002] *)
		mpREPORT_ERR_INVALID_REPORT := -1064112125, (* Invalid report name [Error: 61443, 0xc092f003] *)
		mpREPORT_ERR_GENERATE_REPORT := -1064112124 (* Error during report generation [Error: 61444, 0xc092f004] *)
		);
END_TYPE
