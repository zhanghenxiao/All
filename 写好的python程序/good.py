#ecoding: utf-8
import os
import spynner
import time
import BeautifulSoup    #从网页抓取数据
import xlrd

excel="C:\\Users\\succful\\Desktop\\test.xlsx"
os.popen("md D:\\Download\>nul 2>nul")

browser=spynner.Browser()   #创建一个浏览器对象
#browser.create_webview()
browser.set_html_parser(pyquery.PyQuery)
browser.load("ftp://ftp.usa.hp.com/",load_timeout=120)  #加载网页信息 #load是你想要加载的网址的字符串信息。
#browser.load("https://support.hp.com/cn-zh/drivers/selfservice/hp-elite-slice/12710078",load_timeout=120)
#open("Test.html", 'w+').write(browser.html.encode("utf-8"))
f = open("D:\Temp\Test.html2", 'w+')     #打开html
f.write(browser.webframe.toHtml().toUtf8())     ##也可写入文件中，用浏览器打开
f.close()       #关闭html
browser.close()     #关闭浏览器

soups = BeautifulSoup.BeautifulSoup(open("D:\Download\Test.html2"))   #用本地HTMl文件来创建对象，打开HTML
tag_button = soups.findAll('button',{"class":"hidden-lg button button-sm primary hpdiaButton"})     #寻找所有button都是这个class的语句
num=len(tag_button)
'''
ntfile = open("ntname.txt","r")
ntNames = ntfile.readlines()
ntfile.close()
ntName=ntName.strip("\n")
'''
data = xlrd.open_workbook(excel)    #打开excel文件
table = data.sheet_by_name(u'Softpaq List')    #获取excel中的某一页
nrows = table.nrows     #获取行数
for i in range(0,nrows):    #(1,nrows)表示去第一行以后的行,因为第一行往往是表头。
    ntName = table.cell(i,0).value
    i=0
    for button in tag_button:
        soup = BeautifulSoup.BeautifulSoup(str(button))
        if ntName == soup.button["utilitytitle"]:
            utName = soup.button["utilitytitle"]
            urlDownload = soup.button["href"]
            reName = soup.button["utilityvalue"]
            print "downloading:",utName
            os.popen("powershell $client = new-object System.Net.WebClient;\
              $client.DownloadFile('"+urlDownload+"','"+"D:\\Download\\"+utName+"_"+reName+"')")
            print "success:",ntName
            break
        i=i+1
    if i==num:
        print "fail:",ntName

print "completed !"
os.popen("start D:\\Download")
