#!/usr/bin/env python

import os
import time
import random

path = "/home/code/wallpapers/"
files = os.listdir(path)

while 1 == 1 :
    paper_list = list(map(lambda x: (random.random(), x), files))
    paper_list.sort()
    for i in range(len(paper_list)):
        (x,y) = paper_list[i]
        z = path + y
        os.system("feh --bg-fill %s &" % (z))
#        print('%d %s' % (i,y))
        time.sleep(60)
