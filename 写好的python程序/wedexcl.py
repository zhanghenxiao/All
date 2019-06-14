# import xlrd)#
# class good:
#     #读取Excel的办法，返回sheet对象
#     def read_it(self,x,index=0):
#         #打开指定路劲的excel
#         data = xlrd.open_workbook(x)
#         #获取整个sheet对象
#         sheet = data.sheets()[index]
#         return sheet
#     def fast_read(self):
#         table=self.read_it('C:\\Users\\Administrator\\Desktop\\Book1.xlsx')
#         return table
# e = good()
# for i in range(e.fast_read().nrows):
#     for j in range(e.fast_read().ncols):
#         print(e.fast_read().cell(i,j).value,end='')
#     print()
import xlrd
class a:
    #读取Excel的办法，返回sheet对象
   def add (self , x,index=0):
        #打开指定路劲的 excel
        data =xlrd.open_workbook(x)
        #获取整个sheet对象
        sheet = data.sheets()[index]
        return sheet

   def acc(self):
        table=self.add('C:\\Users\\Administrator\\Desktop\\Book1.xlsx')
        #s=table.cell(1,5)
        #print(s)
        return table
c=a()
for  i in range (c.acc().nrows): #循环行
    #for j in range (c.acc().ncols): #循环列
    print(c.acc().cell(i,5).value,end='') #只循环行，列固定为5
    print()


