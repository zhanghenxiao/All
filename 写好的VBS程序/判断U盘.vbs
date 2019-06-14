dim Wsh,fso,dc,d
set Wsh = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
do
Set dc = fso.Drives
For Each d in dc
If d.DriveType = 1 Then
If u="" Then
u=d.DriveLetter
MsgBox "你已经插入U盘 "& d.DriveLetter &":"
End if
ElseIf Not fso.DriveExists(u) Then
If u<>"" Then MsgBox "你已经拔出U盘 "& u &":"
u=""
End if
WScript.Sleep 1000
Next
Set dc = nothing
loop 