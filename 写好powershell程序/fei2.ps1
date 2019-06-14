param($path)
$sName = "Conexant High Definition Audio Driver"
$jsonFilePath = "D:\Temp\support.txt"
function findDrive{
    $text=Get-Content -path $jsonFilePath
    $a = $text|Convertfrom-Json
    $serchAll = for ($i=0;$i -le 1000;$i++){
        $check = $a.softwareDriversList.latestVersionDriver[$i]
        if ($check -eq $null){Write-Host "fail: not found !" $sName;break}
        $title = $a.softwareDriversList.latestVersionDriver.title[$i]
        if ($title -eq $sName){
        $version = $a.softwareDriversList.latestVersionDriver.version[$i]
        $fileUrl = $a.softwareDriversList.latestVersionDriver.productSoftwareFileList.fileUrl[$i]
        $fileName = $a.softwareDriversList.latestVersionDriver.productSoftwareFileList.fileName[$i] 
        Write-host "Success:"$title "|" $version "|" $fileUrl "|" $fileName
        $des = "D:\Temp\Download\"+$fileName
	    Invoke-WebRequest -uri $fileUrl -OutFile $des
        break}
    }
}
findDrive