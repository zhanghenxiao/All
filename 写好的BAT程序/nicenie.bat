@echo off

md D:\Temp\Download>nul 2>nul
md D:\Temp\Install>nul 2>nul

set /p reNum=0<D:/Temp/tmp.txt
set /a reNum=%reNum%
for /f "skip=%reNum% tokens=1 delims= " %%i in (D:\Temp\ae.txt) do (
set down_url=%%i&&goto ou)
)
:ou

for /f "skip=%reNum% tokens=2 delims= " %%i in (D:\Temp\ae.txt) do (
set anzhuang=%%i&&goto ou1)
)
:ou1


pause
echo param($url)>D:\Temp\xiazai.ps1
echo $client = new-object System.Net 

.WebClient>>D:\Temp\xiazai.ps1 read-host
echo $client.DownloadFile($url,"D:\Temp\Download\qudong.exe")>>D:\Temp\xiazai.ps1
echo downloading...
powershell.exe "D:\Temp\xiazai.ps1" ""%down_url%""

%anzhuang%

set /a m=%reNum%+1
>D:/Temp/tmp.txt echo %m%
pause
::shutdown /r /t 0

