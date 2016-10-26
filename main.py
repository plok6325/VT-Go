# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

import Tkinter 
from PIL import ImageTk, Image
import os
import urllib 
import re
import random  

def get_image(match):
    image_url=match[random.randint(0, len(match)-1)]
    file = StringIO(urllib.urlopen('https://github.com/plok6325/VT-Go/raw/'+image_url).read())
    img1 = ImageTk.PhotoImage(Image.open(file))
    return img1
    
    
def get_image_url():
    name=urllib.urlopen('https://github.com/plok6325/VT-Go/tree/master/images').read() # image home page 
    pattern = re.compile(r'master/images/+\S+.jpg') # regexp pattern
    match = pattern.findall(name) # image url 
    return match
    
    
try:
    from cStringIO import StringIO #python 2
except ImportError:
    from io import StringIO #python 3
    
flag=0

'''
root = Tkinter.Toplevel()

img1=get_image(get_image_url())

panel = Tkinter.Label(root, image = img1)
panel.pack(side = "top", fill = "both", expand = "yes")


redbutton = Tkinter.Button(root, text="   R  E  A  L   ", command = new_window)
redbutton.pack( side = Tkinter.LEFT)

greenbutton = Tkinter.Button(root, text="      P    C    ")
greenbutton.pack( side = Tkinter.RIGHT )

root.mainloop()

    
'''

'''
def new_window_2(root):
    
    root = Tkinter.Tk()

    img1=get_image(get_image_url())

    panel = Tkinter.Label(root, image = img1)
    panel.pack(side = "top", fill = "both", expand = "yes")


    redbutton = Tkinter.Button(root, text="   R  E  A  L   ", command = new_window_2)
    redbutton.pack( side = Tkinter.LEFT)

    greenbutton = Tkinter.Button(root, text="      P    C    ")
    greenbutton.pack( side = Tkinter.RIGHT )

    root.mainloop()
    return root
    
'''
if flag==0:
    image_url=(get_image_url())
    flag=1
    
    
root = Tkinter.Tk()
root.withdraw()
top = Tkinter.Toplevel(root)
def new_window_1():
    
    img1=get_image(image_url)

    panel = Tkinter.Label(top, image = img1)
    panel.pack(side = "top", fill = "both", expand = "yes")


    redbutton = Tkinter.Button(top, text="   R  E  A  L   ", command = top.quit )
    redbutton.pack( side = Tkinter.LEFT)

    greenbutton = Tkinter.Button(top, text="      P    C    ", command = top.quit)
    greenbutton.pack( side = Tkinter.RIGHT )
    subbutton = Tkinter.Button(top, text="   s u b m i t    ", command =top.quit )
    subbutton.pack( side = Tkinter.LEFT )
    
    root.mainloop()
    
    
def real():
    top.destroy()
    
def pc():
    top.destroy()
    
def submit():
    top.destroy()
it=0
while it<10:
    it=it+1 
    new_window_1()



