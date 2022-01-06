<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="MainCtrl" Source="MainControl.MainCtrl.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="CrossCutte" Source="MachineControl.CrossCutter.CrossCutter.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Conveyor" Source="MachineControl.Conveyor.Conveyor.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="AlarmUI" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="AlarmMgt" Source="Infrastructure.Alarm.AlarmMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="AuditMgt" Source="Infrastructure.Audit.AuditMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="ReportMgt" Source="Infrastructure.Report.ReportMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="DataMgt" Source="Infrastructure.Data.DataMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="ProcessCon" Source="Infrastructure.SysServices.ProcessConfig.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="PIDControl" Source="MainControl.PIDControl.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="RecipeMgt" Source="Infrastructure.Recipe.RecipeMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="IoBrowser" Source="Infrastructure.SysServices.IoBrowser.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="UsbDevLink" Source="Infrastructure.UsbDevLink.UsbDevLink.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5">
    <Task Name="SysServs" Source="Infrastructure.SysServices.SysServs.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="UserXMgt" Source="Infrastructure.UserX.UserXMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="UserMgt" Source="Infrastructure.User.UserMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
  </TaskClass>
  <DataObjects>
    <DataObject Name="McAcpSys" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="McDriveLog" Source="" Memory="UserROM" Language="Binary" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpDrv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpSim" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McProfGen" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McMechSys" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TCLang" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arcoal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arflatprv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mCoWebSc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="OpcUaSrv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Report" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Rcp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlmHistory" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Data" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Audit" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserXlogin" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UsX" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Settings" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AxCfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Alarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutCamAut" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="myUnits" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileMgr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutterAlm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="MachineGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Cutter" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvAlm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutterGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="aruser" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="File" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileMgrRep" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileMgrDat" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileMgrAud" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileUI" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CamAutoMa1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_32" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlmCutter" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_2" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserMgr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserSign" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserLogin" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="profiler" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_31" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_3" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CfgUser" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Login" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_23" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_24" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_21" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_20" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CamAutoMat" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vConfig_0" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_0" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_13" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_5" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_8" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_9" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_11" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_15" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_14" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_12" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_10" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_6" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_7" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_22" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_4" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Master" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Slave" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CamID" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CamList" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ProfGen" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="vMaster" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="McBase" Source="Libraries.McBase.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpAx" Source="Libraries.McAcpAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McPathGen" Source="Libraries.McPathGen.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McPureVAx" Source="Libraries.McPureVAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAxGroup" Source="Libraries.McAxGroup.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAxis" Source="Libraries.McAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpPar" Source="Libraries.McAcpPar.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McProgInt" Source="Libraries.McProgInt.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpTool" Source="Libraries.MpTool.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpBase" Source="Libraries.MpBase.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpWebXs" Source="Libraries.MpWebXs.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAudit" Source="Libraries.MpAudit.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpReport" Source="Libraries.MpReport.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpFile" Source="Libraries.MpFile.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBackup" Source="Libraries.MpBackup.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpServer" Source="Libraries.MpServer.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpData" Source="Libraries.MpData.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="CoTrace" Source="Libraries.CoTrace.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsZip" Source="Libraries.AsZip.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpUserX" Source="Libraries.MpUserX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUPS" Source="Libraries.AsUPS.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Gat" Source="Libraries.Gat.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsIO" Source="Libraries.AsIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIOMMan" Source="Libraries.AsIOMMan.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="IoMapMan" Source="Libraries.IoMapMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArCfgMan" Source="Libraries.ArCfgMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arssl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arproject" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asarlog" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asarprof" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asmem" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asarcfg" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asieccon" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asepl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="aseth" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ashw" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arcert" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="mpregmark" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>