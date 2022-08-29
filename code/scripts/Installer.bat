@echo off
color 03
:start
echo Please choose one of the following options:
echo.
echo.
echo      1. Install BCML
echo      2. Create BCML Shortcut
echo      3. Exit
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
rem This the easy part, just installing everything
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
pip install cefpython3
rem Intentionally falls into the shortcut code because option 1 does both

:case_2
echo Creating BCML Shortcut...

rem This code is a sin burn it with fire please
rem fuck batch, this is so overcomplicated
echo import shutil > path.py
echo path = shutil.which("pythonw") >> path.py
echo print(path) >> path.py

for /f %%f in ('path.py') do (set pywpath=%%f)
del path.py
set pyfolder=%pywpath:\pythonw.EXE=\%

curl -s -o Shortcut.zip https://web.archive.org/web/20200530144108/http://optimumx.com/download/Shortcut.zip
powershell -command "Expand-Archive Shortcut.zip ." > NUL
del Shortcut.zip
del ReadMe.txt
Shortcut.exe /A:C /T:%pywpath% /P:"-m bcml" /I:"%pyfolder%Lib\site-packages\bcml\data\bcml.ico" /F:BCML.lnk > NUL
Shortcut.exe /A:C /T:%pyfolder%python.exe /P:"-m pip install -U bcml" /I:"%pyfolder%Lib\site-packages\bcml\data\bcml.ico" /F:"Update BCML.lnk" > NUL
del Shortcut.exe
echo BCML Shortcut Created.
pause

:case_3
exit
