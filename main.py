# -*- coding: utf-8 -*-
"""
Created on Tue Oct 25 18:13:55 2016

@author: zhang
"""

from Tkinter import *

root = Tk()

var = StringVar()
label = Label( root, textvariable=var, relief=RAISED,image=)

var.set("Hey!? How are you doing?")
label.pack()
root.mainloop()