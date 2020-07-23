#!/usr/bin/env python3

from os import listdir
from numpy import asarray
from numpy import save
from glob import glob
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
import sys

# define location of dataset
# input_files  = glob('python/PetImages/Dog/*.jpg')
cat_files = glob('python/PetImages/Cat/*.jpg')
dog_files = glob('python/PetImages/Dog/*.jpg')

# for i in range(len(input_files)):
#     if 'Cat' in input_files[i]:
#         cat_files.append(input_files[i])
#     else:
#         dog_files.append(input_files[i])
        
photos, labels = list(), list()
# enumerate files in the directory

for i in range(len(cat_files)):
    output = 1.0
    photo = load_img(cat_files[i], target_size=(200, 200))
    photo = img_to_array(photo)
    photos.append(photo)
    labels.append(output)
    
for i in range(len(dog_files)):
    output = 0.0
    photo = load_img(dog_files[i], target_size=(200, 200))
    photo = img_to_array(photo)
    photos.append(photo)
    labels.append(output)   

photos = asarray(photos)
labels = asarray(labels)
print(photos.shape, labels.shape)

save('dogs_vs_cats_photos.npy', photos)
save('dogs_vs_cats_labels.npy', labels)





# In[ ]:





# In[ ]:





# In[ ]:




