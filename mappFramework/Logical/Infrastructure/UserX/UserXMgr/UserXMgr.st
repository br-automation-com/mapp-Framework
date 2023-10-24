//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: April 12, 2022
// Description: Tasks for user management.
//***********************************************************************

PROGRAM _INIT

	// Create folder for this component on the user file device
	DirCreateUser(enable := TRUE, pDevice := ADR('mappUserXFiles'), pName := ADR('/'));

	// Check if folder already exist and if so disabled the function block call
	IF DirCreateUser.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreateUser(enable := FALSE);
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
	MpUserXManagerUISys.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXManagerUISys.Enable := TRUE;
	MpUserXManagerUISys.UIConnect := ADR(UserXMgrUIConnect);
	MpUserXManagerUISys();
	MpUserXManagerUISys.UISetup.FileDevice := 'mappUserXFiles';

	MpUserXLoginUISys.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLoginUISys.Enable := TRUE;
	MpUserXLoginUISys.UIConnect := ADR(UserXLoginUIConnect);
	MpUserXLoginUISys();

	MpUserXLoginSys.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLoginSys.Enable := TRUE;
	MpUserXLoginSys();


END_PROGRAM

PROGRAM _CYCLIC

	// Error reset
	IF NOT MpUserXManagerUISys.Error THEN
		MpUserXManagerUISys.ErrorReset := FALSE;
	END_IF

	IF NOT MpUserXLoginUISys.Error THEN
		MpUserXLoginUISys.ErrorReset := FALSE;
	END_IF

	IF NOT MpUserXLoginSys.Error THEN
		MpUserXLoginSys.ErrorReset := FALSE;
	END_IF

	// Call all cyclic actions
	HMIAction;
	
	// Saving last status of UserXMgrUIconnect
	HmiUserX.Status.LastMgrConnectStatus := UserXMgrUIConnect.Status;

	// Assign MpLinks & address references
	MpUserXManagerUISys.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXManagerUISys.UIConnect := ADR(UserXMgrUIConnect);
	MpUserXLoginUISys.MpLink := ADR(gMpLinkUserXLogin);
	MpUserXLoginUISys.UIConnect := ADR(UserXLoginUIConnect);
	MpUserXLoginSys.MpLink := ADR(gMpLinkUserXLogin);

	// Call function blocks
	MpUserXManagerUISys();
	MpUserXLoginUISys();
	MpUserXLoginSys();


END_PROGRAM

PROGRAM _EXIT

	// Disable the function blocls to unlink the MpLinks
	MpUserXManagerUISys.Enable := FALSE;
	MpUserXLoginUISys.Enable := FALSE;
	MpUserXLoginSys.Enable := FALSE;

	// Call function blocks
	MpUserXManagerUISys();
	MpUserXLoginUISys();
	MpUserXLoginSys();

END_PROGRAM

