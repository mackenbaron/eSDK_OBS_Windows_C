@echo off
setlocal EnableDelayedExpansion

set Drive=%~d0
set CurBatPath=%~dp0
echo CurBatPath is %CurBatPath%

set AGENTPATH=%CurBatPath%
set SOLUTION=%AGENTPATH%sln\vc100\obs.sln

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

if not exist "%AGENTPATH%\build\vc100\Release\libeSDKOBSS3.dll" (goto CompileFailed)
if not exist "%AGENTPATH%\build\vc100\Release\libeSDKOBSS3.lib" (goto CompileFailed)

echo ===========Begin to copy files==============
if not exist "%AGENTPATH%build\bin\" (md "%AGENTPATH%build\bin\")
if not exist "%AGENTPATH%build\include\" (md "%AGENTPATH%build\include\")
if not exist "%AGENTPATH%build\lib\" (md "%AGENTPATH%build\lib\")

COPY /Y "%AGENTPATH%..\third_party\build\openssl-1.0.2j\bin\libeay32.dll"  "%AGENTPATH%build\bin\libeay32.dll"

COPY /Y "%AGENTPATH%..\third_party\build\openssl-1.0.2j\bin\ssleay32.dll"  "%AGENTPATH%build\bin\ssleay32.dll"

COPY /Y "%AGENTPATH%..\third_party\build\curl-7.49.1\bin\libcurl.dll"  "%AGENTPATH%build\bin\libcurl.dll"

COPY /Y "%AGENTPATH%..\third_party\build\libssh2-1.7.0\libssh2.dll"  "%AGENTPATH%build\bin\libssh2.dll"

COPY /Y "%AGENTPATH%..\third_party\build\pcre-8.39\bin\pcre.dll"  "%AGENTPATH%build\bin\pcre.dll"

COPY /Y "%AGENTPATH%..\self_dev\eSDK_LogAPI_V2.1.00\bin\eSDKLogAPI.dll"  "%AGENTPATH%build\bin\eSDKLogAPI.dll"

COPY /Y "%AGENTPATH%\build\vc100\Release\libeSDKOBSS3.dll"   "%AGENTPATH%build\bin"
COPY /Y "%AGENTPATH%\build\vc100\Release\libeSDKOBSS3.lib" "%AGENTPATH%build\lib"

COPY /Y "%AGENTPATH%OBS.ini"  "%AGENTPATH%build\bin\OBS.ini"

COPY /Y "%AGENTPATH%inc\eSDKOBSS3.h"	 		"%AGENTPATH%build\include"

goto Exit

:CompileFailed

echo  %DATE% %TIME% libeSDKOBSS3.dll file Not Found,Compile Failed
echo  %DATE% %TIME% libeSDKOBSS3.lib file Not Found,Compile Failed. >> %BUILD_LOG%

:Exit
echo End