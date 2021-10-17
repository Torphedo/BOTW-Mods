@echo off
color 03
:start
echo Please choose one of the following options:
echo.
echo.
echo      1. Install BCML
echo      2. Create BCML Shortcut
echo      3. Download Cemu
echo      4. Exit
echo.
echo.
set /P selection="Enter the number of your selection:"
cls
2>NUL call :case_%selection%
if errorlevel 1 call :ERROR
:ERROR
echo Invalid selection. Please try again.
pause
cls
goto :start

:case_1
echo Starting BCML Installation...
echo Installing Visual C++...
curl -L -s -o vc_redist.x64.exe https://aka.ms/vs/16/release/vc_redist.x64.exe
vc_redist.x64.exe /quiet
del vc_redist.x64.exe
echo Installing Python...
echo Please wait, this may take a while...
curl -s -o python-3.8.10-amd64.exe https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe
python-3.8.10-amd64.exe /quiet InstallAllUsers=1 DefaultAllUsersTargetDir=C:\Python38 PrependPath=1
del python-3.8.10-amd64.exe
echo Installing BCML...
py -3.8 -m pip install bcml -q

:case_2
echo Creating BCML Shortcut...
curl -s -o Shortcut.zip https://web.archive.org/web/20200530144108/http://optimumx.com/download/Shortcut.zip
curl -s -o %USERPROFILE%/bcml.ico https://raw.githubusercontent.com/NiceneNerd/BCML/master/bcml/data/bcml.ico
powershell -command "Expand-Archive Shortcut.zip ." > NUL
del Shortcut.zip
del ReadMe.txt
Shortcut.exe /A:C /T:"pyw" /P:" -3.8 -m bcml" /I:"%USERPROFILE%\bcml.ico" /F:BCML.lnk > NUL
del Shortcut.exe
echo BCML Shortcut Created.
pause
exit

:case_3
echo Downloading Cemu...
curl -L -s -o cemu-latest.zip https://cemu.info/api/cemu_latest.php
powershell -command "Expand-Archive cemu-latest.zip temp6275"
del cemu-latest.zip
for /d %%a in ("temp6275\*") do (
  rename "%%~fa" Cemu
)
move temp6275\Cemu . > NUL
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
cls
echo Cemu Installation Complete.
echo Remember to upate your Cemu and graphics packs occasionally!
pause
exit

:case_4
exit