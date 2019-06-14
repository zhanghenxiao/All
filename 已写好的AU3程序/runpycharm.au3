#RequireAdmin

;$i = 1

;Run("C:\Users\succful\Desktop\Download\sp81955 -s")
;Run("C:\Users\zhang\Downloads\"&$Cmdline[1]&" -s")

Run(@DesktopDir&"\Downloads\" & $CmdLine[1] & " -s")
Run(@DesktopDir&"\Download\"&$Cmdline[1]&" -s")
;MsgBox("","",$cc)
Sleep(6000)
;Run("C:\Users\zhang\Downloads\sp82432 -s")
;Run("C:\Users\zhang\Downloads\sp76368 -s")
;Run("C:\Users\zhang\Downloads\sp78156 -s")
;$title = WinGetHandle("[ACTIVE]")


$i = 0
While $i <=10
   $i = $i + 1
   $title = WinGetHandle("[ACTIVE]")
   WinActivate($title)
   ;$title = WinGetTitle("[CLASS:#32770]","")
   ;MsgBox("","","tt")

   Select
	  Case ControlClick($title,"","&Next >")
		 Sleep(200)
	  Case ControlClick($title,"","&Yes")
		 Sleep(200)
	  Case ControlClick($title,"","&Install")
		 Sleep(200)
	  Case ControlClick($title,"","&Finish")
		 Sleep(200)
	  Case ControlClick($title,"","Finish")
		 Sleep(200)
	  Case ControlClick($title,"","OK")
		 Sleep(200)
	  Case Else
		 ControlClick($title,"","&OK")
   EndSelect
   Sleep(2000)


WEnd
Sleep(6000)
;Shutdown(6)
MsgBox("","","test")
#comments-end
MsgBox("","",@DesktopDir)