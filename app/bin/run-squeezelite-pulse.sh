#!/bin/bash

echo "Running in pulse mode"

current_user_id=$(id -u)
echo "Current user id is [$current_user_id], requested USER_MODE=[${USER_MODE}]"
if [[ $current_user_id -ne 0 ]]; then
  echo "Cannot run in Pulse Mode using docker user mode, you need to run as root and specify PUID/PGID"
  exit 1 
fi

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

DEFAULT_USER_NAME=sq-pulse
DEFAULT_GROUP_NAME=sq-pulse
DEFAULT_HOME_DIR=/home/$DEFAULT_USER_NAME

USER_NAME=$DEFAULT_USER_NAME
GROUP_NAME=$DEFAULT_GROUP_NAME
HOME_DIR=$DEFAULT_HOME_DIR

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

echo "Pulse Mode - Successfully created user $USER_NAME:$GROUP_NAME [$PUID:$PGID])";

PULSE_CLIENT_CONF="/etc/pulse/client.conf"

echo "cat /app/assets/pulse-client-template.conf"
cat /app/assets/pulse-client-template.conf

echo "Creating pulseaudio configuration file $PULSE_CLIENT_CONF..."
cp /app/assets/pulse-client-template.conf $PULSE_CLIENT_CONF
sed -i 's/PUID/'"$PUID"'/g' $PULSE_CLIENT_CONF
cat $PULSE_CLIENT_CONF

CMD_LINE="/app/bin/squeezelite-pulseaudio"

if [[ -n "${SELECT_CUSTOM_BINARY_PULSE}" ]]; then
  if [ -f "$SELECT_CUSTOM_BINARY_PULSE" ]; then
      echo "Custom binary [$SELECT_CUSTOM_BINARY_PULSE] exists."
      if [ -x "$SELECT_CUSTOM_BINARY_PULSE" ]; then
          echo "Custom binary [$SELECT_CUSTOM_BINARY_PULSE] is executable."
          CMD_LINE=$SELECT_CUSTOM_BINARY_PULSE
      else
          echo "Custom binary [$SELECT_CUSTOM_BINARY_PULSE] is not executable, using default."
      fi
  else
      echo "Custom binary [$SELECT_CUSTOM_BINARY_PULSE] does not exist, using default."
  fi
fi

echo "Initializing command line: ["$CMD_LINE"]"

source cmd-line-builder.sh

cmdline-server-port
cmdline-player-name
cmdline-model-name
cmdline-timeout
cmdline-audio-device
cmdline-params
cmdline-codecs

if [ -z "${SQUEEZELITE_RATES}" ]; then
  # default to 44.1kHz
  SQUEEZELITE_RATES=44100
fi
cmdline-rates

if [ -z "${SQUEEZELITE_EXCLUDE_CODECS}" ]; then
  # dsd disabled by default on pulseaudio
  SQUEEZELITE_EXCLUDE_CODECS=dsd
fi
cmdline-exclude-codecs

source logging.sh

add_log_categories

handle_mac_address
cmdline_mac_address

echo "Command Line: ["$CMD_LINE"]"

chown -R $USER_NAME:$GROUP_NAME /config
exec su - $USER_NAME -c "$CMD_LINE"

