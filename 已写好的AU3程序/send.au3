#RequireAdmin
$Check = 1

#comments-start
Run("notepad.exe")
$var = ControlGetText("[CLASS:Notepad]", "", "Edit1")
MsgBox("","",$var)

Run ("C:\Users\succful\Downloads\sp82238")
WinWaitActive("[CLASS:#32770]")
WinGetText("[active]")p
$var = wingettext("[CLASS:#32770]","")
Sleep(500)
MsgBox(64,"",$var)
#comments-end#comments-end
Run("C:\Users\zhang\Downloads\sp82432 -s")
Run("C:\Users\zhang\Downloads\sp74234.exe -s")

;WinWaitActive("[CLASS:#32770]")

;$title = WinGetTitle("[CLASS:#32770]", "")
;MsgBox(1, "test", $title)
$text=ControlGetText("[CLASS:#32770]", "", "Static1")
While $Check
   WinWaitActive("[CLASS:#32770]")
   $title = WinGetTitle("[CLASS:#32770]", "")
   $text=ControlGetText("[CLASS:#32770]", "", "Static1")
   ;MsgBox(1, "test", $title)
   ;MsgBox(1, "test", $text)
   $NEXT = WinWait($title)
   Switch $NEXT
	  Case WinWait($title,$text)
		 WinWaitActive($title,$text)
		 ControlClick($title,$text,"&Next >")
		 ControlClick($title,$text,"&Yes")
	  Case WinWait($title,$text)
		 WinWaitActive($title,$text)
		 ControlClick($title,$text,"Button2")
		 ;MsgBox(1, "test", "test")
	  Case Else
		 ;MsgBox(1, "test", "test2")
	  EndSwitch

WEnd