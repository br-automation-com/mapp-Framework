@@echo off

set tool=%cd%\..\AS\TS_UnitTest\UnitTest_TestProgram_Helper.exe



REM switch to project context
chdir /d %~dp0
set currDirPackage=%cd%\package.pkg



REM execute helper on all test programs in this package
"%tool%" "%currDirPackage%"



REM eval result 
if   errorLevel 1 goto echoErrorLevel
goto End

:echoErrorLevel
echo errorLevel: %errorLevel%


:End
pause
