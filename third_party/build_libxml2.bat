@echo off

rem 设置变量
SET LIBXML2_PATH=%cd%\libxml2-2.9.4
SET SOLUTION="%LIBXML2_PATH%\win32\VC10\libxml2.sln"
SET SOLUTION_CONFIG="Release|Win32"
SET ACTION=Rebuild
rem 编译系统工程
"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv" %SOLUTION% /%ACTION% %SOLUTION_CONFIG%

xCOPY "%LIBXML2_PATH%\win32\VC10\Release\lib\*.lib" "%LIBXML2_PATH%\..\build\libxml2-2.9.4\lib\" /y
xCOPY "%LIBXML2_PATH%\include\libxml\*.h" "%LIBXML2_PATH%\..\build\libxml2-2.9.4\include\libxml\" /y
xCOPY "%LIBXML2_PATH%\include\*.h" "%LIBXML2_PATH%\..\build\libxml2-2.9.4\include\" /y

:Exit