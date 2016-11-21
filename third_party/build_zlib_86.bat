@echo off

SET ZLIB_PATH=%cd%\zlib-1.2.8

@"%VS100COMNTOOLS%\..\IDE\devenv.com" .\zlib-1.2.8\contrib\vstudio\vc10\zlibvc.vcxproj /Rebuild "Release|Win32"

xcopy /Y "%ZLIB_PATH%\contrib\vstudio\vc10\x86\ZlibDllRelease\zlibwapi.dll" "%ZLIB_PATH%\..\build\zlib-1.2.8\x86\dll\"
xcopy /Y "%ZLIB_PATH%\contrib\vstudio\vc10\x86\ZlibDllRelease\zlibwapi.lib" "%ZLIB_PATH%\..\build\zlib-1.2.8\x86\lib\"

xcopy /Y %ZLIB_PATH%\contrib\minizip\crypt.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\ioapi.c "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\ioapi.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\iowin32.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\mztools.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\unzip.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\contrib\minizip\zip.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\zconf.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"
xcopy /Y %ZLIB_PATH%\zlib.h "%ZLIB_PATH%\..\build\zlib-1.2.8\include\"

:Exit