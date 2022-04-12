ACTION AxisInit:
    
    MC_BR_CamAutomatCommandFB.Enable := TRUE;
    
    MC_BR_CamAutomatGetParFB.Command := mcGET_PAR_ACTUAL;
    MC_BR_CamAutomatGetParFB.Execute := TRUE;

    MC_BR_CamAutomatSetParFB.Command := mcSET_UPDATE_FROM_ADR;
    MC_BR_CamAutomatSetParFB.AdvancedParameters.ParLock := mcCAMAUT_UNLOCK_SYNCHRON;
    
    MpRegMarkDetectionFB.Enable := TRUE;
    MpRegMarkDetectionConfigFB.Enable := TRUE;
    MpRegMarkDetectionConfigFB.MpLink := ADR(gRegMarkDetection_Cutter);
    MpRegMarkDetectionConfigFB.Configuration := ADR(RegistrationControl.Configuration);
    WHILE NOT MpRegMarkDetectionConfigFB.Active AND NOT MpRegMarkDetectionConfigFB.Error DO
        MpRegMarkDetectionConfigFB();
    END_WHILE
    MpRegMarkDetectionConfigFB.Load := TRUE;
    MpRegMarkDetectionConfigFB();
    
    MC_BR_PhasingFB.Velocity := 90;
    MC_BR_PhasingFB.Acceleration := 90;
    MC_BR_PhasingFB.AdvancedParameters.ShiftMode := mcSHIFT_RELATIVE;
    
    END_ACTION

ACTION AxisCyclic:

    IF ((MpRegMarkDetectionConfigFB.Active = TRUE) AND (state = STATE_INIT)) THEN
        MpRegMarkDetectionConfigFB.Load := TRUE;
    END_IF
    
    IF (MpRecipeRegPar_UserFB.UpdateNotification) THEN
        UpdateCamAutomat;
        UpdateRegistrationControl;
    END_IF

    MC_BR_CamAutomatGetParFB.CamAutomat.DataAddress := ADR(McCamAutPar);
    MC_BR_CamAutomatGetParFB.Slave := ADR(gAxisCrossCutter);
    MC_BR_CamAutomatGetParFB();
    IF (MC_BR_CamAutomatGetParFB.Done = TRUE) THEN
        MC_BR_CamAutomatGetParFB.Execute := FALSE;
    END_IF
    i:=i + 1;
    
    MC_BR_CamAutomatSetParFB.Slave := ADR(gAxisCrossCutter);
    MC_BR_CamAutomatSetParFB.CamAutomat.DataAddress := ADR(McCamAutPar);
    MC_BR_CamAutomatSetParFB();
    IF (MC_BR_CamAutomatSetParFB.Done = TRUE) THEN
        MC_BR_CamAutomatSetParFB.Execute := FALSE;
    END_IF
    
    MC_BR_CamAutomatCommandFB.Slave := ADR(gAxisCrossCutter);
    MC_BR_CamAutomatCommandFB();
    
    MpRegMarkDetectionFB.MpLink := ADR(gRegMarkDetection_Cutter);
    MpRegMarkDetectionFB();

    MpRegMarkDetectionConfigFB.MpLink := ADR(gRegMarkDetection_Cutter);
    MpRegMarkDetectionConfigFB.Configuration := ADR(RegistrationControl.Configuration);
    MpRegMarkDetectionConfigFB();
    IF (MpRegMarkDetectionConfigFB.CommandDone = TRUE) THEN
        MpRegMarkDetectionConfigFB.Load := FALSE;
        MpRegMarkDetectionConfigFB.Save := FALSE;
    END_IF

    MC_BR_PhasingFB.Slave := ADR(gAxisCrossCutter);
    MC_BR_PhasingFB();
    
    IF (state <> STATE_AUTOMATIC_OPERATION) THEN
        AutomaticState := 0;
    END_IF
    
    MpAlarmXControlProductLengthFB.MpLink := ADR(gAlarmXCore_Cutter);
    MpAlarmXControlProductLengthFB.Enable := TRUE;
    MpAlarmXControlProductLengthFB.Name := ADR('CutterInvalidProductLength');
    MpAlarmXControlProductLengthFB();
    MpAlarmXControlProductLengthFB.Reset := FALSE;


    END_ACTION

ACTION UpdateCamAutomat:
    
    McCamAutPar.Common.Master.MasterStartInterval := AxisControl.Parameters.ProductLength;
    
    McCamAutPar.State[1].MasterFactor := LREAL_TO_DINT(AxisControl.Parameters.SyncAngle);
    McCamAutPar.State[1].SlaveFactor := LREAL_TO_DINT(AxisControl.Parameters.SyncAngle);
    McCamAutPar.State[1].CompensationParameters.MasterCompDistance := AxisControl.Parameters.DistanceFromSensorToCut;
        
    McCamAutPar.State[2].MasterFactor := LREAL_TO_DINT(AxisControl.Parameters.SyncAngle);
    McCamAutPar.State[2].SlaveFactor := LREAL_TO_DINT(AxisControl.Parameters.SyncAngle);
    McCamAutPar.State[2].CompensationParameters.MasterCompDistance := AxisControl.Parameters.ProductLength;
    McCamAutPar.State[2].CompensationParameters.SlaveCompDistance := 360.0 /  AxisControl.Parameters.NumberOfKnives;

    McCamAutPar.State[3].CompensationParameters.MasterCompDistance := AxisControl.Parameters.ProductLength;
    CASE  AxisControl.Parameters.NumberOfKnives OF
        1:
            McCamAutPar.State[3].CompensationParameters.SlaveCompDistance := 270.0;
        2:
            McCamAutPar.State[3].CompensationParameters.SlaveCompDistance := 90.0;
    END_CASE
    
    IF ((MpAxisBasic_0.Active = TRUE) AND (MC_BR_CamAutomatCommandFB.Running = FALSE)) THEN
        MC_BR_CamAutomatSetParFB.Execute := TRUE;
    END_IF
    
    END_ACTION
    
ACTION UpdateRegistrationControl:
    
    RegistrationControl.Configuration.Measurement.Product.Length.Value := AxisControl.Parameters.ProductLength;
    RegistrationControl.Configuration.Measurement.Interval.Length.Value := AxisControl.Parameters.ProductLength;
    RegistrationControl.Configuration.Detection.MarkWidthMonitoring.MaximumWidth := AxisControl.Parameters.MaxPrintMarkLength;
    RegistrationControl.Configuration.Detection.MarkWidthMonitoring.MinimumWidth := AxisControl.Parameters.MinPrintMarkLength;
    
    MpRegMarkDetectionConfigFB.Save := TRUE;
    
    END_ACTION
    
ACTION AxisManual:
    
    MpAxisParameters.Jog.Velocity := AxisControl.Parameters.JogVelocity;
    MpAxisParameters.Position := AxisControl.Parameters.Position;
    MpAxisParameters.Distance := AxisControl.Parameters.Distance;
    MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
    MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
    
    CASE ManualState OF
        MANUAL_STATE_IDLE:
            IF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                ManualState := MANUAL_STATE_JOG;
            ELSIF ((AxisControl.Command.MoveAbsolute = TRUE) OR (AxisControl.Command.MoveAdditive = TRUE)) THEN
                MpAxisBasic_0.MoveAbsolute := AxisControl.Command.MoveAbsolute;
                MpAxisBasic_0.MoveAdditive := AxisControl.Command.MoveAdditive;
                AxisControl.Command.MoveAbsolute := FALSE;
                AxisControl.Command.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_MOVE;
            END_IF
            
        MANUAL_STATE_JOG:
            MpAxisBasic_0.JogNegative := AxisControl.Command.JogNegative;
            MpAxisBasic_0.JogPositive := AxisControl.Command.JogPositive;
            IF (AxisControl.Command.Stop = TRUE) THEN
                AxisControl.Command.Stop := FALSE;
                MpAxisBasic_0.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF ((AxisControl.Command.JogNegative = FALSE) AND (AxisControl.Command.JogPositive = FALSE)) THEN
                MpAxisBasic_0.Stop := FALSE;
                MpAxisBasic_0.JogPositive := FALSE;
                MpAxisBasic_0.JogNegative := FALSE;
                ManualState := MANUAL_STATE_STOPPING;
            END_IF
            
        MANUAL_STATE_MOVE:
            IF (AxisControl.Command.Stop = TRUE) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                AxisControl.Command.Stop := FALSE;
                MpAxisBasic_0.Stop := TRUE;
                ManualState := MANUAL_STATE_STOPPING;
            ELSIF (InPositionEdgePos.Q = TRUE) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            ELSIF ((AxisControl.Command.JogNegative = TRUE) OR (AxisControl.Command.JogPositive = TRUE)) THEN
                MpAxisBasic_0.MoveAbsolute := FALSE;
                MpAxisBasic_0.MoveAdditive := FALSE;
                ManualState := MANUAL_STATE_JOG;
            END_IF
            
        MANUAL_STATE_STOPPING:
            MpAxisBasic_0.JogNegative := FALSE;
            MpAxisBasic_0.JogPositive := FALSE;
            MpAxisBasic_0.MoveAbsolute := FALSE;
            MpAxisBasic_0.MoveAdditive := FALSE;

            IF (MpAxisBasic_0.MoveActive = FALSE) THEN
                ManualState := MANUAL_STATE_IDLE;
                state := STATE_READY;
            END_IF
    END_CASE
    
    END_ACTION

ACTION AxisAutomatic:
    
    MpAlarmXControlProductLengthFB.Set := (AxisControl.Parameters.ProductLength = 0);

    MpAxisParameters.Velocity := AxisControl.Parameters.Velocity;
    MpAxisParameters.Acceleration := AxisControl.Parameters.Acceleration;
    MpAxisParameters.Deceleration := AxisControl.Parameters.Deceleration;
   
    MC_BR_CamAutomatCommandFB.SetSignal1 := FALSE;
    CASE AutomaticState OF
        0:
            MpRegMarkDetectionFB.Detect := TRUE;
            MpRegMarkDetectionFB.Search := TRUE;
            IF (MpRegMarkDetectionFB.SearchDone = TRUE) THEN
                MC_BR_PhasingFB.Enable := TRUE;
                AutomaticState := 1;
                MpRegMarkDetectionFB.Search := FALSE;
            END_IF
            
        1:
            IF (MpRegMarkDetectionFB.Info.Detection.TotalValidMarks <> RegistrationControl.LastValidMarks) THEN
                RegistrationControl.LastValidMarks := MpRegMarkDetectionFB.Info.Detection.TotalValidMarks;
                IF (RegistrationControl.ActualProductLength > 60) THEN
                    RegistrationControl.PhaseShift := AxisControl.Parameters.ProductLength - RegistrationControl.ActualProductLength;
                END_IF
                
                IF (MC_BR_CamAutomatCommandFB.Running = FALSE) THEN
                    MC_BR_CamAutomatCommandFB.SetSignal1 := FALSE;
                    MC_BR_CamAutomatCommandFB.ResetSignal1 := TRUE;
                    MC_BR_CamAutomatCommandFB.Start := (MC_BR_CamAutomatCommandFB.Start = FALSE);
                ELSIF (MC_BR_CamAutomatCommandFB.ActualStateIndex > 0) THEN
                    MC_BR_CamAutomatCommandFB.ResetSignal1 := FALSE;
                    MC_BR_CamAutomatCommandFB.SetSignal1 := TRUE;
                END_IF
            END_IF

            IF ((MC_BR_PhasingFB.PhaseShift <> RegistrationControl.PhaseShift) AND (MC_BR_CamAutomatCommandFB.ActualStateIndex > 0)) THEN
                MC_BR_PhasingFB.PhaseShift := RegistrationControl.PhaseShift;
                MC_BR_PhasingFB.StartShift := TRUE;
            END_IF
    
            IF EDGEPOS(MC_BR_PhasingFB.ShiftAttained = TRUE) THEN
                MC_BR_PhasingFB.StartShift := FALSE;
            END_IF

            IF (AxisControl.Command.Stop = TRUE) THEN
                AxisControl.Command.Stop := FALSE;
                MC_BR_PhasingFB.Enable := FALSE;
                MC_BR_CamAutomatCommandFB.SetSignal2 := TRUE;
                AutomaticState := 10;
            END_IF
            
        10:
            IF (MC_BR_CamAutomatCommandFB.Running = FALSE) THEN
                state := STATE_READY;
            END_IF
        
    END_CASE
    
    AxisControl.Status.ActualProductLength := RegistrationControl.ActualProductLength;
    AxisControl.Status.ValidProducts := MpRegMarkDetectionFB.Info.Detection.TotalValidMarks;
    
    END_ACTION

ACTION AxisReset:

    //    edge alarms don't require a reset
    //    IF (MpAlarmXControlProductLengthFB.Set = TRUE) THEN
    //        MpAlarmXControlProductLengthFB.Set := FALSE;
    //        MpAlarmXControlProductLengthFB.ID := MpAlarmXControlProductLengthZeroFB.InstanceID;
    //        MpAlarmXControlProductLengthFB.Reset := TRUE;
    //    END_IF

    END_ACTION