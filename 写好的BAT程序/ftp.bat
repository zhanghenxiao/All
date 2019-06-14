@echo off
::ftp://stest_03:d*AC10sx@ftp.usa.hp.com 

set ftpfn=autoftp.cfg 

echo open ftp.usa.hp.com 

&gt;"%ftpfn%"
echo stest_03&gt;&gt;"%ftpfn%"
echo d*AC10sx&gt;&gt;"%ftpfn%"
echo bin&gt;&gt;"%ftpfn%"
echo D:/&gt;&gt;"%ftpfn%"
echo get SP82759.zip&gt;&gt;"%ftpfn%"
echo bye&gt;&gt;"%ftpfn%"
ftp -s:"%ftpfn%"
del "%ftpfn%"
