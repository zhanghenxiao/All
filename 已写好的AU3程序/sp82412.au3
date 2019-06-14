#RequireAdmin
Run (@DesktopDir&"\Download\sp82412.exe -s")

WinWait("Intel(R) Multiple Package Installation Tool" ,"All installations completed", 1)
   WinWaitActive("Intel(R) Multiple Package Installation Tool" ,"All installations completed")
   ControlClick("Intel(R) Multiple Package Installation Tool" ,"All installations completed","Button1")
   Run("shutdown -r -t 1")

