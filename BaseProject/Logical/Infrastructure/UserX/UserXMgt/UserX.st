(*********************************************************************************
* Copyright: B&R
* Author:    B&R
* Created:   30. Dec 2020/08:00 
* Description: Tasks FOR user control. The User Management handling is done in this task.
*********************************************************************************)

PROGRAM _INIT
	(* Init MpUserX *)   
	UserXMgrUIConnect.User.Create.Lock := FALSE;
	UserXMgrUIConnect.User.Lock := FALSE;
	UserXMgrUIConnect.User.Edit.Lock := FALSE;
    UserXMgrUIConnect.User.Create.Dialog.UserName := "";
    UserXMgrUIConnect.User.Create.Dialog.NewPassword := "";
    UserXMgrUIConnect.User.Create.Dialog.ConfirmPassword := "";
    MpUserXManagerUI_0.MpLink := ADR(gUserXLoginMpLink);    
    MpUserXManagerUI_0.Enable := TRUE;
    MpUserXManagerUI_0.UIConnect := ADR(UserXMgrUIConnect);
    UserXMgrUIConnect.User.List.MaxSelection := USER_LIST_MAX_SELECTION;
    UserXMgrUIConnect.User.List.RangeStart := USER_LIST_RANGE_START;
    UserXMgrUIConnect.User.List.RangeEnd := USER_LIST_RANGE_END;

END_PROGRAM

PROGRAM _CYCLIC
	(* Handle user on mappView client *)

	IF NOT MpUserXManagerUI_0.Error THEN
		MpUserXManagerUI_0.ErrorReset := FALSE;
    END_IF
    
	MpUserXManagerUI_0();
END_PROGRAM

PROGRAM _EXIT
	(* Call disbaled mapp function blocks *)
    MpUserXManagerUI_0.Enable := FALSE;
	MpUserXManagerUI_0();
END_PROGRAM

