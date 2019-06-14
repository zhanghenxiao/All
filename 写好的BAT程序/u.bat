@echo off
for /f "tokens=2 delims==" %%a in ('wmic LogicalDisk where "DriveType='2'" get DeviceID /value') do (
set DriveU=%%a
)
echo.%DriveU%
pause