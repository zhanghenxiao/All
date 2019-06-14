#RequireAdmin
#comments-start
Run (@DesktopDir&"\Download\sp84849.exe -s")

$TITLE = "Application installation wizard"

WinWait($TITLE ,"Welcome to the application installation wizard.", 1)
	  WinWaitActive($TITLE ,"Welcome to the application installation wizard.")
	  ControlClick($TITLE ,"Welcome to the application installation wizard.","Button3")
if WinWait($TITLE ,"Application installation complete.", 1) Then
   WinActivate($TITLE ,"Application installation complete.")
	  ;WinActivate($TITLE ,"Application installation complete.")
	  ;MsgBox("","test","test")
	  ControlClick($TITLE ,"Application installation complete.","Button3")
EndIf
   ;ControlClick($TITLE ,"Application installation complete.","Button3")
WinWait("Microsoft Windows" ,"", 1)
	  WinWaitActive("Microsoft Windows" ,"")
	  ControlClick("Microsoft Windows" ,"&Restart Now","Button1")
#comments-end
;Run("C:\Users\succful\Desktop\Download\sp81955 -s")
Run(@DesktopDir&"\Download\"&$Cmdline[1]&" -s")
;MsgBox("","",$test)