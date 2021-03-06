@ECHO OFF

set MYFILES="%~dp0"
echo %myfiles%
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=\\VBOXSVvR\Windows_Native_Installer_Files\pharaohtools.exe
REM BFCPEICON=\\VBOXSVR\Windows_Native_Installer_Files\Code\logo-pharaoh-medium.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=1
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Pharaoh Tools
REM BFCPEVERDESC=PHP Automation
REM BFCPEVERCOMPANY=Pharaoh Tools
REM BFCPEVERCOPYRIGHT=
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\Code\wget.exe
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\Code\vc_redist.x86.exe
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\Code\unzip.exe
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\SourceFiles\Windows6.1-KB2999226-x86.msu
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\SourceFiles\Windows6.0-KB2999226-x86.msu
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\SourceFiles\Windows8.1-KB2999226-x86.msu
REM BFCPEEMBED=\\VBOXSVR\Windows_Native_Installer_Files\SourceFiles\Windows8-RT-KB2999226-x86.msu
REM BFCPEOPTIONEND
@ECHO ON
@echo off
REM Start Nicely
echo "Our Pharaoh Tools Windows Executable"
REM Tell Them we're about to start
REM timeout  5
REM Copy wget from installer to temp dir so we can wget PHP
echo "Copying wget from installer to %TEMP%\wget.exe"
copy %MYFILES%\wget.exe %TEMP%\wget.exe
REM Go to the Temp dir
echo "Changing directory to %TEMP%"
cd %TEMP%
REM Do the PHP Download 
echo "Downloading PHP with wget"
rem REM REM pause
wget.exe http://windows.php.net/downloads/releases/archives/php-7.0.2-Win32-VC14-x86.zip
REM Deleting %SystemDrive%\php.zip if it exists
echo "Deleting %SystemDrive%\php.zip if it exists"
if exist "%SystemDrive%\php.zip" del /S /Q %SystemDrive%\php.zip
REM Overwrite %SystemDrive%\php.zip with fresh copy
echo "Copying downloaded php from %TEMP%\php-7.0.2-Win32-VC14-x86.zip to %SystemDrive%\php.zip"
copy %TEMP%\php-7.0.2-Win32-VC14-x86.zip %SystemDrive%\php.zip
REM Delete the php dir if its there
echo "Deleting %SystemDrive%\php if it exists"
if exist "%SystemDrive%\php" rmdir /S /Q %SystemDrive%\php
REM Create new empty php directory
echo "Making directory %SystemDrive%\php"
if not exist "%SystemDrive%\php" mkdir %SystemDrive%\php
REM CD to php dir
echo "Changing directory to %SystemDrive%\php"
cd %SystemDrive%\php
REM Check our current directory, get the unzip exe
echo "Current directory is %cd%"
echo "Copying unzip from installer to %SystemDrive%\unzip.exe"
copy %MYFILES%\unzip.exe %SystemDrive%\unzip.exe
REM Unzip php into the php dir
echo "Unzipping %SystemDrive%\php.zip"
%SystemDrive%\unzip.exe %SystemDrive%\php.zip
REM Get rid of the original php zip
del /S /Q %SystemDrive%\php.zip
REM Install the Visual Studio redistributable that php 7 needs
echo "Installing Visual Studio Redistributable"
rem REM REM pause
%MYFILES%\vc_redist.x86.exe /install /quiet
REM **
systeminfo | find "OS Name" > %TEMP%\osname.txt
FOR /F "usebackq delims=: tokens=2" %%i IN (%TEMP%\osname.txt) DO set vers=%%i
REM **

REM Get the right version to install the right MSU
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" (
    echo "Found Windows Version: Windows 8.1"
    echo "Installing PHP DLL Requirement for 8.1"
    wusa.exe %MYFILES%\..\SourceFiles\Windows8.1-KB2999226-x86.msu /quiet /norestart
) else if "%version%" == "6.2" (
    echo "Found Windows Version: Windows 8"

echo %vers% | find "Windows 8" > nul
if %ERRORLEVEL% == 0 (
    echo "Installing PHP DLL Requirement for 8"
    wusa.exe %MYFILES%\..\SourceFiles\Windows8-RT-KB2999226-x86.msu /quiet /norestart
   )

) else if "%version%" == "6.1" (
    echo "Found Windows Version: Windows 7"
REM    echo "Installing System Update Readiness Tool"
REM    wusa.exe %MYFILES%\..\SourceFiles\Windows6.1-KB947821-v35-x86.msu

echo %vers% | find "Windows 7" > nul
if %ERRORLEVEL% == 0 (    
REM echo "Installing PHP DLL Requirement for 7"
REM    wusa.exe %MYFILES%\..\SourceFiles\Windows6.1-KB2999226-x86.msu /quiet /norestart
)
) else if "%version%" == "6.0" (
    echo "Found Windows Version: Windows Vista"
REM    echo "Installing System Update Readiness Tool"
REM    wusa.exe %MYFILES%\..\SourceFiles\Windows6.0-KB947821-v35-x86.msu

echo %vers% | find "Windows Vista" > nul
if %ERRORLEVEL% == 0 (
    echo "Installing PHP DLL Requirement for vista"
    wusa.exe %MYFILES%\..\SourceFiles\Windows6.0-KB2999226-x86.msu /quiet /norestart
)
) else (
    echo "Unable to calculate Windows Version to ensure Updates exist"
)
endlocal
REM install Chocolatey
echo "Installing the Chocolatey Package Manager for Windows"
rem REM REM pause
start /wait cmd /C @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
start /wait cmd /C choco install nuget.commandline -y
REM Install Git
echo "Installing the latest version of Git"
rem REM REM pause
REM timeout  3
start /wait cmd /C choco install git -y

echo "Creating a new env for phconfigure"
schtasks /create /tn StartSetup /tr "cmd.exe /c %temp%\PharoahTools\native-installers-master\Windows\Code\phconfigure.bat" /sc once /st 00:00
schtasks /run /TN \startsetup

