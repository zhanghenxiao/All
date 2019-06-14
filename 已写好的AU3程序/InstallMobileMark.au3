;include header files
#include <WinAPI.au3>
#include <WinAPIFiles.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <String.au3>
#include <WinAPISys.au3>
#include <file.au3>
#include <GuiListView.au3>

Global $IsInstalled = False
Global $Version = ""
Global $MMPtchId = ""
Global $MMId = ""
Global $IsError = 1

;check languages installed
BlockInput($BI_DISABLE)
;zh-CN
If @OSLang = "0804" Then
;en-US
ElseIf @OSLang = "0409" Then
	_FileWriteLog("1.log", "log content", -1);
    _Main()
Else
	MsgBox($MB_OKCANCEL, "BIOS Team hint:", "Only support en-US/zh-CN", 5)
EndIf
BlockInput($BI_ENABLE)

;main function
Func _Main()
	#RequireAdmin
	;disable uac
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "ConsentPromptBehaviorAdmin", "REG_DWORD", "0")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "EnableLUA", "REG_DWORD", "0")
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "PromptOnSecureDesktop", "REG_DWORD", "0")

	;reg add to startup
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "instmm") =="" Then
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "instmm", "REG_SZ", @ScriptDir & "\installMobileMark.exe")
		_FileWriteLog("1.log", "Reg added", -1);
	EndIf

	;mobilemark is installed
	While 1
		If FileExists("C:\Program Files (x86)\BAPCo\MobileMark2014\Bin\MobileMark 2014.exe") Then
			$IsInstalled = True
			_FileWriteLog("1.log", "IsInstalled: " & $IsInstalled, -1);
			;check if env $IsConfigured
			If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "setted") <> 1 Then
				SetEnv()
			EndIf
		ElseIf RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "installed") <> 1 Then
			ConsoleWrite("Start to install: ")

			InstallMobileMark()
			InstallMobileMarkPatch()
		EndIf
	WEnd

	;InstallMobileMark()
	;InstallMobileMarkPatch()
EndFunc

Func InstallMobileMark()
	;#RequireAdmin
	ShellExecute("C:\MobileMark2014(v1.5.0.47 RTM2)\MobileMark2014_Setup.exe")
	$IsNotFinished = 1

	While $IsNotFinished
		$MMId = "MobileMark 2014 1.5.0.47 Setup"
		$Win = WinWait($MMId)
		Switch $Win
			Case WinWait($MMId, "Welcome to the MobileMark 2014 Setup Wizard", 1)
				WinWaitActive($MMId, "Welcome to the MobileMark 2014 Setup Wizard")
				ControlClick($MMId, "Welcome to the MobileMark 2014 Setup Wizard", "Button2")
			Case WinWait($MMId, "Serial Number", 1)
				WinWaitActive($MMId, "Serial Number")
				ControlClick($MMId, "Serial Number", "Edit1")
				Send("6e0532a094e1d661a394c34cd")
				Sleep(100)
				ControlClick($MMId, "Serial Number", "Button2")
			Case WinWait($MMId, "License Agreement", 1)
				WinWaitActive($MMId, "License Agreement")
				Sleep(100)
				ControlClick($MMId, "License Agreement", "Button4")
				Sleep(100)
				ControlClick($MMId, "License Agreement", "Button2")
				Sleep(100)
			Case WinWait($MMId, "Choose Components", 1)
				WinWaitActive($MMId, "Choose Components")
				ControlClick($MMId, "Choose Components", "Button2")
			Case WinWait($MMId, "Choose Install Location", 1)
				WinWaitActive($MMId, "Choose Install Location")
				ControlClick($MMId, "Choose Install Location", "Button2")
			Case WinWait($MMId, "Choose Start Menu Folder", 1)
				WinWaitActive($MMId, "Choose Start Menu Folder")
				ControlClick($MMId, "Choose Start Menu Folder", "Button2")
			Case WinWait($MMId, "Completing the MobileMark 2014 Setup Wizard", 1)
				WinWaitActive($MMId, "Completing the MobileMark 2014 Setup Wizard")
				ControlClick($MMId, "Completing the MobileMark 2014 Setup Wizard", "Button2")
				$IsNotFinished = 0
			Case Else
				WinActivate($MMId)
				WinWaitActive($MMId, "", 1)
		EndSwitch
	WEnd
EndFunc

Func InstallMobileMarkPatch()
	ShellExecute("C:\MobileMark2014(v1.5.0.47 RTM2)\MobileMark2014_Patch1_1.5.1.55.exe")
	$IsNotFinished = 1

	While $IsNotFinished
		$MMPtchId = "MobileMark 2014 1.5.1.55 Patch"
		$Win = WinWait($MMPtchId)
		Switch $Win
			Case WinWait($MMPtchId, "Welcome to the MobileMark 2014 Setup Wizard", 1)
				WinWaitActive($MMPtchId, "Welcome to the MobileMark 2014 Setup Wizard")
				ControlClick($MMPtchId, "Welcome to the MobileMark 2014 Setup Wizard", "Button2")
			Case WinWait($MMPtchId, "License Agreement", 1)
				WinWaitActive($MMPtchId, "License Agreement")
				Sleep(100)
				ControlClick($MMPtchId, "License Agreement", "Button4")
				Sleep(100)
				ControlClick($MMPtchId, "License Agreement", "Button2")
				Sleep(100)
			Case WinWait($MMPtchId, "Completing the MobileMark 2014 Setup Wizard", 1)
				WinWaitActive($MMPtchId, "Completing the MobileMark 2014 Setup Wizard")
				ControlClick($MMPtchId, "Completing the MobileMark 2014 Setup Wizard", "Button2")
				If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "installed") =="" Then
					RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "installed", "REG_SZ", "1")
					_FileWriteLog("1.log", "MM and MM patch installed", -1);
				EndIf
				$IsNotFinished = 0
			Case Else
				WinActivate($MMPtchId)
				WinWaitActive($MMPtchId, "", 1)
		EndSwitch
	WEnd

	Run("shutdown -r -t 0")
EndFunc

Func SetEnv()
	Run("setscreenbrightness.bat")
	;Sleep(2000)

	While $IsError
		Run("runmm.bat")
		If WinWait("MobileMark 2014 Error", "", 15) Then
			Run("taskkillmm.bat")
			Sleep(10000)
			Run("runmm.bat")
		ElseIf WinWait("BAPCo MobileMark 2014 1.5.1.55", "", 15) Then
			$IsError = 0
		EndIf
	WEnd

	WinWaitActive("BAPCo MobileMark 2014 1.5.1.55")

	;set screen resolution
	$WidthOrignal = @DesktopWidth
	$HeightOrignal = @DesktopHeight
	Run("SetRes.exe" & " h1920 v1080")

	WinWaitActive("BAPCo MobileMark 2014 1.5.1.55")

	$size = WinGetPos("BAPCo MobileMark 2014 1.5.1.55")
	Sleep(100)
	MouseMove($size[0] + 250, $size[1] + 230)
	MouseClick("LEFT")
	Sleep(100)
	MouseMove($size[0] + 900, $size[1] + 180)
	MouseClick("LEFT")

	Sleep(100)
	$handle = WinGetHandle("BAPCo MobileMark 2014 1.5.1.55 System Configuration 0.01")
	WinWaitActive("BAPCo MobileMark 2014 1.5.1.55 System Configuration 0.01")
	;get handle
	$control = ControlGetHandle($handle,"","SysListView321")
	;get position
	$x = _GUICtrlListView_GetItemPositionX($control, 11)
	$y = _GUICtrlListView_GetItemPositionY($control, 11)
	;left click
	ControlClick($handle,"", $control,"left",1, $x, $y)
	Sleep(100)
	ControlClick("BAPCo MobileMark 2014 1.5.1.55 System Configuration 0.01", "", "Button2")

	WinActivate("BAPCo MobileMark 2014 1.5.1.55")
	WinWaitActive("BAPCo MobileMark 2014 1.5.1.55")
	Send("MM14-SKUn")
	Sleep(100)
	MouseMove($size[0] + 400, $size[1] + 540)
	MouseClick("LEFT")
	;set res back
	;Run("SetRes.exe" & " h" & $HeightOrignal & " v" & $WidthOrignal)
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "setted") <> 1 Then
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "setted", "REG_SZ", "1")
		_FileWriteLog("1.log", "env setted", -1);
	EndIf
EndFunc