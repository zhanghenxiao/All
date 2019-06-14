#RequireAdmin
;下拉框
WinActivate("Turn on Script Execution")
Sleep(2000)
ControlCommand("Turn on Script Execution","","ComboBox1","SelectString","Allow all scripts")