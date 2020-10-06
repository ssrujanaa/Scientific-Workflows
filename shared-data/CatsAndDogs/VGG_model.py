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
import pandas as pd
import h5py

#get training, testing and validation data from the saved pickle files.
def get_data():
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
    return train_photos,train_labels,test_photos,test_labels,val_photos,val_labels

#Definition of the VGG16 model and changing the output layer according to our requirements.
#i.e., 2 output classes
def get_model():
    nb_classes = 2
    vgg16_model = VGG16(weights = 'imagenet', include_top = False)
    x = vgg16_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dense(1024, activation='relu')(x)
    predictions = Dense(nb_classes, activation = 'softmax')(x)
    model = Model(input = vgg16_model.input, output = predictions)

    for layer in vgg16_model.layers:
        layer.trainable = False
    model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
    return model


def main():
    train_photos,train_labels,test_photos,test_labels,val_photos,val_labels = get_data()
    model = get_model()
    
    epochs=10
    
    #checkpoint file that saves the weights after each epoch - weights are overwritten to the same file
    checkpoint_file = 'checkpoint_file2.hdf5'
    checkpoint = ModelCheckpoint(checkpoint_file, monitor='loss', verbose=1, mode='auto',save_weights_only = True, period=1)
    
    train_from_beginning = False
    try:
        #Since our hdf5 file contains additional data = epochs, skip_mismatch is used to avoid that column
        model.load_weights("checkpoint_file2.hdf5",skip_mismatch=True)
        with h5py.File('checkpoint_file2.hdf5', "r+") as file:
            data = file.get('epochs')[...].tolist()
            
        #loading the number of epochs already performed to resume training from that epoch
        initial_epoch = data
        model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
        for i in range(initial_epoch,epochs):
            model.fit(x=train_photos, y=train_labels,batch_size=2 , epochs=1, verbose=1,
                      validation_data=(val_photos,val_labels), callbacks = [checkpoint])
            checkpoint = ModelCheckpoint(checkpoint_file, monitor='loss', verbose=1, mode='auto',
                                         save_weights_only = True, period=1)
            
            #saving the number of finished epochs to the same hdf5 file
            with h5py.File('checkpoint_file2.hdf5', "a") as file:
                file['epochs'] = i
    except OSError:
        train_from_beginning = True

    if train_from_beginning:
        model.compile(optimizer = 'rmsprop',loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
        for i in range(epochs):
            model.fit(x=train_photos, y=train_labels,batch_size=2 , epochs=1, 
                           verbose=1,validation_data=(val_photos,val_labels), callbacks = [checkpoint])
            checkpoint = ModelCheckpoint(checkpoint_file, monitor='loss', verbose=1, mode='auto',save_weights_only = True, period=1)
            #saving the number of finished epochs to the same hdf5 file
            with h5py.File('checkpoint_file2.hdf5', "a") as file:
                file['epochs']=i

    model.save('model.h5')
    return 0
    
if __name__ == '__main__':
    main()
