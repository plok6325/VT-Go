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
    idx=random.randint(0, len(match)-1)
    image_url=match[idx]
    match.pop(idx)                
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


def real():
    top.destroy()
    
def pc():
    top.destroy()
    
def submit():
    root.destroy()
    
def change_image():
    imgt=get_image(image_url)
    panel.config(image=imgt)
    panel.image = imgt

    
if flag==0:
    image_url=(get_image_url())
    flag=1
    
    
root = Tkinter.Tk()
root.withdraw()

toplvl = Tkinter.Toplevel(root)
imageFrame=Tkinter.Frame(toplvl)
imageFrame.pack(side=Tkinter.TOP)
bottonFrame=Tkinter.Frame(toplvl)
bottonFrame.pack(side=Tkinter.BOTTOM)

img1=get_image(image_url)
panel = Tkinter.Label(imageFrame, image = img1)
panel.pack(side = "top", fill = "both", expand = "yes")
    
realbutton = Tkinter.Button(bottonFrame, text="   R  E  A  L   ", command = change_image )
realbutton.pack( side = Tkinter.LEFT)

pcbutton = Tkinter.Button(bottonFrame, text="      P    C    ", command = change_image)
pcbutton.pack( side = Tkinter.RIGHT )
subbutton = Tkinter.Button(bottonFrame, text="   s u b m i t    ", command = submit)
subbutton.pack( side = Tkinter.LEFT )
    

root.mainloop()  


    