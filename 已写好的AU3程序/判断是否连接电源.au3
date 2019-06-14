#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $hForm = GUICreate('测试 ' & StringReplace(@ScriptName, '.au3', '()'), 180, 135, -1, -1, -1, $WS_EX_TOPMOST)
Local $idButton = GUICtrlCreateButton('确定', 55, 101, 70, 23)
GUICtrlCreateLabel('AC 电源:', 10, 14, 90, 14)
GUICtrlCreateLabel('状态:', 10, 34, 70, 14)
GUICtrlCreateLabel('充电:', 10, 54, 90, 14)
GUICtrlCreateLabel('剩余时间:', 10, 74, 90, 14)
Global $g_aidLabel[4]
For $i = 0 To 3
    $g_aidLabel[$i] = GUICtrlCreateLabel('未知', 110, 14 + 20 * $i, 60, 14)
Next
GUISetState(@SW_SHOW)

AdlibRegister('_BatteryStatus', 1000)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $idButton
            ExitLoop
    EndSwitch
WEnd

Func _BatteryStatus()
    Local $aData = _WinAPI_GetSystemPowerStatus()
    If @error Then Return

    If BitAND($aData[1], 128) Then
        $aData[0] = '没有系统电池'
        For $i = 1 To 3
            $aData[$i] = '未知'
        Next
    Else
        Switch $aData[0]
            Case 0
                $aData[0] = '未连接'
            Case 1
                $aData[0] = '连接'
            Case Else
                $aData[0] = '未知'
        EndSwitch
        Switch $aData[2]
            Case 0 To 100
                $aData[2] &= '%'
            Case Else
                $aData[2] = '未知'
        EndSwitch
        Switch $aData[3]
            Case -1
                $aData[3] = '未知'
            Case Else
                Local $H, $M
                $H = ($aData[3] - Mod($aData[3], 3600)) / 3600
                $M = ($aData[3] - Mod($aData[3], 60)) / 60 - $H * 60
                $aData[3] = StringFormat($H & ':%02d', $M)
        EndSwitch
        If BitAND($aData[1], 8) Then
            $aData[1] = '充电'
        Else
            Switch BitAND($aData[1], 0xF)
                Case 1
                    $aData[1] = '高'
                Case 2
                    $aData[1] = '低'
                Case 4
                    $aData[1] = '临界'
                Case Else
                    $aData[1] = '未知'
            EndSwitch
        EndIf
    EndIf
    For $i = 0 To 3
        GUICtrlSetData($g_aidLabel[$i], $aData[$i])
    Next
EndFunc   ;==>_BatteryStatus