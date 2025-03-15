@echo off
title Splunk Status Checker
mode con: cols=60 lines=20
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

echo.
echo ================================
echo To restart Splunk, type 'yes' or 'y' and press Enter.
echo Otherwise, just press Enter to quit.
set /p user_input=Your choice: 

:: Check user input for restart command
if /i "%user_input%"=="yes" goto restart
if /i "%user_input%"=="y" goto restart

echo.
echo No restart initiated. Exiting...
pause >nul
exit

:restart
echo.
echo Restarting Splunk...
%SPLUNK_BIN% restart
echo.
echo Splunk has been restarted. Press any key to exit...
pause >nul
exit
