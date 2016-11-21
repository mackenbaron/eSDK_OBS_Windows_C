@echo off

rem 设置变量
SET PCRE_PATH=%cd%\pcre-8.39
SET SOLUTION="%PCRE_PATH%\sln\pcre_839\pcre_839.sln"
SET SOLUTION_CONFIG="Release|Win32"
SET ACTION=Rebuild
rem 编译系统工程
"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv" %SOLUTION% /%ACTION% %SOLUTION_CONFIG%

xCOPY "%PCRE_PATH%\sln\pcre_839\Release\*.dll" "%PCRE_PATH%\..\build\pcre-8.39\bin\" /y
xCOPY "%PCRE_PATH%\sln\pcre_839\Release\*.lib" "%PCRE_PATH%\..\build\pcre-8.39\lib\" /y
xCOPY "%PCRE_PATH%\include\*.h" "%PCRE_PATH%\..\build\pcre-8.39\include\" /y

:Exit