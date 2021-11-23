#!/bin/bash

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC
echo "Ready to start."

echo "See available audio devices"

/usr/bin/squeezelite -l

CMD_LINE="/usr/bin/squeezelite"

if [ -z "${SQUEEZELITE_SERVER_PORT}" ]; then \
  echo "Server has not been specified, using discovery"; \
else \
  echo "Server has been specified: $SQUEEZELITE_SERVER_PORT"; \
  CMD_LINE="$CMD_LINE -s $SQUEEZELITE_SERVER_PORT"; \
fi

if [ -z "${SQUEEZELITE_RATES}" ]; then \
  echo "Rates not specified"; \
else \
  echo "Rates specified: $SQUEEZELITE_RATES"; \
  CMD_LINE="$CMD_LINE -r $SQUEEZELITE_RATES"; \
fi

if [ -z "${SQUEEZELITE_UPSAMPLING}" ]; then \
  echo "Upsampling not specified"; \
else \
  echo "Upsampling specified: $SQUEEZELITE_UPSAMPLING"; \
  CMD_LINE="$CMD_LINE -R $SQUEEZELITE_UPSAMPLING"; \
fi

CMD_LINE="$CMD_LINE -n $SQUEEZELITE_NAME -o $SQUEEZELITE_AUDIO_DEVICE -C $SQUEEZELITE_TIMEOUT -D $SQUEEZELITE_DELAY"

echo "Command Line:"
echo "$CMD_LINE"

eval $CMD_LINE
