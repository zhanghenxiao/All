#include <MsgBoxConstants.au3>
#RequireAdmin
Example()

Func Example()
    ; Run Notepad
    Run("C:\Users\succful\Downloads\sp81516(1).exe -s")

    ; Wait 10 seconds for the Notepad window to appear.
    Local $hWnd = WinWait("[class:#32770]", "", 10)

    ; Set the edit control in Notepad with some text. The handle returned by WinWait is used for the "title" parameter of ControlSetText.
    ;ControlSetText($hWnd, "", "Edit1", "This is some text")

    ; Retrieve the text of the edit control in Notepad. The handle returned by WinWait is used for the "title" parameter of ControlGetText.
    Local $sText = ControlGetText($hWnd, "", "Static1")

    ; Display the text of the edit control.
    MsgBox($MB_SYSTEMMODAL, "", "The text in Edit1 is: " & $sText)
EndFunc