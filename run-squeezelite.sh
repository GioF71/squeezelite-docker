#!/bin/bash

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC
echo "Rise and shine!"

if [ "$SQUEEZELITE_SPECIFY_SERVER" == "yes" ]; then \
  echo "Server has been specified: $SQUEEZELITE_SPECIFY_SERVER" \
  /usr/bin/squeezelite \
    -s $SQUEEZELITE_SERVER_PORT \
    -n $SQUEEZELITE_NAME \
    -o $SQUEEZELITE_AUDIO_DEVICE \
    -C $SQUEEZELITE_TIMEOUT \
    -D $SQUEEZELITE_DELAY; \
else \
  echo "Server has not been specified" \
  /usr/bin/squeezelite \
    -n $SQUEEZELITE_NAME \
    -o $SQUEEZELITE_AUDIO_DEVICE \
    -C $SQUEEZELITE_TIMEOUT \
    -D $SQUEEZELITE_DELAY; \
fi
