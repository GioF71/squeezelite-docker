#!/bin/sh

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC
echo "Rise and shine!"

/usr/bin/squeezelite \
  -n $SQUEEZELITE_NAME \
  -o $SQUEEZELITE_AUDIO_DEVICE \
  -C $SQUEEZELITE_TIMEOUT \
  -D $SQUEEZELITE_DELAY
