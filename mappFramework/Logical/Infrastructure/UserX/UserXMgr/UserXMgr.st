//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Tasks for user management.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('mappUserXFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF

	// Initialize mapp function blocks
	UserXMgrUIConnect.User.Create.Lock := FALSE;
	UserXMgrUIConnect.User.Lock := FALSE;
	UserXMgrUIConnect.User.Edit.Lock := FALSE;
	UserXMgrUIConnect.User.Create.Dialog.UserName := "";
	UserXMgrUIConnect.User.Create.Dialog.NewPassword := "";
	UserXMgrUIConnect.User.Create.Dialog.ConfirmPassword := "";
	UserXMgrUIConnect.User.List.MaxSelection := USER_LIST_MAX_SELECTION;
	UserXMgrUIConnect.User.List.RangeStart := USER_LIST_RANGE_START;
	UserXMgrUIConnect.User.List.RangeEnd := USER_LIST_RANGE_END;
	MpUserXManagerUI_0.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXManagerUI_0.Enable := TRUE;
	MpUserXManagerUI_0.UIConnect := ADR(UserXMgrUIConnect);
	MpUserXManagerUI_0();

	MpUserXLoginUI_0.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLoginUI_0.Enable := TRUE;
	MpUserXLoginUI_0.UIConnect := ADR(UserXLoginUIConnect);
	MpUserXLoginUI_0();

	MpUserXLogin_0.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLogin_0.Enable := TRUE;
	MpUserXLogin_0();


END_PROGRAM

PROGRAM _CYCLIC

	// Error reset
	IF NOT MpUserXManagerUI_0.Error THEN
		MpUserXManagerUI_0.ErrorReset := FALSE;
	END_IF

	IF NOT MpUserXLoginUI_0.Error THEN
		MpUserXLoginUI_0.ErrorReset := FALSE;
	END_IF

	IF NOT MpUserXLogin_0.Error THEN
		MpUserXLogin_0.ErrorReset := FALSE;
	END_IF

	// Call all cyclic actions
	HMIAction;
	
	// Saving last status of UserXMgrUIconnect
	HmiUserX.Status.LastMgrConnectStatus := UserXMgrUIConnect.Status;

	// Assign MpLinks & address references
	MpUserXManagerUI_0.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXManagerUI_0.UIConnect := ADR(UserXMgrUIConnect);
	MpUserXLoginUI_0.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLoginUI_0.UIConnect := ADR(UserXLoginUIConnect);
	MpUserXLogin_0.MpLink := ADR(gMpLinkUserXLogin);

	// Call function blocks
	MpUserXManagerUI_0();
	MpUserXLoginUI_0();
	MpUserXLogin_0();


END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
	MpUserXManagerUI_0.Enable := FALSE;
	MpUserXLoginUI_0.Enable := FALSE;
	MpUserXLogin_0.Enable := FALSE;

	// Call function blocks
	MpUserXManagerUI_0();
	MpUserXLoginUI_0();
	MpUserXLogin_0();

END_PROGRAM

