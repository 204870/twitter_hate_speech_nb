#!/bin/bash

python texas.py
#makes two files, tweets and labels

# retweet indicators
sed -e "s/.*RT //" tweets >> nort

# external links
# egrep http[s]*://[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*/[A-Za-z0-9]* 
sed "s/http[s]*:\/\/[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*\/[A-Za-z0-9]*//" nort >> nolink
rm nort

# cat nolink | egrep http[s]*://[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*/[A-Za-z0-9]* >> captured

cat nolink | tr A-Z a-z >> lower
rm nolink

# remove hashtags but not uncide codes
sed "s/[^\&]#//g" lower >> noht
rm lower

# [:punct:] might not be helpful since we want to preserve html unicode codes
#cat tweets.txt | tr -d '[:punct:]' >> nopunc
sed -e 's/[␠!"$%()\*+,-.:;<=>?@\[\]^_\`{|\}~]*//g' noht >> nopunc
sed -e "s/[\/']*//g" nopunc >> cleaner

rm noht
rm nopunc

# for some reason unknown to me, some things slipped through the cracks, so the rest is being cleaned with tr
cat cleaner | tr -d "\"" | tr -d "!" | tr -d "," | tr -d "@" | tr -d "." >> cleaned
rm cleaner
rm tweets
