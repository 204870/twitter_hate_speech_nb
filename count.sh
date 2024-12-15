#!/bin/bash

echo "starting loop 2!"
while read -r line; do
  count=$(cat types_temp | grep -o "$line" | wc -l) 
  echo $count $line >> ordered2
done < tokens_alpha
echo "ordered list!"
# you can also echo type/token ratio too :)
