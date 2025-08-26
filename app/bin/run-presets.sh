#!/bin/bash

set -ex

declare -A presets

function load_preset_file() {
    echo "Loading $2 Presets..."
    while IFS= read -r line
    do
        if [[ -n "$line" && ! $line = \#* ]]; then
            key="$(cut -d '=' -f1 <<< ${line})"
            keyLen=`echo ${#key}`
            value=${line#*=} 
            echo "Loading preset [$key]=[$value]"
            presets[$key]=$value
    fi
    done < "$1"
    echo "Finished loading $2 presets"
}

# load presets
load_preset_file "/app/assets/builtin-presets.conf" "built-in"

additional_presets_file="/app/assets/additional-presets.conf"
if [ -f $additional_presets_file ]; then
    load_preset_file $additional_presets_file "additional"
else
    echo "No additional preset file found"
fi

sz=`echo "${#presets[@]}"`
echo "There are [$sz] available presets"
if [[ "${DISPLAY_PRESETS}" == "Y" || "${DISPLAY_PRESETS}" == "y" ]]; then  
    for key in "${!presets[@]}"; do
        echo "PRESET ["$key"]=["${presets[$key]}"]"
    done
fi
