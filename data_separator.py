import os, random
import pandas as pd

# this script separates the training data and the test data

## read from csv and get length
df = pd.read_csv('tdata.csv') # i will instead read the csv i make after cleaning the data where i have 'index,class,tweet' as the indices
tdata_length = df.shape[0]

# get 'random' sample of 5000 to use as training data using a starting seed
sample_size = 5000
initdex = random.randint(0, tdata_length)

txt = 'index,class,tweet'
for i in range(initdex, (initdex+sample_size)):
  
  # ensure it can wrap depending on the starting seed
  if (i >= tdata_length):
    i = i % tdata_length
  txt = txt + '\n' + str(i) + "," + str(df['class'].loc[i]) + "," + str(df['tweet'].loc[i])

# i apparently have to make a second for loop for this part, maybe i should've done this with numpy instead of pandas
for i in range(initdex, (initdex+sample_size)):
  if (i >= tdata_length):
    i = i % tdata_length
  df.drop(i)

# write training and test data to csv
f = open('training.csv', 'w')
f.write(txt)
f.close()

df.to_csv('test.csv')
