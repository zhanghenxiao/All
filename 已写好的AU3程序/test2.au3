#RequireAdmin

$var = 3
While $var <=6
   $var = $var + 1
   $test = FileReadLine(@DesktopDir &"\test.txt",$var)
   ;MsgBox("","",$test)
   Run("C:\Users\succful\Downloads\"& $test &" -s")
WEnd