#!/bin/bash

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC
echo "Ready to start."

echo "=== BEGIN Available audio devices ==="
/usr/bin/squeezelite -l
echo "=== END-- Available audio devices ==="
echo ""

# load presets
source ./run-presets.sh

CMD_LINE="/usr/bin/squeezelite"

if [ -z "${PRESET}" ]; then
  echo "Preset has not been specified";
else
  echo "Preset has been specified: $PRESET";

  echo "Explicitly set properties are not overridden"
  echo "Current SQUEEZELITE_AUDIO_DEVICE = $SQUEEZELITE_AUDIO_DEVICE"
  echo "Current SQUEEZELITE_RATES = $SQUEEZELITE_RATES"
  echo "Current SQUEEZELITE_UPSAMPLING = $SQUEEZELITE_UPSAMPLING"

  current_key=""
  current_value=""

  if [[ -z "${SQUEEZELITE_AUDIO_DEVICE}" || "${SQUEEZELITE_AUDIO_DEVICE}" == "default" ]]; then
    current_key=$PRESET".device"
    current_value=${presets[${current_key}]}
    if [[ -v current_value ]]; then
      echo "Setting SQUEEZELITE_AUDIO_DEVICE to ["$current_value"]"
      SQUEEZELITE_AUDIO_DEVICE=$current_value
    else
      echo "Key ["$current_key"] not found"
    fi
  else
    echo "SQUEEZELITE_AUDIO_DEVICE already set to ["$SQUEEZELITE_AUDIO_DEVICE"]"
  fi

  if [[ -z "${SQUEEZELITE_RATES}" || "${SQUEEZELITE_RATES}" == "" ]]; then
    current_key=$PRESET".rates"
    current_value=${presets[${current_key}]}
    if [[ -v current_value ]]; then
      current_value=${presets[${current_key}]}
      echo "Setting SQUEEZELITE_RATES to ["$current_value"]"
      SQUEEZELITE_RATES=$current_value
    else
      echo "Key ["$current_key"] not found"
    fi
  else
    echo "SQUEEZELITE_RATES already set to ["$SQUEEZELITE_RATES"]"
  fi

  if [[ -z "${SQUEEZELITE_UPSAMPLING}" || "${SQUEEZELITE_UPSAMPLING}" == "" ]]; then
    current_key=$PRESET".upsampling"
    current_value=${presets[${current_key}]}
    if [[ -v current_value ]]; then
      current_value=${presets[${current_key}]}
      echo "Setting SQUEEZELITE_UPSAMPLING to ["$current_value"]"
      SQUEEZELITE_UPSAMPLING=$current_value
    else
      echo "Key ["$current_key"] not found"
    fi
  else
    echo "SQUEEZELITE_UPSAMPLING already set to ["$SQUEEZELITE_UPSAMPLING"]"
  fi

  echo "Final SQUEEZELITE_AUDIO_DEVICE = $SQUEEZELITE_AUDIO_DEVICE"
  echo "Final SQUEEZELITE_RATES = $SQUEEZELITE_RATES"
  echo "Final SQUEEZELITE_UPSAMPLING = $SQUEEZELITE_UPSAMPLING"
fi

if [ -z "${SQUEEZELITE_SERVER_PORT}" ]; then \
  echo "Server has not been specified, using discovery"; \
else \
  echo "Server has been specified: $SQUEEZELITE_SERVER_PORT"; \
  CMD_LINE="$CMD_LINE -s $SQUEEZELITE_SERVER_PORT"; \
fi

if [ -z "${SQUEEZELITE_RATES}" ]; then \
  echo "SQUEEZELITE_RATES not specified"; \
else \
  echo "SQUEEZELITE_RATES specified: $SQUEEZELITE_RATES"; \
  CMD_LINE="$CMD_LINE -r $SQUEEZELITE_RATES"; \
fi

if [ -z "${SQUEEZELITE_UPSAMPLING}" ]; then \
  echo "SQUEEZELITE_UPSAMPLING not specified"; \
else \
  echo "SQUEEZELITE_UPSAMPLING specified: $SQUEEZELITE_UPSAMPLING"; \
  CMD_LINE="$CMD_LINE -R $SQUEEZELITE_UPSAMPLING"; \
fi

CMD_LINE="$CMD_LINE -n $SQUEEZELITE_NAME -o $SQUEEZELITE_AUDIO_DEVICE -C $SQUEEZELITE_TIMEOUT -D $SQUEEZELITE_DELAY"

echo "Command Line:"
echo "$CMD_LINE"

eval $CMD_LINE
