With CreateObject("Word.Basic")
 .Sendkeys "{prtsc}"
 .FileQuit '.AppClose
End With
 
Msgbox "ss。",vbSystemModal+vbInformation, WScript.ScriptName