//*********************************************************************** 
// Copyright: B&R Industrial Automation GmbH 
// Author: B&R Industrial Automation GmbH 
// Created: Jan 1, 2022 
// Description: Tasks for user control. The User Management handling is 
// done in this task.
//***********************************************************************

PROGRAM _INIT
	// Create folder for this component on the user file device
	DirCreate_New(enable := TRUE, pDevice := ADR('userPartition'), pName := ADR(LOCAL_FOLDER));		
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_New.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_New(enable := FALSE);
	END_IF	

	// Init MpUserX 
	UserXMgrUIConnect.User.Create.Lock := FALSE;
	UserXMgrUIConnect.User.Lock := FALSE;
	UserXMgrUIConnect.User.Edit.Lock := FALSE;
    UserXMgrUIConnect.User.Create.Dialog.UserName := "";
    UserXMgrUIConnect.User.Create.Dialog.NewPassword := "";
    UserXMgrUIConnect.User.Create.Dialog.ConfirmPassword := "";
    MpUserXManagerUI_0.MpLink := ADR(gMpLinkUserXLogin);    
    MpUserXManagerUI_0.Enable := TRUE;
    MpUserXManagerUI_0.UIConnect := ADR(UserXMgrUIConnect);
    UserXMgrUIConnect.User.List.MaxSelection := USER_LIST_MAX_SELECTION;
    UserXMgrUIConnect.User.List.RangeStart := USER_LIST_RANGE_START;
    UserXMgrUIConnect.User.List.RangeEnd := USER_LIST_RANGE_END;
	
	MpUserXLoginUI_0.MpLink := ADR(gMpLinkUserXLogin);    
    MpUserXLoginUI_0.Enable := TRUE;
	MpUserXLoginUI_0.UIConnect := ADR(UserXLoginUIConnect);

	MpUserXLogin_0.MpLink := ADR(gMpLinkUserXLogin);    
    MpUserXLogin_0.Enable := TRUE;	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//Error reset
	IF NOT MpUserXManagerUI_0.Error THEN
		MpUserXManagerUI_0.ErrorReset := FALSE;
    END_IF
	
	IF NOT MpUserXLoginUI_0.Error THEN
		MpUserXLoginUI_0.ErrorReset := FALSE;
    END_IF
	
	IF NOT MpUserXLogin_0.Error THEN
		MpUserXLogin_0.ErrorReset := FALSE;
    END_IF
	    
	MpUserXManagerUI_0();
	MpUserXLoginUI_0();
	MpUserXLogin_0();
	
END_PROGRAM

PROGRAM _EXIT
	
	// Call disbaled mapp function blocks 
    MpUserXManagerUI_0.Enable := FALSE;
	MpUserXManagerUI_0();
	
	MpUserXLoginUI_0.Enable := FALSE;
	MpUserXLoginUI_0();
	
	MpUserXLogin_0.Enable := FALSE;
	MpUserXLogin_0();
	
END_PROGRAM

