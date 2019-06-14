function Get-installedVersion($driveName){
    $sfobj = Get-InstalledSoftwares
    for ($i=0;$i -le $sfobj.Length;$i++){
        if ($sfobj."Name"[$i] -eq $driveName){return $sfobj."Version"[$i]}
        }
    }
Get-installedVersion("Intel(R) Management Engine Components");read-host "pause"
#Get-installedVersion("Intel(R) Management Engine Driver CMIT DT for Kabylake (Corp)");read-host "pause"