cd C:\tes
$test  = dir -Name
$filecount = $test.Count
for($i=0;$i -lt $filecount; $i++){
$a = Get-Content $test[$i]  -Raw
$test[$i]
if($a -match “\[Error\].+”) {
    write-host -f 12 fail 
    $Matches.Values > "C:\Users\succful\Desktop\MLlog.txt"
    
}else{write-host -f 10 pass}
}

