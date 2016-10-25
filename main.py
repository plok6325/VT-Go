# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

from Tkinter import *
from PIL import ImageTk, Image
import os
import urllib

def get_image():
    file = StringIO(urllib.urlopen('https://lh4.googleusercontent.com/-v0soe-ievYE/AAAAAAAAAAI/AAAAAAADnx8/TYw5hefoVmg/s0-c-k-no-ns/photo.jpg').read())
    img1 = ImageTk.PhotoImage(Image.open(file))
    return img1
    
    
    
    
    
try:
    from cStringIO import StringIO #python 2
except ImportError:
    from io import StringIO #python 3
root = Tk()

img1=get_image()


panel = Label(root, image = img1)

panel.pack(side = "bottom", fill = "both", expand = "yes")

root.mainloop()