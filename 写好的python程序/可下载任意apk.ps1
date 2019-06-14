#param($path)
function appN{
    Write-Host "okokokok："
    $appName=Read-Host
    $searchUrl="http://sj.qq.com/myapp/searchAjax.htm?kw="+$appName+"&pns=&sid="
    $j = Invoke-restmethod $searchUrl
    $ab = for($i=0;$i -le 9;$i++){
        [pscustomobject]@{
        "num"=$i+1
        "appName"=$j.obj.items[$i].appDetail.appName
        #"pkgName"=$j.obj.items[$i].appDetail.pkgName
        "versionName"=$j.obj.items[$i].appDetail.versionName
        #"apkUrl"=$j.obj.items[$i].appDetail.apkUrl
        }
        #$ab|Write-Host
    }
    $ab|format-table
    Write-Host "okokokok："
    $num=Read-Host
    $a=$j.obj.items[$num-1].appDetail.appName
    $b=$j.obj.items[$num-1].appDetail.pkgName
    $c=$j.obj.items[$num-1].appDetail.versionName
    $rename=$a+"_"+$b+"_"+$c
    write-host "okokokok..."
    $client = new-object System.Net.WebClient
    $client.DownloadFile($j.obj.items[$num-1].appDetail.apkUrl,'D:\Download\'+$rename+'.apk')
    write-host "okokokok!"
    write-host "okokokok..."
    start D:\Download\
    CLS
}

while(1){
appN
}
