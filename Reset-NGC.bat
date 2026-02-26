@echo off
title Reset NGC Folder Tool

:: ===== Check for Admin Rights =====
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo Running with Administrator privileges...
echo.

:: ===== Commands =====
echo Taking ownership...
takeown /f C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc /r /d y

echo.
echo Granting permissions...
icacls C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc /grant administrators:F /t

echo.
echo Removing folder...
rd /s /q C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc

echo.
echo =====================================
echo Operation completed.
echo =====================================
echo.

:: ===== Reboot Prompt =====
choice /m "Do you want to reboot now?"
if %errorlevel%==1 (
    echo Rebooting...
    shutdown /r /t 0
) else (
    echo You chose to reboot later.
    pause
)
