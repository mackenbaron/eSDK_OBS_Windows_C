@echo off

set OPENSSL_PATH=%cd%\openssl-1.0.2j
set VCVARS32="%VS100COMNTOOLS%\..\..\VC\bin\vcvars32.bat"

@echo .
@echo гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн▒р╥ыopensslгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
@echo .
cd %OPENSSL_PATH%
perl Configure VC-WIN32 no-asm --prefix=..\..\openssl
call "ms/do_ms.bat"
call %VCVARS32%
nmake -f ms/ntdll.mak
nmake -f ms/ntdll.mak install

xCOPY "%OPENSSL_PATH%\..\..\openssl" "%OPENSSL_PATH%\..\build\openssl-1.0.2j\" /s /e /y

rd /s /q ..\..\openssl
rd /s /q ..\..\..\openssl

:Exit