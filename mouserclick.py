#命令行执行
#pip3 install pymouse
#pip3 install pyuserinput
#pip3 install pypiwin32
from pymouse import PyMouse
 
m = PyMouse()
a = m.position()    #获取当前坐标的位置
print(a)
 
m.move(31, 223)   #鼠标移动到(x,y)位置
a = m.position()
print(a)
 
m.click(31, 223)  #移动并且在(x,y)位置左击

