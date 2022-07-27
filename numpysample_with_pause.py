import numpy as np
import math
import random
import time
 
start = time.time()
for i in range(10):
    list_1 = list(range(1,10000))
    for j in range(len(list_1)):
        list_1[j] = math.sin(list_1[j])
print("使用纯Python用时{}s".format(time.time()-start))
 
start = time.time()
for i in range(10):
    list_1 = np.array(np.arange(1,10000))
    list_1 = np.sin(list_1)
print("使用Numpy用时{}s".format(time.time()-start))


import os
os.system("pause")