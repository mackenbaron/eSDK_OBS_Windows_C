@echo off

rem 设置变量
SET OPT_PATH=%cd%\getopt9
SET SOLUTION="%OPT_PATH%\sln\getopt.sln"
SET SOLUTION_CONFIG="Release|Win32"
SET ACTION=Rebuild
rem 编译系统工程
"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv" %SOLUTION% /%ACTION% %SOLUTION_CONFIG%

xCOPY "%OPT_PATH%\lib\getopt.lib" "%OPT_PATH%\..\build\getopt9\lib\" /y
xCOPY "%OPT_PATH%\include\getopt.h" "%OPT_PATH%\..\build\getopt9\include\" /y

:Exit