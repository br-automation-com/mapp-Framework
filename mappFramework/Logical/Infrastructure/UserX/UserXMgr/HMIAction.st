
ACTION HMIAction:
	CASE HmiUserX.Status.UserXHmiState OF
		USERX_START:
			IF NOT UserXMgrUIConnect.Import.ShowDialog THEN
				UserXMgrUIConnect.Import.ShowDialog := TRUE;
			ELSE
				HmiUserX.Status.UserXHmiState := USERX_WAIT_FOR_DIALOG;
			END_IF
		USERX_WAIT_FOR_DIALOG:
			UserXMgrUIConnect.Import.ShowDialog := FALSE;
			HmiUserX.Status.UserXHmiState := USERX_SET_RESPONSE;
		USERX_SET_RESPONSE:
			IF NOT(UserXMgrUIConnect.Status = mpUSERX_UI_STATUS_IDLE) THEN
				UserXMgrUIConnect.Import.Dialog.Cancel := TRUE;
			ELSE
				UserXMgrUIConnect.Import.Dialog.Cancel := FALSE;
				HmiUserX.Status.UserXHmiState := USERX_CONFIRM_RESPONSE;
			END_IF
		USERX_CONFIRM_RESPONSE:
			IF UserXMgrUIConnect.Status = mpUSERX_UI_STATUS_WAIT_DLG THEN
				HmiUserX.Status.UserXHmiState := USERX_START;
			ELSE
				HmiUserX.Status.UserXHmiState := USERX_FINISH;
			END_IF
		USERX_NEW_EXPORT:
			IF NOT UserXMgrUIConnect.Export.ShowDialog AND UserXMgrUIConnect.Status = mpUSERX_UI_STATUS_IDLE THEN
				HmiUserX.Status.UserXHmiState := USERX_START;
			END_IF
		USERX_FINISH:

	END_CASE
	// If new updates are made via export execute a check
	IF UserXMgrUIConnect.Export.ShowDialog THEN
		HmiUserX.Status.UserXHmiState := USERX_NEW_EXPORT;
	END_IF

	//Duplicate file checks
	HmiUserX.Status.FileDuplicate := FALSE;
	FOR i := 0 TO ((SIZEOF(UserXMgrUIConnect.Import.Dialog.List.FileNames) / SIZEOF(UserXMgrUIConnect.Import.Dialog.List.FileNames[0])) - 1) DO
		temp := UserXMgrUIConnect.Export.Dialog.FileName;
		brsstrcat(ADR(temp),ADR('.usr'));
		IF (temp = UserXMgrUIConnect.Import.Dialog.List.FileNames[i]) AND HmiUserX.Commands.Export THEN
			HmiUserX.Status.FileDuplicate := TRUE;
		END_IF
	END_FOR

	IF HmiUserX.Status.FileDuplicate AND (HmiUserX.Commands.ConfirmOverwrite) THEN
		UserXMgrUIConnect.Export.Dialog.Confirm := TRUE;
		HmiUserX.Commands.Export := FALSE;
		HmiUserX.Commands.ConfirmOverwrite := FALSE;
	ELSIF NOT HmiUserX.Status.FileDuplicate AND HmiUserX.Commands.Export THEN
		UserXMgrUIConnect.Export.Dialog.Confirm := TRUE;
		HmiUserX.Commands.Export := FALSE;
	END_IF

END_ACTION
