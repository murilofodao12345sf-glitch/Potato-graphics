@echo off
title Fortnite Potato Pack Installer
echo ═══════════════════════════════════════════════════════════
echo    FORTNITE POTATO PACK - ULTRA FPS OPTIMIZATION
echo ═══════════════════════════════════════════════════════════
echo.
echo Installing aggressive low-spec config for AMD RX 5500 XT...
echo.

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run as Administrator!
    pause
    exit
)

:: Backup existing settings
set BACKUP_DIR=%userprofile%\Desktop\Fortnite_Backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%
echo [1/4] Creating backup at: %BACKUP_DIR%
mkdir "%BACKUP_DIR%" 2>nul
copy "%localappdata%\FortniteGame\Saved\Config\WindowsClient\GameUserSettings.ini" "%BACKUP_DIR%\" 2>nul
echo Backup created!

:: Install GameUserSettings.ini
echo [2/4] Installing potato config...
mkdir "%localappdata%\FortniteGame\Saved\Config\WindowsClient" 2>nul
copy "GameFiles\WindowsClient\GameUserSettings.ini" "%localappdata%\FortniteGame\Saved\Config\WindowsClient\" /Y

:: Set read-only flag
attrib +r "%localappdata%\FortniteGame\Saved\Config\WindowsClient\GameUserSettings.ini"
echo Config installed and locked!

:: Apply registry tweaks
echo [3/4] Applying performance registry tweaks...
regedit /s "Registry_Tweaks\fps_boost.reg"
echo Registry tweaks applied!

:: Apply additional Windows optimizations
echo [4/4] Applying Windows optimizations...

:: Disable Game Mode (can cause issues with Fortnite)
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable fullscreen optimizations globally (can be done per-game too)
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Clear shader cache to prevent stuttering
rmdir /s /q "%localappdata%\AMD\DxcCache" 2>nul
rmdir /s /q "%localappdata%\AMD\ShaderCache" 2>nul

echo.
echo ═══════════════════════════════════════════════════════════
echo  ✅ INSTALLATION COMPLETE!
echo ═══════════════════════════════════════════════════════════
echo.
echo 📌 MANUAL STEPS REMAINING:
echo 1. Open AMD Adrenalin Software
echo 2. Go to Gaming ^> Fortnite
echo 3. Enable: Anti-Lag, Boost (50%), Image Sharpening (80%)
echo 4. Set Texture Filtering to Performance
echo 5. Set Tessellation to Override ^(8x^)
echo.
echo 🚀 Launch Fortnite and enjoy your potato graphics!
echo.
echo 📁 Backup saved to: %BACKUP_DIR%
echo.
pause