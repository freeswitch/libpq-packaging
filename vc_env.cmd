for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -version %1 -property installationPath`) do (
   set InstallDir=%%i
)
CALL "%InstallDir%\VC\Auxiliary\Build\vcvars%2.bat"