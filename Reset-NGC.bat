@echo off
title Reset NGC Folder Tool

set "NGC=C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"

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

:: ===== Check if Folder Exists =====
if not exist "%NGC%" (
    echo NGC folder not found.
    echo Nothing to reset.
    pause
    exit /b
)

echo WARNING:
echo This will remove Windows Hello PIN and biometric data.
echo.

choice /m "Continue?"
if %errorlevel%==2 exit /b

echo.
echo Stopping Windows Biometric Service...
net stop WbioSrvc >nul 2>&1

echo Taking ownership...
takeown /f "%NGC%" /r /d y >nul

echo Granting permissions...
icacls "%NGC%" /grant administrators:F /t >nul

echo Removing folder...
rd /s /q "%NGC%"

if exist "%NGC%" (
    echo Failed to remove NGC folder.
    echo Please reboot and try again.
    pause
    exit /b
)

echo.
echo Reset completed successfully.
echo.

choice /m "Reboot now?"
if %errorlevel%==1 (
    shutdown /r /t 0
) else (
    echo Please reboot manually before setting up Windows Hello again.
    pause
)
