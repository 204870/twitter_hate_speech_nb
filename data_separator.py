import csv, os, random
import pandas as pd

# this script separates the training data and the test data

## read from csv and get length
with open('tdata_cleaned.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)[1:]
tdata_length = len(data)

# get 'random' sample of 5000 to use as training data using a starting seed
sample_size = 5000
initdex = random.randint(0, tdata_length)

data_train = []

for i in range(initdex, (initdex+sample_size)):
  j = i-initdex
  # ensure it can wrap depending on the starting seed
  if (i >= tdata_length):
    i = i % tdata_length
  data_train.append(data.pop(i))

df = pd.DataFrame(data, columns=['class', 'tweet'])
df_train = pd.DataFrame(data_train, columns=['class', 'tweet'])

# write training and test data to parquet because csv doesn't work because the tweets have commas :'(
df_train.to_parquet('training.parquet')
df.to_parquet('test.parquet')
