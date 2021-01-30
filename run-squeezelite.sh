#!/bin/sh

sed -i 's/SQUEEZELITE_AUDIO_DEVICE/'"$SQUEEZELITE_AUDIO_DEVICE"'/g' /etc/default/squeezelite
sed -i 's/SQUEEZELITE_NAME/'"$SQUEEZELITE_NAME"'/g' /etc/default/squeezelite

cat /etc/default/squeezelite

/usr/bin/squeezelite \
  -n $SQUEEZELITE_NAME \
  -o $SQUEEZELITE_AUDIO_DEVICE \
  -C $SQUEEZELITE_TIMEOUT \
  -D $SQUEEZELITE_DELAY
