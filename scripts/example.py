#!/usr/bin/env python
# coding: utf-8

# In[87]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import preprocessing
plt.rcParams['figure.figsize'] = (16, 9)
plt.style.use('ggplot')
get_ipython().magic(u'matplotlib inline')


# In[88]:


df = pd.read_csv("csvs/hadooprun22.csv")
df.drop(df[df['Mem'] == '_x86_64_'].index, inplace = True) 
df['Mem'] = df['Mem'].astype(float)


# In[89]:


# Sort Run

sort_run = df['Workload'] == 'sort_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[sort_run & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-Sort-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-Sort-22-RSS')

datanode_sort = df[sort_run & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-Sort-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-Sort-22-RSS')

nodemanager_sort = df[sort_run & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-Sort-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-Sort-22-RSS')

resourcemanager_sort = df[sort_run & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-Sort-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-Sort-22-RSS')


# In[90]:


# WC Run

wc = df['Workload'] == 'wc_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[wc & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-wc-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-wc-22-RSS')

datanode_sort = df[wc & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-wc-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-wc-22-RSS')

nodemanager_sort = df[wc & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-wc-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-wc-22-RSS')

resourcemanager_sort = df[wc & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-wc-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-wc-22-RSS')


# In[91]:


# grep Run

grep = df['Workload'] == 'grep_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[grep & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-grep-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-grep-22-RSS')

datanode_sort = df[grep & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-grep-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-grep-22-RSS')

nodemanager_sort = df[grep & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-grep-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-grep-22-RSS')

resourcemanager_sort = df[grep & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-grep-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-grep-22-RSS')


# In[92]:


# md5 Run

md = df['Workload'] == 'md5_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[md & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-md-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-md-22-RSS')

datanode_sort = df[md & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-md-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-md-22-RSS')

nodemanager_sort = df[md & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-md-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-md-22-RSS')

resourcemanager_sort = df[md & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-md-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-md-22-RSS')


# In[93]:


# randsample Run

rs = df['Workload'] == 'randsample_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[rs & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-rs-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-rs-22-RSS')

datanode_sort = df[rs & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-rs-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-rs-22-RSS')

nodemanager_sort = df[rs & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-rs-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-rs-22-RSS')

resourcemanager_sort = df[rs & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-rs-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-rs-22-RSS')


# In[94]:


# matmult Run

mm = df['Workload'] == 'matmult0_5_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[mm & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-mm-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-mm-22-RSS')

datanode_sort = df[mm & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-mm-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-mm-22-RSS')

nodemanager_sort = df[mm & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-mm-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-mm-22-RSS')

resourcemanager_sort = df[mm & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-mm-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-mm-22-RSS')


# In[95]:


# matmult Run

fft = df['Workload'] == 'fft0_5_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[fft & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-fft-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-fft-22-RSS')

datanode_sort = df[fft & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-fft-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-fft-22-RSS')

nodemanager_sort = df[fft & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-fft-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-fft-22-RSS')

resourcemanager_sort = df[fft & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-fft-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-fft-22-RSS')


# In[96]:


# cc Run

cc = df['Workload'] == 'cc_run'
namenode = df['Service'] == '24114'
datanode = df['Service'] == '23826'
nodemanager = df['Service'] == '25408'
resourcemanager = df['Service'] == '25240'

namenode_sort = df[cc & namenode]
namenode_sort = namenode_sort.reset_index()
namenode_sort.plot(y = 'Mem', title = 'Namenode-cc-22-Mem')
namenode_sort.plot(y = 'RSS', title = 'Namenode-cc-22-RSS')

datanode_sort = df[cc & datanode]
datanode_sort = datanode_sort.reset_index()
datanode_sort.plot(y = 'Mem', title = 'Datanode-cc-22-Mem')
datanode_sort.plot(y = 'RSS', title = 'Datanode-cc-22-RSS')

nodemanager_sort = df[cc & nodemanager]
nodemanager_sort = nodemanager_sort.reset_index()
nodemanager_sort.plot(y = 'Mem', title = 'nodemanager-cc-22-Mem')
nodemanager_sort.plot(y = 'RSS', title = 'nodemanager-cc-22-RSS')

resourcemanager_sort = df[cc & resourcemanager]
resourcemanager_sort = resourcemanager_sort.reset_index()
resourcemanager_sort.plot(y = 'Mem', title = 'resourcemanager-cc-22-Mem')
resourcemanager_sort.plot(y = 'RSS', title = 'resourcemanager-cc-22-RSS')


# In[ ]:



