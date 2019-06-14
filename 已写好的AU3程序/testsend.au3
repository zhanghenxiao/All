#RequireAdmin
#comments-start
Run("C:\Users\succful\Downloads\sp81955 -s")
WinWaitActive("[CLASS:#32770]")
;ControlSetText("[CLASS:#32770]","","[CLASSNN:RICHEDIT1]”)

;$text = WinGetText("[CLASS:#32770]", "")
$handle = WinGetTitle("[CLASS:#32770]", "")
MsgBox(0, "", $handle)
#comments-end
Send("#p")
