#创建函数
#function getname{
#test $nice= "1"
#}

#getname
#$function ; getname
#del function:getname
#查看内部自定义函数
#dir function: | ft -AutoSize

function getsql
{
Get-Service -DisplayName "*$args*"
}
