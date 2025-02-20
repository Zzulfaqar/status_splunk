@echo off
title Splunk Status Checker
mode con: cols=60 lines=14
color 0A

set SPLUNK_BIN="C:\Program Files\Splunk\bin\splunk.exe"
set TEMP_FILE="%temp%\splunk_status_check.txt"

echo ================================
echo   Checking Splunk Status...
echo ================================
echo Created by https://github.com/Zzulfaqar
echo.

:: Check Splunk status and save output to a temp file
%SPLUNK_BIN% status > %TEMP_FILE% 2>&1

:: Display status in the command prompt
type %TEMP_FILE%

:: Check if Splunk is already running
findstr /C:"Splunkd: Running" %TEMP_FILE% >nul
if %errorlevel%==0 (
    echo.
    echo ================================
    echo Splunk is already running! No action needed.
    echo Press any key to exit...
    pause >nul
    exit
)

:: If Splunk is not running, ask the user whether to start it
echo.
echo ================================
echo Splunk is not running. Do you want to start it? (yes/y to proceed)
set /p user_input=Type your choice: 

:: Validate user input
if /i "%user_input%"=="y" goto start_splunk
if /i "%user_input%"=="yes" goto start_splunk
if /i "%user_input%"=="n" goto no_action
if /i "%user_input%"=="no" goto no_action

:: Handle invalid input
echo.
echo Invalid input! Please enter 'yes', 'y', 'no', or 'n'.
echo Press any key to exit...
pause >nul
exit

:start_splunk
echo.
echo Starting Splunk...
%SPLUNK_BIN% start

echo.
echo Splunk has been started. Press any key to exit...
pause >nul
exit

:no_action
echo.
echo No action taken. Exiting...
pause >nul
exit
