#!/bin/bash

declare -A custom_presets

input="./presets.conf"
while IFS= read -r line
do
  OLD_IFS=$IFS
  IFS='='
  read -a line_array <<< "$line"
  if [ -n "$line" ]; then
    key=${line_array[0]}
    value=${line_array[1]}
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

