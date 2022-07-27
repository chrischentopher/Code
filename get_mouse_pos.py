from pymouse import PyMouse
import time

m = PyMouse()
while True:
	time.sleep(3)
	a = m.position()    #获取当前坐标的位置
	print(a)
 
# m.click(31, 223)  #移动并且在(x,y)位置左击
# (412, 278)
# (495, 283)
# (585, 283)
# (686, 283)