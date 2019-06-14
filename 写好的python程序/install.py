# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class Install(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "https://support.hp.com/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_install(self):
        driver = self.driver
        driver.find_element_by_id("Hpdia_DownloadDialog_BtnX").click()
        driver.find_element_by_id("Hpdia_DownloadDialog").click()
        driver.find_element_by_id("Hpdia_DownloadDialog_BtnX").click()
        driver.find_element_by_css_selector("#download-table > div.hp-row").click()
        driver.get(self.base_url + "/cn-zh/drivers/selfservice/hp-elite-slice/12710078")
        driver.find_element_by_css_selector("div.wpthemeInner > div.wptheme1Col.wpthemeClear").click()
        driver.find_element_by_css_selector("div.wpthemeInner > div.wptheme1Col.wpthemeClear").click()
        driver.find_element_by_css_selector("#vc-184253-1 > table.table > tbody > tr.swd-dropdown-row > td").click()
        driver.find_element_by_xpath(u"(//a[contains(text(),'下载')])[2]").click()
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException as e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException as e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
