#!/bin/bash

#num=$(cat tweet | wc -l)
#echo $num



# align both files and then use the loop below

# looks like this:                                                              
# file1line: label
# file2line: tweet (cleaned + normalized)                                                                              
echo "starting loop 1!"
while IFS=$'\t' read -r file1line file2line; do                            
  echo $file1line,$file2line >> tdata_cleaner
  if echo $file1line | grep -q [0-1]
  then
    # potentially capture "&#[0-9]*&# and put a space between unicharacters?
    # get them into lines and append to 'types' file
    echo $file2line | tr ' ' '\n' >> types_temp
    
    # make csv-like
  fi 
done < <(paste "labels" "cleaned")   

sed "s/[0-9],$//" tdata_cleaner | sort | uniq >> tdata_cleaned.csv
rm tdata_cleaner

echo "loop 1 done!"

cat types_temp | sort >> types
cat types_temp | sort | uniq >> tokens
# rm types_temp
echo "made files"

# read lines from tokens
cat tokens | grep ^[a-z]*$ >> tokens_alpha
# cat tokens | grep "^#[a-z]*" >> tokens_hash
echo "starting loop 2!"
while read -r line; do
  count=$(cat types_temp | grep -o "$line" | wc -l)
  echo "$count $line" >> orderer
done < tokens_alpha
cat orderer | sort -n -r >> ordered
rm orderer
echo "ordered list!"

# you can also echo type/token ratio too :)
