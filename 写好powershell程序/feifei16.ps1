param($path)

function Get-State{
    try{$cts = (Get-Content -Path ".\Logs\State.txt" -ea SilentlyContinue).Split("|")}
    catch{$cts = "download|0"}
    return $cts.split("|")}

function Go-Exit{write-host -f 10 "Press Enter key to exit...";Read-Host;exit}

function writeStateLog{$str=$args[0] + "|" + $args[1];$str>".\Logs\State.txt"}

function writeLog{$str = "";foreach($arg in $args){$str=$str +$arg + "|"};$str+$(get-date)>>".\Logs\DownloadLog.txt"}

function writeSuccessLog{$str = "";foreach($arg in $args){$str=$str +$arg + "|"};$str>>".\Logs\DownloadSuccessLog.txt"}

function getMusic{start (${env:ProgramFiles(x86)} + "\Windows Media Player\wmplayer.exe") ($env:TEMP + "\testmp3.mp3")}

function getOsName{
    $system = (Get-WmiObject Win32_OperatingSystem).Caption
    $digits = (Get-WmiObject Win32_OperatingSystem).OSArchitecture
    $OsArr = $system+" "+$digits
    switch -Wildcard ($OsArr){
            {$_.split() -contains "7" -and $_.split() -contains "64-bit"} {"Microsoft Windows 7 Professional 64 Edition"}
            {$_.split() -contains "7" -and $_.split() -contains "32-bit"} {"Microsoft Windows 7 Professional 32 Edition"}
            {$_.split() -contains "8.1" -and $_.split() -contains "64-bit"} {"Microsoft Windows 8.1 64"}
            {$_.split() -contains "10" -and $_.split() -contains "64-bit"} {"Microsoft Windows 10 64"}
            default{Write-Warning "Sorry, the current system cannot be identified !";Go-Exit}
        }
    }

function downloadDrive{
    Trap {write-host -f 12 ($_="Error: $($_.Exception.Message)");return ("Warning:"+$_),0;continue}
    $spNumber =  $args[0]
    switch ($spNumber.length){
        7 {$pattern='(\d{5})';$null = $spNumber -match $pattern;}
        6 {$pattern='(\d{4})';$null = $spNumber -match $pattern;}
        0 {Write-Warning ($_="SP Number is empty !");return ("Warning:"+$_),0}
        default {Write-Warning ($_="Sp Number is not correct !");return ("Warning:"+$_),0}
        }
    $reName = "sp" + $Matches[1] +".exe"
    $calculateNum = [math]::Floor(($Matches[1]-1)/500)*500
    $dirName = "sp" + ([string]($calculateNum+1)) + "-" + ([string]($calculateNum+500))+ "/" +$reName
    $DownloadUrl = "http://ftp.hp.com/pub/softpaq/" + $dirName
    $null = New-Item -path ".\Temp" -ItemType Directory -ea SilentlyContinue
    $null = New-Item -path ".\Download" -ItemType Directory -ea SilentlyContinue
    $des = ".\Temp\" + "$reName.sgf"
    write-host  -f 3 "Downloading: "$reName
    Invoke-WebRequest -uri $DownloadUrl -OutFile $des
    $null = Move-Item -Path $des -Destination ".\Download\$reName" -ea SilentlyContinue
    write-host  -f 10 ($_ = "Download successful .")
    return ("Success:"+$_),1,$reName
    }

function getCsvContents{
    #getMusic
    New-Item -path "caseCsv" -ItemType Directory -ea SilentlyContinue
    $csvFile = ".\caseCsv\case.csv"
    while (1) {
        try {$contents = Import-Csv $csvFile} catch {}
        if ($?) {break} 
        else{
            write-host -f 6 "Msg: $($Error[0].Exception.Message)"
            start-process (".\caseCsv")
            write-host -f 10 "Please put the `"case.csv`" in this directory:"
            try{Copy-Item -Path "$(Read-Host)" -Destination ".\caseCsv" -Force}catch{};cls
            }
        }
    return $contents
    }

function checkColumnName($contents){
    $arr = "Platform","Deliverable Name","OS","Status","SP Number","SP Version"
    foreach($i in $arr){
        if ($contents.$i -eq $null) {
            write-host -f 11 "Msg: `"$i`" Column not found!"
            Go-Exit}}
    }

function dlMain($DeviceName){
$contents = getCsvContents
checkColumnName $contents
$getOs_Name = getOsName
$length = $contents.Length
$null = New-Item -path "Logs" -ItemType Directory -ea SilentlyContinue
"lines|logMsg|spNumber|time">".\Logs\DownloadLog.txt"
"Success Download :">".\Logs\DownloadSuccessLog.txt"
"spNumber|Deliverable_Name|SP_Version">>".\Logs\DownloadSuccessLog.txt"
$countNum=$successNum=0
write-host -f 11 "DeviceName: "$DeviceName
for ($i=0;$i -le $length;$i++){
    $platform = $contents."Platform"[$i]
    #if (1){#Matching all devices
    if ($platform -eq $DeviceName){
        $Deliverable_Name = $contents."Deliverable Name"[$i]
        $SP_Version = $contents."SP Version"[$i]
        $caseOS_Name = $contents."OS"[$i]
        $Status = $contents."Status"[$i]
        $SP_Number = $contents."SP Number"[$i]
        if ($getOS_Name -eq $caseOs_Name -and $Status -eq "Approved")
        #if ($OS_Name -eq $caseOs_Name) #Don't match Status
            {
            $log,$sNum,$reName = downloadDrive $SP_Number
            $log = $log
            writeLog "$($i+2)" $log $SP_Number
            if ($sNum -eq 1){writeSuccessLog $reName $Deliverable_Name $SP_Version}
            $successNum = $successNum + $sNum
            $countNum++
            }
        }
    if ($length -eq $i -and $countNum -eq 0){Write-Host -f 11 "Msg : Can't find a driver that meets the criteria."}
    }
write-host -f 11 "Msg : Found:"$countNum "|" "Success:"$successNum "|" "Failure:"($countNum - $successNum)
}

function dl-Start{
    while(1){
        Write-Host -f 10 "Download what device drivers? Please enter name:";
        $_=$DeviceName = read-host;if($_ -eq ""){cls;continue}else{cls;break}}
    dlMain $DeviceName
    write-host -f 14 "end !";
    writeStateLog "install" "2"
    "spNumber|Installed_driveName|spVersion|installedVersion">".\Logs\Compare_Version_Log.txt"
    #Go-Exit
    }

#---------------------------------------------------------------

function writeInstallLog{$str = "";foreach($arg in $args){$str=$str +$arg + "|"};$str>>".\Logs\Install_Log.txt"}

function writeCompareLog{$str = "";foreach($arg in $args){$str=$str +$arg + "|"};$str>>".\Logs\Compare_Version_Log.txt"}

function Get-SuccessDL($line){
    #cls;Write-Host -f 11 "Wait for download to succeed ..."
    while(1) {
        $successLog = Get-Content ".\Logs\DownloadSuccessLog.txt"
        if ($successLog[$line] -ne $null) {
            return $successLog[$line]}
        else{if($line -ne 2){
            
            notepad.exe ".\Logs\Compare_Version_Log.txt";writeStateLog "download" "0";Go-Exit}
            else{Write-Host "Not Found !";writeStateLog "download" "0";Go-Exit}
            }
        Start-Sleep -Seconds 1
        }
    }

function Get-InstalledSoftwares
{
    # Read registry key as product entity.
    function ConvertTo-ProductEntity
    {
        param([Microsoft.Win32.RegistryKey]$RegKey)
        $product = '' | select Name,Version,UninstallString
        $product.Name =  $_.GetValue("DisplayName")
        #$product.Version =  $_.GetValue("DisplayVersion")
        $product.uninstallString =  $_.GetValue("UninstallString")

        if( -not [string]::IsNullOrEmpty($product.Name)){
            $product
        }
    }

    $UninstallPaths = @(,
    # For local machine.
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    # For current user.
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall')

    # For 32bit softwares that were installed on 64bit operating system.
    if([Environment]::Is64BitOperatingSystem) {
        $UninstallPaths += 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'

    }
    $UninstallPaths | foreach {
        Get-ChildItem $_ | foreach {
            ConvertTo-ProductEntity -RegKey $_
        }
    }
}



function Get-NameContents(){
    #getMusic
    New-Item -path "caseCsv" -ItemType Directory -ea SilentlyContinue
    $csvFile = ".\caseCsv\Name.csv"
    while (1) {
        try {$contents = Import-Csv $csvFile} catch {}
        if ($?) {break} 
        else{
            write-host -f 6 "Msg: $($Error[0].Exception.Message)"
            start-process (".\caseCsv")
            write-host -f 10 "Please put the `"Name.csv`" in this directory:"
            try{Copy-Item -Path "$(Read-Host)" -Destination ".\caseCsv" -Force}catch{};cls
            }
        }
    return $contents
    }

function Install-Spexe($spNumber,$spName,$line){
    Write-Host -f 13 "installing $spNumber..."
    while (1){
        if (Test-Path ".\Au3Install\Au3$spNumber"){break}
        else {write-host -f 13 "Msg: Not found Au3$spNumber !";Start-Process ".\Au3Install";read-host;}}
    writeStateLog "compare" "$line"
    cmd "/c" ".\Au3Install\Au3$spNumber"
    Start-Sleep -Seconds 1
    Write-Host "Completed ."
    }

function Uninstall-Sp($driverName,$line){
    $keys = Get-Item "HKLM:\SYSTEM\CurrentControlSet\Control\Class\*\*" -ea SilentlyContinue
    $arr = Get-ItemProperty $keys.PSPath
    $isdVersion = ""
    foreach ($key in $arr){
        if ($key.DriverDesc.Trim() -eq $driverName){
            Write-Host -f 11 "$driverName already exists,Please uninstall."
            Write-Host -f 11 "If you already uninstall it, press Enter to continue ...";Read-Host
            Install-Start($line)
            }
        }
    <#
    if ($isdVersion -ne ""){return $isdVersion}
    else {$_ = "Not found [$driverName] in Device Maneger !";return $_}

    $sfobj = Get-InstalledSoftwares
    for ($i=0;$i -le $sfobj.Length;$i++){
        if ($sfobj."Name"[$i] -eq $driverName){
            $uninstallString = $sfobj."uninstallString"[$i]
            Write-Host -f 11 "$driverName already exists,Now uninstall..."
            Start-Process $uninstallString -wait
            Write-Host -f 10 "Uninstalled completed ! Restart after 5 seconds..."
            Start-Sleep -s 5;Restart-Computer -Force
            break
            }
        }#>
    }

function Get-installedVersion($driverName){
    $keys = Get-Item "HKLM:\SYSTEM\CurrentControlSet\Control\Class\*\*" -ea SilentlyContinue
    $arr = Get-ItemProperty $keys.PSPath
    $isdVersion = ""
    foreach ($key in $arr){
        if ($key.DriverDesc.Trim() -eq $driverName){$isdVersion = $key.DriverVersion.Trim();break}
        }
    if ($isdVersion -ne ""){return $isdVersion}
    else {$_ = "Not found [$driverName] in Device Maneger !";return $_}
    }

function get-installedDriveName($spNumber){
    #Write-Host "Emergency development !";Go-Exit
    try{
        $path = ".\Download\$spNumber"
        $f = Get-item $path -ea SilentlyContinue
        $drName = $f.Versioninfo.FileDescription.Trim()
        }
    catch{return "Not found $spNumber!"}
    $contents = Get-NameContents
    for ($i=0;$i -lt $contents.length;$i++){
        $dldrName = $contents.download_drivername[$i].Trim()
        if ($dldrName -eq $drName){return ($contents.install_drivername[$i].Trim())}
        }
    return "Not found !"
    }

function Compare-Version($spNumber,$Installed_driveName,$spVersion,$installedVersion){
    Write-Host -f 13 "Contrast version..."
    Write-Host -f 11 "sp Number : $spNumber"
    Write-Host -f 11 "Installed_driveName : $Installed_driveName"
    Write-Host -f 11 "Sp Version : $spVersion"
    Write-Host -f 11 "InstalledVersion : $installedVersion"
    if ($InstalledVersion -eq $null){Write-Host "Temporarily unable to compare version !";$result="yes"}
    else {$result="yes"}
    Write-Host "Completed ."
    Start-Sleep -Seconds 1
    writeCompareLog $spNumber $Installed_driveName $spVersion $installedVersion
    }

function Install-Start($line){
    $null = New-Item -path "Au3Install" -ItemType Directory -ea SilentlyContinue
    $contents = Get-SuccessDL $line
    $lineContent = $contents.split("|")
    $spNumber = $lineContent[0]
    $spName = $lineContent[1]
    $Installed_driveName = get-installedDriveName($spNumber)
    Uninstall-Sp $Installed_driveName $line
    Install-Spexe $spNumber $spName $line
    }

function Compare-Start($line){
    $contents = Get-SuccessDL $line
    $lineContent = $contents.split("|")
    $spNumber = $lineContent[0]
    $spName = $lineContent[1]
    $spVersion = $lineContent[2]
    $Installed_driveName = get-installedDriveName($spNumber)
    $installedVersion = get-installedVersion($Installed_driveName)
    Compare-Version $spNumber $Installed_driveName $spVersion $installedVersion
    $line++
    writeStateLog "install" $line
    }

#---------------------------------------------------------------
#start
while (1){
    $state,[Int32]$number = Get-State
    switch($state){
        "download"{dl-Start}
        "install"{Install-Start $number;Start-Sleep -Seconds 60}
        "compare"{Write-Host "Compare the version after 3 seconds...";Start-Sleep -Seconds 3;Compare-Start $number}
        }
    }
