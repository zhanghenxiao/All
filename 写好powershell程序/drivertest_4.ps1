
function Get-DriverVersion($driverName){
  $keys = Get-Item "HKLM:\SYSTEM\CurrentControlSet\Control\Class\*\*" -ea SilentlyContinue
  $arr = Get-ItemProperty $keys.PSPath
  $isdVersion = ""
  foreach ($key in $arr){
    if ($key.DriverDesc.Trim() -eq $driverName){$isdVersion = $key.DriverVersion.Trim();break}
    }
  if ($isdVersion -ne ""){return $isdVersion}
  else {$_ = "Not found [$driverName] in Device Maneger !";return $_}
  }
#Get-DriverVersion("Intel(R) Ethernet Connection (2) I219-LM")
#Get-DriverVersion("Intel(R) Display Audio")
#Get-DriverVersion("Realtek High Definition Audio")
#Get-DriverVersion("Intel(R) Management Engine Interface")
#Get-DriverVersion("ASUS PA238 (Intel(R) Display Audio)")

