#!/bin/bash

echo "=== BEGIN Available audio devices ==="
/app/bin/squeezelite -l
echo "=== END-- Available audio devices ==="
echo ""

# load presets
echo "=== BEGIN Loading presets ==="
source run-presets.sh
echo "=== END-- Loading presets ==="

CMD_LINE="/app/bin/squeezelite"
echo "Initializing command line: ["$CMD_LINE"]"

source cmd-line-builder.sh

if [ -z "${PRESET}" ]; then
  echo "No presets have been specified";
else
  echo "Presets have been specified: ["$PRESET"]";
  echo "Explicitly set properties will not be overridden"
  echo "Presets are executed in order of appearance"
  echo "Current SQUEEZELITE_AUDIO_DEVICE = $SQUEEZELITE_AUDIO_DEVICE"
  echo "Current SQUEEZELITE_RATES = $SQUEEZELITE_RATES"
  echo "Current SQUEEZELITE_UPSAMPLING = $SQUEEZELITE_UPSAMPLING"
  echo "Current SQUEEZELITE_CODECS = $SQUEEZELITE_CODECS"
  echo "Current SQUEEZELITE_EXCLUDE_CODECS = $SQUEEZELITE_EXCLUDE_CODECS"
  echo "Current SQUEEZELITE_MIXER_DEVICE = $SQUEEZELITE_MIXER_DEVICE"
  echo "Current SQUEEZELITE_VOLUME_CONTROL = $SQUEEZELITE_VOLUME_CONTROL"

  OLD_IFS=$IFS
  IFS=',';
  read -rasplitIFS<<< "$PRESET";
  IFS=$OLD_IFS

  current_key=""
  current_value=""
  for current_preset in "${splitIFS[@]}"; do
    if ! [ -z "${current_preset}" ]; then
      echo "Processing current preset: ["$current_preset"]";
      # device in preset
      if [[ -z "${SQUEEZELITE_AUDIO_DEVICE}" || "${SQUEEZELITE_AUDIO_DEVICE}" == "default" ]]; then
        current_key=$current_preset".device"
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
      # mixer-device in preset
      if [[ -z "${SQUEEZELITE_MIXER_DEVICE}" || "${SQUEEZELITE_MIXER_DEVICE}" == "default" ]]; then
        current_key=$current_preset".mixer-device"
        current_value=${presets[${current_key}]}
        if [[ -v current_value ]]; then
          echo "Setting SQUEEZELITE_MIXER_DEVICE to ["$current_value"]"
          SQUEEZELITE_MIXER_DEVICE=$current_value
        else
          echo "Key ["$current_key"] not found"
        fi
      else
        echo "SQUEEZELITE_MIXER_DEVICE already set to ["$SQUEEZELITE_MIXER_DEVICE"]"
      fi
      # volume-control in preset
      if [[ -z "${SQUEEZELITE_VOLUME_CONTROL}" || "${SQUEEZELITE_VOLUME_CONTROL}" == "default" ]]; then
        current_key=$current_preset".volume-control"
        current_value=${presets[${current_key}]}
        if [[ -v current_value ]]; then
          echo "Setting SQUEEZELITE_VOLUME_CONTROL to ["$current_value"]"
          SQUEEZELITE_VOLUME_CONTROL=$current_value
        else
          echo "Key ["$current_key"] not found"
        fi
      else
        echo "SQUEEZELITE_VOLUME_CONTROL already set to ["$SQUEEZELITE_VOLUME_CONTROL"]"
      fi
      # rates in preset
      if [[ -z "${SQUEEZELITE_RATES}" || "${SQUEEZELITE_RATES}" == "" ]]; then
        current_key=$current_preset".rates"
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
      # upsampling in preset
      if [[ -z "${SQUEEZELITE_UPSAMPLING}" || "${SQUEEZELITE_UPSAMPLING}" == "" ]]; then
        current_key=$current_preset".upsampling"
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
      # codecs in preset
      if [[ -z "${SQUEEZELITE_CODECS}" || "${SQUEEZELITE_CODECS}" == "" ]]; then
        current_key=$current_preset".codecs"
        current_value=${presets[${current_key}]}
        if [[ -v current_value ]]; then
          current_value=${presets[${current_key}]}
          echo "Setting SQUEEZELITE_CODECS to ["$current_value"]"
          SQUEEZELITE_CODECS=$current_value
        else
          echo "Key ["$current_key"] not found"
        fi
      else
        echo "SQUEEZELITE_CODECS already set to ["$SQUEEZELITE_CODECS"]"
      fi
      # exclude codecs in preset
      if [[ -z "${SQUEEZELITE_EXCLUDE_CODECS}" || "${SQUEEZELITE_EXCLUDE_CODECS}" == "" ]]; then
        current_key=$current_preset".exclude-codecs"
        current_value=${presets[${current_key}]}
        if [[ -v current_value ]]; then
          current_value=${presets[${current_key}]}
          echo "Setting SQUEEZELITE_EXCLUDE_CODECS to ["$current_value"]"
          SQUEEZELITE_EXCLUDE_CODECS=$current_value
        else
          echo "Key ["$current_key"] not found"
        fi
      else
        echo "SQUEEZELITE_EXCLUDE_CODECS already set to ["$SQUEEZELITE_EXCLUDE_CODECS"]"
      fi
    fi
  done;
  # summary of preset values
  echo "Final SQUEEZELITE_AUDIO_DEVICE = $SQUEEZELITE_AUDIO_DEVICE"
  echo "Final SQUEEZELITE_RATES = $SQUEEZELITE_RATES"
  echo "Final SQUEEZELITE_UPSAMPLING = $SQUEEZELITE_UPSAMPLING"
  echo "Final SQUEEZELITE_CODECS = $SQUEEZELITE_CODECS"
  echo "Final SQUEEZELITE_EXCLUDE_CODECS = $SQUEEZELITE_EXCLUDE_CODECS"
  echo "Final SQUEEZELITE_MIXER_DEVICE = $SQUEEZELITE_MIXER_DEVICE"
  echo "Final SQUEEZELITE_VOLUME_CONTROL = $SQUEEZELITE_VOLUME_CONTROL"
fi

cmdline-server-port
cmdline-player-name
cmdline-model-name
cmdline-timeout
cmdline-mac-address
cmdline-audio-device
cmdline-mixer-device
cmdline-delay
cmdline-params
cmdline-volume-control
cmdline-linear-volume
cmdline-codecs
cmdline-exclude-codecs
cmdline-rates

if [ -z "${SQUEEZELITE_PRIORITY}" ]; then
  echo "Variable SQUEEZELITE_PRIORITY has not been specified";
else
  echo "Variable SQUEEZELITE_PRIORITY has been specified: $SQUEEZELITE_PRIORITY";
  CMD_LINE="$CMD_LINE -p $SQUEEZELITE_PRIORITY";
fi

if [ -z "${SQUEEZELITE_UPSAMPLING}" ]; then
  echo "Variable SQUEEZELITE_UPSAMPLING not specified";
else
  echo "Variable SQUEEZELITE_UPSAMPLING specified: $SQUEEZELITE_UPSAMPLING";
  CMD_LINE="$CMD_LINE -R $SQUEEZELITE_UPSAMPLING";
fi

if [ -z "${SQUEEZELITE_BUFFER_SIZE}" ]; then
  echo "Variable SQUEEZELITE_BUFFER_SIZE not specified";
  if [ -z "${SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE}" ]; then
    echo "Variable SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE (DEPRECATED) not specified";
  else
    echo "Variable SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE (DEPRECATED) specified: $SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE";
    CMD_LINE="$CMD_LINE -b $SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE";
  fi
else
  echo "Variable SQUEEZELITE_BUFFER_SIZE specified: $SQUEEZELITE_BUFFER_SIZE";
  CMD_LINE="$CMD_LINE -b $SQUEEZELITE_BUFFER_SIZE";
fi

if [ -z "${SQUEEZELITE_UNMUTE}" ]; then
  echo "Variable SQUEEZELITE_UNMUTE not specified";
else
  echo "Variable SQUEEZELITE_UNMUTE specified: $SQUEEZELITE_UNMUTE";
  CMD_LINE="$CMD_LINE -U $SQUEEZELITE_UNMUTE";
fi

if [ -z "${SQUEEZELITE_VISUALIZER}" ]; then
  echo "Variable SQUEEZELITE_VISUALIZER not specified";
else
  echo "Variable SQUEEZELITE_VISUALIZER specified: $SQUEEZELITE_VISUALIZER";
  visualizer=${SQUEEZELITE_VISUALIZER^^}
  echo "visualizer: $visualizer";
  if [ "$visualizer" == "Y" ]; then
    echo "Variable SQUEEZELITE_VISUALIZER set to enabled.";
    CMD_LINE="$CMD_LINE -v";
  else 
    if [ "$visualizer" == "N" ]; then
      echo "Variable SQUEEZELITE_VISUALIZER set to disabled.";
    else
      echo "Variable SQUEEZELITE_VISUALIZER invalid value: $SQUEEZELITE_VISUALIZER";
    fi
  fi
fi

source logging.sh

add_log_categories

USE_USER_MODE="N"

## User mode support
if [[ "${USER_MODE^^}" == "YES" || "${USER_MODE^^}" == "Y" ]]; then
    USE_USER_MODE="Y"
    echo "User mode enabled"
    echo "Creating user ...";
    DEFAULT_UID=1000
    DEFAULT_GID=1000
    if [ -z "${PUID}" ]; then
        PUID=$DEFAULT_UID;
        echo "Setting default value for PUID: ["$PUID"]"
    fi
    if [ -z "${PGID}" ]; then
        PGID=$DEFAULT_GID;
        echo "Setting default value for PGID: ["$PGID"]"
    fi
    USER_NAME=sq-user
    GROUP_NAME=sq-user
    HOME_DIR=/home/$USER_NAME
    ### create home directory and ancillary directories
    if [ ! -d "$HOME_DIR" ]; then
    echo "Home directory [$HOME_DIR] not found, creating."
    mkdir -p $HOME_DIR
    chown -R $PUID:$PGID $HOME_DIR
    ls -la $HOME_DIR -d
    ls -la $HOME_DIR
    fi
    ### create group
    if [ ! $(getent group $GROUP_NAME) ]; then
        echo "group $GROUP_NAME does not exist, creating..."
        groupadd -g $PGID $GROUP_NAME
    else
        echo "group $GROUP_NAME already exists."
    fi
    ### create user
    if [ ! $(getent passwd $USER_NAME) ]; then
        echo "user $USER_NAME does not exist, creating..."
        useradd -g $PGID -u $PUID -s /bin/bash -M -d $HOME_DIR $USER_NAME
        id $USER_NAME
        echo "user $USER_NAME created."
    else
        echo "user $USER_NAME already exists."
    fi

    if [ -z "${AUDIO_GID}" ]; then
        echo "AUDIO_GID is mandatory for user mode and alsa output"
        exit 3
    fi
    if [ $(getent group $AUDIO_GID) ]; then
        echo "Alsa Mode - Group with gid $AUDIO_GID already exists"
    else
        echo "Alsa Mode - Creating group with gid $AUDIO_GID"
        groupadd -g $AUDIO_GID mpd-audio
    fi
    echo "Alsa Mode - Adding $USER_NAME to gid $AUDIO_GID"
    AUDIO_GRP=$(getent group $AUDIO_GID | cut -d: -f1)
    echo "gid $AUDIO_GID -> group $AUDIO_GRP"
    usermod -a -G $AUDIO_GRP $USER_NAME
    echo "Alsa Mode - Successfully created $USER_NAME (group: $GROUP_NAME)";
else 
    echo "User mode disabled"
fi

echo "Command Line: ["$CMD_LINE"]"

if [[ ${USE_USER_MODE} == "Y" ]]; then
  su - $USER_NAME -c "$CMD_LINE"
else
  eval $CMD_LINE
fi
