@echo off
for /f "delims=" %%i in (cla.txt) do (
if not defined %%i set %%i=A & echo %%i >str_.txt)
start str_.txt
pause 