
TYPE
    MpBackupErrorEnum : 
        ( (* Error numbers of library MpBackup *)
        mpBACKUP_NO_ERROR := 0, (* No error *)
        mpBACKUP_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpBACKUP_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpBACKUP_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpBACKUP_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpBACKUP_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpBACKUP_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpBACKUP_ERR_CONFIG_NULL := -1064239096, (* Configuration structure is null pointer [Error: 8, 0xc0910008] *)
        mpBACKUP_ERR_CONFIG_NO_PV := -1064239095, (* Configuration pointer not PV [Error: 9, 0xc0910009] *)
        mpBACKUP_ERR_CONFIG_LOAD := -1064239094, (* Error loading configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 10, 0xc091000a] *)
        mpBACKUP_WRN_CONFIG_LOAD := -2137980917, (* Warning loading configuration [Warning: 11, 0x8091000b] *)
        mpBACKUP_ERR_CONFIG_SAVE := -1064239092, (* Error saving configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 12, 0xc091000c] *)
        mpBACKUP_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpBACKUP_ERR_INSTALL_FAILED := -1064159488, (* Installation of backup/update "{2:Name}" failed (ErrorCause: {1:ErrorNumber}) [Error: 14080, 0xc0923700] *)
        mpBACKUP_ERR_CREATE_FAILED := -1064159487, (* Creation of backup "{2:Name}" failed (ErrorCause: {1:ErrorNumber}) [Error: 14081, 0xc0923701] *)
        mpBACKUP_ERR_REQUEST_INFO_FAILED := -1064159486, (* Getting info of backup/update "{2:Name}" failed (ErrorCause: {1:ErrorNumber}) [Error: 14082, 0xc0923702] *)
        mpBACKUP_WRN_UPDATE_CHECK_FAILED := -2137901309 (* Update check failed (ErrorCause: {1:ErrorNumber}) [Warning: 14083, 0x80923703] *)
        );
END_TYPE
