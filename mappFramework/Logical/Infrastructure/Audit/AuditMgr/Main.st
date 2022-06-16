//***********************************************************************
// Copyright: B&R Industrial Automation GmbH
// Author: B&R Industrial Automation GmbH
// Created: Sept 1, 2022
// Description: Task for audit management. 
//***********************************************************************

PROGRAM _INIT
		
	// Create folder for this component on the user file device
	DirCreate_0(enable := TRUE, pDevice := ADR('UserPartition'), pName := ADR(LOCAL_FOLDER));
	
	// Check if folder already exist and if so disabled the function block call
	IF DirCreate_0.status = fiERR_DIR_ALREADY_EXIST THEN
		DirCreate_0(enable := FALSE);
	END_IF
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

