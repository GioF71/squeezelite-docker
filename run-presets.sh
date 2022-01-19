#!/bin/bash

upsampling_goldilocks="v::4:28:95:105:45"
echo $upsampling_goldilocks

rates_up_to_384k="44100,48000,88200,96000,176400,192000,352800,384000"

device_x20="hw:CARD=x20,DEV=0"
device_dac="hw:CARD=DAC,DEV=0"

declare -A presets

presets[gustard-x12-goldilocks.device]=$device_x20
presets[gustard-x12-goldilocks.rates]=$rates_up_to_384k":200"
presets[gustard-x12-goldilocks.upsampling]=$upsampling_goldilocks

presets[gustard-x12.device]=$device_x20
