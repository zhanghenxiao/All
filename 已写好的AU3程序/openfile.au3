#include <File.au3>
#include <Array.au3>
#RequireAdmin

#comments-start
Func Example()
    Run("C:\Users\succful\Downloads\sp82432.exe")
    Local $hWnd = WinWait("Intel Management Engine Driver - InstallShield Wizard", "", 10)
    ;ControlSetText($hWnd, "", "RICHEDIT1")

    Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")

    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	FileWrite("1.txt", $sText)
EndFunc
#comments-end
;遍历一个文件夹一个一个输出
$testdir="C:\Users\succful\Desktop\Download"
Local $hSearch = FileFindFirstFile($testdir & "\*.exe*")

If $hSearch <> -1 Then
	While 1
		Local $sFile = FileFindNextFile($hSearch)

		If @error Then ExitLoop

		 MsgBox(1, "test", $sFile)
		 Run("C:\Users\succful\Desktop\Download\"&$sFile)
		 Local $hWnd = WinWait("Intel Management Engine Driver - InstallShield Wizard", "", 10)
    ;ControlSetText($hWnd, "", "RICHEDIT1")

    Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")

    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	FileWrite("1.txt", $sText)
	WEnd
 EndIf

 #comments-start
 Run("C:\Users\succful\Desktop\Download\"&$sFile)
 Func Example()

    Run("C:\Users\succful\Downloads\sp82432.exe")
    Local $hWnd = WinWait("Intel Management Engine Driver - InstallShield Wizard", "", 10)
    ;ControlSetText($hWnd, "", "RICHEDIT1")

    Local $sText = ControlGetText($hWnd, "", "RICHEDIT1")

    ;MsgBox($MB_SYSTEMMODAL, "", $sText)
	FileWrite("1.txt", $sText)
EndFunc
#comments-end