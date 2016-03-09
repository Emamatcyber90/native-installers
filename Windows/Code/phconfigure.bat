REM Get rid of the ptconfigure install files if they do exist
if exist "%TEMP%\ptconfigure-install" rmdir /S /Q %TEMP%\ptconfigure-install
REM Download Pharaoh configure, install 
echo "Downloading the latest version of Pharaoh Configure to..."
rem pause
echo %TEMP%\ptconfigure-install

echo "Please wait for 30 seconds..its important"
path
cd "C:\Program Files\Git\cmd"
git clone https://github.com/PharaohTools/ptconfigure %TEMP%\ptconfigure-install

REM Install Pharaoh configure
echo "Installing the latest version of Pharaoh Configure"
rem pause
cmd /C "%SystemDrive%\php\php.exe %TEMP%\ptconfigure-install\install-silent"


REM Install Pharaoh Tools
echo "Installing all available Pharaoh Tools"
rem pause
REM php Ptconfigure pharaohtools install -yg

cd %SystemDrive%\PharaohTools
cmd /C "%SystemDrive%\PharaohTools\ptconfigure.cmd ptvirtualize install -yg"
rem pause
cd %SystemDrive%\PharaohTools
cmd /C "%SystemDrive%\PharaohTools\ptconfigure.cmd ptdeploy install -yg"
rem pause
cd %SystemDrive%\PharaohTools
cmd /C "%SystemDrive%\PharaohTools\ptconfigure.cmd pttest install -yg"
rem pause
cd %SystemDrive%\PharaohTools
cmd /C "%SystemDrive%\PharaohTools\ptconfigure.cmd ptbuild install -yg --with-webfaces"
REM Thank You for installing message
echo "Thank you for Installing the latest version of Pharaoh Tools"
REM Ending
timeout 5
