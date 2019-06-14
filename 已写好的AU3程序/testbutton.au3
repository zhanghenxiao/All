#RequireAdmin
;MsgBox("","test","test")

$TITLE = "Application installation wizard"
WinWait($TITLE ,"Application installation complete.", 1)
MsgBox("","test","test")
   WinActivate($TITLE ,"Application installation complete.")
   ControlClick($TITLE ,"Application installation complete.","Button3")