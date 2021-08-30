echo Building Platfrom = %~1 Configuration=%~2
copy config.pl postgresql-10.18\src\tools\msvc\config.pl
copy Solution.pm postgresql-10.18\src\tools\msvc\Solution.pm

REM Copy openssl binaries
RMDIR /S /Q openssl 2>nul
mkdir openssl
mkdir openssl\include
mkdir openssl\lib
mkdir openssl\bin
echo %~3
xcopy /s %~3\include openssl\include

if "%~1" == "amd64" (
xcopy /s %~3\include_x64 openssl\include
xcopy /s %~3\binaries\x64\%~2 openssl\lib
xcopy /s %~3\binaries\x64\%~2 openssl\bin
)

if "%~1" == "x86" ( 
xcopy /s %~3\include_x86 openssl\include
xcopy /s %~3\binaries\Win32\%~2 openssl\lib
xcopy /s %~3\binaries\Win32\%~2 openssl\bin
)

REM Copy zlib binaries
RMDIR /S /Q zlib 2>nul
mkdir zlib
mkdir zlib\include
mkdir zlib\lib

xcopy /s %~4\include zlib\include

if "%~1" == "amd64" (
  if "%~2" == "Debug" (
      copy %~4\binaries\x64\%~2\lib\zlibd.lib zlib\lib\zdll.lib
  )
  if "%~2" == "Release" (
      copy %~4\binaries\x64\%~2\lib\zlib.lib zlib\lib\zdll.lib
  )
)

if "%~1" == "x86" ( 
  if "%~2" == "Debug" (
      copy %~4\binaries\Win32\%~2\lib\zlibd.lib zlib\lib\zdll.lib
  )
  if "%~2" == "Release" (
      copy %~4\binaries\Win32\%~2\lib\zlib.lib zlib\lib\zdll.lib
  )
)                                                         

REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %~1

call vc_env.cmd %~5 %~6
cd postgresql-10.18/src/tools/msvc/
build.bat %~2 libpq