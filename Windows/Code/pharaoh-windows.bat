@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\vagrant\native-installers\Windows\pharaohtools2.exe
REM BFCPEICON=
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Pharaoh Tools
REM BFCPEVERDESC=PHP Automation
REM BFCPEVERCOMPANY=Pharaoh Tools
REM BFCPEVERCOPYRIGHT=
REM BFCPEEMBED=C:\Users\vagrant\native-installers\Windows\Code\wget.exe
REM BFCPEEMBED=C:\Users\vagrant\native-installers\Windows\Code\unzip.exe
REM BFCPEEMBED=C:\Users\vagrant\native-installers\Windows\Code\vc_redist.x86.exe
REM BFCPEOPTIONEND
@ECHO ON
@echo off
echo "Our Pharaoh Tools Windows Executable"
timeout 5
del /S /Q %TEMP%\php.zip
echo "Copying wget from installer to %TEMP%\wget.exe"
copy %MYFILES%\wget.exe %TEMP%\wget.exe
echo "Changing directory to %TEMP%"
cd %TEMP%
echo "Downloading PHP with wget"
wget.exe http://windows.php.net/downloads/releases/archives/php-7.0.2-Win32-VC14-x86.zip
echo "Deleting %SystemDrive%\php.zip if it exists"
del /S /Q %SystemDrive%\php.zip
echo "Copying downloaded php from %TEMP%\php-7.0.2-Win32-VC14-x86.zip to %SystemDrive%\php.zip"
copy %TEMP%\php-7.0.2-Win32-VC14-x86.zip %SystemDrive%\php.zip
echo "Deleting %SystemDrive%\php if it exists"
rmdir /S /Q %SystemDrive%\php
echo "Making directory %SystemDrive%\php"
mkdir %SystemDrive%\php
echo "Changing directory to %SystemDrive%\php"
cd %SystemDrive%\php
echo "Current directory is %cd%"
echo "Unzipping to %SystemDrive%\php.zip"
%SystemDrive%\unzip.exe %SystemDrive%\php.zip
del /S /Q %SystemDrive%\php.zip
echo "Installing Visual Studio Redistributable"
start /wait %MYFILES%\vc_redist.x86.exe /install /quiet /norestart
REM install chocolatey
echo "Installing the Chocolatey Package Manager for Windows"
start /wait cmd /C @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
start /wait cmd /C choco install nuget.commandline -y
REM Install Git
echo "Installing the latest version of Git"
start /wait cmd /C choco install git -y
REM Download Pharaoh configure
echo "Downloading the latest version of Pharaoh Configure"
echo %TEMP%\ptconfigure-install
timeout 5
rmdir /S /Q %TEMP%\ptconfigure-install
start /wait cmd /C git clone https://github.com/PharaohTools/ptconfigure %TEMP%\ptconfigure-install
timeout 5
REM Install Pharaoh configure
echo "Installing the latest version of Pharaoh Configure"
start /wait cmd /C %SystemDrive%\php\php.exe%TEMP%\ptconfigure-install\install-silent
REM Install Pharaoh Tools
echo "Installing all available Pharaoh Tools"
REM php Ptconfigure pharaohtools install -yg
start /wait cmd /C %SystemDrive%\php\php.exe ptconfigure pharaohtools install -yg
REM Thank You for installing message
echo "Thank you for Installing the latest version of Pharaoh Tools"
timeout 15