#RequireAdmin

Example()
Func Example()
;Run(@DesktopDir &"\Download\sp82432 -s")
;Run(@DesktopDir &"\Download\sp81955 -s")
Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
;Run("C:\Users\zhang\Downloads\$Cmdline[0] -s")
Sleep(1000)
;Run("C:\Users\zhang\DownloadRun(@DesktopDir &"\Downloads\sp81955 -s")s\sp82432 -s")
;Run("C:\Users\zhang\Downloads\sp76368 -s")
;Run("C:\Users\zhang\Downloads\sp78156 -s")
;$title = WinGetHandle("[ACTIVE]")


$i = 0
While $i <=20
   $i = $i + 1

   $title = WinGetHandle("[ACTIVE]")
   ;WinActivate($title,"")
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
Shutdown(6)
;MsgBox("","","test")
EndFunc
