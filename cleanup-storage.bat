@echo off
:: Cleanup Script for Windows
:: Removes temporary files, clears old logs, and frees up disk space.

echo Starting system cleanup...

:: 1. Clear Windows Temporary Files
echo Cleaning up temporary files...
del /s /q "%TEMP%\*" >nul 2>&1
rmdir /s /q "%TEMP%" >nul 2>&1
mkdir "%TEMP%" >nul 2>&1

:: 2. Clear System Temp Files
del /s /q "C:\Windows\Temp\*" >nul 2>&1
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp" >nul 2>&1

:: 3. Clear Recycle Bin
echo Emptying Recycle Bin...
rd /s /q "%systemdrive%\$Recycle.Bin" >nul 2>&1

:: 4. Remove Old Log Files (older than 7 days)
echo Removing old log files...
forfiles /p "C:\Windows\Logs" /s /m *.log /d -7 /c "cmd /c del @file" >nul 2>&1

:: 5. Clean up Windows Update Cache (optional)
echo Cleaning up Windows Update cache...
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1

:: 6. Clear Prefetch Files (optional)
echo Cleaning up Prefetch files...
del /s /q "C:\Windows\Prefetch\*" >nul 2>&1

:: 7. Check for Large Files (Optional)
set /p checkLargeFiles="Do you want to search for large files (>100MB) on C:? (y/n): "
if /i "%checkLargeFiles%"=="y" (
    echo Searching for large files on C: drive...
    forfiles /p C:\ /s /m *.* /c "cmd /c if @fsize gtr 104857600 echo @path (@fsize bytes)"
) else (
    echo Skipping large file search.
)

:: Final Message
echo System cleanup completed!
pause
