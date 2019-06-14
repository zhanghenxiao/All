@echo off
::set wget_home=C:\Program Files (x86)\GnuWin32\bin
::set PATH=%wget_home%/bin;%wget_home%/jre/bin 
::set CLASSPATH=.;%wget_home%\lib\dt.jar;%wget_home%\lib\tools.jar; 
::C:\Program Files (x86)\GnuWin32\bin

goto nice
set regpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set evname=JAVA_HOME
set javapath=C:\Program Files (x86)\GnuWin32\bin
reg add "%regpath%" /v %evname% /d %javapath% /f
pause>nul

SET regPath= HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
reg add %regPath% /v Path1 /t REG_EXPAND_SZ /d "%path%;C:\Program Files (x86)\GnuWin32\bin" /f
pause


setx wegt.exe "C:\Program Files (x86)\GnuWin32\bin" -m
:nice

:nice
set "add_path1=C:\Program Files (x86)\GnuWin32\bin"  
set "set_val=%add_path1%;%PATH%"  
wmic ENVIRONMENT where "name='PATH' and username='<system>'" set VariableValue="%set_val%" 

pause

















