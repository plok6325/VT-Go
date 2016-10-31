# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

import os
from ftplib import FTP
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

'''
def ftp_up(filename ): 
    
    ftp = FTP('192.168.1.113')  
    ftp.login()
    ftp.set_debuglevel(2)#打开调试级别2，显示详细信息;0为关闭调试信息 
    bufsize = 1024#设置缓冲块大小 
    file_handler = open(filename,'rb')#以读模式在本地打开文件 
    ftp.storbinary('STOR %s' % os.path.basename(filename),file_handler,bufsize)#上传文件 
    ftp.set_debuglevel(0) 
    file_handler.close() 
    ftp.quit() 
    print "ftp up OK" 
    '''
    
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
    subbutton.config(text='             ')
    realbutton.config(text='R   E   A   L  ')
    pcbutton.config(text='G E N E R A T E D')
    #root.destroy()
    det=1
    change_image()

def timeout(): 
    change_image()
    print ('Saving')
    df=pd.Series(result)
    df.to_csv('.\uploadme\\'+name+'result.csv')
    print ('result saved to uploadme ')
    realbutton.config(bg='white')
    pcbutton.config(bg='white')
    
    
    
def loadingscreen():
    panel.config(image=loading)
    panel.image = loading
    timeout()
    
def quitit():
    root.destroy()  
    det=1
      
    
    
    
def change_image():
    global imgname,loading
    global img_disp
    imgt,imgname=get_image(image_url)
    panel.config(image=imgt)
    panel.image = imgt
    print 'change image done'
    aferid=panel.after(delay,loadingscreen)
    result_tuple[imgname]=(0,0)
    result[imgname]=-1
    
    
    
    
if flag==0:
    image_url=(get_image_url())
    
    
result_tuple={}
result={}



delay=2000
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
exitbutton = Tkinter.Button(bottonFrame, text=" quit  ", command = quitit)
exitbutton.pack( side = Tkinter.RIGHT )
pcbutton = Tkinter.Button(bottonFrame, text="                  ", command = pc)
pcbutton.pack( side = Tkinter.RIGHT )
subbutton = Tkinter.Button(bottonFrame, text=" s t a r t  ", command = submit)
subbutton.pack( side = Tkinter.LEFT )

det=0

name=str(time.time())
root.mainloop()  

while det==1:
    filee='.\uploadme\\'+name+'result.csv'
    #ftp_up(filename=filee)
    det=3


    