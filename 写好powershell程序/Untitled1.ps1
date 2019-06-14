<#
param（
    [parameter(mandatory = $True)]
    [Alias('hostname')]
    [string]$computername,

    [validateset(2,3)]
    [int]$drivertype = 3 
）
Write-Verbose "Connecting to $computername" 
Write-Verbose "Looking for drive type $drivetype" 
Get-WmiObject -class Win32_LogicalDisk -computername $computername ` -filter "drivetype=$drivetype" | 
 Sort-Object -property DeviceID | 
 Select-Object -property DeviceID， 
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}}, 
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}} 
Write-Verbose "Finished running command"
#>
param(
  [parameter(mandatory = $true)]
  [string]$computername
  []
)
#$testname = 'locahost'
get-wmiobject win32_networkadapter -computername `$testname` |  
 where { $_.PhysicalAdapter } |  
 select MACAddress,AdapterType,DeviceID,Name,Speed