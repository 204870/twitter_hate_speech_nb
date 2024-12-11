#!/bin/bash

python texas.py
#makes two files, tdata.csv and tweets.csv

# removes header and line numbers from tweets.csv
sed -e "s/^[0-9][0-9]*,//" tweets.csv | tail -n +2 >> tweets.txt
rm tweets.csv
rm tdata.csv

# external links
# egrep http[s]*://[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*/[A-Za-z0-9]* 
sed -e "s/http[s]*:\/\/[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*\/[A-Za-z0-9]*//" tweets.txt >> nolink
cat nolink | egrep http[s]*://[A-Za-z][A-Za-z]*\.[A-Za-z][A-Za-z]*/[A-Za-z0-9]* >> captured
cat nolink | tr A-Z a-z >> lower
rm nolink
# [:punct:] might not be helpful since we want to preserve html unicode codes
#cat tweets.txt | tr -d '[:punct:]' >> nopunc
rm tweets.txt
