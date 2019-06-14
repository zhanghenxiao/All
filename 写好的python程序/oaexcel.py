from selenium import webdriver

import time
class sem :
    def __init__(self):
        self .webdriver=webdriver.Firefox()
        self.test()
        self.new()
        # f =open('C:\\Users\\Administrator\\Desktop\\3.6.txt','r')
        # self.a=f.readlines()
        # for i in self.a:
        #     self.b=i.split('\n')
        #
        #     print(self.b)

    def test(self,p):
        wd=self.webdriver
        wd.get('http://192.168.10./smeoa/index.php/login ') #导入网址
        wd.find_element_by_id('emp_no').send_keys('admin')
        wd.find_element_by_id('password').send_keys('admin')
        wd.find_element_by_xpath("//input[@value='登录']").click()
        time.sleep(1)
    def new(self,p):
        wd=self.webdriver
        wd.find_element_by_xpath("//div[@id='navbar-collapse-6']/ul/a/i").click()
        time.sleep(1)
        wd.find_element_by_link_text('写信').click()
        time.sleep(0.5)
        wd.find_element_by_css_selector('input.letter').send_keys(p[0])
        time.sleep(1)
        wd.find_element_by_xpath('/html/body/div[2]/div/div[2]/div[2]/div/div/form/div[1]/div/div/div[2]/ul/li/a').click()
        time.sleep(1)
        wd.find_element_by_xpath("(//input[@type='text'])[2]").send_keys(p[1])
        time.sleep(1)
        wd.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/div/div/form/div[2]/div[2]/div/div[2]/ul/li/a").click()
        time.sleep(0.5)
        wd.find_element_by_id('mail_title').send_keys(p[3])
        time.sleep(1)
        wd.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/div/div/form/div[5]/div/div/div/input").send_keys("C:\\Users\\Administrator\\Desktop")
        wd.find_element_by_link_text('发送').click()
