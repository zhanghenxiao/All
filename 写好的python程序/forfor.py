#!/usr/bin/python
#ecoding: utf-8
import sys
'''
name = "zhang"
type = "xiaokeai"

if name == "tao":
    print "you are good"
elif name == "zhang":
    print "nishuaidailo"
else:
    print "nifeichangshuai"

'''

'''
name = "zhang"

if(name == "zhang"):
    print "shuai"
else:
    print "henshua"
'''

#python while 循环语句

'''
i = 1
while i < 6:
    i=i+1
    if i%2 > 0: #非双数跳过输出
        continue
    print i     # 输出双数2、4、6、8、10
'''



i = 1
while 1:            # 循环条件为1必定成立
    print i         # 输出1~10
    i = i+1
    if i > 10:
        break       # 当i大于10时跳出循环

'''
name = "shuai"
while name=="shuai":
    print "nice boy"
'''

#python for循环语句

'''
name = ['zhang','yuantao','shuai']
for c in range(len(name)):
    print 'dage ：',name[c]
print "zhangshao"

if 'zhang' in name:
    print "zhang"
for i in  range(len(name)):
    print 'nice:',name[i]
'''



'''
fruits = ['banana', 'apple', 'mango']
for fruit in fruits:  # 第二个实例
    print '当前水果 :', fruit

print "Good bye!"
'''
'''
for number in range(10,20): #迭代10到20之间的数字
    for i in range(2,number): #根据因子迭代
        if number%i == 0:      #确定第一个因子(%i 取余)
            j=number/i        #计算第二个因子
            print '%d 等于 %d * %d' %(number,i,j)
            break
    else:
        print number,'是一个质数'
'''

