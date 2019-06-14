#include <MsgBoxConstants.au3>

#RequireAdmin

 #comments-start
Example()
;获取文本输出到txt
Func Example()
   ;Run("C:\Users\succful\Downloads\sp82432.exe -s")
   Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
   Local $hWnd = WinWait("Setup", "", 10)
    ;ControlSetText($hWnd, "", "RICHEDIT1")

    Local $sText = ControlGetText($hWnd, "", "Static1")

    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	FileWrite(@DesktopDir &"\logs\Installed_name.txt", $sText)

    $file = FileOpen(@DesktopDir &"\logs\Installedname.txt",0)
    $line = FileReadLine($file,1)

    $title = StringRegExpReplace($line, "^TITLE:", "");  ($line, "^TITLE:");
   ;MsgBox("","test",$line)
   MsgBox("","test",$title)
   FileWrite(@DesktopDir &"\logs\Installed_name.txt", $title)

EndFunc   ;==>Example
#comments-end


TEST()
Func TEST()
  Run("C:\Users\succful\Downloads\" & $CmdLine[1] & " -s")
   Local $hWnd = WinWait("Setup", "", 10)

    Local $sText = ControlGetText($hWnd, "", "Static1")

    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	FileWrite(@DesktopDir &"\logs\Installed_name.txt", $sText)

  EndFunc



