#!/bin/bash

#num=$(cat tweet | wc -l)
#echo $num



# align both files and then use the loop below

# looks like this:                                                              
# file1line: label
# file2line: tweet (cleaned + normalized)                                                                              
while IFS=$'\t' read -r file1line file2line; do                               
  if echo $file1line | grep -q [0-1]
  then
    # potentially capture "&#[0-9]*&# and put a space between unicharacters?
    # get them into lines and append to 'types' file
    echo $file2line | tr ' ' '\n' >> types_temp
  fi
done < <(paste labels cleaned)   

cat types_temp | sort >> types
cat types_temp | uniq >> tokens
rm types_temp

# read lines from tokens
while read -r line; do
  count=$(cat types | grep -o "$j" | wc -l)
  echo "$count $j" >> ordered
done < tokens

# you can also echo type/token ratio too :)
