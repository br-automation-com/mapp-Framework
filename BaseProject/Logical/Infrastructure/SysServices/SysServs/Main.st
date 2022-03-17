(*********************************************************************************
* Copyright: B&R Industrial Automation GmbH 
* Author:    B&R Industrial Automation GmbH 
* Created:   30. Sep 2020/08:00 
* Description: Tasks FOR Visualization control. The HMI handling is done in this task.
*********************************************************************************)


PROGRAM _INIT
	(* Insert code here *)

	brsstrcpy(ADR(EthConfig.Device), ADR('IF2'));

	(* Configure Ethernet configuration function blocks *)
	CfgGetIPAddr_0.pDevice				:= ADR(EthConfig.Device);
	CfgGetDefaultGateway_0.pDevice		:= ADR(EthConfig.Device);
	CfgGetSubnetMask_0.pDevice			:= ADR(EthConfig.Device);
	CfgGetIPAddr_0.pIPAddr				:= ADR(EthConfig.Ip);
	CfgGetDefaultGateway_0.pGateway		:= ADR(EthConfig.Gateway);
	CfgGetSubnetMask_0.pSubnetMask		:= ADR(EthConfig.SubnetMask);
	CfgGetIPAddr_0.Len					:= 16;
	CfgGetDefaultGateway_0.Len			:= 16;
	CfgGetSubnetMask_0.Len				:= 16;
	CfgSetIPAddr_0.pDevice				:= ADR(EthConfig.Device);
	CfgSetDefaultGateway_0.pDevice		:= ADR(EthConfig.Device);
	CfgSetSubnetMask_0.pDevice			:= ADR(EthConfig.Device);
	CfgSetIPAddr_0.pIPAddr				:= ADR(EthConfig.Ip);
	CfgSetDefaultGateway_0.pGateway		:= ADR(EthConfig.Gateway);
	CfgSetSubnetMask_0.pSubnetMask		:= ADR(EthConfig.SubnetMask);
	CfgSetIPAddr_0.Option				:= 1;
	CfgSetDefaultGateway_0.Option		:= 1;
	CfgSetSubnetMask_0.Option			:= 1;

	(* Read ETHERNET information after booting *)
	ReadEthConfig						:= TRUE;
	
	(* Configure Get/Set time function blocks *)
	DTStructureGetTime_0.pDTStructure	:= ADR(DateTimeCfg);
	DTStructureSetTime_0.pDTStructure	:= ADR(DateTimeCfg);
	
	(* Client info *)
	ClientInfo[0].activityCount			:= 0;
END_PROGRAM

PROGRAM _CYCLIC
	(* Read ethernet information from target *)
	IF ReadEthConfig THEN
		CfgGetIPAddr_0.enable			:= TRUE;
		CfgGetDefaultGateway_0.enable	:= TRUE;
		CfgGetSubnetMask_0.enable		:= TRUE;
		ReadEthConfig					:= FALSE;
	END_IF
	(* Write ethernet information to target *)
	IF WriteEthConfig THEN
		CfgSetIPAddr_0.enable			:= TRUE;
		CfgSetDefaultGateway_0.enable	:= TRUE;
		CfgSetSubnetMask_0.enable		:= TRUE;
		WriteEthConfig					:= FALSE;
	END_IF
	
	(* Call ethernet configuration related function blocks *)
	CfgGetIPAddr_0();
	CfgGetDefaultGateway_0();
	CfgGetSubnetMask_0();
	CfgSetIPAddr_0();
	CfgSetDefaultGateway_0();
	CfgSetSubnetMask_0();

	(* Reset the enable inputs when done *)
	IF (CfgGetIPAddr_0.status <> ERR_FUB_BUSY) AND (CfgGetIPAddr_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgGetIPAddr_0.enable			:= FALSE;
	END_IF
	IF (CfgGetDefaultGateway_0.status <> ERR_FUB_BUSY) AND (CfgGetDefaultGateway_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgGetDefaultGateway_0.enable	:= FALSE;
	END_IF
	IF (CfgGetSubnetMask_0.status <> ERR_FUB_BUSY) AND (CfgGetSubnetMask_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgGetSubnetMask_0.enable		:= FALSE;
	END_IF
	IF (CfgSetIPAddr_0.status <> ERR_FUB_BUSY) AND (CfgSetIPAddr_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgSetIPAddr_0.enable			:= FALSE;
	END_IF
	IF (CfgSetDefaultGateway_0.status <> ERR_FUB_BUSY) AND (CfgSetDefaultGateway_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgSetDefaultGateway_0.enable	:= FALSE;
	END_IF
	IF (CfgSetSubnetMask_0.status <> ERR_FUB_BUSY) AND (CfgSetSubnetMask_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		CfgSetSubnetMask_0.enable		:= FALSE;
	END_IF
	
	(* Reset time function block enable commands *)
	IF (DTStructureGetTime_0.status <> ERR_FUB_BUSY) AND (DTStructureGetTime_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		DTStructureGetTime_0.enable		:= FALSE;
	END_IF
	IF (DTStructureSetTime_0.status <> ERR_FUB_BUSY) AND (DTStructureSetTime_0.status <> ERR_FUB_ENABLE_FALSE) THEN
		DTStructureSetTime_0.enable		:= FALSE;
	END_IF
	
	(* Call time configuration function blocks *)
	DTStructureGetTime_0();
	DTStructureSetTime_0();
	
	IF CpuIoMap.SerialNumber_CPU = 0 THEN
		CurrentMode := 'Simulation Mode' ;
		Simulation  := TRUE ;
	ELSE
		CurrentMode := 'Runtime Mode' ;
		Simulation  := FALSE ;
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)

END_PROGRAM

