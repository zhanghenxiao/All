@echo off
::md C:\zhang
wget -i w.txt -nH -nc --ftp-user=stest_03 --ftp-password=d*AC10sx -P C:\Users\succful\Desktop\ftp_test\123\df
::wget -t 0 -w 31 -c -B --ftp-user=stest_03 --ftp-password=d*AC10sx  -i filelist.txt -o down.log &
pause

 