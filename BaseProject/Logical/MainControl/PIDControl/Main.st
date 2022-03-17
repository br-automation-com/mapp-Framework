(*********************************************************************************
 * Copyright: B&R Industrial Automation GmbH 
 * Created:   22 July, 2021/15:54 
 * This task contains the logic for a PID controller
 *********************************************************************************)

PROGRAM _INIT
	(* Register parameters to the recipe *)
	MpRecipeRegPar_P.MpLink := ADR(gMpLinkRecipeXml);
	MpRecipeRegPar_P.Enable := TRUE;
	MpRecipeRegPar_P.PVName := ADR('PIDControl:PidControlParameters');
	MpRecipeRegPar_P.Category := ADR('Product');
	MpRecipeRegPar_Pre.MpLink := ADR(gRecipeXmlPreviewMpLink);
	MpRecipeRegPar_Pre.Enable := TRUE;
	MpRecipeRegPar_Pre.PVName := ADR('PIDControl:PidControlParameters');
	MpRecipeRegPar_Pre.Category := ADR('Preview');
	(* Activate recipe registration *)
	WHILE NOT MpRecipeRegPar_P.Active DO
		MpRecipeRegPar_P();
	END_WHILE
	WHILE NOT MpRecipeRegPar_Pre.Active DO
		MpRecipeRegPar_Pre();
	END_WHILE
	(* Keep start signal of tuning fub true, tuning is started and stopped via HMI by setting the enable input *)
	MTBasicsOscillationTuning_0.Start := TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Simulation *)
	SimulateActValue;

	(* Update parameters on update notification *)
	IF MpRecipeRegPar_P.UpdateNotification THEN
		MTBasicsPID_0.PIDParameters := PidControlParameters.PidParameters;
		MTBasicsPID_0.SetValue := PidControlParameters.SetValue;
		MTBasicsPID_0.MinOut := PidControlParameters.MinOut;
		MTBasicsPID_0.MaxOut := PidControlParameters.MaxOut;
		MTBasicsPID_0.Invert := PidControlParameters.Invert;
		MTBasicsPID_0.Update := MTBasicsPID_0.Active;
		MTBasicsOscillationTuning_0.MinOut := PidControlParameters.MinOut;
		MTBasicsOscillationTuning_0.MaxOut := PidControlParameters.MaxOut;
		MTBasicsOscillationTuning_0.SetValue := PidControlParameters.SetValue;
		MTBasicsOscillationTuning_0.Invert := PidControlParameters.Invert;
		MTBasicsOscillationTuning_0.Update := MTBasicsOscillationTuning_0.Active;
	END_IF

	(* Update actual value  *)
	MTBasicsPID_0.ActValue := ActValue;
	MTBasicsOscillationTuning_0.ActValue := ActValue;
	
	(* Autotuning of parameters *)
	IF MTBasicsOscillationTuning_0.TuningDone THEN
		PidControlParameters.PidParameters := MTBasicsOscillationTuning_0.PIDParameters;
		TuningQuality := MTBasicsOscillationTuning_0.Quality;
	END_IF
	
	(* Reset update commands *)
	IF MTBasicsPID_0.UpdateDone THEN
		MTBasicsPID_0.Update := FALSE;
	ELSIF MTBasicsOscillationTuning_0.UpdateDone THEN
		MTBasicsOscillationTuning_0.Update := FALSE;
	END_IF
	
	(* Call function blocks *)
	MpRecipeRegPar_P();
	MpRecipeRegPar_Pre();
	MTBasicsPID_0();
	MTBasicsOscillationTuning_0();
	
	(* Update status value *)
	IF MTBasicsOscillationTuning_0.TuningActive THEN 
		PidStatus := PID_TUNING;
	ELSIF MTBasicsPID_0.Error THEN
		PidStatus := PID_ERROR;
	ELSIF MTBasicsPID_0.Active THEN
		PidStatus := PID_ACTIVE;
	ELSE
		PidStatus := PID_IDLE;
	END_IF
	
	(* Set output value *)
	IF MTBasicsOscillationTuning_0.TuningActive THEN
		OutValue := MTBasicsOscillationTuning_0.Out;
	ELSE
		OutValue := MTBasicsPID_0.Out;
	END_IF
END_PROGRAM

PROGRAM _EXIT
	MpRecipeRegPar_P.Enable := FALSE;
	MpRecipeRegPar_P();
	MpRecipeRegPar_Pre.Enable := FALSE;
	MpRecipeRegPar_Pre();
END_PROGRAM

