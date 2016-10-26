# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

import Tkinter 
from PIL import ImageTk, Image
import os
from urllib import urlopen

import re
import random  
import pandas as pd 

def get_image(match):
    idx=random.randint(0, len(match)-1)
    image_url=match[idx]
    match.pop(idx)          
    print ('loading images')      
    file = StringIO(urlopen('https://github.com/plok6325/VT-Go/raw/'+image_url).read())
    img1 = ImageTk.PhotoImage(Image.open(file))
    return img1,image_url
    
   
def get_image_url():
    print ('getting image url')
    name=urlopen('https://github.com/plok6325/VT-Go/tree/master/images').read() # image home page 
    pattern = re.compile(r'master/images/+\S+.jpg') # regexp pattern
    match = pattern.findall(name) # image url 
    return match
    
    
try:
    from cStringIO import StringIO #python 2
except ImportError:
    from io import StringIO #python 3
    
    
if os.path.exists('.\uploadme'):
    print ('file found')
else:
    os.mkdir('.\uploadme')


    
flag=0


def real():
    global imgname
    numr=result_tuple[imgname][1]
    nump=result_tuple[imgname][0]
    result_tuple[imgname]=(numr+1,nump)
    result[imgname]=0
    change_image()
    
def pc():
    global imgname
    numr=result_tuple[imgname][1]
    nump=result_tuple[imgname][0]
    result_tuple[imgname]=(numr,nump+1)
    result[imgname]=1
    change_image()
    
def submit():
    global det 
    root.destroy()
    det=1
    
def change_image():
    global imgname
    imgt,imgname=get_image(image_url)
    result_tuple[imgname]=(0,0)
    panel.config(image=imgt)
    panel.image = imgt
    
    
if flag==0:
    image_url=(get_image_url())
    flag=1
    
result_tuple={}
result={}


root = Tkinter.Tk()
root.withdraw()

toplvl = Tkinter.Toplevel(root)
imageFrame=Tkinter.Frame(toplvl)
imageFrame.pack(side=Tkinter.TOP)
bottonFrame=Tkinter.Frame(toplvl)
bottonFrame.pack(side=Tkinter.BOTTOM)

img1,imgname=get_image(image_url)
result_tuple[imgname]=(0,0)

panel = Tkinter.Label(imageFrame, image = img1)
panel.pack(side = "top", fill = "both", expand = "yes")
realbutton = Tkinter.Button(bottonFrame, text="   R  E  A  L   ", command = real)
realbutton.pack( side = Tkinter.LEFT)
pcbutton = Tkinter.Button(bottonFrame, text="      P    C    ", command = pc)
pcbutton.pack( side = Tkinter.RIGHT )
subbutton = Tkinter.Button(bottonFrame, text="   s u b m i t    ", command = submit)
subbutton.pack( side = Tkinter.LEFT )
    
root.mainloop()  


if det==1:
    df=pd.Series(result)
    name=str(random.randint(0,99999))
    df.to_csv('.\uploadme\\'+name+'result.csv')
    print ('result saved to uploadme ')


    