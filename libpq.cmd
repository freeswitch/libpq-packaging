echo Building Platfrom = %~1 Configuration=%~2
copy config.pl postgresql-10.3\src\tools\msvc\config.pl

REM Copy openssl binaries
RMDIR /S /Q openssl 2>nul
mkdir openssl
mkdir openssl\include
mkdir openssl\lib
echo %~3
xcopy /s %~3\include openssl\include

if "%~1" == "amd64" (
xcopy /s %~3\include_x64 openssl\include
xcopy /s %~3\binaries\x64\%~2 openssl\lib
)

if "%~1" == "x86" ( 
xcopy /s %~3\include_x86 openssl\include
xcopy /s %~3\binaries\Win32\%~2 openssl\lib
)

REM Copy zlib binaries
RMDIR /S /Q zlib 2>nul
mkdir zlib
mkdir zlib\include
mkdir zlib\lib

xcopy /s %~4\include zlib\include

if "%~1" == "amd64" (
copy %~4\binaries\x64\%~2\zlib.lib zlib\lib\zdll.lib
)

if "%~1" == "x86" ( 
copy %~4\binaries\Win32\%~2\zlib.lib zlib\lib\zdll.lib
)                                                         

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %~1
cd postgresql-10.3/src/tools/msvc/
build.bat %~2 libpq