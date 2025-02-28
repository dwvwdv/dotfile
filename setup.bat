@echo off
setlocal EnableDelayedExpansion

:: 設定 dotfile 來源目錄
set "DOTFILE_DIR=%USERPROFILE%\dotfile"

:: 建立軟連結的子程序
:CreateSymlink
rem %1 = source, %2 = target
set "SOURCE=%~1"
set "TARGET=%~2"

rem 如果目標路徑以 "~" 開頭，替換為 %USERPROFILE%
if "%TARGET:~0,1%"=="~" (
    set "TARGET=%USERPROFILE%%TARGET:~1%"
)

rem 將斜線轉換為反斜線
set "SOURCE=%SOURCE:/=\%"
set "TARGET=%TARGET:/=\%"

rem 取得 TARGET 的父層目錄
for %%I in ("%TARGET%") do set "TARGET_PARENT=%%~dpI"
if not exist "%TARGET_PARENT%" (
    mkdir "%TARGET_PARENT%"
)

rem 刪除已存在的目標（不論為目錄或檔案）
if exist "%TARGET%" (
    rmdir /s /q "%TARGET%" 2>nul || del /f /q "%TARGET%"
)

echo Creating symlink: "%SOURCE%" -> "%TARGET%"
mklink /D "%TARGET%" "%SOURCE%"
goto :EOF

:: 以下依序建立各項軟連結
call :CreateSymlink "%DOTFILE_DIR%\yazi" "~/.config/yazi"
call :CreateSymlink "%DOTFILE_DIR%\nvim" "~/AppData/Local/nvim"
call :CreateSymlink "%DOTFILE_DIR%\starship.toml" "~/.config/starship.toml"
call :CreateSymlink "%DOTFILE_DIR%\lazysql" "~/.config/lazysql"
call :CreateSymlink "%DOTFILE_DIR%\wezterm" "~/.config/wezterm"
call :CreateSymlink "%DOTFILE_DIR%\nushell" "~/AppData/Roaming/nushell"

echo Symlink creation completed!
endlocal
pause
