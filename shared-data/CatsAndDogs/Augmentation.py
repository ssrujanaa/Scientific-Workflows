#!/usr/bin/env python3
# coding: utf-8

# In[76]:



# Importing necessary functions 
from keras.preprocessing.image import ImageDataGenerator,  array_to_img, img_to_array, load_img 
from glob import glob
import os
cwd = os.getcwd()
os.sys.path.insert(0, os.getcwd())

resized_images = glob(os.getcwd() + '/wf-output/resized_*.jpg')
labels_txt = os.getcwd() + '/wf-output/labels.txt'

cat_images=[]
dog_images=[]
labels=[]
for i in range(len(resized_images)):
    if 'resized_Cat' in resized_images[i]:
        cat_images.append(resized_images[i])
    else:
        dog_images.append(resized_images[i])

        
datagen = ImageDataGenerator( 
        rotation_range = 40, 
        shear_range = 0.2, 
        zoom_range = 0.2, 
        horizontal_flip = True, 
        brightness_range = (0.5, 1.5)) 

for image in cat_images:
    num = 1.0
    img = load_img(image)  
    x = img_to_array(img) 
    x = x.reshape((1, ) + x.shape)  

    # Generating and saving 5 augmented samples  
    i = 0
    for batch in datagen.flow(x, batch_size = 1, 
                              save_to_dir = os.getcwd() + '/wf-output',  
                              save_prefix ='/aug_cat', save_format ='jpg'): 
        i += 1
        labels.append(num)
        if i > 5: 
            break
            
for image in dog_images:
    img = load_img(image)  
    x = img_to_array(img) 
    x = x.reshape((1, ) + x.shape)  
    num = 0.0
    # Generating and saving 5 augmented samples  
    i = 0
    for batch in datagen.flow(x, batch_size = 1, 
                              save_to_dir = os.getcwd() + '/wf-output',  
                              save_prefix ='/aug_dog', save_format ='jpg'): 
        
        i += 1
        labels.append(num)
        if i > 5: 
            break

aug_cat = glob(os.getcwd() + '/wf-output/aug_cat_0_*.jpg')
aug_dog = glob(os.getcwd() + '/wf-output/aug_dog_0_*.jpg')

aug_images = aug_cat + aug_dog

aug_images_txt = 'augmentation.txt'
aug_labels_txt = 'aug_labels.txt'
        
with open(aug_images_txt, 'w') as f:
    for item in aug_images:
        f.write("%s\n" % item)
        
with open(aug_labels_txt, 'w') as f:
    for item in labels:
        f.write("%s\n" % item)




