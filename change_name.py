# -*- coding: utf-8 -*-
"""
Created on Thu Nov 24 23:38:43 2016

@author: zhang
"""

# -*- coding: cp936 -*-
import os
import re
    

def get_folders(path):
    all_files=os.listdir(path)
    folders=[]
    for file in all_files:
        if os.path.isfile(os.path.join(path,file))==False:
            print 'found: ' +file
            folders.append(file)
    return folders

  
def add_name(path,name):    
    
    for file in os.listdir(path):
        if file[:2] != 'Ex':
            
            if os.path.isfile(os.path.join(path,file))==True:
                if file.find('.png')>0:
                    final_name= name+file
                    os.rename(path+'/'+file,path+'/'+final_name)
                 
    #        print file.split('.')[-1] 
    

path = '.\pioGAN4'
folders= get_folders(path)

for folder in folders: 
    f=open(os.path.join(path,folder)+'/var.txt')
    txt=f.read()
    f.close
    k=re.search(r"k:(\S*)",txt)
    k='k='+k.group(1)
    pi=re.search(r"pi:(\S*)",txt)
    pi='pi='+pi.group(1)
    new_name=folder+'#'+k+'#'+pi+'#'
    print new_name
    subfolders=get_folders(path+'/'+folder)
    
    for subfolder in subfolders:
        add_name(path+'/'+folder+'/'+subfolder,new_name)
        print folder, 'OK' 
       
        
        
        