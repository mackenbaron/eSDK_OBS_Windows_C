@echo off

rem 设置变量
SET LIBCURL_PATH=%cd%\curl-7.49.1
SET SOLUTION="%LIBCURL_PATH%\projects\Windows\VC10\curl-all.sln"
SET SOLUTION_CONFIG="DLL Release - DLL OpenSSL - DLL LibSSH2|Win32"
SET ACTION=Rebuild
rem 编译系统工程
"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv" %SOLUTION% /%ACTION% %SOLUTION_CONFIG%

xCOPY "%LIBCURL_PATH%\build\Win32\VC10\DLL Release - DLL OpenSSL - DLL LibSSH2\*.lib" "%LIBCURL_PATH%\..\build\curl-7.49.1\lib\" /y
xCOPY "%LIBCURL_PATH%\build\Win32\VC10\DLL Release - DLL OpenSSL - DLL LibSSH2\*.dll" "%LIBCURL_PATH%\..\build\curl-7.49.1\bin\" /y
xCOPY "%LIBCURL_PATH%\include\curl\*.h" "%LIBCURL_PATH%\..\build\curl-7.49.1\include\curl\" /y

:Exit