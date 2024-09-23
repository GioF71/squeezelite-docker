#!/bin/bash

# exit codes

# 5 root mode required

echo "=== BEGIN Available audio devices ==="
/app/bin/squeezelite -l
echo "=== END-- Available audio devices ==="
echo ""

# load presets
echo "=== BEGIN Loading presets ==="
source run-presets.sh
echo "=== END-- Loading presets ==="

CMD_LINE="/app/bin/squeezelite"

if [[ -n "${SELECT_CUSTOM_BINARY_ALSA}" ]]; then
  if [ -f "$SELECT_CUSTOM_BINARY_ALSA" ]; then
      echo "Custom binary [$SELECT_CUSTOM_BINARY_ALSA] exists."
      if [ -x "$SELECT_CUSTOM_BINARY_ALSA" ]; then
          echo "Custom binary [$SELECT_CUSTOM_BINARY_ALSA] is executable."
          CMD_LINE=$SELECT_CUSTOM_BINARY_ALSA
      else
          echo "Custom binary [$SELECT_CUSTOM_BINARY_ALSA] is not executable, using default."
      fi
  else
      echo "Custom binary [$SELECT_CUSTOM_BINARY_ALSA] does not exist, using default."
  fi
fi

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
  CMD_LINE="$CMD_LINE -R $(quote_if_needed $SQUEEZELITE_UPSAMPLING)"
fi

if [ -z "${SQUEEZELITE_READ_FORMATS_FROM_HEADER}" ]; then
  echo "Variable SQUEEZELITE_READ_FORMATS_FROM_HEADER not specified";
else
  echo "Variable SQUEEZELITE_READ_FORMATS_FROM_HEADER specified: $SQUEEZELITE_READ_FORMATS_FROM_HEADER";
  if [[ "${SQUEEZELITE_READ_FORMATS_FROM_HEADER^^}" == "Y" || "${SQUEEZELITE_READ_FORMATS_FROM_HEADER^^}" == "YES" ]]; then
    CMD_LINE="$CMD_LINE -W"
  elif [[ "${SQUEEZELITE_READ_FORMATS_FROM_HEADER^^}" != "N" && "${SQUEEZELITE_READ_FORMATS_FROM_HEADER^^}" != "NO" ]]; then
    echo "Invalid SQUEEZELITE_READ_FORMATS_FROM_HEADER=[${SQUEEZELITE_READ_FORMATS_FROM_HEADER}]"
    exit 2
  fi
fi

if [ -z "${SQUEEZELITE_BUFFER_SIZE}" ]; then
  echo "Variable SQUEEZELITE_BUFFER_SIZE not specified";
  if [ -z "${SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE}" ]; then
    echo "Variable SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE (DEPRECATED) not specified";
  else
    echo "Variable SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE (DEPRECATED) specified: $SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE";
    CMD_LINE="$CMD_LINE -b $(quote_if_needed $SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE)"
  fi
else
  echo "Variable SQUEEZELITE_BUFFER_SIZE specified: $SQUEEZELITE_BUFFER_SIZE";
  CMD_LINE="$CMD_LINE -b $(quote_if_needed $SQUEEZELITE_BUFFER_SIZE)"
fi

if [ -z "${SQUEEZELITE_UNMUTE}" ]; then
  echo "Variable SQUEEZELITE_UNMUTE not specified";
else
  echo "Variable SQUEEZELITE_UNMUTE specified: $SQUEEZELITE_UNMUTE";
  CMD_LINE="$CMD_LINE -U $(quote_if_needed $SQUEEZELITE_UNMUTE)"
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
DEFAULT_UID=1000
DEFAULT_GID=1000

DEFAULT_USER_NAME=sq-user
DEFAULT_GROUP_NAME=sq-user
DEFAULT_HOME_DIR=/home/$DEFAULT_USER_NAME

USER_NAME=$DEFAULT_USER_NAME
GROUP_NAME=$DEFAULT_GROUP_NAME
HOME_DIR=$DEFAULT_HOME_DIR

current_user_id=$(id -u)
echo "Current user id is [$current_user_id], requested USER_MODE=[${USER_MODE}]"
actual_user_mode=0
if [[ $curret_user_id -eq 0 ]] && [[ "${USER_MODE^^}" == "YES" || "${USER_MODE^^}" == "Y" ]]; then
  actual_user_mode=1
fi

echo "Resulting actual_user_mode: [$actual_user_mode]"

if [[ "${INSTALL_BLUETOOTH_LIBRARIES^^}" == "YES" || "${INSTALL_BLUETOOTH_LIBRARIES^^}" == "Y" ]]; then
  echo "Bluetooth libraries installation requested."
  if [ $current_user_id -ne 0 ]; then
    echo "Installation of additional libraries is avaialable only when running as root."
    exit 5
  fi
  # this will be executed on each startup
  # maybe we can check if packages are already installed and 
  # avoid to install again
  apt-get update
  apt-get install -y bluetooth bluez-alsa-utils alsa-utils
fi

## User mode support
if [[ $actual_user_mode -eq 1 ]]; then
    USE_USER_MODE="Y"
    echo "User mode enabled"
    echo "Creating user ...";
    if [ -z "${PUID}" ]; then
        PUID=$DEFAULT_UID;
        echo "Setting default value for PUID: ["$PUID"]"
    fi
    if [ -z "${PGID}" ]; then
        PGID=$DEFAULT_GID;
        echo "Setting default value for PGID: ["$PGID"]"
    fi
    echo "Ensuring user with uid:[$PUID] gid:[$PGID] exists ...";
    ### create group if it does not exist
    if [ ! $(getent group $PGID) ]; then
        echo "Group with gid [$PGID] does not exist, creating..."
        groupadd -g $PGID $GROUP_NAME
        echo "Group [$GROUP_NAME] with gid [$PGID] created."
    else
        GROUP_NAME=$(getent group $PGID | cut -d: -f1)
        echo "Group with gid [$PGID] name [$GROUP_NAME] already exists."
    fi
    ### create user if it does not exist
    if [ ! $(getent passwd $PUID) ]; then
        echo "User with uid [$PUID] does not exist, creating..."
        useradd -g $PGID -u $PUID -M $USER_NAME
        echo "User [$USER_NAME] with uid [$PUID] created."
    else
        USER_NAME=$(getent passwd $PUID | cut -d: -f1)
        echo "user with uid [$PUID] name [$USER_NAME] already exists."
        HOME_DIR="/home/$USER_NAME"
    fi
    ### create home directory
    if [ ! -d "$HOME_DIR" ]; then
        echo "Home directory [$HOME_DIR] not found, creating."
        mkdir -p $HOME_DIR
        echo ". done."
    fi
    chown -R $PUID:$PGID $HOME_DIR
    if [ -z "${AUDIO_GID}" ]; then
        echo "WARNING: AUDIO_GID is mandatory for user mode and alsa output"
    else
      if [ $(getent group $AUDIO_GID) ]; then
          echo "Alsa Mode - Group with gid $AUDIO_GID already exists"
      else
          echo "Alsa Mode - Creating group with gid $AUDIO_GID"
          groupadd -g $AUDIO_GID sq-audio
      fi
      echo "Alsa Mode - Adding $USER_NAME [$PUID] to gid [$AUDIO_GID]"
      AUDIO_GRP=$(getent group $AUDIO_GID | cut -d: -f1)
      echo "gid $AUDIO_GID -> group $AUDIO_GRP"
      usermod -a -G $AUDIO_GRP $USER_NAME
      echo "Alsa Mode - Successfully created user $USER_NAME:$GROUP_NAME [$PUID:$PGID])";
    fi
else 
    echo "User mode disabled"
fi

handle_mac_address
cmdline_mac_address

echo "Command Line: ["$CMD_LINE"]"

if [[ $actual_user_mode -eq 1 ]]; then
  chown -R $USER_NAME:$GROUP_NAME /config
  exec su - $USER_NAME -c "$CMD_LINE"
else
  eval "exec $CMD_LINE"
fi
