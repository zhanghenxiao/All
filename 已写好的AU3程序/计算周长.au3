Global $gc_Pi = 3.14
_Main()

Func _Main()
	;创建一个宽215像素、高125像素，居中显示的窗体
	Local $gu_Form1 = GUICreate("计算圆的面积", 215, 125, -1, -1)
	Local $gu_Label1 = GUICtrlCreateLabel("半径", 16, 19, 28, 17)
	Local $gu_Label2 = GUICtrlCreateLabel("周长", 16, 51, 28, 17)
	Local $gu_Input1 = GUICtrlCreateInput("", 48, 16, 145, 21, 0x2000) ;只能输入数字
	Local $gu_Input2 = GUICtrlCreateInput("", 48, 48, 145, 21, 0x0800) ;只读
	Local $gu_Button1 = GUICtrlCreateButton("计算", 104, 88, 41, 25)
	Local $gu_Button2 = GUICtrlCreateButton("清空", 152, 88, 41, 25)
	GUISetState(@SW_SHOW, $gu_Form1)
	Local $r, $s
	Local $nMsg
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case -3
				Exit
			Case $gu_Button1
				$r = GUICtrlRead($gu_Input1)
				If $r = "" Then
					MsgBox(0, "错误", "未设置半径")
				Else
					$s = $gc_Pi * $r ^ 2
					GUICtrlSetData($gu_Input2, $s)
				EndIf

			Case $gu_Button2
				GUICtrlSetData($gu_Input1, "")
				GUICtrlSetData($gu_Input2, "")
		EndSwitch
	WEnd
EndFunc   ;==>_Main