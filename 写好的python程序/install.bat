@echo off
title downloadApp
mode con cols=70 lines=30
color 20

md D:\Temp\ >nul 2>nul
md D:\Download\ >nul 2>nul

:re
echo param($path)>D:\Temp\tmp.ps1
echo function appN{>>D:\Temp\tmp.ps1
echo     Write-Host "??????APP:">>D:\Temp\tmp.ps1
echo     $appName=Read-Host>>D:\Temp\tmp.ps1
echo     $searchUrl="http://sj.qq.com/myapp/searchAjax.htm?kw="+$appName+"&pns=&sid=">>D:\Temp\tmp.ps1
echo     $j = Invoke-restmethod $searchUrl>>D:\Temp\tmp.ps1
echo     $ab = for($i=0;$i -le 9;$i++){>>D:\Temp\tmp.ps1
echo         [pscustomobject]@{>>D:\Temp\tmp.ps1
echo         "num"=$i+1>>D:\Temp\tmp.ps1
echo         "appName"=$j.obj.items[$i].appDetail.appName>>D:\Temp\tmp.ps1
echo         #"pkgName"=$j.obj.items[$i].appDetail.pkgName>>D:\Temp\tmp.ps1
echo         "versionName"=$j.obj.items[$i].appDetail.versionName>>D:\Temp\tmp.ps1
echo         #"apkUrl"=$j.obj.items[$i].appDetail.apkUrl>>D:\Temp\tmp.ps1
echo         }>>D:\Temp\tmp.ps1
echo         #$ab^|Write-Host>>D:\Temp\tmp.ps1
echo     }>>D:\Temp\tmp.ps1
echo     $ab^|format-table>>D:\Temp\tmp.ps1
echo     Write-Host "???app????????:">>D:\Temp\tmp.ps1
echo     $num=Read-Host>>D:\Temp\tmp.ps1
echo     $a=$j.obj.items[$num-1].appDetail.appName>>D:\Temp\tmp.ps1
echo     $b=$j.obj.items[$num-1].appDetail.pkgName>>D:\Temp\tmp.ps1
echo     $c=$j.obj.items[$num-1].appDetail.versionName>>D:\Temp\tmp.ps1
echo     $rename=$a+"_"+$b+"_"+$c>>D:\Temp\tmp.ps1
echo     write-host "????,???...">>D:\Temp\tmp.ps1
echo     $client = new-object System.Net.WebClient>>D:\Temp\tmp.ps1
echo     $client.DownloadFile($j.obj.items[$num-1].appDetail.apkUrl,$path+'\'+$rename+'.apk')>>D:\Temp\tmp.ps1
echo     write-host "????!">>D:\Temp\tmp.ps1
echo }>>D:\Temp\tmp.ps1
echo appN>>D:\Temp\tmp.ps1

powershell.exe "D:\Temp\tmp.ps1" "D:\Download"
del /F /Q D:\Temp\tmp.ps1
echo ??????...
choice /t 1 /d y /n >nul
start D:\Download\
pause
CLS
goto re