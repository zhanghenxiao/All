 @echo off
set rar=C:\Program Files\WinRAR\WinRar.exe
for /f "delims=" %%a in ('dir c:\zhang /a-d/s/b *.rar,*.zip') do (
"%rar%" x "%%~a" -o "c:\new" -ibck
)