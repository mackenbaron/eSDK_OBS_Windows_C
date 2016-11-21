@echo off
setlocal EnableDelayedExpansion

set Drive=%~d0
set CurBatPath=%~dp0
echo CurBatPath is %CurBatPath%

set AGENTPATH=%CurBatPath%
set SOLUTION=%AGENTPATH%sln\obs_demo.sln

echo AGENTPATH is %AGENTPATH%
echo SOLUTION is %SOLUTION%

set VCTOOL_HOME="%VS100COMNTOOLS%"

echo VCTOOL_HOME is %VCTOOL_HOME%
set DEVEVN_FILE=%VCTOOL_HOME%\..\IDE\devenv.exe

echo include is %INCLUDE%

set SOLUTION_CONFIG="Release|Win32"
set ACTION=Rebuild
call %VCTOOL_HOME%vsvars32.bat

echo ===========Begin to clean compile==============
echo %DEVEVN_FILE% "%SOLUTION%" /clean %SOLUTION_CONFIG%
%DEVEVN_FILE% "%SOLUTION%" /clean %SOLUTION_CONFIG%

echo ===========Begin to rebuild the Agent==============
echo %DEVEVN_FILE% %SOLUTION% /%ACTION% %SOLUTION_CONFIG% /useenv
%DEVEVN_FILE% "%SOLUTION%" /%ACTION% %SOLUTION_CONFIG% /useenv

if not exist "%AGENTPATH%\sln\eSDKOBSS3_demo.exe" (goto CompileFailed)

echo ===========Begin to copy files==============
if not exist "%AGENTPATH%demo" (md "%AGENTPATH%demo")

COPY /Y "%AGENTPATH%..\src\build\bin\*"  "%AGENTPATH%demo\"
COPY /Y "%AGENTPATH%sln\eSDKOBSS3_demo.exe"  "%AGENTPATH%demo\"

goto Exit

:CompileFailed

echo  %DATE% %TIME% eSDKOBSS3_demo.exe file Not Found,Compile Failed
echo  %DATE% %TIME% eSDKOBSS3_demo.exe file Not Found,Compile Failed. >> %BUILD_LOG%

:Exit
echo End