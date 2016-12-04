# -*- coding: utf-8 -*-
"""
Created on Fri Nov 25 05:48:36 2016

@author: zhang
"""
from shutil import copyfile

import os
import random as random 
from PIL import Image
import PIL.ImageOps    




def get_folders(path):
    all_files=os.listdir(path)
    folders=[]
    for file in all_files:
        if os.path.isfile(os.path.join(path,file))==False:
            #print 'found: ' +file
            folders.append(file)
    return folders

def explore_image(path): # return True is found .png in this directory
    for file in os.listdir(path):
        if file.find('.png')>0:
            return True
    return False
    

def PC_invert(path):
    if path.find('PC')>0:
        return True
    else:
        return False



def get_fundamental_path(path):
    guess_path_list=[]
    guess_path_list.append(path)
    i=1
    while i<10: 
        for guess_path in guess_path_list:
            if explore_image(guess_path) == False:
                os.listdir(guess_path)
                
                folders = get_folders(guess_path)
                for folder in folders:
                    guess_path_list.append(os.path.join(guess_path,folder))
                i+=1
    return guess_path_list

         
def extract_X_images(path,num_real): 
   
    real_image_path=get_fundamental_path(path) 
    real_image_path.remove(path)       
    random_folder=[]
    i=0        
    while i<=int(num_real):
        random_folder.append(random.choice(real_image_path))
        i+=1
    
    random_image=[]
    for folder in random_folder:
        random_file=random.choice(os.listdir(folder))
        random_image.append(['./images1.1.0/'+random_file,folder+'/'+random_file])
        
    for dst, src in random_image:
        if (dst.find('.png')>0):
            if PC_invert(path)==False:
                image = Image.open(src)
                image = image.convert('L')
                inverted_image = PIL.ImageOps.invert(image)

                inverted_image.save(dst)
                
            else:
                
                copyfile(src,dst)
                
                
                
                

real_image_path='./image_database/real'   
num_real=raw_input('Extract how many real images ? > ')     

extract_X_images(real_image_path,num_real)
            
            
PC='./image_database/PC'
PC_path=os.listdir(PC)
for PC1 in PC_path:
    num_pc=raw_input('Extract how many generated image from %s folder ? > ' %PC1)        
    extract_X_images(PC+'/'+PC1,num_pc)    
    
    


