#!/bin/bash

declare -A custom_presets

input="./presets.conf"
while IFS= read -r line
do
  OLD_IFS=$IFS
  IFS='='
  read -a strarr <<< "$line"

  if [ -n "$line" ]; then
    key=${strarr[0]}
    value=${strarr[1]}
    key=`echo "$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'<<<"${key}")"`
    value=`echo "$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'<<<"${value}")"`
    if [[ -n "$key" && -n "$value" ]]; then 
      echo $key"="$value  
    fi
    IFS=$OLD_IFS
  else 
    echo "<<<EMPTY_LINE>>>"
  fi
done < "$input"






#while IFS= read -r line; do
#  printf '%s\n' "$line"
#  OLD_IFS=$IFS 
#  IFS='='
#  pair=$line
#  echo $pair[0]  
# #key="$(cut -d '=' -b1 <<< $line)"
#  IFS=$OLD_IFS
#done < presets.conf


