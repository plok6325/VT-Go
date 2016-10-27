# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

import Tkinter 
from PIL import ImageTk, Image
import os
from urllib import urlopen
import time
import re
import random  
import pandas as pd 

def get_home_image():
    file = StringIO(urlopen('https://github.com/plok6325/VT-Go/raw/master/content/loading.jpg').read())
    loading = ImageTk.PhotoImage(Image.open(file))
    
    
    
def get_image(match):
    print ('start load')
    idx=random.randint(0, len(match)-1)
    image_url=match[idx]
    match.pop(idx)    
    file = StringIO(urlopen('https://github.com/plok6325/VT-Go/raw/'+image_url).read())
    img1 = ImageTk.PhotoImage(Image.open(file))
    print ('finish load')
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
    global imgname,flag
    numr=result_tuple[imgname][1]
    nump=result_tuple[imgname][0]
    result_tuple[imgname]=(numr+1,nump)
    result[imgname]=0
    pcbutton.config(bg='white')
    realbutton.config(bg='red')
    print ('real !')
    flag=1
    
    
    
def pc():
    global imgname,flag
    realbutton.config(bg='white')
    pcbutton.config(bg='red')
    numr=result_tuple[imgname][1]
    nump=result_tuple[imgname][0]
    result_tuple[imgname]=(numr,nump+1)
    result[imgname]=1
    print ('pc!')
    flag=1
    
    
    
def submit():
    global det 
    change_image()
    subbutton.config(text='             ')
    realbutton.config(text='T  R  U  M  P ')
    pcbutton.config(text='C l i n t o n')
    #root.destroy()
    det=1

def timeout(): 
    
    print ('Saving')
    df=pd.Series(result)
    df.to_csv('.\uploadme\\'+name+'result.csv')
    print ('result saved to uploadme ')
    realbutton.config(bg='white')
    pcbutton.config(bg='white')
    change_image()
    
    
def loadingscreen():
    
    panel.config(image=loading)
    panel.image = loading
    
    
    
    
def change_image():
    loadingscreen()
    global imgname,loading
    global img_disp
    imgt,imgname=get_image(image_url)
    
    result_tuple[imgname]=(0,0)
    result[imgname]=-1
    panel.config(image=imgt)
    panel.image = imgt
    aferid=panel.after(delay,timeout)
    print 'change image done'
    
    
    
    
if flag==0:
    image_url=(get_image_url())
    
    
result_tuple={}
result={}

delay=3000
root = Tkinter.Tk()
root.withdraw()

toplvl = Tkinter.Toplevel(root)
imageFrame=Tkinter.Frame(toplvl)
imageFrame.pack(side=Tkinter.TOP)
bottonFrame=Tkinter.Frame(toplvl)
bottonFrame.pack(side=Tkinter.BOTTOM)

file = StringIO(urlopen('https://github.com/plok6325/VT-Go/raw/master/content/loading.jpg').read())
loading = ImageTk.PhotoImage(Image.open(file))

file = StringIO(urlopen('https://github.com/plok6325/VT-Go/raw/master/content/welcome.jpg').read())
home= ImageTk.PhotoImage(Image.open(file))
imgname=str(time.time())
result_tuple[imgname]=(0,0)
panel = Tkinter.Label(imageFrame, image = home)
panel.pack(side = "top", fill = "both", expand = "no")
realbutton = Tkinter.Button(bottonFrame, text="                   ", command = real)
realbutton.pack( side = Tkinter.LEFT)
exitbutton = Tkinter.Button(bottonFrame, text=" quit  ", command = root.destroy)
exitbutton.pack( side = Tkinter.RIGHT )
pcbutton = Tkinter.Button(bottonFrame, text="                  ", command = pc)
pcbutton.pack( side = Tkinter.RIGHT )
subbutton = Tkinter.Button(bottonFrame, text=" s t a r t  ", command = submit)
subbutton.pack( side = Tkinter.LEFT )

det=0
name=str(random.randint(0,99999))
    
root.mainloop()  




    