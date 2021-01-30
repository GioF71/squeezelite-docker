#!/bin/sh

sed -i 's/SQUEEZELITE_AUDIO_DEVICE/'"$SQUEEZELITE_AUDIO_DEVICE"'/g' /etc/default/squeezelite
sed -i 's/SQUEEZELITE_NAME/'"$SQUEEZELITE_NAME"'/g' /etc/default/squeezelite

cat /etc/default/squeezelite

/usr/bin/squeezelite -o $SQUEEZELITE_AUDIO_DEVICE -C 2
