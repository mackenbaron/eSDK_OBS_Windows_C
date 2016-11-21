::请先用vs2010打开libssh2.dsw将其转化为vs2010工程，并修改其工程属性，包括opennssl、zlib的头文件和库路径
@echo off

rem 设置变量
SET LIBSSH2_PATH=%cd%\libssh2-1.7.0
SET SOLUTION="%LIBSSH2_PATH%\win32\libssh2.sln"
SET PROJECT="libssh2"
SET SOLUTION_CONFIG="OpenSSL DLL Release|Win32"
SET ACTION=Rebuild
rem 编译系统工程
"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv" %SOLUTION% /%ACTION% %SOLUTION_CONFIG% /project %PROJECT%

xCOPY "%LIBSSH2_PATH%\win32\Release_dll\*.dll" "%LIBSSH2_PATH%\..\build\libssh2-1.7.0\" /y
xCOPY "%LIBSSH2_PATH%\win32\Release_dll\*.lib" "%LIBSSH2_PATH%\..\build\libssh2-1.7.0\" /y
xCOPY "%LIBSSH2_PATH%\include\*.h" "%LIBSSH2_PATH%\..\build\libssh2-1.7.0\include\" /y

:Exit