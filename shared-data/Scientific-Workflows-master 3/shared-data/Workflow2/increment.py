#!/usr/bin/env python
# coding: utf-8

# In[6]:


#!/usr/bin/env python3
import sys

input_filename  = sys.argv[1]
output_filename = sys.argv[2]

with open(input_filename, "r") as in_file,open(output_filename, "w") as out_file:
    num = in_file.read()
    out_file.write(str(int(num)+1))


# In[ ]:





# In[ ]:




