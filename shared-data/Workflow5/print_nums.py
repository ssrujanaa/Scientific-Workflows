#!/usr/bin/env python3
# coding: utf-8

# In[ ]:


#!/usr/bin/env python3
import os
import signal
import sys
import time
import traceback

from pathlib import Path


# args = sys.argv[1:]
CHECKPOINT_FILE = "saved_stated.txt"
NUM_ITERATIONS = 180

i = 0
try:
    with open(CHECKPOINT_FILE, mode="r") as f:
        i = int(f.read())
            
    def SIGTERM_handler(signum, frame):
        with open(CHECKPOINT_FILE, mode="w") as f:
            f.write(str(i))
            
    signal.signal(signal.SIGTERM, SIGTERM_handler)

    print("pid: {}".format(os.getpid()))
    for _ in range(NUM_ITERATIONS+1):
        print(i)
        if i == NUM_ITERATIONS:
            break
        i += 1
        time.sleep(1)
        with open(CHECKPOINT_FILE, mode="w") as f:
            f.write(str(i))
            
except Exception as e:
    traceback.print_exc()


