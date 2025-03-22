@echo off

:TIME_INPUT
set /p "choice=Enter the time until shutdown (m for minutes, h for hours): "

if "%choice%" == "" (
  CLS
  echo Please enter "m" for minutes or "h" for hours.
  goto WAIT
)

CLS
if /i "%choice%"=="m" (
  set /p "TMinus=Enter time in minutes: "
  set /a TMinus*=60
) else if /i "%choice%"=="h" (
  set /p "TMinus=Enter time in hours: "
  set /a TMinus*=3600
) else (
  echo Invalid choice. Please enter "m" or "h".
  goto TIME_INPUT
)

shutdown -s -t %TMinus%
CLS

echo Scheduled shutdown in...
echo.
set /a TMinus/=60
echo %TMinus% Minutes
set /a TMinus/=60F
echo %TMinus% hours
echo.

pause
