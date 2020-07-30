#!/usr/bin/env python3
# coding: utf-8
# get_ipython().system('sudo pip3 install keras==2.1.5 tensorflow numpy pandas pillow opencv--python')

#!/usr/bin/env python3
from os import listdir
from numpy import asarray
from numpy import save
from glob import glob
import numpy as np
import tensorflow as tf
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
import sys
import cv2 as cv
import os
import sys
from glob import glob
cwd = os.getcwd()


input_files = glob('images/*.jpg')
norm_img = np.zeros((800,800))
photos, labels = list(), list()
cat_files =[]
dog_files =[]
c=0
d=0

for i in range(len(input_files)):
    if 'Cat' in input_files[i]:
        cat_files.append(input_files[i])
        output = 1.0
        photo = load_img(input_files[i], target_size=(200, 200))
#         photo = cv.normalize(photo, norm_img, 0, 255, cv.NORM_MINMAX)
        photo.save('resized_Cat'+ str(c) + '.jpg', 'JPEG', quality=90)
        photos.append(photo)
        labels.append(output)
        c+=1
    else:
        dog_files.append(input_files[i]) 
        output = 0.0
        photo = load_img(input_files[i], target_size=(200, 200))
        photo.save('resized_Dog'+ str(d) + '.jpg', 'JPEG', quality=90)
    #     photo = img_to_array(photo)
        photos.append(photo)
        labels.append(output)   
        d+=1
    
with open('resized_images.txt', 'w') as f:
    for item in photos:
        f.write("%s\n" % item)

with open('labels.txt', 'w') as f:
    for item in labels:
        f.write("%s\n" % item)