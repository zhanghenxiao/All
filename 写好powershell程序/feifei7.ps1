param($path)




function writeLog{foreach($arg in $args){$str=$str +$arg + "|"};$str+$(get-date)>>".\caseCsv\log.txt"}




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

            default{Write-Warning "Sorry, the current system cannot be identified !";exit}

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

    New-Item -path ".\Download" -ItemType Directory -ea SilentlyContinue

    $des = ".\Download\" + $reName

    #write-host  -f 3 "Downloading: "$reName

    #Invoke-WebRequest -uri $DownloadUrl -OutFile $des

    write-host  -f 10 ($_ = "Download successful .")

    return ("Success:"+$_),1

    return $true

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

    $arr = "Platform","Deliverable Name","OS","Status","SP Number"

    foreach($i in $arr){

        if ($contents.$i -eq $null) {

            write-host -f 11 "Msg: `"$i`" Column not found!"

            write-host -f 10 "Press any key to exit...";Read-Host;exit}}

    }




function testStart($DeviceName){

$contents = getCsvContents

checkColumnName $contents

$getOsName = getOsName

$length = $contents.Length

"lines|logMsg|spNumber|time">".\caseCsv\log.txt"

$countNum=$successNum=0

write-host -f 11 "DeviceName: "$DeviceName

for ($i=0;$i -le $length;$i++){

    $platform = $contents."Platform"[$i]

    #if (1){#Matching all devices

    if ($platform -eq $DeviceName){

        $Deliverable_Name = $contents."Deliverable Name"[$i]

        $OS_Name = $contents."OS"[$i]

        $caseOs_Name = $getOsName

        $Status = $contents."Status"[$i]

        $SP_Number = $contents."SP Number"[$i]

        if ($OS_Name -eq $caseOs_Name -and $Status -eq "Approved")

        #if ($OS_Name -eq $caseOs_Name) #Don't match Status

            {

            $log,$sNum = downloadDrive $SP_Number

            $log = $log

            writeLog "$($i+2)" $log $SP_Number

            $successNum = $successNum + $sNum

            $countNum++

            }

        }

    if ($length -eq $i -and $countNum -eq 0){Write-Host -f 11 "Msg : Can't find a driver that meets the criteria."}

    }

write-host -f 11 "Msg : Found:"$countNum "|" "Success:"$successNum "|" "Failure:"($countNum - $successNum)

}







#--------------------------------start--------------------------

#------DeviceName------




while(1){

    Write-Host -f 10 "Download what device drivers? Please enter name:";

    $_=$DeviceName = read-host;if($_ -eq ""){cls;continue}else{cls;break}}




#------execute-----

testStart $DeviceName




#------end----

write-host -f 14 "end !";

write-host -f 10 "Press any key to exit...";Read-Host

#--------------------------------start--------------------------