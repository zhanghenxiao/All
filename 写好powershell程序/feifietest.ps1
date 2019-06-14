function Get-installedVersion($driveName){
  $info = get-wmiobject win32_systemdriver
  for ($i=0;$i -le $info.Length;$i++){
    try{$DisplayName = $info[$i].DisplayName.Trim()}catch{}
    if ($DisplayName -eq $driveName){$version = (get-childitem $info[$i].PathName).VersionInfo.ProductVersion}
    else {}}
  if ($version -eq $null){write-host "Sorry:Not found this driver version ! please check."}
  else{return $version}
  }

Get-installedVersion("Conexant UAA Function Driver for High Definition Audio Service")