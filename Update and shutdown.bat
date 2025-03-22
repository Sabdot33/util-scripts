@echo off
:input_loop
echo Do you want to shutdown? (y/n)
set /p choice=
if /i "%choice%"=="y" (
    echo Starting updates and shutdown...
    choco upgrade all -y
    winget upgrade --all
    spicetify update
    shutdown /s /f /t 0
) else if /i "%choice%"=="n" (
    echo Starting updates without shutdown...
    choco upgrade all -y
    winget upgrade --all
    spicetify update
) else (
    echo Invalid input. Please enter 'y' or 'n'.
    goto input_loop
)