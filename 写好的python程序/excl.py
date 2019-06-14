from selenium import webdriver
from wedexcl import *
import time
class sem :
    def __init__(self):
        self .webdriver=webdriver.Firefox()
        self.test()
        self.new()
    def test(self):
        wd=self.webdriver
        wd.get('http://192.168.0.124/smeoa/index.php/login ') #导入网址
        wd.find_element_by_id('emp_no').send_keys('admin')
        wd.find_element_by_id('password').send_keys('admin')
        wd.find_element_by_xpath("//input[@value='登录']").click()
        time.sleep(2)
    def new(self):
        wd=self.webdriver
        wd.find_element_by_xpath("//div[@id='navbar-collapse-6']/ul/a/i").click()
        time.sleep(1)
        wd.find_element_by_link_text('写信').click()
        time.sleep(2)
        wd.find_element_by_css_selector('input.letter').send_keys('张三')

        wd.find_element_by_xpath('/html/body/div[2]/div/div[2]/div[2]/div/div/form/div[1]/div/div/div[2]/ul/li/a').click()
        wd.find_element_by_id('mail_title').send_keys('家在海边从小爱浪')
        time.sleep(2)
        wd.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/div/div/form/div[5]/div/div/div/input").send_keys("C:\\Users\\Administrator\\Desktop")
        wd.find_element_by_link_text('发送').click()
sem()
