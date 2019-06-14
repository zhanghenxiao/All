#RequireAdmin
Run (@DesktopDir&"\Download\sp82432.exe -s")
$Check = 1

While $Check
$TITLE = "Setup"
$NEXT = WinWait($TITLE)
Switch $NEXT
   Case WinWait($TITLE ,"Welcome", 1)
	  WinActivate($TITLE ,"Welcome")
	  ;MsgBox(1, "yes", "yes")
	  ControlClick($TITLE ,"Welcome","Button2")
   case WinWait($TITLE ,"License Agreement", 1)
	  WinActivate($TITLE ,"License Agreement")
	  ControlClick($TITLE ,"License Agreement","Button4")
	  Sleep(100)
	  ControlClick($TITLE ,"License Agreement","Button2")
	  Sleep(100)
   case WinWait($TITLE ,"Destination Folder", 1)
	  WinActivate($TITLE ,"Destination Folder")
	  ControlClick($TITLE ,"Destination Folder","Button2")
	  Sleep(100)
   Case WinWait($TITLE ,"Completion", 1)
	  WinActivate($TITLE ,"Completion")
	  ;MsgBox(1, "yes", "yes")
	  ControlClick($TITLE ,"Completion","Button3")
	  Run("shutdown -r -t 1")
	  ;Sleep(30000)
	  ExitLoop
EndSwitch
WEnd
