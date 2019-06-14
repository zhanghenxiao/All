@echo off
for /f "delims=" %%a in (22.txt) do (
echo "%%a"|find "version" &&echo %%a >>newtest.txt
)
echo end...
pause