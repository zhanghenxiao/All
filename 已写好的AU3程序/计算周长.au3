Global $gc_Pi = 3.14
_Main()

Func _Main()
	;����һ����215���ء���125���أ�������ʾ�Ĵ���
	Local $gu_Form1 = GUICreate("����Բ�����", 215, 125, -1, -1)
	Local $gu_Label1 = GUICtrlCreateLabel("�뾶", 16, 19, 28, 17)
	Local $gu_Label2 = GUICtrlCreateLabel("�ܳ�", 16, 51, 28, 17)
	Local $gu_Input1 = GUICtrlCreateInput("", 48, 16, 145, 21, 0x2000) ;ֻ����������
	Local $gu_Input2 = GUICtrlCreateInput("", 48, 48, 145, 21, 0x0800) ;ֻ��
	Local $gu_Button1 = GUICtrlCreateButton("����", 104, 88, 41, 25)
	Local $gu_Button2 = GUICtrlCreateButton("���", 152, 88, 41, 25)
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
					MsgBox(0, "����", "δ���ð뾶")
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