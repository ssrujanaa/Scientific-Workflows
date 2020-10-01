#!/usr/bin/env python3
# coding: utf-8

import pickle
import signal
from os import listdir
from numpy import asarray
from numpy import save
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
import numpy as np
from keras import layers
from keras.layers import Input,Dense,BatchNormalization,Flatten,Dropout,GlobalAveragePooling2D
from keras.models import Model, load_model
from keras.utils import layer_utils
from keras.optimizers import Adam
from keras.callbacks import ModelCheckpoint
from keras.callbacks import CSVLogger
import keras.backend as K
import traceback
from keras.applications.vgg16 import VGG16
from keras.models import Model,load_model

with open('training.pkl', 'rb') as f:
     train = pickle.load(f)
    
with open('testing.pkl', 'rb') as f:
     test = pickle.load(f)
        
with open('validation.pkl','rb') as f:
    val = pickle.load(f)

train_photos, train_labels = list(), list()
tp = list()
for file in train:
    if 'Cat' in file:
        output = 1.0
    else:
        output = 0.0
    photo = load_img(file)
    photo = img_to_array(photo)
    train_photos.append(photo)
    train_labels.append(output)
train_photos = asarray(train_photos)
train_labels = asarray(train_labels)

test_photos, test_labels = list(), list()
for file in test:
    if 'Cat' in file:
        output = 1.0
    else:
        output = 0.0
    photo = load_img(file)
    photo = img_to_array(photo)
    tp.append(photo)
    test_photos.append(photo)
    test_labels.append(output)
test_photos = asarray(test_photos)
test_labels = asarray(test_labels)

val_photos, val_labels = list(), list()
for file in val:
    if 'Cat' in file:
        output = 1.0
    else:
        output = 0.0
    photo = load_img(file)
    photo = img_to_array(photo)
    val_photos.append(photo)
    val_labels.append(output)
val_photos = asarray(val_photos)
val_labels = asarray(val_labels)

nb_classes = 2
epochs=10
batch_size =5

vgg16_model = VGG16(weights = 'imagenet', include_top = False)
x = vgg16_model.output
x = GlobalAveragePooling2D()(x)
x = Dense(1024, activation='relu')(x)
predictions = Dense(nb_classes, activation = 'softmax')(x)
model = Model(input = vgg16_model.input, output = predictions)

for layer in vgg16_model.layers:
    layer.trainable = False
model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
checkpoint_file = 'checkpoint_file.hdf5'
checkpoint = ModelCheckpoint(checkpoint_file, monitor='loss', verbose=1, mode='auto',save_weights_only = True, period=1)
csv_logger = CSVLogger("model_history_log.csv", append=True)

train_from_beginning = False
try:
    model.load_weights("checkpoint_file.hdf5")
    df1 =  pd.read_csv("model_history_log.csv") 
    model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
    model.fit(x=train_photos, y=train_labels,batch_size=2 , epochs=epochs, initial_epoch = len(df1['epoch']),
                       verbose=1,validation_data=(val_photos,val_labels), callbacks = [checkpoint,csv_logger])
except OSError:
    train_from_beginning = True
    
if train_from_beginning:
    model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
    model.fit(x=train_photos, y=train_labels,batch_size=2 , epochs=epochs, 
                       verbose=1,validation_data=(val_photos,val_labels), callbacks = [checkpoint,csv_logger])

model.save('model.h5')
