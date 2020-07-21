#!/usr/bin/env python3
import emoji
import sys,os

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r') as f,open(output_file,'w',encoding='utf-8-sig') as f1:
    input_txt = f.readlines()
    f1.write(input_txt[0])
    f1.write(emoji.emojize(':thumbs_up:'))





