#RequireAdmin
Global $IsNotFinished = 1

Install()

Func Install()

   ShellExecute("C:\Users\succful\Desktop\sp82412.exe")

   $Title = "[CLASS:#32770]"
   $Win = WinWait($Title)

   While $IsNotFinished
	  Switch $Win
	  Case WinWait($Title, "DESCRIPTION:  ", 5)
			MsgBox(1, "test", "test")
			ControlClick($Title, "TITLE:  Intel Bluetooth Driver (Windows 10)", "Button2")
		 ;Case WinWait($Title, "", 5)
	  EndSwitch
   WEnd
EndFunc