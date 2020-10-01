#!/usr/bin/env python3
# coding: utf-8
import sys
import pickle
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
from keras.callbacks import EarlyStopping
import keras.backend as K
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

train_photos =train_photos.astype('float32')
test_photos= test_photos.astype('float32')
val_photos =val_photos.astype('float32')
train_photos /= 255
val_photos /= 255
test_photos /= 255


from optkeras.optkeras import OptKeras
import optkeras
import pickle
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
from keras.callbacks import EarlyStopping
import keras.backend as K
from keras.applications.vgg16 import VGG16
from keras.models import Model,load_model
from keras.optimizers import RMSprop

import optuna
import os
import tensorflow as tf
import argparse
optkeras.optkeras.get_trial_default = lambda: optuna.trial.FrozenTrial(
            None, None, None, None, None, None, None, None, None, None, None)
study_name = "CatsAndDogs" + '_Simple'
ok = OptKeras(study_name=study_name,
              monitor='val_acc',
              direction='maximize')
import joblib
MODEL = "vgg"
STUDY = None
N_TRIALS = 4


def sigterm_handler(signum, frame):
    hpo_monitor_sigterm()
    sys.exit(3)
    
def hpo_monitor(study, trial):
    joblib.dump(study,checkpoint_file) 
    
def objective(trial):
    nb_classes = 2
    epochs=3
    batch_size =2
    optimizer_options = ["RMSprop", "Adam", "SGD"]

    vgg16_model = VGG16(weights = 'imagenet', include_top = False)
    x = vgg16_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dense(1024, activation=trial.suggest_categorical('activation', ['relu', 'linear']))(x)
    predictions = Dense(nb_classes, activation = 'softmax')(x)
    model = Model(input = vgg16_model.input, output = predictions)
    for layer in vgg16_model.layers:
        layer.trainable = False

    model.compile(optimizer = trial.suggest_categorical("optimizer", ["rmsprop", "Adam", "SGD"]),loss = 'sparse_categorical_crossentropy', metrics = ['accuracy'])
    cp_callback = tf.keras.callbacks.ModelCheckpoint(filepath=checkpoint_path, verbose=1, save_weights_only=True,
    period=10)
    model.fit(x=train_photos, y=train_labels,batch_size=2 , epochs=epochs, callbacks=ok.callbacks(trial),
              verbose=ok.keras_verbose ,validation_data=(val_photos,val_labels))
    return ok.trial_best_value
STUDY.optimize(objective, n_trials=1, timeout=600, callbacks=[hpo_monitor])
checkpoint_file = "study_checkpoint.pkl"

try:
    STUDY = joblib.load(checkpoint_file)
    finished = len(STUDY.trials_dataframe())
except AttributeError:
    STUDY = OptKeras(study_name=study_name,monitor='val_acc',direction='maximize')
    finished = 1


if finished < N_TRIALS:  
    todo_trials = N_TRIALS - finished
    if todo_trials > 0 :
        STUDY.optimize(objective, n_trials=todo_trials, timeout=600, callbacks=[hpo_monitor])
    else:
        pass
else:
    STUDY = OptKeras(study_name=study_name,monitor='val_acc',direction='maximize')
    STUDY.optimize(objective, n_trials=N_TRIALS, timeout=600, callbacks=[hpo_monitor])
 