import xlrd

class Excel:
    #   读取excel的方法, 返回sheet对象
    def read_it(self, file_path, index = 0):
        #   打开指定路径的excel
        data = xlrd.open_workbook(file_path)
        #   获取整个sheet对象
        sheet = data.sheets()[index]
        return sheet

    def fast_read(self):
        path = "C:\\Users\\Administrator\\PycharmProjects\\phase3\\demo_HTTP请求_0316\\DDT\\cases.xlsx"
        table = self.read_it(path)
        return table