#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#!/usr/bin/env python3
import emoji
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, 'r') as f,open(output_file,'w',encoding='utf-8-sig') as f1:
    input_txt = f.readlines()
    f1.write(input_txt)
    f1.write(emoji.emojize(':thumbs_up:'))


# In[ ]:





# In[ ]:




