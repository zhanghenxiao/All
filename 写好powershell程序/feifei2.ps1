olor 10 "Download successful ."
    return [PSCustomObject][Ordered]@{getlog = "Download successful ."},[PSCustomObject][Ordered]@{successNum = 1}
    return $true


function getCsvContents{
    #getMusic
    $currentPath = cmd /c echo %cd%
    $csvFile = $currentPath + "\caseCsv\case.csv"
    while (1) {
        try {$contents = Import-Csv $csvFile} catch {}
        if ($?) {break} 
        else {
            write-host -foregroundcolor 12 "Error: $($Error[0].Exception.Message)"
            start-process ($currentPath + "\caseCsv")
            write-host -foregroundcolor 10 "Press any key to continue:";Read-Host
        }
    }
    return $contents
}

function testStart{
$contents = getCsvContents
$length = $contents.Length
$countNum=$successNum=0
for ($i=0;$i -le $length;$i++)
{
$platform = $contents."Platform"[$i]
if ($platform -eq "Slice")
    {
    $Deliverable_Name = $contents."Deliverable Name"[$i]
    $OS_Name = $contents."OS"[$i]
    $caseOs_Name = getOsName
    $Status = $contents."Status"[$i]
    $SP_Number = $contents."SP Number"[$i]
    if ($OS_Name -eq $caseOs_Name -and $Status -eq "Approved")
        {
        $logObj,$numObj = downloadDrive $SP_Number
        $log = $logObj.getlog
        $successNum = $successNum + $numObj.successNum
        $countNum++
        }
    }
if ($length -eq $i -and $countNum -eq 0){Write-Host "Msg : Sorry, Can't find a driver that meets the criteria."}
}
write-host -foregroundcolor 11 "Msg : Found:"$countNum "|" "Success:"$successNum "|" "Failure:"($countNum - $successNum)
}


testStart
write-host "end !";read-host