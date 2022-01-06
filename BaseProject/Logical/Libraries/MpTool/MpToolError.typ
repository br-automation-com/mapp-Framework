
TYPE
    MpToolErrorEnum : 
        ( (* Error numbers of library MpTool *)
        mpTOOL_NO_ERROR := 0, (* No error *)
        mpTOOL_ERR_GET_FAILED := -1067211776, (* "Get" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41984, 0xc063a400] *)
        mpTOOL_ERR_SET_FAILED := -1067211775, (* "Set" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41985, 0xc063a401] *)
        mpTOOL_ERR_CREATE_FAILED := -1067211774, (* "Create" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41986, 0xc063a402] *)
        mpTOOL_ERR_DELETE_FAILED := -1067211773, (* "Delete" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41987, 0xc063a403] *)
        mpTOOL_INF_NO_MORE_ELEMENTS := 1080271876, (* No more elements available [Informational: 41988, 0x4063a404] *)
        mpTOOL_INF_NO_ELEMENT_FOUND := 1080271877, (* No element of defined type found [Informational: 41989, 0x4063a405] *)
        mpTOOL_ERR_EXECUTE_FAILED := -1067211770, (* "Execute" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41990, 0xc063a406] *)
        mpTOOL_ERR_NEXT_FAILED := -1067211769, (* "Next" command failed (ErrorCause: {1:ErrorNumber}) [Error: 41991, 0xc063a407] *)
        mpTOOL_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpTOOL_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpTOOL_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpTOOL_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpTOOL_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpTOOL_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpTOOL_ERR_PAR_NULL := -1064239097 (* Parameters structure is a null pointer [Error: 7, 0xc0910007] *)
        );
END_TYPE
