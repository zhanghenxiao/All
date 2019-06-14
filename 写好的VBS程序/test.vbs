set wshell=createobject("wscript.shell")
wshell.run "C:\SWSETUP\SP81516\SetupRST.exe",1
wscript.sleep 1000
wshell.SendKeys "{Enter}"
wscript.sleep 1000
wshell.SendKeys "{Enter}"



