#!/bin/sh

sed -i 's/MPD_AUDIO_DEVICE/'"$MPD_AUDIO_DEVICE"'/g' /etc/default/squeezelite

cat /etc/default/squeezelite

/usr/bin/squeezelite
