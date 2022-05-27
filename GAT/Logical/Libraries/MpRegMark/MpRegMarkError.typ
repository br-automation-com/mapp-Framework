
TYPE
    MpRegMarkErrorEnum : 
        ( (* Error numbers of library MpRegMark *)
        mpREGMARK_NO_ERROR := 0, (* No error *)
        mpREGMARK_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpREGMARK_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpREGMARK_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpREGMARK_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpREGMARK_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpREGMARK_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpREGMARK_ERR_CONFIG_NULL := -1064239096, (* Configuration structure is null pointer [Error: 8, 0xc0910008] *)
        mpREGMARK_ERR_CONFIG_NO_PV := -1064239095, (* Configuration pointer not PV [Error: 9, 0xc0910009] *)
        mpREGMARK_ERR_CONFIG_LOAD := -1064239094, (* Error loading configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 10, 0xc091000a] *)
        mpREGMARK_WRN_CONFIG_LOAD := -2137980917, (* Warning loading configuration [Warning: 11, 0x8091000b] *)
        mpREGMARK_ERR_CONFIG_SAVE := -1064239092, (* Error saving configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 12, 0xc091000c] *)
        mpREGMARK_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpREGMARK_ERR_CONFIG_PAR := -1064018944, (* The specified configuration parameters are invalid. [Error: 23552, 0xc0945c00] *)
        mpREGMARK_WRN_CONFIG_NOT_SAVED := -2137760767, (* A configuration parameter was not applied by the component. [Warning: 23553, 0x80945c01] *)
        mpREGMARK_ERR_LIBRARY_MISSING := -1064018942, (* Library {2:LibName} is not in the target system. [Error: 23554, 0xc0945c02] *)
        mpREGMARK_ERR_AXIS_ERROR := -1064018941, (* Axis error. [Error: 23555, 0xc0945c03] *)
        mpREGMARK_ERR_COMMAND_INVALID := -1064018940, (* Specified command "{2:Command}" cannot be executed at this time. [Error: 23556, 0xc0945c04] *)
        mpREGMARK_WRN_MISSED_MARK := -2137760763, (* No valid registration mark was found. [Warning: 23557, 0x80945c05] *)
        mpREGMARK_ERR_AR_NOT_SUPPORTED := -1064018938 (* The io channel mapping via the configuration is not supported for an AR version below 4.72. [Error: 23558, 0xc0945c06] *)
        );
END_TYPE
