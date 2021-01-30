#!/bin/sh

sed -i 's/SQUEEZELITE_AUDIO_DEVICE/'"$SQUEEZELITE_AUDIO_DEVICE"'/g' /etc/default/squeezelite

cat /etc/default/squeezelite

/usr/bin/squeezelite
