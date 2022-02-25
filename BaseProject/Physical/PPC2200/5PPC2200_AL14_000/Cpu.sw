<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="MainCtrl" Source="MainControl.MainCtrl.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="AxisContro" Source="Infrastructure.AxisTemplate.AxisControl.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="AppAxis_1" Source="MachineControl.AppAxis_1.AppAxis_1.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="CrossCutte" Source="MachineControl.CrossCutter.CrossCutter.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="PIDControl" Source="MainControl.PIDControl.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5">
    <Task Name="UserXMgt" Source="Infrastructure.UserX.UserXMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="UserMgt" Source="Infrastructure.User.UserMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="ProcessCon" Source="Infrastructure.SysServices.ProcessConfig.prg" Memory="UserROM" Language="IEC" Debugging="true" Disabled="true" />
    <Task Name="AlarmMgt" Source="Infrastructure.AlarmX.AlarmMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="AuditMgt" Source="Infrastructure.Audit.AuditMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="DataMgt" Source="Infrastructure.Data.DataMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="UsbDevLink" Source="Infrastructure.UsbDevLink.UsbDevLink.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="ReportMgt" Source="Infrastructure.Report.ReportMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="RecipeMgt" Source="Infrastructure.Recipe.RecipeMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="BackupMgt" Source="Infrastructure.Backup.BackupMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="FileMgt" Source="Infrastructure.File.FileMgt.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="IoBrowser" Source="Infrastructure.SysServices.IoBrowser.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="SysServs" Source="Infrastructure.SysServices.SysServs.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <DataObjects>
    <DataObject Name="McAcpSys" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="McDriveLog" Source="" Memory="UserROM" Language="Binary" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="McProfGen" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McMechSys" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpSim" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arflatprv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCLang" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arcoal" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="OpcUaSrv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="McAcpDrv" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mCoWebSc" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Report" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutterAlm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Audit" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Data" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserXlogin" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="MachineGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FileMgr" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Settings" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutVirt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="CutAxis" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutCamAut" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="myUnits" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="CutterGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Backup" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="BackupFile" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UserX" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmX" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="RecipeXML" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlarmXHist" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="RecipeCSV" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="VAppAxis1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Axis1Alm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Axis1Grp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AppAxis1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvVirt" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvAxis" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvGrp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ConvAlm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Cutter" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="AlmHistory" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Rcp" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Alarm" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="UsX" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrWStr" Source="Libraries.AsBrWStr.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArUser" Source="Libraries.ArUser.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsARCfg" Source="Libraries.AsARCfg.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsZip" Source="Libraries.AsZip.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsUPS" Source="Libraries.AsUPS.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIO" Source="Libraries.AsIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIOMMan" Source="Libraries.AsIOMMan.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Gat" Source="Libraries.Gat.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="IoMapMan" Source="Libraries.IoMapMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArCfgMan" Source="Libraries.ArCfgMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="CoTrace" Source="Libraries.CoTrace.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpFile" Source="Libraries.MpFile.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpData" Source="Libraries.MpData.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBase" Source="Libraries.MpBase.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpWebXs" Source="Libraries.MpWebXs.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAudit" Source="Libraries.MpAudit.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRecipe" Source="Libraries.MpRecipe.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpUserX" Source="Libraries.MpUserX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpReport" Source="Libraries.MpReport.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBackup" Source="Libraries.MpBackup.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McAxis" Source="Libraries.McAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McBase" Source="Libraries.McBase.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpAx" Source="Libraries.McAcpAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McPureVAx" Source="Libraries.McPureVAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpPar" Source="Libraries.McAcpPar.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpServer" Source="Libraries.MpServer.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpRegMark" Source="Libraries.MpRegMark.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIODiag" Source="Libraries.AsIODiag.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="aseth" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arssl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asepl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asarlog" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ashw" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arproject" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arcert" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asarprof" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>