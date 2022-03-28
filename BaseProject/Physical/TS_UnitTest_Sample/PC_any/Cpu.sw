<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="AxisMgr" Source="Infrastructure.AxisTemplate.AxisMgr.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="prototypeT" Source="Infrastructure.AxisTemplate.UnitTests.prototypeTest.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="Runtime" Source="Libraries.Runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsARCfg" Source="Libraries.AsARCfg.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="UnitTest" Source="Infrastructure.TS_UnitTest.Libraries.UnitTest.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="LibAssert1" Source="Infrastructure.TS_UnitTest.Samples.Framework_Extension_With_Custom_Asserts.LibAssert1.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="UtWs" Source="Infrastructure.TS_UnitTest.Libraries.UtWs.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="UtMgr" Source="Infrastructure.TS_UnitTest.Libraries.UtMgr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="SPLMyCalc" Source="Infrastructure.TS_UnitTest.Samples.Tests_Program.SPLMyCalc.lby" Memory="UserROM" Language="IEC" Debugging="true" />
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
    <LibraryObject Name="MpTool" Source="Libraries.MpTool.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpBackup" Source="Libraries.MpBackup.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="McAxis" Source="Libraries.McAxis.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McBase" Source="Libraries.McBase.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAxGroup" Source="Libraries.McAxGroup.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpAx" Source="Libraries.McAcpAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McPathGen" Source="Libraries.McPathGen.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McPureVAx" Source="Libraries.McPureVAx.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="McAcpPar" Source="Libraries.McAcpPar.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsZip" Source="Libraries.AsZip.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpServer" Source="Libraries.MpServer.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsBrWStr" Source="Libraries.AsBrWStr.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="ArUser" Source="Libraries.ArUser.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsUPS" Source="Libraries.AsUPS.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIO" Source="Libraries.AsIO.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsIOMMan" Source="Libraries.AsIOMMan.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Gat" Source="Libraries.Gat.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="IoMapMan" Source="Libraries.IoMapMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ArCfgMan" Source="Libraries.ArCfgMan.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="AsUSB" Source="Libraries.AsUSB.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="MpRegMark" Source="Libraries.MpRegMark.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="dvframe" Source="Libraries.dvframe.lby" Memory="UserROM" Language="binary" Debugging="true" />
  </Libraries>
</SwConfiguration>