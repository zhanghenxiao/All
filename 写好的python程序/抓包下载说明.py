
#ecoding: utf-8

import os    #系统模块，windows和linux可以参考百度
import spynner   #此处用到它来模拟浏览器打开网页，以获取动态网页数据
import time    #这里没有用到
import BeautifulSoup    #用来处理网页信息，此处用到它来查找标签及获取属性值，这两个方法类似于selenium的find_element_...方法
import xlrd    #处理excel的模块

excel="C:\\Users\\succful\\Desktop\\test.xls"   #含需要下载驱动名的excel表
os.popen("md D:\\Download\>nul 2>nul")    #创建D:\Download,不打印标准输出；os.popen(),隐藏执行windows的cmd命令，os.system(),不隐藏

browser=spynner.Browser()    #spynner模拟浏览器对象，.load(),打开网页，包括动态网页，目前测试win10_x64无法打开该网页，原因不明
browser.load("https://support.hp.com/us-en/drivers/selfservice/hp-elite-slice/12710078",load_timeout=120)
#open("Test.html", 'w+').write(browser.html.encode("utf-8"))
f = open("D:\\Temp\\Test.html", 'w+')    #创建Test.html文本对象并打开write+权限
f.write(browser.webframe.toHtml().toUtf8())    #存储网页为Test.html
f.close()    #关闭文件
#browser.close()

soups = BeautifulSoup.BeautifulSoup(open("D:\\Temp\\Test.html"))    #BeautifulSoup()，加载网页到soup对象
tag_button = soups.findAll('button',{"class":"hidden-lg button button-sm primary hpdiaButton"})    #findAll()方法查找网页中：class属性为""的所以button标签
num=len(tag_button)    #查找到的button个数，这里即为网页中驱动信息个数
'''
ntfile = open("ntname.txt","r")
ntNames = ntfile.readlines()
ntfile.close()
ntName=ntName.strip("\n")
'''
data = xlrd.open_workbook(excel)    #打开excel表到data对象
table = data.sheet_by_name(u'Softpaq List')    #查找其中名为""的表
nrows = table.nrows    #获取该表的行数
for i in range(1,nrows):    #根据行数从第一行遍历
    ntName = table.cell(i,8).value     #获取第i行，第9列数据，这里即为驱动名列
    i=0
    for button in tag_button:    #遍历tag_button,进行驱动名对比
        soup = BeautifulSoup.BeautifulSoup(str(button))    #新建soup对象，单个button为参数，以通过其方法获取属性值
        if ntName == soup.button["utilitytitle"]:    #如果发现有button中，驱动名属性值==表中驱动名
            utName = soup.button["utilitytitle"]    #驱动名=button中驱动名
            urlDownload = soup.button["href"]    #下载地址=button中下载地址
            reName = soup.button["utilityvalue"]   #别名=驱动中别名
            print "downloading:",utName    #打印下载开始信息
            #通过powershell中启动client进行下载
            os.popen("powershell $client = new-object System.Net.WebClient;\
              $client.DownloadFile('"+urlDownload+"','"+"D:\\Download\\"+utName+"_"+reName+"')")
            print "success:",ntName    #打印下载成功信息
            break    #终止此次内for循环，进行下一个外for循环
        i=i+1   #计数内for循环次数
    if i==num:  #若内循环次数==button个数
        print "fail:",ntName    #打印失败信息，这里失败是指未查找到驱动

print "completed !"   #结束所有循环，运行结束
os.popen("start D:\\Download")    #打开下载目录



