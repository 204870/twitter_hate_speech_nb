import os
import pandas as pd

df = pd.read_parquet("train-00000-of-00001.parquet")
'''
~~~~~~~~Data Fields~~~~~~~~~~~~~~~~~~~~~~~~~
count: (Integer) number of users who coded each tweet (min is 3, sometimes more users coded a tweet when judgments were determined to be unreliable,
hate_speech_annotation: (Integer) number of users who judged the tweet to be hate speech,
offensive_language_annotation: (Integer) number of users who judged the tweet to be offensive,
neither_annotation: (Integer) number of users who judged the tweet to be neither offensive nor non-offensive,
label: (Class Label) class label for majority of CF users (0: 'hate-speech', 1: 'offensive-language' or 2: 'neither'),
tweet: (string)
'''
# forgive me for i could not find a good way to do this in bash
# believe me, i've done a fair amount of searching in my opinion but
# most of the tools we've been introduced to work on a line-by-line basis and well..
# some tweets have newline chars in them :')
l = df.shape[0]
li = df.tweet.tolist()
for i in range(0,l):
  li[i].replace("\n", "")
df.tweet = li

df.to_csv('tdata.csv')
df.tweet.to_csv('tweets.csv')
df['class'].to_csv('labels.csv')
