#RequireAdmin
Run (@DesktopDir&"\Download\sp81955.exe -s")


$TITLE = "Intel® Installation Framework"
   WinWait($TITLE ,"Welcome to the Setup Program", 1)
	  WinWaitActive($TITLE ,"Welcome to the Setup Program")
	  ControlClick($TITLE ,"Welcome to the Setup Program","Button4")
	  Sleep(200)
   WinWait($TITLE ,"License Agreement", 1)
	  WinActivate($TITLE ,"License Agreement")
	  ControlClick($TITLE ,"License Agreement","Button2")
	  ;Sleep(100)
	  ;ControlClick($TITLE ,"License Agreement","Button2")
	  ;Sleep(100)
   WinWait($TITLE ,"Intel® Graphics Driver", 1)
	  WinActivate($TITLE ,"Intel® Graphics Driver")
	  ControlClick($TITLE ,"Intel® Graphics Driver","Button2")
	  Sleep(100)
   WinWait($TITLE ,"Setup Progress", 1)
	  WinActivate($TITLE ,"Setup Progress")
	  ControlClick($TITLE ,"Setup Progress","Button1")
	  Sleep(200)
   WinWait($TITLE ,"Setup Is Complete", 1)
	  WinWaitActive($TITLE ,"Setup Is Complete")
	  ControlClick($TITLE ,"Setup Is Complete","Button3")

