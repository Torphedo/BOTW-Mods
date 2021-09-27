@echo off
:start
echo Please choose one of the following options:
echo.
echo      1. BCML Quick Setup
echo      2. Exit
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
cls
set /P ACTION="Please enter the path to your Cemu Installation: "
cls

set "ACTION=%ACTION:\=\\%" # Converts Windows single slashes to the double slashes BCML requires.

echo { > %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "cemu_dir": "%ACTION%", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "game_dir": "%ACTION%\\mlc01\\usr\\title\\00050000\\101c9400\\content", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "game_dir_nx": "", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "update_dir": "%ACTION%\\mlc01\\usr\\title\\0005000e\\101c9400\\content", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "dlc_dir": "%ACTION%\\mlc01\\usr\\title\\0005000c\\101c9400\\content\\0010", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "dlc_dir_nx": "", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "store_dir": "%ACTION%\\BCML", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "export_dir": "%ACTION%\\graphicPacks\\BreathOfTheWild_BCML", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "export_dir_nx": "E:\\Emulation\\BCML\\mods_nx\\9999_BCML", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "load_reverse": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "site_meta": "", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "no_guess": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "lang": "USen", >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "no_cemu": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "wiiu": true, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "no_hardlinks": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "force_7z": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "suppress_update": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "loaded": true, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "nsfw": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "changelog": true, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "strip_gfx": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "auto_gb": true, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "dark_theme": false, >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo   "last_version": "3.5.0" >> %USERPROFILE%\AppData\Local\bcml\settings.json
echo } >> %USERPROFILE%\AppData\Local\bcml\settings.json
exit

:case_2
exit