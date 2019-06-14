#include <MsgBoxConstants.au3>

#RequireAdmin
;Run("C:\Users\succful\Desktop\getname.au3" & " " & "sp82432.exe
;ShellExecute("C:\Users\succful\Desktop\getname.au3", @DesktopDir & "sp82432.exe")

;Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
;Run("C:\Users\succful\Downloads\" & $CmdLine[1])
;Run("C:\Users\succful\Downloads\sp82432.exe")
;Local $hWnd = WinWait("[class: # 32770]", "", 1)
;Local $hWnd = WinWait("[class:#32770]", "", 1)
    ;ControlSetText($hWnd, "", "RICHEDIT1")
;Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")

;MsgBox($MB_SYSTEMMODAL, "", $sText)
;FileWrite(@DesktopDir &"\logs\Installedname.txt", $sText)

;$file = FileOpen(@DesktopDir &"\logs\Installedname.txt",0)
;$line = FileReadLine($file,1)

;$title = StringRegExpReplace($line, "^TITLE:", "");  ($line, "^TITLE:");
;FileWrite(@DesktopDir &"\logs\Installed_Name.txt", $sText)

;EndFunc   ;==>Examples

;Run("C:\Users\succful\Desktop\Download\sp82432.exe -s")
;Run("C:\Users\succful\Downloads\sp81516(1).exe -s")
   ;传参
;Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
		 Run(@DesktopDir &"\Downloads\sp82432")
		 ;MsgBox("","",@DesktopDir)
   ;Run("C:\Users\“ & @UserName & ”\Downloads\" & $CmdLine[1] & " -s")
   ;Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
   ;以class获取控件文本
   ;Local $hWnd = WinWait("[class:#32770]", "", 10)
   ;Local $hWnd = WinWait("Setup", "", 1)
		 WinWaitActive("Setup", "")
		 Local $hWnd = WinWait("Setup", "", 10)
;Sleep(200)
		 Local $sText = ControlGetText($hWnd, "", "Static1")

		 ;MsgBox("","TEST",$sText)
    ;MsgBox("","TEST",$sText)
    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	;获取到txt中
		 FileWrite(@DesktopDir &"\Logs\Installed_Name.txt",$sText)
	;$nice = StringRegExpReplace($sText)
	;MsgBox("","test","$nice")
	;FileWrite(@DesktopDir &"\Logs\Installed_Name.txt", $nice )
	;打开文本清除数据
	;Sleep(200)
		 $fifle = FileOpen(@DesktopDir &"\Logs\Installed_Name.txt",2)
   ;FileWrite(@DesktopDir &"\Logs\Installed_Name.txt", $sText & @CRLF)
		 FileWrite(@DesktopDir &"\Logs\Installed_Name.txt", $sText)
   ;WinClose($hWnd)
   ;Sleep(200)
   ;Send("[ENTER]")
   ;MsgBox("","TEST",$sText)













