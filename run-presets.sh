#!/bin/bash

upsampling_goldilocks="v::4:28:95:105:45"

rates_up_to_384k="44100-384000"

device_x20="hw:CARD=x20,DEV=0"
device_dac="hw:CARD=DAC,DEV=0"

declare -A presets

presets[goldilocks_up_to_384k.rates]=$rates_up_to_384k":200"
presets[goldilocks_up_to_384k.upsampling]=$upsampling_goldilocks

presets[gustard-x12-goldilocks.device]=$device_x20
presets[gustard-x12-goldilocks.rates]=$rates_up_to_384k":200"
presets[gustard-x12-goldilocks.upsampling]=$upsampling_goldilocks

presets[gustard-x12.device]=$device_x20
