#!/bin/bash

upsampling_goldilocks="v::4:28:95:105:45"
echo $upsampling_goldilocks

declare -A presets

#declare -A gustard_x12
#gustard_x12[device]='hw:CARD=x20,DEV=0'
#gustard_x12[rates]='44100,48000,88200,96000,176400,192000,352800,384000:200'
#gustard_x12[upsampling]=$upsampling_goldilocks


presets[gustard-x12-goldilocks.device]="hw:CARD=x20,DEV=0"
presets[gustard-x12-goldilocks.rates]="44100,48000,88200,96000,176400,192000,352800,384000:200"
presets[gustard-x12-goldilocks.upsampling]=$upsampling_goldilocks


#chosen="gustard-x12-goldilocks"
#echo "Device (inline) = "${presets[$chosen".device"]}
#echo "Rates (inline) = "${presets[$chosen".rates"]}
#echo "Upsampling (inline) = "${presets[$chosen".upsampling"]}

