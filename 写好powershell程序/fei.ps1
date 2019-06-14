$name=Read-Host "iuput"
pause
$src = "http://ftp.hp.com/pub/softpaq/sp80001-80500/sp80318.exe"
$des = "D:\Temp\Download\$name"
Invoke-WebRequest -uri $src -OutFile $des
