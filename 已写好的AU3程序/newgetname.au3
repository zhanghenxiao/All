#include <MsgBoxConstants.au3>
#RequireAdmin

#comments-start
Example()

Func Example()
   Run(@DesktopDir &"\driver\sp81955")
   WinWaitActive("[class:#32770]")
   Local $hWnd = WinWait("[class:#32770]", "", 1)
   ;ControlSetText($hWnd, "", "RICHEDIT1")
   Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")
   ;MsgBox($MB_SYSTEMMODAL, "", "The text in Edit1 is: " & $sText)
   MsgBox("","test",$sText)
   ;FileWrite =
EndFunc   ;==>Example
#comments-end

nice()
Func nice()
Run(@DesktopDir&"\Download\" & $CmdLine[1])
;Run(@DesktopDir &"\driver\sp81955.exe")
$cls = FileOpen(@DesktopDir &"\Logs\Installed_Name.txt",2)
$clss = FileOpen(@DesktopDir &"\Logs\InstalledName.txt",2)
;#comments-start
;Run(@DesktopDir &"\Downloads\" & $CmdLine[1])
Local $hWnd = WinWait("Intel", "", 1)
Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")

FileWrite(@DesktopDir &"\Logs\InstalledName.txt",$sText)

$file = FileOpen(@DesktopDir &"\Logs\InstalledName.txt",0)
;读取文本第一行
$line = FileReadLine($file,1)
;截取title之后的内容
$title = StringRegExpReplace($line, "^TITLE: ", "")

FileWrite(@DesktopDir &"\Logs\Installed_Name.txt", $title)
;#comments-end
EndFunc