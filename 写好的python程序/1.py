#ecoding: utf-8

import os
import spynner
import time
import BeautifulSoup
import xlrd

excel="C:\\Users\\succful\\Desktop\\test.xlsx"
os.popen("md D:\\Download\>nul 2>nul")

browser=spynner.Browser()
browser.load("https://support.hp.com/us-en/drivers/selfservice/hp-elite-slice/12710078",load_timeout=120)
#browser.load("https://support.hp.com/cn-zh/drivers/selfservice/hp-elite-slice/12710078",load_timeout=120)
#open("Test.html", 'w+').write(browser.html.encode("utf-8"))
f = open("Test.html", 'w+')
f.write(browser.webframe.toHtml().toUtf8())
f.close()
#browser.close()

soups = BeautifulSoup.BeautifulSoup(open("Test.html"))
tag_button = soups.findAll('button',{"class":"hidden-lg button button-sm primary hpdiaButton"})
num=len(tag_button)
'''
ntfile = open("ntname.txt","r")
ntNames = ntfile.readlines()
ntfile.close()
ntName=ntName.strip("\n")
'''
data = xlrd.open_workbook(excel)
table = data.sheet_by_name(u'Softpaq List')
nrows = table.nrows
for i in range(1,nrows):
    ntName = table.cell(i,8).value 
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
