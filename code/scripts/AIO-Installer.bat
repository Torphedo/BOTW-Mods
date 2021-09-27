@echo off
:start
echo Please choose one of the following options:
echo.
echo.
echo      1. BCML + Cemu
echo      2. BCML Only
echo      3. Cemu Only
echo      4. Install BOTW from Dumpling folder
echo      5. Create BCML Shortcut
echo      6. Exit
echo.
echo.
set /P ACTION="Enter the number of your selection:"
cls
2>NUL call :case_%ACTION%
if errorlevel 1 call :ERROR
:ERROR
echo Invalid selection. Please try again.
pause
cls
goto :start

:case_1
set install-both=1 equ 1
call :case_2

:case_2
echo Starting BCML Installation...
echo Downloading Visual C++ Installer...
curl -L -s -o vc_redist.x64.exe https://aka.ms/vs/16/release/vc_redist.x64.exe
echo Installing Visual C++...
vc_redist.x64.exe /quiet
del vc_redist.x64.exe
echo Downloading Python Installer...
curl -s -o python-3.8.10-amd64.exe https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe
echo Installing Python...
echo Please wait, this may take a while...
python-3.8.10-amd64.exe /quiet InstallAllUsers=1 DefaultAllUsersTargetDir=C:\Python38 PrependPath=1
del python-3.8.10-amd64.exe
echo Installing BCML...
py -3.8 -m pip install bcml -q
call :shortcut

:shortcut
echo Creating BCML Shortcut...
curl -s -o Shortcut.zip https://web.archive.org/web/20200530144108/http://optimumx.com/download/Shortcut.zip
curl -s -o %USERPROFILE%/bcml.ico https://raw.githubusercontent.com/NiceneNerd/BCML/master/bcml/data/bcml.ico
powershell -command "Expand-Archive Shortcut.zip ."
del Shortcut.zip
del ReadMe.txt
Shortcut.exe /A:C /T:"C:\Windows\pyw.exe" /P:" -3.8 -m bcml" /I:"%USERPROFILE%\bcml.ico" /F:BCML.lnk
del Shortcut.exe
echo BCML Installation Complete
if %install-both% (
   goto :case_4
   )
pause
exit

:case_3
echo.
echo Starting Cemu Installation
echo Downloading Cemu...
curl -L -s -o cemu-latest.zip https://cemu.info/api/cemu_latest.php
powershell -command "Expand-Archive cemu-latest.zip temp6275"
del cemu-latest.zip
for /d %%a in ("temp6275\*") do (
  rename "%%~fa" Cemu
)
move temp6275\Cemu .
rmdir temp6275
echo Downloading CemuHook...
curl -L -s -o cemuhook.zip https://files.sshnuke.net/cemuhook_1251c_0575.zip
powershell -command "Expand-Archive cemuhook.zip Cemu"
del cemuhook.zip
echo Downloading Graphics Packs...
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/ActualMandM/cemu_graphic_packs/releases/latest ^| find "browser_download_url"') do (
    curl -kL -s -o gfx-packs-latest.zip %%B
)
powershell -command "Expand-Archive gfx-packs-latest.zip Cemu\graphicPacks\downloadedGraphicPacks"
del gfx-packs-latest.zip
echo Cemu Installation Complete
if %install-both% (
   echo BCML and Cemu successfully installed
   pause
   exit
   )
pause

:case_4
cls
set /P dumpling="Please enter the location of your Dumpling folder: "
set /P cemu="Please enter the path to your Cemu Installation: "
ren "%dumpling%\Games\Breath of the Wild" 101c9400
ren "%dumpling%\Updates\Breath of the Wild" 101c9400
ren "%dumpling%\DLCs\Breath of the Wild" 101c9400
echo Copying Base Game files...
xcopy "%dumpling%\Games\101c9400" "%cemu%\mlc01\usr\title\00050000\101c9400" /E /I /Q
echo Copying Update files...
xcopy "%dumpling%\Updates\101c9400" "%cemu%\mlc01\usr\title\0005000e\101c9400" /E /I /Q
echo Copying DLC files...
xcopy "%dumpling%\DLCs\101c9400" "%cemu%\mlc01\usr\title\0005000c\101c9400" /E /I /Q

ren "%dumpling%\Games\101c9400" "Breath of the Wild"
ren "%dumpling%\Updates\101c9400" "Breath of the Wild"
ren "%dumpling%\DLCs\101c9400" "Breath of the Wild"

:case_5
echo Creating BCML Shortcut...
curl -s -o Shortcut.zip https://web.archive.org/web/20200530144108/http://optimumx.com/download/Shortcut.zip
curl -s -o %USERPROFILE%/bcml.ico https://raw.githubusercontent.com/NiceneNerd/BCML/master/bcml/data/bcml.ico
powershell -command "Expand-Archive Shortcut.zip ."
del Shortcut.zip
del ReadMe.txt
Shortcut.exe /A:C /T:"C:\Windows\pyw.exe" /P:" -3.8 -m bcml" /I:"%USERPROFILE%\bcml.ico" /F:BCML.lnk
del Shortcut.exe
echo BCML Shortcut Created.

:case_6
exit