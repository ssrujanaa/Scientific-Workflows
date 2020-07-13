#!/usr/bin/env python
# coding: utf-8

# In[85]:


#!/usr/bin/env python3
from glob import glob

input_files = glob('nums[0-9].txt')
even_file = 'even.txt'
odd_file = 'odd.txt'

even=[]
odd=[]

with open(even_file, "w") as e_file, open(odd_file,"w") as o_file:
    for file in input_files:
        with open(file, "r")as in_file,open(even_file, "a") as e_file, open(odd_file,"a") as o_file:
            num = in_file.read().split('\n')
            for n in num:
                if int(n) % 2 == 0:
                    e_file.write(n)
                    e_file.write('\n')
                else:
                    o_file.write(n)
                    o_file.write('\n')


# In[ ]:





# In[73]:





# In[ ]:




