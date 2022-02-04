#!/bin/bash

upsampling_goldilocks="v::4:28:95:105:45"
upsampling_extremus="v::3.05:28:99.7:100:45"
rate_delay=200

rate_44="44100"
rate_48="48000"
rate_88="88200"
rate_96="96000"
rate_176="176400"
rate_192="192000"
rate_352="352800"
rate_384="384000"
rate_704="705600"
rate_768="768000"

rates_2x_only="$rate_88,$rate_96"
rates_4x_only="$rate_176,$rate_192"
rates_8x_only="$rate_352,$rate_384"
rates_16x_only="$rate_704,$rate_768"
rates_up_to_96k="$rate_44-$rate_96"
rates_up_to_192k="$rate_44-$rate_192"
rates_up_to_384k="$rate_44-$rate_384"
rates_up_to_768k="$rate_44-$rate_768"

#rates_96k=$rate_96

device_x20="hw:CARD=x20,DEV=0"
device_dac="hw:CARD=DAC,DEV=0"
device_gustard_x12=$device_x20
device_topping_d10="hw:CARD=D10,DEV=0"
device_hifiberry_dac_plus="hw:CARD=sndrpihifiberry,DEV=0"
device_fiio_e18="hw:CARD=DACE18,DEV=0"

declare -A presets

presets[dac.device]=$device_dac
presets[x20.device]=$device_x20
presets[topping-d10.device]=$device_topping_d10
presets[hifiberry-dac-plus.device]=$device_hifiberry_dac_plus
presets[gustard-x12.device]=$device_gustard_x12
presets[fiio-e18]=$device_fiio_e18

presets[goldilocks.upsampling]=$upsampling_goldilocks
presets[extremus.upsampling]=$upsampling_extremus

presets[archimago-goldilocks.upsampling]=$upsampling_goldilocks
presets[archimago-extremus.upsampling]=$upsampling_extremus



presets[rates_96k.rates]=$rate_96":"$rate_delay
presets[rates_2x_only.rates]=$rates_2x_only":"$rate_delay
presets[rates_4x_only.rates]=$rates_4x_only":"$rate_delay
presets[rates_8x_only.rates]=$rates_8x_only":"$rate_delay
presets[rates_16x_only.rates]=$rates_16x_only":"$rate_delay
presets[rates_up_to_96k.rates]=$rates_up_to_96k":"$rate_delay
presets[rates_up_to_192k.rates]=$rates_up_to_192k":"$rate_delay
presets[rates_up_to_384k.rates]=$rates_up_to_384k":"$rate_delay
presets[rates_up_to_768k.rates]=$rates_up_to_768k":"$rate_delay

presets[goldilocks_96k.rates]=$rates_96k":"$rate_delay
presets[goldilocks_96k.upsampling]=$upsampling_goldilocks

presets[goldilocks_2x_only.rates]=$rates_2x_only":"$rate_delay
presets[goldilocks_2x_only.upsampling]=$upsampling_goldilocks

presets[goldilocks_4x_only.rates]=$rates_4x_only":"$rate_delay
presets[goldilocks_4x_only.upsampling]=$upsampling_goldilocks

presets[goldilocks_8x_only.rates]=$rates_8x_only":"$rate_delay
presets[goldilocks_8x_only.upsampling]=$upsampling_goldilocks

presets[goldilocks_up_to_96k.rates]=$rates_up_to_96k":"$rate_delay
presets[goldilocks_up_to_96k.upsampling]=$upsampling_goldilocks

presets[goldilocks_up_to_192k.rates]=$rates_up_to_192k":"$rate_delay
presets[goldilocks_up_to_192k.upsampling]=$upsampling_goldilocks

presets[goldilocks_up_to_384k.rates]=$rates_up_to_384k":"$rate_delay
presets[goldilocks_up_to_384k.upsampling]=$upsampling_goldilocks

presets[goldilocks_up_to_768k.rates]=$rates_up_to_768k":"$rate_delay
presets[goldilocks_up_to_768k.upsampling]=$upsampling_goldilocks

presets[gustard-x12-goldilocks.device]=$device_x20
presets[gustard-x12-goldilocks.rates]=$rates_up_to_384k":"$rate_delay
presets[gustard-x12-goldilocks.upsampling]=$upsampling_goldilocks

